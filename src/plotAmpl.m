function [] = plotAmpl(audioData, tStart, tEnd)
%PLOTAMPL Plot the amplitude of the canals of audioData between tStart and
% tEnd
%   audioData is a matrice (1st result of the function audioread)
%   tStart and tEnd are floats, define the extract to plot

assert(tStart < tEnd, "tStart must be lower than tEnd");

% Voie X
subplot(1, 2, 1);
plotCanal(audioData(:,1), tStart, tEnd, "Amplitude voie X");

% Voie Y
subplot(1, 2, 2);
plotCanal(audioData(:,2), tStart, tEnd, "Amplitude voie Y");
end

