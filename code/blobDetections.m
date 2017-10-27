close all;

% image paths
imNames = cell(1, 8);
imNames{1, 1} = './../data/butterfly.jpg';
imNames{1, 2} = './../data/sunflowers.jpg';
imNames{1, 3} = './../data/fishes.jpg';
imNames{1, 4} = './../data/einstein.jpg';
imNames{1, 5} = './../data/myimages/cheetah.jpg';
imNames{1, 6} = './../data/myimages/cropcircles2.jpg';
imNames{1, 7} = './../data/myimages/emojis_small.jpg';
imNames{1, 8} = './../data/myimages/honeycombs.jpg';

% number of images
l = size(imNames, 2);

% parameters for blob detection
sigma = 1.618; % 1.168
k = 1.159; % 1.159
layers = 15;
thresholdPercent = 40; % this is percentage, should be in scale 0-100

disp('~~~~~~~~~~~~~~~~~~~~~~~~~~Method 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
for i=1:l
    tic;
    disp(imNames{1, i});
    blobDetectionMethod1(imNames{1, i}, sigma, k, layers, ...
        thresholdPercent);
    toc;
end;

disp('~~~~~~~~~~~~~~~~~~~~~~~~~~Method 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
for i=1:l
    tic;
    disp(imNames{1, i});
    blobDetectionMethod2(imNames{1, i}, sigma, k, layers, ...
        thresholdPercent);
    toc;
end;

% save the figures with blobs
% for i=9:16
%     saveas(figure(i), ['./../results/method2/method2_', ...
%         imNames{1, i - 8}], 'jpg');
% end;