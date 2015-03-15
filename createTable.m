function PsCentroid =  createTable(centroidsVect, crossedDataset, Features)

% Create the state-babbling table
% 
% ARGUMENTS:
%  - centroidsVect:       the features vectors of the centroids
%  - target               target word
%
% RETURNS:
%  - Table:              the state-babbling table

%create empty table
table = zeros(20, size(crossedDataset,2));

%use a random signal
r1 = randi(length(crossedDataset), 2);

target(1).sig = crossedDataset(1).sig;

%target

%extract the features of the target
%targetFeatures = featureExtractionDataset(target);
%targetFeatures = targetFeatures';

targetFeatures = Features(1,:);

% Feature normalization:
MEAN = mean(targetFeatures);
STD = std(targetFeatures);
targetFeatures = (targetFeatures - repmat(MEAN, [size(targetFeatures,1) 1])) ...
    ./ repmat(STD, [size(targetFeatures,1) 1]  );




targetFeatures









%calculate the similarity with the centroid vectors
for ii = 1:size(centroidsVect,1)
  centroidDistances(ii) = norm(centroidsVect(ii)- targetFeatures, 2);
end

centroidDistances

%centroidDistances

% Distance to probability estimation:
PsCentroid = 1 ./ centroidDistances;
% smoothing
for i=1:size(PsCentroid, 2)
    PsCentroid(:,i) = filter([1/3 1/3 1/3], 1, PsCentroid(:,i));
end
PsCentroid = PsCentroid./repmat(sum(PsCentroid,2), [1 size(PsCentroid, 2)]);


%centroidsSimilarity(ii) = 1 - tanh(norm(centroidsVect(ii)- targetFeatures, 2));

%actualState = find(centroidsSimilarity == max(centroidsSimilarity))
%calculate the distance from the composed sound signal and the centroid
%vector