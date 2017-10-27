function [imFilterResponses] = applyLoGM2WScaleNormalizedFilter( im, ...
    filter, sigma, scaleFactors, thresholdPercent, displayFlag )

% This function iteratively applies LoG filter to the image. The filter
% mask is fixed. In each iteration, the image is first downsampled by the
% factor k for the respective layer. Then the filter is applied to the
% downsampled image. The filter response is then upsampled by the same
% factor k. This response is squared and threshold is applied. This process
% is repeated for all the layer. The final response and effective sigma
% for each layer is stored in a cell array of size(1, numScaleSpaceSize,
% 2) and returned.

% INPUTS:
% im: gray scale input image
% filter: fixed filter mask which is used for all the layers.
% sigma: standard deviation used to generate the filter mask.
% scaleFactors: array of scaling factors for each layer.
% thresholdPercent: percentage of maximum in the response to be used as
% threshold. It should be in range 0-100
% displayFlag: if true, response at each step is displayed for each layer.

% RETURNS:
% imFilterResponses: cell array of size(1, numScaleSpaceSize, 2). Contains
% sigma and final response for the image at each layer. sigma value is
% stored at index{1, numScaleSpacceSize, 1} and response is stored at
% index{1, numScaleSpaceSize, 2}

    imFilterResponses = cell([1, size(scaleFactors, 2), 2]);

    for i=1:1:size(scaleFactors, 2)
        if displayFlag
            figure;
        end;
        
%         Step 1: downsampling the image by factor 1/k
        imDownSampled = imresize(im, 1/scaleFactors(i), 'bicubic');
        
%         Step 2: applying fitler on downsampled image
        imFilterResponse = imfilter(imDownSampled, filter, 'replicate', ...
            'conv');

        if displayFlag
            subplot(1, 2, 1);
            imshow(imFilterResponse);
            title(sprintf('scale = %f', scaleFactor(i)));
        end;
        
%         Step 3: upsampling the image bby factor k
        imFilterResponse = imresize(imFilterResponse, scaleFactors(i), ...
            'bicubic');
        
%         Step 4: taking square of response 
        imFilterResponse = imFilterResponse .^ 2;

        if displayFlag
            subplot(1, 2, 2);
            imshow(imFilterResponse);
            title('square');
        end;
        
%         Step 5: applying threshold on squared response
        maxx = max(imFilterResponse(:));
        threshold = thresholdPercent * maxx / 100;
        [r, c] = size(imFilterResponse);
        for j=1:1:r
            for k=1:1:c
                if imFilterResponse(j, k) < threshold
                    imFilterResponse(j, k) = 0;
                end;
            end;
        end;
         
%         Step 6: save filter responses at each scale to cell array
        imFilterResponses{1, i, 1} = sigma * scaleFactors(i);
        imFilterResponses{1, i, 2} = imFilterResponse;
    end;

end

