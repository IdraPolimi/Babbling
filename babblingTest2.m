
treshold= 0;
meanBabblingVector7 = [];
meanSimilarityVector7 = [];

for jj = 1:19
treshold = treshold + 0.05
babblingTestVector = [];
similarityVector = [];

indexVector = [];

table = zeros(statesNumber, size(crossedDataset,2));

    for ii = 1:200
     ii
     testNumber = randi(200, 1);
     [bestBabble, table, indexVector, PsCentroid, centroidDistances, nBabbling, bestBabbleSimilarity] = findBabble(Centroids, crossedDataset, table, indexVector,testNumber, treshold); 
     babblingTestVector = [babblingTestVector nBabbling];
     similarityVector = [similarityVector bestBabbleSimilarity];
    end

meanBabblingVector7 = [meanBabblingVector7 mean(babblingTestVector)];
meanSimilarityVector7 = [meanSimilarityVector7 mean(similarityVector)];


end



