close all;
clear all;
clc;

A = load('heatmap_data_1.mat', 'degree_of_ordering', 'X', 'Y', 'Z');
figure;

levels = linspace(min(A.degree_of_ordering(:)), max(A.degree_of_ordering(:)), 200); 
contourf(A.X, A.Y, A.degree_of_ordering, levels, 'LineStyle', 'none');
colormap(viridis);

set(gca, 'YDir', 'normal');
cb = colorbar;  
set(cb, 'TickDirection', 'out');  
cb.Label.FontSize = 36;             
cb.FontSize = 36;                   
cbAxis = cb.Axes; 
set(cbAxis, 'LineWidth', 2); 
cb.LineWidth = 2; 
cb.Ticks = [1,2,3,4,5,6,7];                

ax = gca;
set(ax, 'XScale','log','YScale','log' )
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.XTick = [1e-4, 1e-3];
ax.XTickLabel = { '10^{-4}', '10^{-3}'};
ax.XAxis.FontSize = 36;
ax.YAxis.FontSize = 36;
ax.LineWidth = 2;
xlabel('\sigma_p (C/m^2)', 'FontSize', 36);
ylabel('\kappa', 'FontSize', 36);
axis square;
hold on;
x_optimal = 1.6e-4;
y_optimal = 180;
plot(x_optimal, y_optimal, 'rx', 'MarkerSize', 12, 'LineWidth', 2);
hold on;
x_optimal = 1.5e-4;
y_optimal = 182;
plot(x_optimal, y_optimal, 'gx', 'MarkerSize', 12, 'LineWidth', 2);

