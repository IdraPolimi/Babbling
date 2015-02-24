dataSet = loadAudioFiles('Dataset');
normDataset = normalizeDataSet(dataSet, 44000);

newPitch = 400;
normVett=[];
startVett = [];    
for ii = 1:2%size(dataSet,2)
    
    oldPitch = pitchDetector(normDataset(ii).sig, normDataset(ii).freq)
    step = 4%(newPitch - oldPitch)/40
    %startVett = [startVett; normDataset(ii).sig];
    [normDataset(ii).sig,normDataset(ii).freq  ]= pitchShift(normDataset(ii).sig, normDataset(ii).freq, 1024, 256, step);
    %normVett = [normVett normDataset(ii).sig];
    newFreq = normDataset(ii).freq
    pitchDetector(normDataset(ii).sig, normDataset(ii).freq)
end


%sound(startVett,44000);
%pause
%sound(normVett,44000);