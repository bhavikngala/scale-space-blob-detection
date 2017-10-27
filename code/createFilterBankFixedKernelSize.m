function [filter, scaleFactors] = ...
    createFilterBankFixedKernelSize(sigma, ...
        scaleFactor, numScaleSpaceSize)
    
% Create one filter masks and an array which contains scaling factors for 
% each layer in the scale space. The size of the mask is calculated by the 
% formula: 2 * ceil(3 * sigma) + 1.

% INPUTS:
% sigma: standard deviation of the first layer.
% scaleFactor: scale factor for the scale space i.e k.
% numScaleSpaceSize: number of layers in the scalespace.

% RETURNS:
% filter: filter mask which is used in all the layers
% scaleFactors: array of scaling factors for every layer. Calculated by the
% formula scaleFactor ^ (i - 1), i=1:numScaleSpaceSize

%     in my opinion since we are keeping the filter scale same, to the
%     lowest, the filter peak will have the highest magnitude at all times
%     and thus the ouput will not decrease in magnitude with increase scale
%     thus we do not need to appy scale normalization
    filter = fspecial('log', 2 * ceil(3 * sigma) + 1, sigma);
    scaleFactors = zeros(1, numScaleSpaceSize);
    
    for scaleNum = 1:1:numScaleSpaceSize
        scaleFactors(scaleNum) = scaleFactor ^ (scaleNum - 1);
    end;

end

