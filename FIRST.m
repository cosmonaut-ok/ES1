%FIRST - Set initial input values
%Program parameters

weight = 0; %zero for nearest grid point, one for linear


%Input Variables
L = 0.001; % Physical length of system in meters
nsp = 1; % Number of particle species
dt = 5e-12; % Time step in seconds
nt = 300; % Number of time steps
ng = 2^7; % Number of spatial grid points - only change the power of 2
epsi = 1/8.85e-12; % 1 over epsilon naught (F/m) Epsilon normalized to 1
e0 = 5e7; % Add uniform electric field e0*cos(w0*time)
f = 3e12;
w0 = 2*3.1415*f;
BC = 0; %Boundary condition 0-mirror 1-wall

gridx  = 0:1/(ng-1):1;
dx = gridx(2)*L;

k = 1.381e-23;			%boltzmann constant Joules per K