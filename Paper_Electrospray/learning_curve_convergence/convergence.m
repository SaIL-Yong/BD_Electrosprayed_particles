data = load('convergence_data.mat');
x_values = data.x_values;
y_values = data.y_values;
figure;
plot(x_values, y_values, '-o','LineWidth', 2, 'MarkerSize', 8);
xlabel('n', 'FontSize', 36);
ylabel('min f(x)', 'FontSize', 36);
set(gca, 'FontSize', 20, 'LineWidth', 2);
xlim([0, 50]);
grid on;
axis square
ax = gca;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
% ax.XMinorGrid = 'on';
% ax.YMinorGrid = 'on';
ax.FontSize = 40;
ax.XAxis.FontSize = 36;
ax.YAxis.FontSize = 36;
ax.LineWidth = 2;
% Display grid
 grid off;
axis square
% Hold off to end the plot
hold off;