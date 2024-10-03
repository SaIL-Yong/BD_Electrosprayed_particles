clear all
close all
clc


[data]=dlmread('traj_1p_xyz_0.txt','\t',0,0);
% % 
bin_width=0.5;
num_particles=9000;
num_frames=1229;
starting_frame=1029;
n_every=10;
num_fun=((num_frames-starting_frame)/n_every)+1;

Rmin=1;
Rmax=100;
weight=1;
N = Rmin:bin_width:Rmax;


Rad_Dist=zeros(length(N),7850,1);

Mean=zeros(length(N),num_fun);
Mean_1=zeros(length(N),1);

nn=0;
for j=starting_frame:n_every:num_frames
    nn=nn+1;
     Rad_Dist(:,:,1)=fun_radial_dist(data,j,num_particles,bin_width,Rmin,Rmax,weight);
    for i=1:1:length(N)
        Mean(i,nn)=mean(Rad_Dist(i,1:7850,1));

    end
end

Mean_1(:)=mean(Mean,2);


figure
plot(N(3:end)+0.25,(Mean_1(3:end)/(7850/(pi*500*500))), 'LineWidth', 2)
 xlim([0 100])
xticks(0:10:100)
% set(gcf,'position',[x0,y0,3.38,3.38])
% ax = gca; 
axis square

ax = gca;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';

ax.FontSize = 30;
ax.XAxis.FontSize = 30;
ax.YAxis.FontSize = 30;

ax.LineWidth = 2;

xlabel('r (\mum)', 'FontSize', 30)
ylabel('\rho(r)', 'FontSize', 30)

output_data.N = N(3:end)+0.25;
output_data.RDF = transpose((Mean_1(3:end)/(7850/(pi*500*500)))/1);

save('RDF_data_25_0.025_bw_1.mat', 'output_data');

fid = fopen('N_values.csv', 'w');
fprintf(fid, '%f,', output_data.N); % Note the comma after %f
fclose(fid);

% Save RDF values to CSV
fid = fopen('RDF_values_25_0.025_bin_w_1.csv', 'w');
fprintf(fid, '%f,', output_data.RDF); % Note the comma after %f
fclose(fid);
