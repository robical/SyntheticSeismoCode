%% Gradiente coniugato secondo Fomel (Shaping Regularization)

% clear all;
% close all;
% clc;

load('/geoscratch/workgroup/Local_Attributes/Software/Matlab/Attributi_codici/workspacefomel'); 

%forward
F=diag(den);
dim_m=size(F,2);
dim_p=dim_m;


%finestra triangolare
dim_w=5; %larghezza totale shaping
w=triangularwin(dim_w);




%triangulae smoothing
Z=smooth(w,dim_m,dim_p);

%dati
d=num;
dim_n=length(d);

%Parametri per shaping regulari/geodata10/calandrinization (lam,N,tol)
% N= cardinalità dello spazio dove avviene la ricerca = dim_m in questo
% caso
% tol= tolleranza, per testare la convergenza della soluzione
% lam= fattore di non ben precisata natura
tol=1e-6;
lam=1e-6;

%inizializzazione
p=zeros(dim_p,1);
m=zeros(dim_m,1);
r=-d;
sp=zeros(dim_p,1);
sm=zeros(dim_m,1);
sr=zeros(dim_n,1);

for i=1:dim_m
    gm(:,i)=F'*r - lam*m; %nello spazio del modello
    gp(:,i)=Z'*gm(:,i) + lam*p; %nello spazio del modello riparametrizzato
    gm(:,i)=Z*gp(:,i); %ancora nello spazio del modello (stessa iterazione)
    gr(:,i)=F*gm(:,i); %nello spazio dei dati (nuovo residuo)
    
    rho(i)=gp(:,i)'*gp(:,i); %peso rho all'iterazione i
    
    if (i==1)
        beta(i)=0; %passo beta
    else
        beta(i)=rho(i)/rho(i-1);
        if (beta(i)<tol || (rho(i)/rho(1))<tol)
            disp('Convergenza raggiunta!');
            disp(strcat('Beta : ',num2str(beta(i))));
            disp(strcat('Rho : ',num2str(rho(i))));
            disp(strcat('# iterazioni : ',num2str(i)));
            break;
        end
        
        %Aggiornamento 1
        sr=gr(:,i)+beta(i)*sr; 
        sm=gm(:,i)+beta(i)*sm;
        sp=gp(:,i)+beta(i)*sp;
        
        alfa(i)=rho(i)/(sr'*sr+ lam*(sp'*sp - sm'*sm)); %altro peso
        
        %Aggiornamento 2
        p=p - alfa(i)*sp;
        m=m - alfa(i)*sm;
        r=r - alfa(i)*sr;
    end
end

%plotting del modello
figure,plot(m), grid on , hold on

% Prova di precondizionamento con filtraggio in frequenza della soluzione
% W=dftmtx(dim_m);
% F=diag(conv(triangularwin(99),triangularwin(100)));
% P=F*W;
% 
% 
% [sol,itr]=SD(R,b,tol,Maxitr,damp)
        
    