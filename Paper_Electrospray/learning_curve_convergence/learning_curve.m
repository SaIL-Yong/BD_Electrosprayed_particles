data = load('training_loss_data.mat');
epochs = data.epochs;
train_loss = data.train_loss;
figure;
plot(epochs, train_loss, 'LineWidth', 2);
xlabel('Epochs','FontSize', 36);
ylabel('Loss','FontSize', 36);
set(gca);
grid on;
xlim([0, 500]); 
axis square
ax = gca;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.FontSize = 40;
ax.XAxis.FontSize = 36;
ax.YAxis.FontSize = 36;
ax.LineWidth = 2;
grid off;
axis square
hold off;