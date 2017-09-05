%% Prove gradiente e gradiente coniugato
clear all;
close all;
clc;


N=10000;
M=700;

%Per matrici forward dense, è molto più veloce la fattorizzazione
%per matrici sparse sono più veloci i metodi iterativi


%Esempio matrice sparsa

disp('Esempio con matrice sparsa 10000x700 :');

i=randint(1,N*10,[1 N]);
j=randint(1,N*10,[1 M]);
s=randn(1,N*10);
R = sparse(i,j,s,N,M);

b=randn(N,1); %vettore dati

Mitr=5000;
tol=1e-8;

disp('Velocità SD: ');
tic;
[sol,itr]=SD(R,b,tol,Mitr,0);
toc;


disp('Velocità fattorizzazione: ');
tic;
sol_fat=R\b;
toc;

disp('MSE soluzione tra fattor e SD: ');
(sol_fat-sol)'*(sol_fat-sol)

disp('Norma Residuo per soluzione con fattorizzazione: ');
(R*sol_fat-b)'*(R*sol_fat-b)

disp('Norma Residuo per soluzione con SD: ');
(R*sol-b)'*(R*sol-b)

%Esempio matrice densa

N=100;
M=70;

disp('Esempio con matrice densa 100x70: ');

R=randn(N,M); %matrice forward

b=randn(N,1); %vettore dati

Mitr=5000;
tol=1e-8;

disp('Velocità SD: ');
tic;
[sol,itr]=SD(R,b,tol,Mitr,0);
toc;


disp('Velocità fattorizzazione: ');
tic;
sol_fat=R\b;
toc;

disp('MSE soluzione tra fattor e SD: ');
(sol_fat-sol)'*(sol_fat-sol)

disp('Norma Residuo per soluzione con fattorizzazione: ');
(R*sol_fat-b)'*(R*sol_fat-b)

disp('Norma Residuo per soluzione con SD: ');
(R*sol-b)'*(R*sol-b)


%% idea su cosa fa con shaping regularization

clear all;
close all;
clc;

