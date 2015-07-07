%ES1 - Main Program
clear variables


FIRST

INIT

N_grid = linspace(0,1,N);
phi_left = 0;
phi_right = 0;

sink_countl = 0;
sink_countr = 0;
sink_countil = 0;
sink_countir = 0;
wall_ions = zeros(N,1);
gridt = linspace(0,(nt+1)*dt,(nt+1));
x_hist = zeros(nt,1);
xi_hist = zeros(nt,1);
vi_hist = zeros(nt,1);
v_hist = zeros(nt,1);
x_hist(1) = x(1);
xi_hist(1) = ionx(1);
v_hist(1) = v_hist(1);
vi_hist(1) = vxi(1);

SINK

SETRHO


FIELDS

SETV



    %F(3) = struct('cdata',[],'colormap',[]);
for i=1:nt

if mod(i,1) == 0


%{
    figure(1) % create new figure
    subplot(2,3,1) % first subplot
    plot(gridx,density_e, gridx, density_i)
    title('Density')
    subplot(2,3,2) % first subplot
    hist([vx,vxi],ng)
    title('Velocity Hist.')
    subplot(2,3,3) % first subplot
    scatter(x,vx)
    hold on
    scatter(ionx,vxi)
    axis([0 1 -1e8 1e8])
    title('Phase Space')

    hold off
    subplot(2,3,4) % first subplot
    plot(gridx,phi)
    title('Potential')
    subplot(2,3,5) % first subplot
    plot(gridx,E)
    title('E field')
    subplot(2,3,6) % first subplot
    hist(wall_ions(1:(sink_countil + sink_countir)), ng)
    title('Ion Impact v') 
    
%}
end

   figure(2)
    scatter(x,vx, '.')
    ylim([-1e6 1e6])
    hold on
    scatter(ionx,vxi, '.')
    title('Phase Space')
    xlabel('Position');
ylabel('Velocity');
    hold off

       F(i) = getframe;
   

    ACCEL
    MOVE
x_hist(i+1) = x(1);
xi_hist(i+1) = ionx(1);
v_hist(i+1) = vx(1);
vi_hist(i+1) = vxi(1);
    SINK
    sink_countl;
    sink_countr;
    sink_countil;
    sink_countir;
  
    SETRHO

    FIELDS

    i
end

numtimes=1;

fps=1;
figure
movie(F,numtimes,fps);

movie2avi(F, 'two_stream.avi');
