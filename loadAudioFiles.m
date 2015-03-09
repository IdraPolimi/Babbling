function dataSet = loadAudioFiles(folder, maxNumberOfFiles)
% loadAudioFiles: load all the audio .wav files contained in the specified folder
%   input: the target directory
%   output: the dataset as structure, sig and sampling frequency

d=dir([folder '/*.wav']);

if(nargin == 2)
    maxNumberOfFiles = min([maxNumberOfFiles; length(d)]);
else
    maxNumberOfFiles = length(d);
end

for ii=1:maxNumberOfFiles
    fname=d(ii).name;
    [sig , freq] = audioread(fname);
    % Only one channel signal
    dataSet(ii).sig = sum(sig,2);
    % Frequency of the audio file
    dataSet(ii).freq = freq;
end

