%Controlli su sismogramma sintetico

%Plotting

% figure,imagesc(t,t,W),xlabel('Ritardo [s]'),...
%     ylabel('Temprms=sqrt(num/dtao [s]'),...
%     title('Matrice delle ondine ritardate con assorbimento'),colormap(hot)

% figure, imagesc(off,t,sr),...
%     title('Common shot gather'),...
%     xlabel('Offset [m]'),ylabel('Tempo [s]'),colormap(gray),...
%     hold on,imagesc(off,t,sr_2)


% hh=figure,
% 
% for kk=1:size(sr,2)
%     
%     cla(hh);
%     plot(t,sr(:,kk),'k'),hold on,plot(t,sr_2(:,kk),'r-'),...
%     xlabel('Tempo [s]'),ylabel('Ampiezza'),...
%     title('Confronto tra stessa traccia con SH e Raggi'),...
%     legend('Shifted Hyperbola','Raggi');
%     
%     M(kk)=getframe;
% end
% 
% movie(M)

%confronto con plot e vertical time - ok funziona
% vtime=cumsum(s./c*2);
% 
% figure,plot(TT),hold on,plot(ARTtime','--'),hold on,...
%     plot(41*ones(3,1),vtime,'*k')

% vtime=cumsum(s./c*2);
% 
% figure,plot(TT),hold on,plot(ARTtime','--'),hold on,...
%     plot(41*ones(3,1),vtime,'*k')

% figure,bar(cumsum(s),c),title('Profilo di velocità C(z)'),...
%     xlabel('Profondità [m]'),ylabel('Velocità [m/s]'),

%ANALISI via STFT

% win=hamming(round(Ns/8));
% Nwin=length(win);
% 
% %Nfft=512; %numero punti campionamento spettro
% 
% [TRA]=STFT(sr,win,round(Nfft),0.5);
% 
% fk=assefr(Nfft,fc,0);
% 
% for i=1:size(TRA,2)
%     TRA(:,i)=fftshift(TRA(:,i)); %metto al centro la frequenza zero
%     %phase(:,i)=unwrap(angle(TRA(:,i)));
% end
% 
% tslice=[1:1:size(TRA,2)]*(Nwin/fc);
% 
% 
% 
% figure,imagesc(t,fk(round(Nfft/2+1):end),abs(TRA(round(Nfft/2+1):end,:))),...
%     ylabel('Frequenza [Hz]'),xlabel('Tempo [s]'),...
%     title('Analisi STFT della traccia sintetica - Ampiezza'),colormap(hot),



%Come variano nel tempo le tracce
% figure,
% fk=assefr(Nfft,fc,0);
% 
% for kk=1:size(W,1)
%     %ANALISI via STFT
% 
%     win=hamming(round(Ns/4));
%     Nwin=length(win);
%     
% 
%     %Nfft=512; %numero punti campionamento spettro
% 
%     [TRA]=STFT(W(:,kk),win,round(Nfft),0.2);
% 
% 
% 
%     for i=1:size(TRA,2)
%         TRA(:,i)=fftshift(TRA(:,i)); %metto al centro la frequenza zero
%     %phase(:,i)=unwrap(angle(TRA(:,i)));
%     end
%     
%     tslice=[1:1:size(TRA,2)]*(Nwin/fc);
% 
% 
%     imagesc(tslice,fk(round(Nfft/2+1):end),abs(TRA(round(Nfft/2+1):end,:))),ylabel('Frequenza [Hz]'),xlabel('Tempo [s]'),...
%     title('Analisi STFT della traccia sintetica - Ampiezza'),colormap(hot)
%     M(kk) = getframe;
% end
% 
% movie(M)


%Calcolo dei centrodi di frequenza
% fk=assefr(Nfft,fc,0);
% for kk=1:size(W,2)
%     Wf=abs(fft(W(:,kk)));
%     Wf=[Wf(Nfft/2+2:end);Wf(1:Nfft/2+1)]; %centro lo zero
%     Wmat(:,kk)=Wf;
%     fcentr(kk)=(fk(Nfft/2:end)*Wf(Nfft/2:end))/sum(Wf(Nfft/2:end));
% end
% 
% figure,plot(fcentr),xlabel('Tempo [s]'),...
%     ylabel('Frequenza [Hz]'),...
%     title('Frequency downshift del centroide dell''ondina per effetto del fattore Q'),
% figure,imagesc(t,fk(Nfft/2:end),Wmat((Nfft/2:end),:)),...
%     xlabel('Tempo [s]'),ylabel('Frequenza [Hz]'),...
%     title('Frequency downshift per effetto del fattore Q'),colormap(hot)
%     