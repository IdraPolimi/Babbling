function [bestBabble, table, indexVector, PsCentroid, centroidDistances, nBabbling, bestBabbleSimilarity] = findBabble(Centroids, crossedDataset, table, indexVector, targetIndex, treshold)

%determinate the target
%use a random signal
%targetIndex = randi(length(crossedDataset), 1)
target(1) = crossedDataset(targetIndex);

%make a babble similar to the target sound
[PsCentroid, centroidDistances, table, indexVector, bestBabble,bestBabbleSimilarity, nBabbling] = babbling(crossedDataset, Centroids, table, indexVector, target, treshold);

bestBabble;%print