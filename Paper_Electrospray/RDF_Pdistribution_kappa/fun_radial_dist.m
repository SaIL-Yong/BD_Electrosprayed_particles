function [Rad_Dist] = fun_radial_dist(data, frame, num_particles, bin_width, Rmin, Rmax, weight)
    ni = 1;
    count = 0;
    N = Rmin:bin_width:Rmax;
    Bin_Count = zeros(length(N), num_particles);
    Vol = zeros(length(N), num_particles);
    Rad_Dist = zeros(length(N),7850);
  x_center = 4706;
    y_center = 4957;
    circle_radius = 500;
    
    for i = 1:length(N)
        Num_Particles_In_Circle = 0;
        for j = (frame-1) * num_particles + 1:frame * num_particles
            dist_to_center = sqrt((data(j, 5) - x_center)^2 + (data(j, 6) - y_center)^2);
            if dist_to_center <= circle_radius
                Num_Particles_In_Circle = Num_Particles_In_Circle + 1;
                for k = (frame-1) * num_particles + 1:frame * num_particles
                    dist = sqrt((data(j, 5) - data(k, 5))^2 + (data(j, 6) - data(k, 6))^2);
                    if dist >= N(i) && dist < N(i) + bin_width
                        count = count + 1;
                    end
                end
                Rad_Dist(i, Num_Particles_In_Circle) = (count / (2 * pi * N(i) * bin_width));
            end
            count = 0;
            ni = ni + 1;
        end
        ni =1;
    end
    disp(Num_Particles_In_Circle)
end