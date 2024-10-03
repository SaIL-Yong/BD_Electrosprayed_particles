close all 
clear all
clc
data = load('N_values.csv');
data_1 = load('50.csv');
data_2 = load('200.csv');
 data_3 = load('400.csv');
 data_4 = load('800.csv');
S = load('colorblind_colormap.mat'); 
CT = S.colorblind;
figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.8, 0.8]);
plot(data, data_1, 'Color', CT(1,:), 'LineWidth', 2)   
hold on
plot(data, data_2, 'Color', CT(6,:), 'LineWidth', 2)   
hold on
plot(data, data_3, 'Color', CT(10,:), 'LineWidth', 2)   
hold on
plot(data, data_4, 'Color', CT(12,:), 'LineWidth', 2)   
legend('\kappa = 50', '\kappa = 200', '\kappa = 400', '\kappa = 800', 'FontSize', 36, 'Location', 'northeast', 'EdgeColor', 'none')
axis square
ax = gca;
ylim([0 5])
xlim([7 100])
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.FontSize = 30;
ax.XAxis.FontSize = 36;
ax.YAxis.FontSize = 36;

% Set box line width
ax.LineWidth = 2;

xlabel('r (μm)', 'FontSize', 36)
ylabel('g(r)', 'FontSize', 36)
print('plot.tif', '-dtiff', '-r300');