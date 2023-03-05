fech=500;
%fcoup=1500; % max=fech/2
fcoup=fech/2;


audiofile_name='ZOOM0001';
tab_intervals=[1.0 3.0 ; 9.0 12.0 ; 18.0 20.0];
pth_output_audio=strcat('D:\audio_output\',audiofile_name,'\');
pth_im_png=strcat('D:\images\png\ampl\',audiofile_name,'\');
pth_im_fig=strcat('D:\images\fig\ampl\',audiofile_name,'\');

for c = 1:length(tab_intervals)

    filename_audio_extr=strcat('2fcoup_',string(floor(2*fcoup/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'.wav');
    [s_t, fs]=audioread(strcat(pth_output_audio,filename_audio_extr));

    X=s_t(:,1);
    Y=s_t(:,2);

    t=linspace(tab_intervals(c,1),tab_intervals(c,2),length(X));

    h_ampl=figure(c); 

    subplot(1,2,1);
    plot(t,X,'linewidth',0.1); grid on;
    ylabel('Amplitude voie X');xlabel('Temps(s)'); 

    subplot(1,2,2);
    plot(t,Y,'linewidth',0.1); grid on;
    ylabel('Amplitude voie Y');xlabel('Temps(s)');

    strcat(pth_im_png,string(c),'\','_ampl.png');
    

    im_name_png=strcat('2fcoup_',string(floor(2*fcoup/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_ampl.png');
    im_name_fig=strcat('2fcoup_',string(floor(2*fcoup/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'_ampl.fig');


    saveas(h_ampl,strcat(pth_im_png,im_name_png));
    saveas(h_ampl,strcat(pth_im_fig,im_name_fig));


end

