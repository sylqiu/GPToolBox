%% compute bd 
% Find boundary of mesh, returned bd will be in ccw consecutive order. For
% multiple boundary mesh, return a cell, each cell is a closed boundary.
% For single boundary mesh, return an array.
%
%% Syntax
%   bd = compute_bd(face)
%
%% Description
%  face: double array, nf x 3, connectivity of mesh
%
%  bd: double array, n x 1, consecutive boundary vertex list in ccw order
%      cell, n x 1, each cell is one closed boundary
% 
%% Contribution
%  Author : Wen Cheng Feng
%  Created: 2014/03/06
%  Revised: 2014/03/14 by Wen, add document
%  Revised: 2014/03/23 by Wen, revise doc
% 
%  Copyright 2014 Computational Geometry Group
%  Department of Mathematics, CUHK
%  http://www.math.cuhk.edu.hk/~lmlui

function bd = compute_bd(face)
% amd stores halfedge information, interior edge appear twice in amd,
% while boundary edge appear once in amd. We use this to trace boundary. 
% 
[am,amd] = compute_adjacency_matrix(face);
md = am - (amd>0) * 2;
md = md == -1;

% number of boundary
bd = cell(1);
k = 1;
[boundary_list, ~] = find(md);
curr_v = boundary_list(1);
boundary_list = setdiff(boundary_list, curr_v);
bd{1} = [bd{1}; curr_v];
% trace through boundary
while ~isempty(boundary_list) 
    neighbors = find(md(curr_v, :));
    if sum(ismember(neighbors, bd{k})) == 0 % boundary not yet closed
        curr_v = neighbors;
    else
        curr_v = boundary_list(1);
        k = k+1;
        bd{k} = [];
        
    end
    boundary_list = setdiff(boundary_list, curr_v);
    bd{k} = [bd{k}; curr_v];
    
    
end

end
