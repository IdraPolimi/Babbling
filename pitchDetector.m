
function freq = pitchDetector(x, fs)
% Extract the pitch of the signal x
% INPUT x = audio signal, fs = frequency
% OUTPUT the pitch frequency

 N = length(x);
 x = x(:) .* hamming(N);
 y = fft(x, N);
 c = ifft(log(abs(y)+eps));
 
 % search for maximum  between 2ms (=500Hz) and 20ms (=50Hz)
 ms2=floor(fs*0.002); % 2ms
 ms20=floor(fs*0.02); % 20ms
 [maxi,idx]=max(abs(c(ms2:ms20)));
 freq = fs/(ms2+idx-1);