function [PsCentroid, centroidDistances, table, BabbleIndexes, bestBabble, bestBabbleSimilarity, nBabbling] =  babbling(crossedDataset, centroidsVect, table, BabbleIndexes, target, treshold)

% Create the state-babbling table
%
% ARGUMENTS:
%  - centroidsVect:       the features vectors of the centroids
%  - target               target word
%
% RETURNS:
%  - Table:              the state-babbling table

%extract the features of the target
targetFeatures = featureExtractionDataset(target);

targetFeatures = targetFeatures';

%calculate the similarity with the centroid vectors
for ii = 1:size(centroidsVect,1)
    centroidDistances(ii) = norm(centroidsVect(ii,:) - targetFeatures(1,:), 2);
end

centroidDistances = centroidDistances.^2;

% Distance to probability estimation:
PsCentroid = tanh(1 ./ centroidDistances);
%PsCentroid = PsCentroid./repmat(sum(PsCentroid,2), [1 size(PsCentroid, 2)])

%find the current state in the table
currentState = find(PsCentroid == max(PsCentroid));BabbleIndexes

%parameters initialization
condition = 0;
start = 0;
endState=0;
ii=0;
jj=0;
tt=0;

%try to use the best babble in the current state
if table(currentState, 1 ) ~= 0
    tempBest = find(table(currentState, : ) == max(table(currentState, : )));BabbleIndexes
    tempTarget(1) = crossedDataset(BabbleIndexes(tempBest));
    
    tempBabbleFeatures = featureExtractionDataset(tempTarget);
    tempBabbleFeatures = tempBabbleFeatures';
    
    tempBabbleDistance = norm(tempBabbleFeatures(1,:) - targetFeatures(1,:), 2);BabbleIndexes
    PsTempBabble = tanh(1 ./ tempBabbleDistance);BabbleIndexes
    
    %the babble is very similar
    if PsTempBabble > treshold
        %update the value of the best babble in the table
        table(currentState, tempBest ) = PsTempBabble;
        bestPs = find(table(currentState, : ) == max(table(currentState, : )));BabbleIndexes
        bestBabble = BabbleIndexes(bestPs);BabbleIndexes
        bestBabbleSimilarity = table(currentState, bestPs);
        condition = 1;
        nBabbling = 1;
        endState=1;
        %the babble is NOT very similar
        %try to use the other babbles in the current state
    else
        table(currentState, tempBest ) = PsTempBabble;
        for jj = 1:size(BabbleIndexes,2)
     
           jj;BabbleIndexes
            tempTarget(1) = crossedDataset(BabbleIndexes(jj));
            
            tempBabbleFeatures = featureExtractionDataset(tempTarget);
            tempBabbleFeatures = tempBabbleFeatures';
            
            tempBabbleDistance = norm(tempBabbleFeatures(1,:) - targetFeatures(1,:), 2);
            PsTempBabble = tanh(1 ./ tempBabbleDistance);
            
            % update the babble in the table
            table(currentState, jj ) = PsTempBabble;
            
            if PsTempBabble > treshold
               %disp('ho trovato tra i babble già fatti uno con valore alto, termino');BabbleIndexes
                condition = 1;
                bestPs = find(table(currentState, : ) == max(table(currentState, : )));BabbleIndexes
                bestBabble = BabbleIndexes(bestPs);BabbleIndexes
                bestBabbleSimilarity = table(currentState, bestPs);
                nBabbling = jj;
                endState=1;
                break;
            end
            
        end
        start=size(BabbleIndexes,2);   
    end
    % the row is empty (that is you are for the first time in that state), find
    % new babble OR there aren't good value in the table
elseif table(currentState, 1 ) == 0
    % try different babbling until the treshold or the max number of try is reached
    PsCurrentBabble = 0;
    
    for ii = 1:size(BabbleIndexes,2)
        ii;BabbleIndexes     
        currentBabbleIndex = BabbleIndexes(ii);
        currentBabble(1) = crossedDataset(currentBabbleIndex);
        currentBabbleFeatures = featureExtractionDataset(currentBabble);
        currentBabbleFeatures = currentBabbleFeatures';
        
        currentBabbleDistance = norm(currentBabbleFeatures(1,:) - targetFeatures(1,:), 2);
        PsCurrentBabble = tanh(1 ./ currentBabbleDistance);
        %PsCurrentBabble = PsCurrentBabble./repmat(sum(PsCurrentBabble,2), [1 size(PsCurrentBabble, 2)])
        
        % save the new babble in the table
        table(currentState, ii) = PsCurrentBabble;
        
        if PsCurrentBabble > treshold
            condition = 1;
            bestPs = find(table(currentState, : ) == max(table(currentState, : ))); BabbleIndexes
            bestBabble = BabbleIndexes(bestPs); BabbleIndexes
            bestBabbleSimilarity = table(currentState, bestPs);
            nBabbling = ii;
            endState=1;
            break;
        end
    end
    
    start = size(BabbleIndexes,2);
    
end
    
if condition == 0
    condition;
    % try different babbling until the treshold or the max number of try is reached
    PsCurrentBabble = 0;
    
    for tt = 1:(900-size(BabbleIndexes,2))
        tt;BabbleIndexes
        
        for k = 1:10000
            %obtain a new index and check if it is already present in the
            %vector
            currentBabbleIndex = randi(length(crossedDataset), 1);
            if sum(BabbleIndexes == currentBabbleIndex) == 0
                break;
            end
        end
        
        BabbleIndexes = [BabbleIndexes currentBabbleIndex];
        
        currentBabble(1) = crossedDataset(currentBabbleIndex);
        currentBabbleFeatures = featureExtractionDataset(currentBabble);
        currentBabbleFeatures = currentBabbleFeatures';
        
        currentBabbleDistance = norm(currentBabbleFeatures(1,:) - targetFeatures(1,:), 2);
        PsCurrentBabble = tanh(1 ./ currentBabbleDistance);
        %PsCurrentBabble = PsCurrentBabble./repmat(sum(PsCurrentBabble,2), [1 size(PsCurrentBabble, 2)])
        
        % save the new babble in the table
        table(currentState, start + tt) = PsCurrentBabble;
        
        if PsCurrentBabble > treshold
            nBabbling = tt + ii + jj;
           
             bestPs = find(table(currentState, : ) == max(table(currentState, : )));BabbleIndexes
             bestBabble = BabbleIndexes(bestPs);BabbleIndexes
             bestBabbleSimilarity = table(currentState, bestPs);
             endState=1;
             break;
        end
    end
    
    if endState == 0
    disp('No similar babbling for that treshold')
    end
    
end
