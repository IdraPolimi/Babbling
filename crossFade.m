function crossFaded = crossFade(y1 , y2)

% cross fade of y1 and y2 sounds

% Create Cross fade half width of wave y1 for xfade window

xfadewidth = floor(length(y1)/1.5);
ramp1 = (1:xfadewidth)/xfadewidth;
ramp2 = 1 - ramp1;

%apply crossfade centered over the join of y1 and y2

xramp1 = [ones(1,ceil(length(y1)-xfadewidth/2)), ramp2, zeros(1,ceil(length(y2)-xfadewidth/2))];
xramp2 = 1- xramp1;

% Create two period waveforms to fade between

ywave1 = [y1 , zeros(1,length(xramp1)-length(y1))];
ywave2 = [zeros(1,length(xramp2)-length(y2)), y2];

% do xfade
% add two waves together over the period modulated by xfade ramps (recall
% .* to multiply matrices element by element NOT MATRIX mutliplication

crossFaded = xramp1.*ywave1 + xramp2.*ywave2;



