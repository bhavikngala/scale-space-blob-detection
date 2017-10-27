function [imNonMaximum] = performNonMaximumSuppression( ...
    imFilterResponses, displayFlag)

% This function performs non maximum suppression on the filter response. It
% find the local maximum in the neighbourhood of 5 * 5 pixels and sets the
% pixels less than the local maxima to zero. Matlab function colfilt with 
% sliding window and function handle removeBelowLocalMaxima are used for 
% the purpose.

% INPUTS:
% imFilterResponses: cell array of size(1, numScaleSpaceSize, 2). Contains
% final response of the filter stage at index {1, numScaleSpaceSize, 2} and
% sigma for respective layer at index {1, numScaleSpaceSize, 1}.
% displayFlag: if true, display the non-maxima suppressed image for each
% layer.

% RETURNS:
% imNonMaximum: cell arry of size(1, numScaleSpaceSize, 2). Contains
% non-maxima suppressed image at index {1, numScaleSpaceSize, 2} and
% sigma for respective layer at index {1, numScaleSpaceSize, 1}.

    imNonMaximum = cell(size(imFilterResponses));
    for i=1:1:size(imFilterResponses, 2)        
        imNonMaximum{1, i, 1} = imFilterResponses{1, i, 1};
%         imNonMaximum{1, i, 2} = nlfilter(imFilterResponses{1, i, 2}, ...
%             [5 5], @removeBelowLocalMaxima);
        imNonMaximum{1, i, 2} = colfilt(imFilterResponses{1, i, 2}, ...
            [5 5], 'sliding', @removeBelowLocalMaxima);
        
        if displayFlag
            figure;
            imshow(imNonMaximum{1, i, 2});
            disp(imNonMaximum{1, i, 1});
%             title(sprintf('sigma %f', imNonMaximum{1, i, 1}));
        end;
    end;
    
end

