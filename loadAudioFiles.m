function dataSet = loadAudioFiles(folder)
% Load all the audio files contained in a specified folder
d=dir([folder '/*.wav']);


for ii=1:length(d)
    fname=d(ii).name;
    [sig , freq] = audioread(fname);
    % Only one channel signal
    dataSet(ii).sig = sum(sig,2);
    % Frequency of the audio file
    dataSet(ii).freq = freq;
end

