clear
clc

%load dataset
dataSet = loadAudioFiles('Dataset');

%normalize dataset channel, frequency and intensity
normDataset = normalizeDataSet(dataSet, 44000);

%normalize the pitch
newPitchFs = 440;
normVett=[];
startVett = [];
modPitch = [];

for ii = 1:size(dataSet,2)
    oldPitchFs = pitchDetector(normDataset(ii).sig, normDataset(ii).freq);
    step = 12*log2(newPitchFs/oldPitchFs);
    shiftedNormDataset(ii).sig = pitchShift(normDataset(ii).sig, 1024, 256, step);
    normVett = [normVett shiftedNormDataset(ii).sig];
    tempPitch = pitchDetector(shiftedNormDataset(ii).sig, normDataset(ii).freq);
    modPitch = [modPitch tempPitch];
    difference = tempPitch-oldPitchFs;
end

%creates the crossed dataset composing the lenguage primitives
crossedDataset = [];
rr = 1;
for jj = 1:size(dataSet,2)
 for tt = 1:size(dataSet,2)  
     crossedDataset(rr).sig = crossFade(shiftedNormDataset(jj).sig , shiftedNormDataset(tt).sig);
     rr = rr+1;   
end   
end

%extract the features from the crossed dataset and creates the states
%making the clustering
statesNumber = 20;
[Features, normFeatures,composedDatasetClusters, Centroids, sums, distances, Ps] = featuresClustering(crossedDataset, statesNumber);

%inizialize the state table and the index vector
table = zeros(statesNumber, size(crossedDataset,2));
indexVector = [];