function new_boundary_id = orient_boundary(face, boundary_list)
[am,amd] = compute_adjacency_matrix(face);
md = am - (amd>0) * 2;
md = md == -1;
new_boundary_id = [];
curr_v = boundary_list(1);
boundary_list = setdiff(boundary_list, curr_v);
new_boundary_id = [new_boundary_id; curr_v];
% trace through boundary
while ~isempty(boundary_list) 
    neighbors = find(md(curr_v, :));
    if sum(ismember(neighbors, new_boundary_id)) == 0 % boundary not yet closed
        curr_v = neighbors;        
    end
    boundary_list = setdiff(boundary_list, curr_v);
    new_boundary_id = [new_boundary_id; curr_v];
    
    
end

end