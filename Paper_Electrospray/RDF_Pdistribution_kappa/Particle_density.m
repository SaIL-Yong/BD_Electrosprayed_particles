close all
clear all
D = load('data_50.mat');
C = load('data_200.mat');
B = load('data_400.mat');
A = load('data_800.mat');
S = load('colorblind_colormap.mat'); 
CT = S.colorblind;
figure('Units', 'normalized', 'Position', [0.1, 0.1, 0.8, 0.8]);
plot(A.X_av_total_column2, A.Y_av_total_column2, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', CT(1,:))
hold on
plot(B.X_av_total_column2, B.Y_av_total_column2, '-o', 'LineWidth', 2, 'MarkerSize', 8,'Color', CT(6,:))
hold on
plot(C.X_av_total_column2, C.Y_av_total_column2,'-o', 'LineWidth', 2, 'MarkerSize', 8,'Color', CT(10,:))
hold on
plot(D.X_av_total_column2, D.Y_av_total_column2,'-o', 'LineWidth', 2, 'MarkerSize', 8,'Color', CT(12,:))
hold on

legend('\kappa = 50', '\kappa = 200', '\kappa = 400', '\kappa = 800', 'FontSize', 24, 'Location', 'northeast', 'EdgeColor', 'none')
axis square
ax = gca;
ylim([0 2.8])
% xlim([7 100])
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
xticks([0 1000 2000]);
ax.FontSize = 40;
ax.XAxis.FontSize = 36;
ax.YAxis.FontSize = 36;
ax.LineWidth = 2;

xlabel('L (μm)', 'FontSize', 36)
ylabel('Particle density', 'FontSize', 36)
print('paricle_density.tif', '-dtiff', '-r300');