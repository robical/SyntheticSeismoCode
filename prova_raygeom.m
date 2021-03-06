%% Prova funzionale da minimizzare per ray tracing geometrico

clear all;
close all;
clc;

%parametri del mezzo stratificato

%velocità
v=[1300 1200 1600];


%spessori
s=[-500 -300 -200];

off=100; %offset in metri source-rx

mp=off/2; %mid point

dx=1;
x1=0:dx:mp;
x2=0:dx:mp;

f=zeros(length(x1),length(x2));
for i=1:length(x1)
    for kk=1:length(x2)
        xx=[x2(kk) (x1(i)-x2(kk)) (mp-(x1(i)+x2(kk)))];
        for l=length(s):-1:1
            f(i,kk)=f(i,kk)+(sqrt(s(l)^2+xx(l)^2)/v(l));
        end
    end
end

figure,imagesc(x1,x2,f),...
    xlabel('x1'),ylabel('x2'),...
    colorbar,colormap(1-gray),

[val1,ind1]=min(f); %restituisce un vettore del minimo x1 per ogni x2
[val2,ind2]=min(val1); %ind2 contiene l'indice del x2 da scegliere

x1_min=x1(ind1(ind2));
x2_min=x2(ind2);

x1_min
x2_min

%raggio
X=[0 x1_min (mp-x2_min) mp mp+x2_min mp+x1_min off];
Y=[0 s(1) sum(s(1:2)) sum(s(1:3)) sum(s(1:2)) s(1) 0];

figure,...
    plot(0,0,'*g'),hold on,...
    plot(off,0,'or'), hold on,...
    line(X,Y)
    