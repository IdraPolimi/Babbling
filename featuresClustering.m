function [Features, Clusters, Centroids,  Ps] =  featuresClustering(dataset, clusterNumber)

% ARGUMENTS:
%  - dataset:           dataset with the audio signal of the primitives
%  - clusterNumber      the number of the clusters to create
%
% RETURNS:
%  - Features:          contains the features matrix
%  - Clusters:          contains the centroid's indices
%                       feature of all data
%  - Centroids:         returns the centroids vectors
%  - Ps:                contains the probability that each vector belong to a
%                       specific cluster

Features = featureExtractionDataset(dataset);

normFeatures = Features;

normFeatures = normFeatures';

[Clusters, Centroids, sums, distances] = kmeans(normFeatures, clusterNumber);

% Distance to probability estimation:
Ps = tanh(1 ./ distances);
