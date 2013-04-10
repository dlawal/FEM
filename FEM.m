%% Project #2
% Authors: Blake Levy and Adedayo Lawal
clc;clear;
%% Set up Parameters
c = 299792458;
mu0 = (4*pi)*1e-7;
epsilon = 1/(mu0*c^2);
eps0 = epsilon;
f = 1e6; % initial frequency
w = 2*pi*f;
k0 = w/c;
lamb0 = c/f;
%% Set up geometry
m = 50; % Number of elements
n = m+1; % Number of elements
L = 5*lamb0; % Length of slab is 5x free space wavelength
x = 0:L/m:L; % discretize dielectric slab with M elements
theta = 0:2*pi/m:2*pi; % incident angle range from 0 to 90 degrees
e_left = eps0 + eps0*sqrt(x/L); 
kx = k0*sqrt(mu0*e_left - sin(theta).^2);
%% FEM
eta = zeros(1,m);
R = zeros(1,m);
R(1) = -1;
for i = 2:m+1
    eta(i) = (mu0*kx(i) - mu0*kx(i-1))/(mu0*kx(i) + mu0*kx(i-1));
    R(i) = exp(2*1j*kx(i)*x(i))*((eta(i) + R(i-1)*exp(-2*1j*kx(i-1)*x(i)))...
        /(1+eta(i)*R(i-1)*exp(-2*1j*kx(i-1)*x(i))));
end
subplot(1,2,1)
plot(x/L,e_left); title('Permitivity profile in slab');
ylabel('permitivity');xlabel('distance from PEC (x/L)');
subplot(1,2,2)
plot(theta,abs(R))




