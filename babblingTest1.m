babblingTestVector = [];
similarityVector = [];

indexVector = [];

table = zeros(statesNumber, size(crossedDataset,2));

for ii = 1:200
    ii
    testNumber = randi(900, 1);
    [bestBabble, table, indexVector, PsCentroid, centroidDistances, nBabbling, bestBabbleSimilarity] = findBabble(Centroids, crossedDataset, table, indexVector,testNumber); 
    babblingTestVector = [babblingTestVector nBabbling];
    similarityVector = [similarityVector bestBabbleSimilarity];
end

babblingTestVector
similarityVector

meanBabbling = mean(babblingTestVector)
meanSimilarity = mean(similarityVector)