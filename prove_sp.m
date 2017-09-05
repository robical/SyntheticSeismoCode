%% Prove aliasing spaziale

clear all;
close all;
clc;

dx=2*1e-1;
dz=1e-1;

fcx=1/dx; %freq campionamento spaziale in x
fcz=1/dz; %freq campionamento spaziale in z

c=3*1e3; %mezzo omogeneo, velocità

x=0:dx:20;
z=0:dz:50;

[X,Z]=meshgrid(x,z);

%numeri d'onda di cut-off della griglia spaziale

kx_Ny=(2*pi*(fcx/2))/c;
kz_Ny=(2*pi*(fcz/2))/c;

%numero d'onda di cut-off della griglia

k_Ny=sqrt(kx_Ny^2+kz_Ny^2); %per ogni direzione

%tettoia
f=100;
w=2*pi*f;
the=deg2rad(30);

k_tet=(w/c);

kx=(w/c)*sin(the);
kz=(w/c)*cos(the);

tet=exp(1i*(kx*X+kz*Z));

figure,mesh(X,Z,real(tet)),...
    xlabel('X'),ylabel('Z'),zlabel('Ampiezza')

k_Ny
k_tet