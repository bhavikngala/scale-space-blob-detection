function blobDetectionMethod1(imPath, sigma, k, layers, thresholdPercent)

% Function to perform blob detection on a given image. It generates filter
% masks for each layer and applies the filter for each layer on the image
% iteratively. The size of the filter mask is caluclated by the formula:
% 2 * ceil(3 * sigma) + 1, which changes for every layer. After filtering 
% is done, non-maximum suppresion is applied on the image and the remainder
% blobs are displayed.

% INPUTS:
% imPath: Path of the image on which blob detection is to be performed
% sigma: standard deviation of the first layer
% k: scale factor used to scale the sigma for the following layer
% layers: number of layers in the scale space
% thresholdPercent: the percentage of the maximum response value to be used
% for thresholding. It should in the range 0-100.

% OUTPUTS:
% displays the original image with detected blobs

% RETURNS: None


% print sigma for each layer
%     for i=1:1:layers
%         fprintf('sigma for layer %d === %f\n', i, sigma * (k ^ (i-1)));
%     end;

%     create the filter bank, filters for each layer
%     kernel size of the filter is calculated by the formula:
%     2 * ceil(3 * sigma) + 1
    filterBankWScaleN = createScaleNormalizedFilterBank(sigma, k, ...
        layers, false);

%     read image, convert to rgb, convert to double
    im = im2double(rgb2gray(imread(imPath)));

%     apply LoG filter on the image for each layer, square the response,
%     and apply threshold
    imFilterResponses = applyLoGM1WScaleNormalizedFilter(im, ...
        filterBankWScaleN, thresholdPercent, false);

%     Perform non maximum  suppression
    imNonMaximum = performNonMaximumSuppression(imFilterResponses, false);

%     display blobs
    displayBlobs(imread(imPath), imNonMaximum);

end