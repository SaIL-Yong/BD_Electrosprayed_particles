clear all
close all
clc

data = load('HWT3_frame_1730_vol_0.14_pts_DoG.mat');
x = data.ptsDoG(:,1); 
y = data.ptsDoG(:,2); 
tri = [x y];

DT = delaunayTriangulation(tri);
edges = DT.edges();
connectivityList = DT.ConnectivityList;
angles_to_delete = [];
for i = 1:size(connectivityList, 1)
    vertices = DT.Points(connectivityList(i, :), :);
    edgess = zeros(3, 2);
    for j = 1:3
        edgess(j, :) = vertices(mod(j, 3) + 1, :) - vertices(j, :);
    end
   
    angles = zeros(3, 1);
    for j = 1:3
        v1 = edgess(mod(j, 3) + 1, :);
        v2 = edgess(mod(j + 1, 3) + 1, :);
        angles(j) = acos(dot(v1, v2) / (norm(v1) * norm(v2)));
    end

    angles = rad2deg(angles);

    if any(angles > 150)
        angles_to_delete = [angles_to_delete, i];
    end
end

connectivityList(angles_to_delete, :) = [];
threshold = 18; 
edges_to_delete = [];

for i = 1:size(connectivityList, 1)
    vertices = DT.Points(connectivityList(i, :), :);
    edge_lengths = zeros(3, 1);
    for j = 1:3
        edge_lengths(j) = norm(vertices(mod(j, 3) + 1, :) - vertices(j, :));
    end
    if any(edge_lengths > threshold)
        edges_to_delete = [edges_to_delete, i];
    end
end
connectivityList(edges_to_delete, :) = [];
edges = [connectivityList(:, [1, 2]); 
         connectivityList(:, [2, 3]); 
         connectivityList(:, [3, 1])];

edges = unique(sort(edges, 2), 'rows');
num_vertices = max(edges(:));

neighbors = cell(num_vertices, 1);

for i = 1:size(edges, 1)
    vertex1 = edges(i, 1);
    vertex2 = edges(i, 2);

    if isempty(neighbors{vertex1})
        neighbors{vertex1} = vertex2;
    else
        neighbors{vertex1} = [neighbors{vertex1}, vertex2];
    end

    if isempty(neighbors{vertex2})
        neighbors{vertex2} = vertex1;
    else
        neighbors{vertex2} = [neighbors{vertex2}, vertex1];
    end
end


for vertex = 1:num_vertices
    vertex_coord = DT.Points(vertex,:);
    neighbor_indices = neighbors{vertex};
    ii=0;
    for neighbor_index = neighbor_indices
        neighbor_coord = DT.Points(neighbor_index,:);
        ii=ii+1;
        distance = norm(vertex_coord - neighbor_coord);
        distances(vertex, ii) = distance;
    end
end
min_indices = zeros(num_vertices, 1);

for vertex = 1:num_vertices
    vertex_distances = distances(vertex, :);
    non_zero_indices = find(vertex_distances > 0);
    if ~isempty(non_zero_indices)
        [~, min_index] = min(vertex_distances(non_zero_indices));
        min_indices(vertex) = non_zero_indices(min_index);
    else
        min_indices(vertex) = NaN;
    end
end

min_neighbor_values = cell(num_vertices, 1);

for vertex = 1:num_vertices
    min_index = min_indices(vertex);
    if isnan(min_index)
        min_neighbor_values{vertex} = [];
        bondOrderParams(vertex, 1) = 0; 
        continue; 
    end

    neighbor_index = neighbors{vertex,1}(min_index);

    min_neighbor_values{vertex} = neighbor_index;
end

bondOrderParams = zeros(num_vertices, 1);

for vertex = 1:num_vertices
    if isempty(neighbors{vertex,1})
        bondOrderParams(vertex, 1) = 0; 
        continue; 
    end

    neighbor_index_1 = neighbors{vertex,1}(:);
    min_index = min_indices(vertex);

    if isnan(min_index)
        bondOrderParams(vertex, 1) = 0;
        continue;
    end

    neighbor_index_minimum = neighbors{vertex,1}(min_index);
    center_to_center = DT.Points(vertex,:) - DT.Points(neighbor_index_minimum,:);
    angleList = [];
    
    for j = 1:length(neighbor_index_1)
        P = neighbor_index_1(j);
        neighborVector = DT.Points(vertex,:) - DT.Points(P,:);
        angle = acosd(dot(center_to_center, neighborVector) / (norm(center_to_center) * norm(neighborVector)));
        angleList = [angleList angle];
    end
    
    psi_6 = exp(1i * 6 * deg2rad(angleList));
    bondOrderParams(vertex, 1) = abs(mean(psi_6));
end
scatter(DT.Points(:,1), DT.Points(:,2), 10, bondOrderParams, 'filled');
hold on
caxis([0 1]);
axis off
axis square
hold off;
colormap(slanCM('inferno'))
cb = colorbar; 
cb.FontSize = 36; 
