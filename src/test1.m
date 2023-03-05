% Auteur : Romain Rousselet
% Date : 08/02/2023


%% OBJECTIFS

% 1 - Lire le fichier audio, enlever des points pour filtrer les frequences
% les plus elevees (fichier plus leger)

% 2 - Generer des fichiers aux moments de passage des véhicules et les
% enregistrer

% 3 - Afficher et enregistrer les amplitudes en fonction du temps pour
% chaque extrait

% 4 - Afficher et enregistrer les FFT pour chaque extrait ; enregistrer les
% ifft

% 5 - Sortir les metadonnees pour chaque extrait (.xlsx)

% 6 - Comparer les fft des fichiers allégés et des fichiers initiaux


%%
pth_file_init='D:\fichiers audio\ZOOM0004.WAV';
fcoup=3000; % Hz


% Lecture du  fichier Audio (.wav, .mp3, etc.) 
[s_t_old, fs_old]=audioread('D:\fichiers audio\ZOOM0004.WAV'); 

ts_old=1/fs_old; 

mult_fact=8; % On prend un point tous les mult_fact

n=floor(length(s_t_old)/mult_fact);
s_t=zeros(n,2);



for i = 1:n
    s_t(i,1)=s_t_old(i*mult_fact,1);
    s_t(i,2)=s_t_old(i*mult_fact,2);
end

fs=fs_old/mult_fact;
ts=1/fs;



filename = 'D:\fichiers audio\generes\ZOOM0004_new.wav';
audiowrite(filename,s_t,fs);


% Affichage voix X 
T_sec=15; N=round(T_sec/ts); 
N_old
X=s_t(1:N,1);


t11=1.3;
N11=round(t11/ts)+1;

t12=2.7;
N12=round(t12/ts);


I1=[t11;t12];

X1=s_t(N11:N12,1);
Y1=s_t(N11:N12,2);


filename = 'D:\fichiers audio\generes\Pass1.wav';
audiowrite(filename,s_t(N11:N12,:),fs);



t=linspace(0,T_sec,N); 

T1=t(N11:N12);


% Amplitude extrait 1

h1_ampl=figure(1); 

subplot(1,2,1);
plot(T1,X1,'linewidth',0.1); grid on;
ylabel('Amplitude voie X');xlabel('Temps(s)'); 

length(T1)
length(X1)
length(Y1)


%%%% Cette partie ne fonctionne pas : a debeuguer
%%%% Est censee afficher l'amplitude pour l'extrait 1

%{
subplot(1,2,2);
plot(T1,Y1,'linewidth',0.1); grid on;
ylabel('Amplitude voie Y');xlabel('Temps(s)');

saveas(h1_ampl,'D:\images\ampl\png\extrait1_ampl.png') ;
saveas(h1_ampl,'D:\images\ampl\fig\extrait1_ampl.fig') ;
%}


%%%% A debeuguer

L1=length(T1);

% fft extrait 1

h1_fft=figure(2); 



U1X=fft(X1);
U1Y=fft(Y1);

f1_abs_x = abs(U1X/L1);
P1x = f1_abs_x(1:floor(L1/2)+1);
P1x(2:end-1) = 2*P1x(2:end-1);

f1_abs_y = abs(U1Y/L1);
P1y = f1_abs_y(floor(1:L1/2)+1);
P1y(2:end-1) = 2*P1y(2:end-1);

f = fs*(0:floor(L1/2))/L1;

subplot(1,2,1);
plot(f,P1x,'linewidth',0.1); grid on;
ylabel('fft voie X');xlabel('freq(Hz)'); 

subplot(1,2,2);
plot(f,P1y,'linewidth',0.1); grid on;
ylabel('fft voie Y');xlabel('freq(Hz)');

saveas(h1_fft,'D:\images\fft\png\extrait1_fft.png') ;
saveas(h1_fft,'D:\images\fft\fig\extrait1_fft.fig') ;


%%%

% Metadonnees extrait 1

%%%


A_f0=P1y(1);
u=max(Y1);
Amax_S=max(u,-min(Y1));
Amoy_S=100*mean(P1y)/Amax_S;
Amax_f=max(P1y);
Fmax=max(f);
nbpt=length(T1);

N1y= { 1,'A_f0',A_f0; 2,'Amax_S',Amax_S;3,'Amoy_S/Amax_S(%)',Amoy_S;4,'Amax_f',Amax_f;5,'Fmax',Fmax;6,'nbpt',nbpt};
xlswrite('D:\metadata\meta1y.xlsx',N1y);


A_f0=P1y(1);
u=max(X1);
Amax_S=max(u,-min(X1));
Amoy_S=100*mean(P1x)/Amax_S;
Amax_f=max(P1x);
Fmax=max(f);
nbpt=length(T1);

N1x= { 1,'A_f0',A_f0; 2,'Amax_S',Amax_S;3,'Amoy_S/Amax_S(%)',Amoy_S;4,'Amax_f',Amax_f;5,'Fmax',Fmax;6,'nbpt',nbpt};
xlswrite('D:\metadata\meta1x.xlsx',N1x);





%%% Extrait 2 %%%




t21=6.7;
N21=round(t21/ts);

t22=8.2;
N22=round(t22/ts);

T2=t(N21:N22);

I2=[t21;t22];
X2=s_t(N21:N22,1);
Y2=s_t(N21:N22,2);



filename = 'D:\fichiers audio\generes\Pass2.wav';
audiowrite(filename,s_t(N21:N22,:),fs);

h2_ampl=figure(3); 

subplot(1,2,1);
plot(T2,X2,'linewidth',0.1); grid on;
ylabel('Amplitude voie X');xlabel('Temps(s)'); 

subplot(1,2,2);
plot(T2,Y2,'linewidth',0.1); grid on;
ylabel('Amplitude voie Y');xlabel('Temps(s)');

saveas(h2_ampl,'D:\images\ampl\png\extrait2_ampl.png') ;
saveas(h2_ampl,'D:\images\ampl\fig\extrait2_ampl.fig') ;

L2=length(T2);

% fft extrait 2

h2_fft=figure(4); 



U2X=fft(X2);
U2Y=fft(Y2);

f2_abs_x = abs(U2X/L2);
P2x = f1_abs_x(1:floor(L2/2)+1);
P2x(2:end-1) = 2*P2x(2:end-1);

f2_abs_y = abs(U2Y/L2);
P2y = f2_abs_y(1:floor(L2/2)+1);
P2y(2:end-1) = 2*P2y(2:end-1);

f = fs*(0:(L2/2))/L2;

subplot(1,2,1);
plot(f,P2x,'linewidth',0.1); grid on;
ylabel('fft voie X');xlabel('freq(Hz)'); 

subplot(1,2,2);
plot(f,P2y,'linewidth',0.1); grid on;
ylabel('fft voie Y');xlabel('freq(Hz)');

saveas(h2_fft,'D:\images\fft\png\extrait2_fft.png') ;
saveas(h2_fft,'D:\images\fft\fig\extrait2_fft.fig') ;


%%%

% Figures extrait 2

%%%


A_f0=P2y(1);
u=max(Y2);
Amax_S=max(u,-min(Y2));
Amoy_S=100*mean(P2y)/Amax_S;
Amax_f=max(P2y);
Fmax=max(f);
nbpt=length(T2);

N2y= { 1,'A_f0',A_f0; 2,'Amax_S',Amax_S;3,'Amoy_S/Amax_S(%)',Amoy_S;4,'Amax_f',Amax_f;5,'Fmax',Fmax;6,'nbpt',nbpt};
xlswrite('D:\metadata\meta2y.xlsx',N2y);


A_f0=P2y(1);
u=max(X2);
Amax_S=max(u,-min(X2));
Amoy_S=100*mean(P2x)/Amax_S;
Amax_f=max(P2x);
Fmax=max(f);
nbpt=length(T2);

N2x= { 1,'A_f0',A_f0; 2,'Amax_S',Amax_S;3,'Amoy_S/Amax_S(%)',Amoy_S;4,'Amax_f',Amax_f;5,'Fmax',Fmax;6,'nbpt',nbpt};
xlswrite('D:\metadata\meta2x.xlsx',N2x);



h2_ampl=figure(5); 

subplot(1,2,1);
plot(T2,X2,'linewidth',0.1); grid on;
ylabel('Amplitude voie X');xlabel('Temps(s)'); 

subplot(1,2,2);
plot(T2,Y2,'linewidth',0.1); grid on;
ylabel('Amplitude voie Y');xlabel('Temps(s)');

saveas(h2_ampl,'D:\images\ampl\png\extrait2_ampl.png') ;
saveas(h2_ampl,'D:\images\ampl\fig\extrait2_ampl.fig') ;

L2=length(T2);

% fft extrait 2

h2_fft=figure(6); 



U2X=fft(X2);
U2Y=fft(Y2);

f2_abs_x = abs(U2X/L2);
P2x = f2_abs_x(1:floor(L2/2)+1);
P2x(2:end-1) = 2*P2x(2:end-1);

f2_abs_y = abs(U2Y/L2);
P2y = f2_abs_y(1:floor(L2/2)+1);
P2y(2:end-1) = 2*P2y(2:end-1);

f = fs*(0:(L2/2))/L2;

subplot(1,2,1);
plot(f,P2x,'linewidth',0.1); grid on;
ylabel('fft voie X');xlabel('freq(Hz)'); 

subplot(1,2,2);
plot(f,P2y,'linewidth',0.1); grid on;
ylabel('fft voie Y');xlabel('freq(Hz)');

saveas(h2_fft,'D:\images\fft\png\extrait2_fft.png') ;
saveas(h2_fft,'D:\images\fft\fig\extrait2_fft.fig') ;


%%%

% Metadonnees extrait 2

%%%


A_f0=P2y(1);
u=max(Y2);
Amax_S=max(u,-min(Y2));
Amoy_S=100*mean(P2y)/Amax_S;
Amax_f=max(P2y);
Fmax=max(f);
nbpt=length(T2);

N2y= { 1,'A_f0',A_f0; 2,'Amax_S',Amax_S;3,'Amoy_S/Amax_S(%)',Amoy_S;4,'Amax_f',Amax_f;5,'Fmax',Fmax;6,'nbpt',nbpt};
xlswrite('D:\metadata\meta2y.xlsx',N2y);


A_f0=P2y(1);
u=max(X2);
Amax_S=max(u,-min(X2));
Amoy_S=100*mean(P2x)/Amax_S;
Amax_f=max(P2x);
Fmax=max(f);
nbpt=length(T2);

N2x= { 1,'A_f0',A_f0; 2,'Amax_S',Amax_S;3,'Amoy_S/Amax_f(%)',Amoy_S;4,'Amax_f',Amax_f;5,'Fmax',Fmax;6,'nbpt',nbpt};
xlswrite('D:\metadata\meta2x.xlsx',N2x);











%%% Extrait 3 %%%


%%% Pas encore code



t31=10.3;
N31=round(t31/ts);

t32=11.5;
N32=round(t32/ts);

I3=[t31;t32];
X3=s_t(N31:N32,1);
Y3=s_t(N31:N32,2);

filename = 'D:\fichiers audio\generes\Pass3.wav';
audiowrite(filename,s_t(N31:N32,:),fs);





%%% Extrait 4 %%%


%%% Pas encore code

t41=12.9;
N41=round(t41/ts);

t42=14.9;
N42=round(t42/ts);

I4=[t41;t42];
X4=s_t(N41:N42,1);
Y4=s_t(N41:N42,2);

filename = 'D:\fichiers audio\generes\Pass4.wav';
audiowrite(filename,s_t(N41:N42,:),fs);



%%% 6 - Comparaison des fft sur 15s
%%% fft(S2-S1),fft(S1) (f)






























%figure(2);
%subplot(2,2,1);
%plot(T1,X1);

%subplot(2,2,2);
%plot(T2,X2);


%subplot(2,2,3);
%plot(T3,X3);

%subplot(2,2,4);
%plot(T4,X4);



%subplot(2,2,4);
%plot(T4,X4);
%%  Lecture d'un fichier Audio 


sound(X,fs);    % La voie X (mono)
%sound(X,fs);   % La voie Y (mono)
%sound([X Y],fs);   % Les deux (stéréo)
%tfx=fft(X)
%y=abs(tfx)




