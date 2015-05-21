
treshold= 0;
meanBabblingVector4 = [];
meanSimilarityVector4 = [];

for jj = 1:19
treshold = treshold + 0.05
babblingTestVector = [];
similarityVector = [];

indexVector = [];

table = zeros(statesNumber, size(crossedDataset,2));

    for ii = 1:200
     ii
     testNumber = randi(900, 1);
     [bestBabble, table, indexVector, PsCentroid, centroidDistances, nBabbling, bestBabbleSimilarity] = findBabble(Centroids, crossedDataset, table, indexVector,testNumber, treshold); 
     babblingTestVector = [babblingTestVector nBabbling];
     similarityVector = [similarityVector bestBabbleSimilarity];
    end

meanBabblingVector4 = [meanBabblingVector4 mean(babblingTestVector)];
meanSimilarityVector4 = [meanSimilarityVector4 mean(similarityVector)];


end



