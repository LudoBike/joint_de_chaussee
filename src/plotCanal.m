function [] = plotCanal(X, tStart, tEnd, yLabel)
%PLOTCANAL Plot the amplitude of the extract of X between tStart and tEnd
%   X is the audio canal to print 
%   yLabel is the yLabel for the plot
assert(tStart < tEnd, "tStart must be lower than tEnd");

t=linspace(tStart, tEnd, length(X));

plot(t, X, "linewidth", 0.1); grid on;
ylabel(yLabel); xlabel("Temps (s)");
end

