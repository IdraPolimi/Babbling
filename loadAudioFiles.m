function icaInput = loadAudioFiles(folder)
out = [];
dims = [];
d=dir([folder '/*.wav']);

for ii=1:length(d)
    fname=d(ii).name;
    y =audioread(fname);
    dims = [dims size(y,1)];
end


media = floor(mean(dims))
if media > 440000
    media = 440000;
end

for ii=1:length(d)
    fname=d(ii).name;
    y = audioread(fname);
    f = sum(y,2);
    if (length(f) > media)
        out = [out f(1:media)];
    else
        f(media) = 0;
        out = [out f];
    end
end
icaInput = out;

