function FeaturesVector =  featureExtractionDataset(dataset)

%
% function [FeaturesDir, FileNames] =  featureExtractionDir(dirName)
%
% Extracts mid term features for a list of WAV files stored in a given path
% 
% ARGUMENTS:
%  - dataset:           struct with all signals vectors corresponding to the
%  primitives
%
%
% RETURNS:
%  - FeaturesVector:    contains the features vector of the the mid-term 
%                       feature of all data


%feature extraction parameters (windows and statistics) - for very short
%file 0.040, 0.040, 2.0, 1.0
stWin = 0.0050; stStep = 0.0025;
%mtWin = 2; mtStep = 0.5;

%featureStatistics = {'mean','median','std','stdbymean','max','min'};
%featureStatistics = {'mean','median','std','stdbymean'};
featureStatistics = {'mean','std'};
FeaturesVector = [];

%D = dir([dirName filesep '*.wav']);

for i=1:length(dataset)       % for each WAV file
    %curName = [dirName filesep D(i).name];    
    %FileNames{i} = curName;  % get current filename
    % extract mid-term features:
    [mtFeatures, stFeaturesPerSegment] = ...
        featureExtractionSig(dataset(i).sig', stWin, stStep, featureStatistics);
    FeaturesVector = [FeaturesVector mtFeatures];
end

