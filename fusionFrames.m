function vector = fusionFrames(framesMatrix, hop)
% fusionFrames: overlap-and-adds the frames in the input matrix      
%   inputs: framesMatrix, matrix containing all the frames as rows
%           hop, number of samples between adjacent windows
%   outputs: vector, result of the overlapp-add method

[nFrames sizeFrames] = size(framesMatrix);
vector = zeros(nFrames*hop-hop+sizeFrames,1);
timeIndex = 1;
for index=1:nFrames
    vector(timeIndex:timeIndex+sizeFrames-1) = vector(timeIndex:timeIndex+sizeFrames-1) + framesMatrix(index,:)';
    timeIndex = timeIndex + hop;
end