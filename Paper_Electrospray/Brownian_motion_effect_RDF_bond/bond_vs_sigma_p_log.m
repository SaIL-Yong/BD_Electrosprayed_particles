close all
clear all
clc

x_1 = [5e-5 ,10e-5, 25e-5 100e-5, 200e-5, 400e-5, 600e-5, 800e-5];
y_1 = [0.45 ,0.4704, 0.485, 0.5116, 0.574, 0.6322, 0.6890, 0.7201];

figure;
semilogx(x_1, y_1, 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
axis square;
xlabel('\sigma_p (C/m^2)', 'FontSize', 36);
ylabel('\psi_6', 'FontSize', 36);
ax = gca;
ax.XTick = [1e-4, 1e-3];
ax.XTickLabel = { '10^{-4}', '10^{-3}'};
ylim([0.43 0.75]);
xlim([1e-5 8e-3]); 
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.FontSize = 36;
ax.XAxis.FontSize = 36;
ax.YAxis.FontSize = 36;
ax.LineWidth = 2;
