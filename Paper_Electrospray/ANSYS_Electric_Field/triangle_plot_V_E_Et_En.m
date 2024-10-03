%% Plot Electric Field on Triangle Droplet Surface
% Joe Prisaznuk 8/29/2023

%% Load mesh data, voltage, and electric field

clc; clear variables; close all

shape = "tri"; % droplet shape
vol = 0.3; % droplet volume [μl]
geom = "offset_0.001"; % mesh geometry (triangle surface, offset by 0.001 mm = 1 μm)
dataFile = sprintf("%s_%.3f_%s_mesh_and_fields.mat",shape,vol,geom);
load(dataFile,"tri","V","E","Et","En")
mag = sqrt(sum(E.^2,2)); % for normalizing e field
E1 = E./mag; % vector magnitude becomes unity

%% plot V on mesh

figure
patch(tri.mesh,FaceVertexCData=V,FaceColor='interp',FaceAlpha=1,EdgeColor='k',EdgeAlpha=0.5);
view(-88, 38)
axis equal off
lims = [min(V) max(V)];
cb = colorbar; clim([0 lims(2)*0.2])
cb.Label.String = 'Voltage (Volts)';
title("$V$",'Interpreter','latex');

%% plot E field magnitude on mesh

figure
patch(tri.mesh,FaceVertexCData=mag,FaceColor='interp',FaceAlpha=1,EdgeColor='k',EdgeAlpha=0.5);
view(-88, 38)
axis equal off
lims = [min(mag) max(mag)];
cb = colorbar; clim([0 lims(2)*0.2])
cb.Label.String = 'Electric Field Strength (V/m)';
title("$|\vec{E}|$",'Interpreter','latex');

%% plot Et magnitude on mesh

magEt = sqrt(sum(Et.^2,2)); % magnitude of Et field

figure
patch(tri.mesh,FaceVertexCData=magEt,FaceColor='interp',FaceAlpha=1,EdgeColor='k',EdgeAlpha=0.5);
view(-88, 38)
axis equal off
lims = [min(magEt) max(magEt)];

cb = colorbar; clim([0 2e3])
cb.Label.String = 'Tangential Electric Field Strength (V/m)';
title("$|\vec{E}_t|$",'Interpreter','latex');

%% plot En magnitude on mesh

magEn = sqrt(sum(En.^2,2)); % magnitude of En field

figure
patch(tri.mesh,FaceVertexCData=magEn,FaceColor='interp',FaceAlpha=1,EdgeColor='k',EdgeAlpha=0.5);
view(-88, 38)
axis equal off
cb = colorbar; set(gca,'ColorScale','log');
clim([1e4 1e5])
cb.Label.String = 'Normal Electric Field Strength (V/m)';
title("$|\vec{E}_n|$",'Interpreter','latex');

%% plot tangetial E field on mesh (with color)

figure
Etn = Et./magEt; % vector magnitude becomes unity

m = magEt;
m(m <= 0) = 0; m(m >= 2e3) = 2e3;
cmin = min(m,[],'all'); cmax = max(m,[],'all');
M = round((m-cmin)/(cmax-cmin)*64); M(M == 0) = 1;
cmap = jet(64);

patch(tri.mesh,FaceColor='none',FaceAlpha=0.5,EdgeColor='k',EdgeAlpha=0.5);
hold on
% note: drawing individual vectors like this is very inefficient, it will
% take awhile to run
for ii = 1:1:length(Etn)
    quiver3(tri.mesh.vertices(ii,1),tri.mesh.vertices(ii,2),tri.mesh.vertices(ii,3),...
        Etn(ii,1),Etn(ii,2),Etn(ii,3),0.05,Color=cmap(M(ii,1),:),LineWidth=1.5,MaxHeadSize=1)
end
view(-88, 38)
axis equal off
colormap(jet); cb = colorbar; clim([0 2e3])
cb.Label.String = 'Tangential Electric Field Strength (V/m)';
title("$\vec{E}_t$",'Interpreter','latex');

%% plot tangential E field vectors (to scale) on mesh

figure
patch(tri.mesh,FaceColor='none',FaceAlpha=0.5,EdgeColor='k',EdgeAlpha=0.5);
hold on
quiver3(tri.mesh.vertices(:,1),tri.mesh.vertices(:,2),tri.mesh.vertices(:,3),...
    Et(:,1),Et(:,2),Et(:,3),10,Color='r',LineWidth=1.5)
view(0,90)
axis equal off
title("$\vec{E}_t$",'Interpreter','latex');
