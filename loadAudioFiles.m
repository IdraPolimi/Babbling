function dataSet = loadAudioFiles(folder)
% Load all the audio files contained in a specified folder
d=dir([folder '/*.wav']);


for ii=1:length(d)
    fname=d(ii).name;
    [sig , freq] = audioread(fname);
    dataSet(ii).sig = sum(sig,2);
    dataSet(ii).freq = freq;
end

