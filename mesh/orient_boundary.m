function correct_bdyi = orient_boundary(F)
% this version didn't consider boundary edges, discarded
% correct_bdyi = [];
% correct_bdyi = [correct_bdyi; bdyi(1)];
% curr_v = bdyi(1);
% final = 0;
% ii = 1;
% while ~final
%     nxt_tri = find_tri_by_vertex(F,curr_v);
%     nxt_tri = nxt_tri{1};
%     nxt_v_set = F(nxt_tri,:);
%     nxt_v_set = unique(nxt_v_set(:));
%     nxt_v_set = intersect(nxt_v_set, bdyi);
%     nxt_v_set = setdiff(nxt_v_set,correct_bdyi);
%     if isempty(nxt_v_set)
%         final = 1;
%     else
%         nxt_v = nxt_v_set(1);
%         correct_bdyi = [correct_bdyi; nxt_v];
%         ii = ii +1;
%         curr_v = nxt_v;
%     end
%     
% end

% Assume only one boundary component
[~, correct_bdyi] = meshboundaries(F);

end