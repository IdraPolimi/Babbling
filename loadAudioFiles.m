function dataSet = loadAudioFiles(folder)
% loadAudioFiles: load all the audio .wav files contained in the specified folder
%   input: the target directory
%   output: the dataset as structure, sig and sampling frequency

d=dir([folder '/*.wav']);
for ii=1:length(d)
    fname=d(ii).name;
    [sig , freq] = audioread(fname);
    % Only one channel signal
    dataSet(ii).sig = sum(sig,2);
    % Frequency of the audio file
    dataSet(ii).freq = freq;
end

