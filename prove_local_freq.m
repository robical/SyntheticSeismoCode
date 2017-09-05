%% Prova di stima di frequenza locale

clear all;
close all;
clc;


%Comincio a vedere come si comporta con una sinusoide la stima di frequenza
%istantanea

fc=200;
dt=1/fc;
t=0:dt:1-dt;
t=t(:);
N=length(t);


f1=30;
y=sin(2*pi*f1*t);

figure,plot(t,y,'k')

%Stima della frequenza istantanea

fre=f1*ones(size(y));

%Prima finestro il segnale
%il terzo parametro è il reciproco della sigma (dev std nel tempo), ed è
%una misura della larghezza in frequenza della finestra, default 2.5 -->
%0.4 nel tempo
w=window(@gausswin,N,3.0);

[fst]=stifre_b(y,0,fc);

hold on,plot(t,w,'r')

%Segnale finestrato

yf=y.*w;

figure,plot(t,yf,'g'),title('Osservazione finestrata con finestra gaussiana');

[fstw]=stifre_b(yf,0,fc);

figure,plot(t,abs(fst-fre)*(100/f1),'k'),hold on,plot(t,abs(fstw-fre)*(100/f1),'b-'),...
    xlabel('Tempo [s]'),ylabel('Errore % di stima della frequenza istantanea'),...
    title('Errori assoluti (%) nella stima di frequenza istantanea'),...
    legend('Non finestrato','Finestrato')

%Osservazione degli spettri

Y=fft(y);
YF=fft(yf);

fk=assefr(N,fc,0);

figure,subplot(2,2,1),plot(fk,abs(fftshift(Y)),'k'),title('Spettro d''ampiezza segnale non finestrato'),...
    subplot(2,2,2),plot(fk,abs(fftshift(YF)),'r'),title('Spettro d''ampiezza segnale finestrato'),...

subplot(2,2,3),stem(fk,angle(fftshift(Y)),'k'),title('Spettro di fase segnale non finestrato'),...
    subplot(2,2,4),stem(fk,angle(fftshift(YF)),'r'),title('Spettro di fase segnale finestrato'),

%Creazione del segnale analitico da segnale finestrato e non finestrato

yana=hilbert(y);
yfana=hilbert(yf);

%Grafico inviluppo d'ampiezza e fase istantanea del segnale analitico

figure,subplot(2,2,1),plot(t,abs(yana),'k'),title('Inviluppo d''ampiezza segnale analitico (no fin)'),...
    subplot(2,2,2),plot(t,abs(yfana),'r'),title('Inviluppo d''ampiezza segnale analitico (fin)'),...
    subplot(2,2,3),stem(t,angle(yana),'k'),title('Fase istantanea segnale analitico (no fin)'),...
    subplot(2,2,4),stem(t,angle(yfana),'r'),title('Fase istantanea segnale analitico (fin)'),...

%Derivazione numerica della fase del segnale analitico ed estrazione della
%frequenza istantanea
h=[1 -1]*fc;
fas_un_y=unwrap(angle(yana));
fas_un_yf=unwrap(angle(yfana));

%Plotting delle fasi unwrapped

figure, subplot(1,2,1),plot(t,fas_un_y,'k'),subplot(1,2,2),plot(t,fas_un_yf,'r'),...
    title('Fasi unwrapped del segnale analitico (1) non finestrato (2) finestrato'),...
    xlabel('Tempo [s]'),ylabel('Fase [rad]'),

fr1=(1/(2*pi))*conv(fas_un_y,h);
fr1f=(1/(2*pi))*conv(fas_un_yf,h);
fr1=fr1(:);
fr1=[fr1(2);fr1(2:end-1)];
fr1f=fr1f(:);
fr1f=[fr1f(2);fr1f(2:end-1)];

figure, plot(t,fr1,'k'), hold on,plot(t,fr1f,'r'),title('Stime frequenza istantanea'),...
    legend('Non finestrato','Finestrato'),xlabel('Tempo [s]'),ylabel('Frequenza [Hz]')

%% Prova con + sinusoidi localizzate nel tempo

clear all;
close all;
clc;


%Comincio a vedere come si comporta con una sinusoide la stima di frequenza
%istantanea

fc=500;
dt=1/fc;
t=0:dt:1-dt;
t=t(:);
N=length(t);


f1=3;
y1=sin(2*pi*f1*t);

f2=10;
y2=sin(2*pi*f2*t);

%sommo

ytot=y1+y2;

%Localizzo temporalmente

%Prima finestro il segnale
%il terzo parametro è il reciproco della sigma (dev std nel tempo), ed è
%una misura della larghezza in frequenza della finestra, default 2.5 -->
%0.4 nel tempo
w=window(@gausswin,N,2.0);

ytot_loc=ytot.*w;

%Regolarizzatore - derivata prima -> diff centrali

S=diag(zeros(length(t),1),0)-diag(ones(length(t)-1,1),-1)+diag(ones(length(t)-1,1),1);
%S(1,1)=0;
%S=S./(sqrt(sum(sum(S.^2))));

%Osservo la fase del segnale analitico, con localizzazione temporale
ylocana=hilbert(ytot_loc);
y1ana=hilbert(y1);
y2ana=hilbert(y2);

fase_ana_loc=imag(log(ylocana));
fase1_ana=imag(log(y1ana));
fase2_ana=imag(log(y2ana));


figure,subplot(2,2,1),plot(t,fase_ana_loc,'k'),...
    xlabel('Tempo [s]'),ylabel('Fase [Rad]'),title('Fase wrapped del segnale analitico somma'),a=axis();
    subplot(2,2,3),plot(t,fase1_ana,'k'),axis(a),...
    xlabel('Tempo [s]'),ylabel('Fase [Rad]'),title('Fase wrapped del segnale analitico 1'),...
    subplot(2,2,4),plot(t,fase2_ana,'k'),axis(a),...
    xlabel('Tempo [s]'),ylabel('Fase [Rad]'),title('Fase wrapped del segnale analitico 2'),

%Osservo la fase degli stessi segnali, in frequenza, dove lo spettro di
%ampiezza è non nullo

Nfft=2^(ceil(log2(N)));
Yloc=fftshift(fft(ytot_loc,Nfft));
Y1=fftshift(fft(y1,Nfft));
Y2=fftshift(fft(y2,Nfft));
fk=assefr(Nfft,fc,0);

figure,subplot(2,2,1),plot(fk,(angle(Yloc)),'k'),xlabel('Frequency [Hz]'),...
    ylabel('Phase [rad]'),title('Spettro di fase del segnale somma'),...
    subplot(2,2,2),plot(fk,(abs(Yloc)),'k'),xlabel('Frequency [Hz]'),...
    ylabel('Amplitude'),title('Spettro di ampiezza del segnale somma'),...
    
%Ricostruzione nel tempo del segnale somma tramite somma di Fourier
sric=zeros(size(t));
for i=1:length(fk)
    if(abs(Yloc(i))>135)
        sric=sric+exp(1i*(2*pi*fk(i)*t+angle(Yloc(i))));
    end
end

figure,plot(t,sric,'k'),hold on,title('Segnale ricostruito & originale'),...
    plot(t,ytot_loc,'g-'),hold on,plot(t,ytot,'r-.'),legend('Ricostruito','Originale localizzato','Originale'),...
    xlabel('Tempo [s]'),ylabel('Ampiezza')

%% Regolarizzazione in frequenza

clear all;
close all;
clc;

fc=300;
dt=1/fc;
t=0:dt:1;
t=t(:);

f1=10:1:149;

for i=1:length(f1)


y=cos(2*pi*f1(i)*t);

%Stima di frequenza locale con metodo di Fomel
S=zeros(length(y));

%Derivata prima
%S=S+diag(ones(length(y),1),0)-diag(ones(length(y)-1,1),-1);

%Laplaciano
S=S-diag(2*ones(length(y),1),0)+diag(ones(length(y)-1,1),-1)+diag(ones(length(y)-1,1),1);

%filtraggio in frequenza della soluzione - minimizzo il filtraggio passa
%alto (derivata prima e laplaciano sono già filtri passa alto, dunque fanno già
%questa cosa)

e=1e-20;
[fstfom]=stifre_ser(y,e,S,fc);
fstfom=fstfom(:);
f_mis_fom(i)=mean(fstfom);
[fst_ist]=stifre_b(y,0,fc);
fst_ist=fst_ist(:);
f_mis_ist(i)=mean(fst_ist);
end

figure,plot(f1,f_mis_ist,'k'),hold on,plot(f1,f_mis_fom,'r'),...
    xlabel('Real Frequency'),ylabel('Estimated frequency'),...
    title('Comparison between the IF and Fomel approach to frequency estimation'),...
    legend('Istantanea','Fomel - inversione')

% figure,plot(t,fst,'k'),title('Stima frequenza locale Fomel'),...
%     xlabel('Tempo [s]'),ylabel('Frequenza [Hz]')


