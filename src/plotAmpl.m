function [] = plotAmpl(audioData, tStart, tEnd)
%PLOTAMPL Summary of this function goes here
%   Detailed explanation goes here

% Voie X
subplot(1, 2, 1);
plotCanal(audioData(:,1), tStart, tEnd, "Amplitude voie X");

% Voie Y
subplot(1, 2, 2);
plotCanal(audioData(:,2), tStart, tEnd, "Amplitude voie Y");
end

