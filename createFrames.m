function [vectorFrames] = createFrames(x,hop,windowSize)
% createFrames: splits a vector in overlapping frames 
%   inputs: x, vector to be splitted
%           hop, displacement of each windows in number of samples;
%           windowSize, length of the windows
%   outputs: vectorFrames matrix containing each frame as rows

numberSlices = floor((length(x)-windowSize)/hop) +1; %added +1!;
x = x(1:((numberSlices-1)*hop+windowSize));
vectorFrames = zeros(numberSlices,windowSize);
for index = 1:numberSlices   
    indexTimeStart = (index-1)*hop + 1;
    indexTimeEnd = (index-1)*hop + windowSize;
    vectorFrames(index,:) = x(indexTimeStart: indexTimeEnd);
end