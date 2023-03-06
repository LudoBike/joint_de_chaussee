
fech=500; % le fichier avec cette fréquence d'échantillonnage doit déjà exister
fcoup=fech/2; % Frequence de coupure initiale
% 1/2 car theoreme de shannon
fcoup_new=fech/4; % Possibilite de supprimer les hautes frequences
audiofile_name='ZOOM0001'; % sans le .wav car rentre dans le chemin d'acces

optn_genere_wav=true; 






tab_intervals=[1.3 2.7 ; 6.7 8.2 ; 10.3 11.5 ; 12.9 14.9];

pth_extraits=strcat('..\audio_output\',audiofile_name,'\');                                          % Chemin d'acces fichiers apres traitement fft de coupure
pth_im_png=strcat('..\images\png\fft\',audiofile_name,'\');
pth_im_fig=strcat('..\images\fig\fft\',audiofile_name,'\'); % Chemins d'acces images

pth_mod='module\';
pth_arg='arg\';
pth_real='real\';
pth_im='im\';


for c = 1:length(tab_intervals)


% Lecture du fichier audio

    filename_audio_extr=strcat('2fcoup_',string(floor(2*fcoup/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'.wav');
    strcat(pth_extraits,filename_audio_extr)
    [s_t, fs]=audioread(strcat(pth_extraits,filename_audio_extr));

% Extraction des tableaux

    % coupure

    

    X=s_t(:,1);
    Y=s_t(:,2);

    L=length(X);

    f_full = fs*(0:(L/2))/L;
    nf=floor(length(f_full)*2*fcoup/fech);
    %f=f_full si axis=equal
    f=f_full(1:nf);

    % Calcul des fft
    UX=fft(X);
    UY=fft(Y);


    UX(nf:L-nf)=zeros(L-2*nf);
    UY(nf:L-nf)=zeros(L-2*nf);


    X1=UX(1:floor(L/2)+1);
    X1(2:end-1) = 2*X1(2:end-1);

    Y1=UY(1:floor(L/2)+1);
    Y1(2:end-1) = 2*Y1(2:end-1);


    % module

    % X

    mX1 = abs(X1);

    mY1 = abs(Y1);

    mod_fft=figure(4*c);

    subplot(1,2,1);

    plot(f,mX1,'linewidth',0.1); grid on;
    ylabel('|fft| voie X');xlabel('freq(Hz)'); 

    subplot(1,2,2);

    plot(f,mY1,'linewidth',0.1); grid on;
    ylabel('|fft| voie Y');xlabel('freq(Hz)');


    filename_png=strcat('2fcoup_',string(floor(2*fcoup_new/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_fft_mod.png');
    filename_fig=strcat('2fcoup_',string(floor(2*fcoup_new/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_fft_mod.fig');


    saveas(mod_fft,strcat(pth_im_png,pth_mod,filename_png)) ;
    saveas(mod_fft,strcat(pth_im_fig,pth_mod,filename_fig)) ;



    % phase

    phX1 = angle(X1);

    phY1 = angle(Y1);

    phase_fft=figure(4*c+1);

    subplot(1,2,1);

    plot(f,phX1,'linewidth',0.1); grid on;
    ylabel('phase(fft) voie X');xlabel('freq(Hz)'); 

    subplot(1,2,2);

    plot(f,phY1,'linewidth',0.1); grid on;
    ylabel('phase(fft) voie Y');xlabel('freq(Hz)');


    filename_png=strcat('2fcoup_',string(floor(2*fcoup_new/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_fft_arg.png');
    filename_fig=strcat('2fcoup_',string(floor(2*fcoup_new/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_fft_arg.fig');


    saveas(phase_fft,strcat(pth_im_png,pth_arg,filename_png)) ;
    saveas(phase_fft,strcat(pth_im_fig,pth_arg,filename_fig)) ;




    % partie reelle

    reX1 = real(X1);

    reY1 = real(Y1);

    real_fft=figure(4*c+2);

    subplot(1,2,1);

    plot(f,reX1,'linewidth',0.1); grid on;
    ylabel('re(fft) voie X');xlabel('freq(Hz)'); 

    subplot(1,2,2);

    plot(f,reY1,'linewidth',0.1); grid on;
    ylabel('re(fft) voie Y');xlabel('freq(Hz)');


    filename_png=strcat('2fcoup_',string(floor(2*fcoup_new/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_fft_real.png');
    filename_fig=strcat('2fcoup_',string(floor(2*fcoup_new/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_fft_real.fig');


    saveas(real_fft,strcat(pth_im_png,pth_real,filename_png)) ;
    saveas(real_fft,strcat(pth_im_fig,pth_real,filename_fig)) ;




    % partie imaginaire

    imX1 = imag(X1);

    imY1 = imag(Y1);


      
    im_fft=figure(4*c+3); 

    subplot(1,2,1);

    plot(f,imX1,'linewidth',0.1); grid on;
    ylabel('im(fft) voie X');xlabel('freq(Hz)'); 

    subplot(1,2,2);

    plot(f,imY1,'linewidth',0.1); grid on;
    ylabel('im(fft) voie Y');xlabel('freq(Hz)');


    filename_png=strcat('2fcoup_',string(floor(2*fcoup_new/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_fft_imag.png');
    filename_fig=strcat('2fcoup_',string(floor(2*fcoup_new/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_fft_imag.fig');


    saveas(im_fft,strcat(pth_im_png,pth_im,filename_png)) ;
    saveas(im_fft,strcat(pth_im_fig,pth_im,filename_fig)) ;

    if optn_genere_wav

        X2=ifft(UX);
        Y2=ifft(UY);
        s2=[X2,Y2];

        filename_audio_extr=strcat('2fcoup_',string(floor(2*fcoup/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'.wav');
        audiowrite(strcat(pth_extraits,filename_audio_extr),s2,fech);
        
    end

end

close all
