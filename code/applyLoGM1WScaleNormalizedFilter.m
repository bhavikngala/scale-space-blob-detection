function [imFilterResponses] = applyLoGM1WScaleNormalizedFilter(im, ...
    filterBank, thresholdPercent, displayFlag)

% This function iteratively applies LoG filter to the image using
% corresponding filter mask for all the layers in the scale space. The
% response of the filter is squared. Threshold is applied to the squared
% response as the last stp of the function. Final response for each layer
% along with their sigma value are stored in a cell array of 
% size(1, layers in scale space, 2) and returned.

% INPUTS:
% im: gray scale input image
% filterBank: cell array of size(1, numScaleSpaceSize, 2), contains sigma
% and filter masks for each layer
% thresholdPercent: percentage of maximum in the response to be used as
% threshold. It should be in range 0-100
% displayFlag: if true, response at each step is displayed for each layer.

% RETURNS:
% imFilterResponses: cell array of size(1, numScaleSpaceSize, 2). Contains
% sigma and final response for the image at each layer. sigma value is
% stored at index{1, numScaleSpacceSize, 1} and response is stored at
% index{1, numScaleSpaceSize, 2}

    imFilterResponses = cell(size(filterBank));

    for i=1:1:size(filterBank, 2)
        if displayFlag
            figure;
        end;
        
%         Step 1: apply filter to the image
        imFilterResponse = imfilter(im, filterBank{1, i, 2}, ...
            'replicate', 'conv');

        if displayFlag
            subplot(1, 2, 1);
            imshow(imFilterResponse);
            title(sprintf('scale normalized filter sigma = %f', ...
                filterBank{1, i, 1}));
        end;
        
%         Step 2: taking square of response 
        imFilterResponse = imFilterResponse .^ 2;

        if displayFlag
            subplot(1, 2, 2);
            imshow(imFilterResponse);
            title('square');
        end;
        
%         Step 3: Apply threshold to the squared response
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
         
%         Step 4: save filter responses at each scale to cell array
        imFilterResponses{1, i, 1} = filterBank{1, i, 1};
        imFilterResponses{1, i, 2} = imFilterResponse;
    end;

end

