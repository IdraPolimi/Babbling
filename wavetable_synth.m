clear all;
close all;

% open file

[y1, fs1]=wavread('da.wav');
[y2, fs2]=wavread('ga.wav');


y1 = sum(y1,2)';
y2 = sum(y2,2)';
%Create a single sine waves of  frequencie f1


doit = input('\nPlay/Plot  Y/[N]:\n\n', 's');

if doit == 'y',
figure(1)
plot(y1);
sound(y1,fs1);
end


doit = input('\nPlay/Plot Raw saw y2 looped for 10 seconds? Y/[N]:\n\n', 's');


if doit == 'y',
figure(2)
plot(y2);
sound(y2,fs2);
end

size(y1)
size(y2)
ywave = [y1 , y2];


doit = input('\nPlay/Plot Raw Concatenated  Y/[N]:\n\n', 's');


if doit == 'y',
figure(3)
plot(ywave);
sound(ywave,fs1);
end





% Create Cross fade half width of wave y1 for xfade window

xfadewidth = floor(length(y1)/1.5);
ramp1 = (0:xfadewidth)/xfadewidth;
ramp2 = 1 - ramp1;

doit = input('\nShow Crossfade Y/[N]:\n\n', 's');


if doit == 'y',
figure(4)
plot(ramp1);
hold on;
plot(ramp2,'r');
end;


%apply crossfade centered over the join of y1 and y2

xramp1 = [ones(1,floor(length(y1)-xfadewidth/2)), ramp2, zeros(1,floor(length(y2)-xfadewidth/2))];
xramp2 = 1- xramp1;

% Create two period waveforms to fade between

ywave1 = [y1 , zeros(1,length(y2))];
ywave2 = [zeros(1,length(y1)), y2];

% do xfade

% add two waves together over the period modulated by xfade ramps (recall
% .* to multiply matrices element by element NOT MATRIX mutliplication

size(xramp1)
size(xramp2)
size(ywave1)
size(ywave2)

ywave = xramp1.*ywave1 + xramp2.*ywave2;

doit = input('\nPlay/Plot Additive Sines together? Y/[N]:\n\n', 's');

if doit == 'y',
figure(5)

subplot(3,1,1);
plot(ywave);

hold off
%axis([0 1.5*N1 -1.1 1.1]);grid
set(gca,'fontsize',18);
ylabel('Amplitude'); 
title('Two Waves');
set(gca,'fontsize',18);

subplot(3,1,2);
plot(xramp1);
hold on
plot(xramp2,'r')
hold off
%axis([0 1.5*N1 -1.1 1.1]);grid
set(gca,'fontsize',18);
ylabel('Amplitude'); 
title('Crossfade Masks');
set(gca,'fontsize',18);

subplot(3,1,3);
plot(ywave2);
set(gca,'fontsize',18);
ylabel('Amplitude'); 
title('WaveTable Synthesis');
set(gca,'fontsize',18);

sound(ywave,fs1);
end


