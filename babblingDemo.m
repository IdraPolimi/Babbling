clear
clc
dataSet = loadAudioFiles('Dataset');
normDataset = normalizeDataSet(dataSet, 44000);

newPitchFs = 440;
normVett=[];
startVett = [];
modPitch = [];

for ii = 1:size(dataSet,2)
    disp(ii)
    oldPitchFs = pitchDetector(normDataset(ii).sig, normDataset(ii).freq)
    step = 12*log2(newPitchFs/oldPitchFs)
    %startVett = [startVett; normDataset(ii).sig];
    shiftedNormDataset(ii).sig = pitchShift(normDataset(ii).sig, 1024, 256, step);
    normVett = [normVett shiftedNormDataset(ii).sig];
    tempPitch = pitchDetector(shiftedNormDataset(ii).sig, normDataset(ii).freq)
    modPitch = [modPitch tempPitch];
    difference = tempPitch-oldPitchFs;
    disp('::::::::::::::::::::::::::::::::::::::::::::::::::::');
end


%sound(startVett,44000);
%pause
%sound(normVett,44000)