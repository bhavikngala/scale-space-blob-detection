function blobDetectionMethod2(imPath, sigma, k, layers, thresholdPercent)

% Function to perform blob detection on a given image. It generates only 
% one filter mask which is used for all the layers. The size of the filter 
% mask is calculated as 2 * ceil(3 * sigma) + 1, which remains constant for
% all the layers. It generates an array of scales used to downsample and 
% upsample the image in respective layer. After filtering is done, 
% non-maximum suppression is performed and the remainder blobs are 
% displayed on the original image.

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

%     display scaling factors for each layer
%     for i=1:1:layers
%         fprintf('scaling factor for layer %d === %f\n', i, (k ^ (i-1)));
%     end;

%     create a filter mask and array of scaling factors
    [filter, scaleFactors] = ...
        createFilterBankFixedKernelSize(sigma, k, layers);

%     read image, convert to rgb, convert to double
    im = im2double(imresize(rgb2gray(imread(imPath)), 1));

%     apply downsample the image, apply LoG filter, upsample the image,
%     sqaure the response, and apply threshold
    imFilterResponses = applyLoGM2WScaleNormalizedFilter(im, ...
        filter, sigma, scaleFactors, thresholdPercent, false);

%     Perform non maximum  suppression
    imNonMaximum = performNonMaximumSuppression(imFilterResponses, false);

%     display blobs
    displayBlobs(imresize(imread(imPath), 1), imNonMaximum);

end