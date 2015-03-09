function dataSet = normalizeDataSet(dataSet, newFs)
% normalizeDataSet: normalize the given dataSet; 
%               1. resample all the signals;
%               2. remove the mean;
%               3. normalize to [-1;1]
%   input: the dataset and a target sampling frequency (if not specified
%   newFs = 44100
%   output: the normalized dataset as structure, signal and sampling
%   frequency

RMSs = [];
rmsVec = [];
maxScale = [];
if(nargin<2)
    newFs = 44100;
end  

for ii=1:length(dataSet)
    [P,Q] = rat(newFs/dataSet(ii).freq); 
    % Resample the audio file
    dataSet(ii).sig = resample(dataSet(ii).sig ,P,Q);
    dataSet(ii).freq = newFs;
    %scales and shifts the sound vectors so they have a max amplitude of one and have a average value of zero
    dataSet(ii).sig = (dataSet(ii).sig - mean(dataSet(ii).sig));
    rmsVec = [rmsVec sqrt(sum(dataSet(ii).sig.^2)/length(dataSet(ii).sig))];
    maxScale = [maxScale 0.999 / max(abs(dataSet(ii).sig))];
end

RMSs = maxScale .* rmsVec;
targetRMS = min(RMSs);
for ii=1:length(dataSet)
    dataSet(ii).sig = dataSet(ii).sig*targetRMS/rmsVec(ii);
end




