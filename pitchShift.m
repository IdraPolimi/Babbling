function outputVector = pitchShift(inputVector, windowSize, hopSize, step)
% pitchShift: takes a vector of samples in the time-domain and shifts the pitch 
% by the number of steps specified. Each step corresponds to half a tone. 
%   inputs: inputVector, vector (time-domain) to be processed, as column
%                       vector
%           windowSize, size of the window
%           hopSize, size of the hop
%           step, number of steps to shift
%   outputs: outputVector, result vector (time-domain)                 

hopOut = round((2^(step/12))*hopSize);
%Creation of the window
wn=.5*(1 - cos(2*pi*(0:windowSize-1)'/(windowSize)));
y = createFrames(inputVector,hopSize,windowSize);
output = zeros(size(y,1),windowSize);
phaseCumulative = 0;
previousPhase = 0;

for index=1:size(y,1)
    currentFrame = y(index,:);
    %Window the frame
    currentFrameWindowed = currentFrame .* wn'/ sqrt(((windowSize/hopSize)/2));% / (hopSize/windowSize); %
    %Get the FFT of the fftshif
    currentFrameWindowedFFT = fft(fftshift(currentFrameWindowed));
    %Get the magnitude
    magFrame = abs(currentFrameWindowedFFT);
    %Get the angle
    phaseFrame = angle(currentFrameWindowedFFT);
    %Get the phase difference
    deltaPhi = phaseFrame - previousPhase;
    previousPhase = phaseFrame;
    deltaPhiPrime = deltaPhi - hopSize * 2*pi*(0:(windowSize-1))/windowSize;
    deltaPhiPrimeMod = mod(deltaPhiPrime+pi, 2*pi) - pi;     
    % Get the true frequency
    trueFreq = 2*pi*(0:(windowSize-1))/windowSize + deltaPhiPrimeMod/hopSize;
    %Get the final phase
    phaseCumulative = phaseCumulative + hopOut * trueFreq;    
    % Produce output frame
    outputFrame = fftshift(real(ifft(magFrame .* exp(j*phaseCumulative))));
    output(index,:) = outputFrame .* wn' / sqrt(((windowSize/hopOut)/2));
end
%Overlap add in a vector
outputTimeStretched = fusionFrames(output,hopOut);
%Resample with linearinterpolation
outputTime = interp1((0:(length(outputTimeStretched)-1)),outputTimeStretched,(0:2^(step/12):(length(outputTimeStretched)-1)),'linear');
outputVector = outputTime;