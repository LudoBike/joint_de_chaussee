%%

fech=500; % Hz
%fcoup=1500;


input_file='ZOOM0001';                                           % sans terminaison
pth_input_audio=strcat('D:\audio_input\',input_file,'.WAV');
pth_output_audio=strcat('D:\audio_output\',input_file,'\');      % modifie a chaque extrait genere
tab_intervals=[1.0 3.0 ; 9.0 12.0 ; 18.0 20.0];                  % importer a partir d excel (a coder)



                                                            
[s_t_old, fs_old]=audioread(pth_input_audio);                    % Lecture du  fichier Audio (.wav, .mp3, etc.)
%fech=fs_old;
ts_old=1/fs_old; 


fcoup=fech/2;
                                                                 % Preparation traitement fichiers

mult_fact=floor(fs_old/fech);                                    % On prend un point tous les mult_fact

n=floor(length(s_t_old)/mult_fact);
s_t=zeros(n,2);

for i = 1:n
    s_t(i,1)=s_t_old(i*mult_fact,1);
    s_t(i,2)=s_t_old(i*mult_fact,2);
end

fs=fs_old/mult_fact;
ts=1/fs;



for c = 1:length(tab_intervals)
    Interval=tab_intervals(c,:);

    t1=Interval(1);
    N1=round(t1/ts)+1;

    t2=Interval(2);
    N2=round(t2/ts);

    X=s_t(N1:N2,1);
    Y=s_t(N1:N2,2);
    
    filename_audio_extr = strcat('2fcoup_',string(floor(2*fcoup/1000)),'kHz_','fech_',string(floor(fech/1000)),'kHz_','extr',string(c),'.wav');
    audiowrite(strcat(pth_output_audio,filename_audio_extr),s_t(N1:N2,:),floor(fs));


end








