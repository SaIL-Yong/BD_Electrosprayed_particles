close all 
clear all
clc
data = load('N_values_1.csv');
data_1 = load('510-5.csv');
data_2 = load('10-4.csv');
 data_3 = load('2.510-4.csv');
 S = load('colorblind_colormap.mat'); 
CT = S.colorblind;
plot(data, data_1, 'Color', CT(1,:), 'LineWidth', 2)
hold on
plot(data, data_2, 'Color', CT(6,:), 'LineWidth', 2)
hold on
 plot(data, data_3, 'Color', CT(10,:), 'LineWidth', 2)
axis square
ax = gca;
ylim([0 7])
xlim([7 100])
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.FontSize = 40;
ax.XAxis.FontSize = 36;
ax.YAxis.FontSize = 36;
ax.LineWidth = 2;
xlabel('r (μm)', 'FontSize', 36)
ylabel('g(r)', 'FontSize', 36)
 ylim([0 5])
legend('\sigma_p = 5×10^-^5 C/m^2', '\sigma_p = 10^-^4 C/m^2', '\sigma_p = 2.5×10^-^4 C/m^2', ...
    'FontSize', 22, 'Location', 'northeast', 'EdgeColor', 'none');