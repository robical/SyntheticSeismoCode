%% Esempio POCS (articolo Papoulis)

clear all;
close all;
clc;

%Parametri

sig=2;
T=pi/(5*sig);
fc=(7*(2*sig));

%asse temporale

t=(-15*T:1/fc:15*T)';


Nfft=length(t);
fk=assefr(Nfft,fc,1)';
Nite=800;


%Creo finestratura del sinc
y=zeros(size(t));
y(abs(t)<=T)=sin(sig*t(abs(t)<=T))./(pi*t(abs(t)<=T));

%originale
ori=sin(sig*t)./(pi*t);



%Preparo il segnale per la FFT (dato che è anticausale)
tn=[t(end/2+1:end);t(1:end/2)];
gg(:,1)=[y(end/2+1:end); fliplr(y(1:end/2))];

%filtro rect in frequenza, banda sigma
ref=zeros(size(fk));
ref(abs(fk)<=sig)=1;

%filtro rect nel tempo, durata T
ret=zeros(size(t));
ret(abs(t)<=T)=1;

%POCS method

i=1;
G(:,i)=fft(gg(:,i),Nfft);

for i=2:Nite

    %Moltiplico


    F(:,i)=G(:,i-1).*ref;

    %Antitrasformo
    f(:,i)=ifft(F(:,i),'symmetric');

    %Riaggiusto il segnale (torna anticausale)

    f(:,i)=[f(end/2+1:end,i); fliplr(f(1:end/2,i))];

    %Costruisco nuova approssimazione

    g(:,i)=y.*ret+f(:,i).*(ones(size(t))-ret);

    %Giro di nuovo il segnale

    gg(:,i)=[g(end/2+1:end,i); fliplr(g(1:end/2,i))];

    %Trasformo
    G(:,i)=fft(gg(:,i),Nfft);
end

figure,plot(t,g(:,end)),hold on,plot(t,ori,'r-')
    
