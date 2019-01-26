function I = interpolate_to(vertex,M,vposx,vposy)
% interpolate the function M on vertex to a regular grid stored as image
% s1 = ceil((max(vertex(:,1))-min(vertex(:,1))))+1; 
% s2 = ceil((max(vertex(:,2))-min(vertex(:,2))))+1; 
% I = zeros(s2,s1);
% mask = zeros(s2,s1);
% grid point
% [vposy,vposx] = ndgrid(1:d:sy,1:d:sx);
% vposy = sy + 1 - vposy; % natural image ordering
% shifting
% vposx = vposx - 1 + floor(min(vertex(:,1)));
% vposy = vposy - 1 + floor(min(vertex(:,2)));
% splat
% flrv = floor(vertex);
% vpos = [flrv, flrv+[ones(N,1),zeros(N,1)],flrv+[ones(N,1),ones(N,1)],flrv+[zeros(N,1),ones(N,1)]];
% vposx = vpos(:,[1,3,5,7]);
% vposy = vpos(:,[2,4,6,8]);
% dis = repmat(V_m,1,4) - vpos ;
% dis = dis.^2;
% dis = [dis(:,1)+dis(:,2),dis(:,3)+dis(:,4),dis(:,5)+dis(:,6),dis(:,7)+dis(:,8)];
% dis = sqrt(dis);
% dis = dis./repmat(sqrt(sum(dis,2)),1,4);
I = griddata(vertex(:,1),vertex(:,2),M,vposx,vposy,'linear');
I(isnan(I)) = 0;
end


% 
% function [ind1,ind2] = v2imgind(vertex,s2,vposx,vposy)
% % get the image index of vpos
% ind1 = vposy - floor(min(vertex(:,2))) + 1;
% ind2 = vposx - floor(min(vertex(:,1))) + 1;
% ind1 = s2 + 1 - ind1;
% end