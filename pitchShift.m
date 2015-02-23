function [outputVector] = pitchShift(inputVector, windowSize, hopSize, step)
% pitchShift: takes a vector of samples in the time-domain and shifts the pitch 
% by the number of steps specified. Each step corresponds to half a tone. 
%   inputs: inputVector, vector (time-domain) to be processed, as column
%                       vector
%           windowSize, size of the window
%           hopSize, size of the hop
%           step, number of steps to shift
%   outputs: outputVector, result vector (time-domain)                 

alpha = 2^(step/12);
hopOut = round(alpha*hopSize);
wn = hann(windowSize);
% plot(wn,'r+');
% hold on
% wn = hann(windowSize*2+1);
% plot(wn);
% wn = wn(2:2:end);
% plot(wn);
%inputVector = [zeros(hopSize*3,1) ; inputVector];
%size(inputVector)
y = createFrames(inputVector,hopSize,windowSize);
output = zeros(size(y,1),windowSize);
phaseCumulative = 0;
previousPhase = 0;

% for index=1:size(y,1)
%     currentFrame = y(index,:);
%     
%     Window the frame
%     currentFrameWindowed = currentFrame .* wn' / sqrt(((windowSize/hopSize)/2));
%         
%     Get the FFT
%     currentFrameWindowedFFT = fft(currentFrameWindowed);
%     
%     Get the magnitude
%     magFrame = abs(currentFrameWindowedFFT);
%     
%     Get the angle
%     phaseFrame = angle(currentFrameWindowedFFT);
%     
% % Processing    
% 
%     Get the phase difference
%     deltaPhi = phaseFrame - previousPhase;
%     previousPhase = phaseFrame;
%     
%     % Remove the expected phase difference
%     deltaPhiPrime = deltaPhi - hopSize * 2*pi*(0:(windowSize-1))/windowSize;
%     
%     % Map to -pi/pi range
%     deltaPhiPrimeMod = mod(deltaPhiPrime+pi, 2*pi) - pi;
%      
%     % Get the true frequency
%     trueFreq = 2*pi*(0:(windowSize-1))/windowSize + deltaPhiPrimeMod/hopSize;
% 
%     % Get the final phase
%     phaseCumulative = phaseCumulative + hopOut * trueFreq;    
%     
%     % Remove the 60 Hz noise. This is not done for now but could be
%     % achieved by setting some bins to zero.
%    
% %% Synthesis    
%     
%     % Get the magnitude
%     outputMag = magFrame;
%     
%     % Produce output frame
%     outputFrame = real(ifft(outputMag .* exp(1j*phaseCumulative)));
%      
%     % Save frame that has been processed
%     output(index,:) = outputFrame .* wn' / sqrt(((windowSize/hopOut)/2));
%         
% end

%% Finalize

% Overlap add in a vector
outputTimeStretched = fusionFrames(y,hopOut);

% Resample with linearinterpolation
outputTime = interp1((0:(length(outputTimeStretched)-1)),outputTimeStretched,(0:alpha:(length(outputTimeStretched)-1)),'linear');

% Return the result
outputVector = outputTime;

return