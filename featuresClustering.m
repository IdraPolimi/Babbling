function [Features, Clusters, Centroids, sums, distances, Ps] =  featuresClustering(dataset)

%
% function [FeaturesDir, FileNames] =  featureExtractionDir(dirName)
%
% Extracts mid term features for a list of WAV files stored in a given path
% 
% ARGUMENTS:
%  - dataset:           dataset with the audio signal of the primitives
%
%
% RETURNS:
%  - Clusters:          contains the centroid's indices
%                       feature of all data
%  - Centroids:         returns the centroids vectors
% 




Colors = {'y*','m*','c*','r*','g*','b*','k*','y^','m^','c^','r^','g^','b^','k^','y+','m+','c+','r+','g+','b+'};
%STD = 0.2;
%nSamplesPerCluster = 200;
%means = [0.0 0.0; 0.0 1.0; 1.0 0.0; 1.0 1.0];
%stds  = [STD STD; STD STD; STD STD; STD STD];

%Features(1:nSamplesPerCluster, :) = ...
%    [stds(1,1) * randn(nSamplesPerCluster, 1)  + means(1,1)  stds(1,2) * randn(nSamplesPerCluster, 1) + means(1,2)];
%Features(nSamplesPerCluster+1:nSamplesPerCluster*2, :) = ...
%    [stds(2,1) * randn(nSamplesPerCluster , 1) + means(2,1)  stds(2,2) * randn(nSamplesPerCluster, 1) + means(2,2)];
%Features(nSamplesPerCluster*2+1:nSamplesPerCluster*3, :) = ...
%    [stds(3,1) * randn(nSamplesPerCluster , 1) + means(3,1) stds(3,2) * randn(nSamplesPerCluster, 1) + means(3,2)];
%Features(nSamplesPerCluster*3+1:nSamplesPerCluster*4, :) = ...
%    [stds(4,1) * randn(nSamplesPerCluster , 1) + means(4,1) stds(4,2) * randn(nSamplesPerCluster, 1) + means(4,2)];

Features = featureExtractionDataset(dataset);
Features = Features';

% Feature normalization:
MEAN = mean(Features);
STD = std(Features);
Features = (Features - repmat(MEAN, [size(Features,1) 1])) ...
    ./ repmat(STD, [size(Features,1) 1]  );

figure;
hold on;

for i=1:size(Features, 1)
    plot(Features(i, 1), Features(i, 2), 'k*');
end



xlabel('x_1'); ylabel('x_2'); title('Initial (unlabelled) data')


%nClusters = 10:60;
%for i=1:length(nClusters)   
%    IDX = kmeans(Features, nClusters(i));
%    S = silhouette(Features, IDX);
%    meanS(i) = mean(S);
%end


%bestNClusters = find(meanS == max(meanS))

%plot(nClusters, meanS, 'k')

nClusters = 20; [Clusters, Centroids, sums, distances] = kmeans(Features, nClusters);
figure;
hold on;
for i=1:size(Features, 1)
    plot(Features(i, 1), Features(i, 2), [Colors{Clusters(i)}]);
end
xlabel('x_1'); ylabel('x_2'); title('Clustering Result')



% Distance to probability estimation:
Ps = 1 ./ distances;
% smoothing
for i=1:size(Ps, 2)
    Ps(:,i) = filter([1/3 1/3 1/3], 1, Ps(:,i));
end
Ps = Ps./repmat(sum(Ps,2), [1 size(Ps, 2)]);



%nClusters = 4; Cluster = kmeans(Features, nClusters);
%figure;
%hold on;
%for i=1:size(Features, 1)
%    plot(Features(i, 1), Features(i, 2), [Colors{Cluster(i)}]);
%end
%xlabel('x_1'); ylabel('x_2'); title('Clustering (4 clusters used)')