function dataSet = normalize(dataSet, newFs)
%Normalize the frequence of the audio set, remove the mean and normalize
%the amplitude

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
    dataSet(ii).sig = dataSet(ii).sig  / max(abs(dataSet(ii).sig));
    dsppitchtime
end


