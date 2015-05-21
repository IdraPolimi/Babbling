
treshold= 0;
meanBabblingVector5 = [];
meanSimilarityVector5 = [];

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

meanBabblingVector5 = [meanBabblingVector5 mean(babblingTestVector)];
meanSimilarityVector5 = [meanSimilarityVector5 mean(similarityVector)];


end



