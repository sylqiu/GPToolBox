function [map, se] = bdsv(Vpre,V,F,b,bc,K1,K2)
% QC map from bounds on singular values 0<K2 <= s1,s2 <= K1
% K2 = K1 = 1 equivalent to a version of ARAP
% Initiallize with (V_pre,F), gradient operator of (V,F)
% V_pre, V: #V x 3
% F: #F x 3
% b: #b x1 constraint vertex indices
% bc: #b x 3 target positions

%  Jan 21. 2019 @sylvesterqiu@gamil.com


[G] = grad(V,F);
Gu = G*Vpre(:,1); Gu = reshape(Gu, size(F,1),2);
Gv = G*Vpre(:,2); Gv = reshape(Gv, size(F,1),2);
S = [Gu,Gv]'; S = reshape(S,2,[]);
R = zeros(2,2*size(F,1));
se = 0;
for i = 1:size(F,1)
    [uu,ss,vv] = svd(S(:,2*i-1 : 2*i));
    sv1 = min(ss(1,1),K1);
    sv2 = max(ss(2,2),K2);
    se = se + ((ss(1,1) - sv1)^2 + (ss(2,2) - sv2)^2) * face_area(F(i,:), V);
    R(:,2*i-1:2*i) = uu*diag([sv1,sv2])*vv';
end
R = reshape(R,4,[]); R = R';
R = [reshape(R(:,1:2),[],1),reshape(R(:,3:4),[],1)];
A = sparse(1:2*size(F,1), 1:2*size(F,1), repmat(doublearea(V,F)/2,2,1));
rhs = G'*A*R;
L = G'*A*G;
rhs = -L(:,b)*bc + rhs;
rhs(b,:) = bc;
L(b,:) = 0;
L(:,b) = 0;
for ind = 1:size(b,1)
    L(b(ind),b(ind)) = 1;
end

map = L\rhs;
end