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

num_points = size(DT.Points, 1);
num_neighbors = zeros(num_points, 1);
for i = 1:size(edges, 1)
    num_neighbors(edges(i, :)) = num_neighbors(edges(i, :)) + 1;
end
figure;
hold on;
for i = 1:size(connectivityList, 1)
    vertices = DT.Points(connectivityList(i, :), :);
    plot([vertices(:, 1); vertices(1, 1)], [vertices(:, 2); vertices(1, 2)], 'b-');
end
scatter(DT.Points(:, 1), DT.Points(:, 2), 20, num_neighbors, 'filled');
caxis([0 8]); 
axis equal;
axis off
colormap(slanCM('imola'))
hold off;