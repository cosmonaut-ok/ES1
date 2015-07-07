% INIT - Initial values for each species

N = 10000; % Number of simulation particles

q =  1.602E-19;

ne = 1280E5; % Plasma density
nN = ne/N; % Number of real particles per simulated particle
T = 20; % electron temperature in eV
wc = 0; % Cyclotron frequency
qm = q/9.11e-31; % q/m charge to mass ratio (C/kg)
qmi = q/1.66e-27; % q/m charge to mass ratio (C/kg)
vt1 = 2*0; % RMS thermal velocity for random velocities
vt2 = 1; % RMS thermal velocity for ordered velocities
v0 = 0; % Drift velocity

wp = sqrt(ne*(q)^2*epsi/9.11e-31); % Plasma frequency

%%%%%%%%%Computer defined variable
%q =  1.602E-19; % wp*wp*L/N/epsi/qm;
m = q/qm;
mi = q/qmi;
m_super = m*nN;

x = zeros(N,1); % position vector
ionx = zeros(N,1); % position vector
vx = zeros(N,1); % velocity x vector
vxi = zeros(N,1); % velocity x vector
vy = zeros(N,1); % velocity y vector

% Set evenly spaced spatial distribution

    x = transpose(linspace(0,1,N));
    ionx = transpose(linspace(0,1,N));

%x(1) = 0.5 -(1E-5)/L;
%ionx(1) = 0.5 + (1E-5)/L;

%Excited wave energies
wave_E = qm*e0/w0*2/3.1415;
wave_Ei = qmi*e0/w0*2/3.1415;

% Set random gaussian velocity distribution for electrons
std_dev = sqrt(T*qm);
std_devi = sqrt(T*qmi);

vx(1:N) = normrnd(wave_E,std_dev/100,N,1);
vxi(1:N) = normrnd(wave_Ei,std_devi/100,N,1);

%vx(1) = 0;
%vxi(1) = 0;

for z = 1:N/2
    vx(2*z) = normrnd(-wave_E,std_dev/100);
    vxi(2*z) = normrnd(-wave_Ei,std_devi/100);
end
