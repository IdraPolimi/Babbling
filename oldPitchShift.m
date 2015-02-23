function [outputVector] = pitchShift(inputVector, windowSize, hopSize, step)

%% Parameters

% Window size
winSize = windowSize;
% Space between windows
hop = hopSize;
% Pitch scaling factor
alpha = 2^(step/12);

% Intermediate constants
hopOut = round(alpha*hop);

% Hanning window for overlap-add
wn = hann(winSize*2+1);
wn = wn(2:2:end);

%% Source file

x = inputVector;

% Rotate if needed
if size(x,1) < size(x,2)
   
    x = transpose(x);

end

x = [zeros(hop*3,1) ; x];

%% Initialization

% Create a frame matrix for the current input
y = createFrames(x,hop,winSize);

% Create a frame matrix to receive processed frames
numberFramesOutput = size(y,1);
outputy = zeros(numberFramesOutput,winSize);

% Initialize cumulative phase
phaseCumulative = 0;

% Initialize previous frame phase
previousPhase = 0;

for index=1:size(y,1)
    
%% Analysis
    
    % Get current frame to be processed
    currentFrame = y(index,:);
    
    % Window the frame
    currentFrameWindowed = currentFrame .* wn' / sqrt(((winSize/hop)/2));
    
    % Get the FFT
    currentFrameWindowedFFT = fft(currentFrameWindowed);
    
    % Get the magnitude
    magFrame = abs(currentFrameWindowedFFT);
    
    % Get the angle
    phaseFrame = angle(currentFrameWindowedFFT);
    
%% Processing    

    % Get the phase difference
    deltaPhi = phaseFrame - previousPhase;
    previousPhase = phaseFrame;
    
    % Remove the expected phase difference
    deltaPhiPrime = deltaPhi - hop * 2*pi*(0:(winSize-1))/winSize;
    
    % Map to -pi/pi range
    deltaPhiPrimeMod = mod(deltaPhiPrime+pi, 2*pi) - pi;
     
    % Get the true frequency
    trueFreq = 2*pi*(0:(winSize-1))/winSize + deltaPhiPrimeMod/hop;

    % Get the final phase
    phaseCumulative = phaseCumulative + hopOut * trueFreq;    
    
    % Remove the 60 Hz noise. This is not done for now but could be
    % achieved by setting some bins to zero.
   
%% Synthesis    
    
    % Get the magnitude
    outputMag = magFrame;
    
    % Produce output frame
    outputFrame = real(ifft(outputMag .* exp(j*phaseCumulative)));
     
    % Save frame that has been processed
    outputy(index,:) = outputFrame .* wn' / sqrt(((winSize/hopOut)/2));
        
end

%% Finalize

% Overlap add in a vector
outputTimeStretched = fusionFrames(outputy,hopOut);

% Resample with linearinterpolation
outputTime = interp1((0:(length(outputTimeStretched)-1)),outputTimeStretched,(0:alpha:(length(outputTimeStretched)-1)),'linear');

% Return the result
outputVector = outputTime;

return