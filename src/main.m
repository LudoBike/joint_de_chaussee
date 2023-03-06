
extract_filename = gen_extract(fech, tab_intervals, input_file, pth_output_audio);

for filename = extract_filename 
   [extract_audio, fech] = audioread(filename);
   
   writeMetadata(extract_audio, pth_output_audio, filename);
   
   plotAmpl(extract_audio, pth_output_audio);
   
   plotFft(extract_audio, pth_output_audio);
end