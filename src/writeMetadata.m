function [] = writeMetadata(extract_audio, pth_output_audio, filename)
%WRITEMETADATA Summary of this function goes here
%   Detailed explanation goes here

canal_nb = transpose(1:2);
ampl_max = zeros(2, 1);
ampl_avg = zeros(2, 1);
ampl_abs_avg = zeros(2, 1);

% Compute metadata
for i = canal_nb
    canal = extract_audio(:, i);
    ampl_max(i) = max(canal);
    ampl_avg(i) = mean(canal);
    ampl_abs_avg(i) = mean(abs(canal));
end

% json export
json_data = jsonencode(table(canal_nb, ampl_max, ampl_avg, ampl_abs_avg));

% Write file
metadata_filename = strcat(first(strsplit(filename,".")), ".json");
if last(pth_output_audio) == "/"
    metadata_filename = strcat(pth_output_audio, metadata_filename);
else
    metadata_filename = strcat(pth_output_audio, "/", metadata_filename);
end

fileID = fopen(metadata_filename, "w");
fprintf(fileID, json_data);
fclose(fileID);

end

function [first_elem] = first(array)
    first_elem = array(1);
end

function [last_elem] = last(array)
    last_elem = array(length(array));
end