function [filterBank] = createScaleNormalizedFilterBank(sigma, ...
    scaleFactor, numScaleSpaceSize, displayFlag)

% Create filter masks for each layer in the scale space. The size of the
% mask is calculated by the formula: 2 * ceil(3 * sigma) + 1.

% INPUTS:
% sigma: standard deviation of the first layer.
% scaleFactor: scale factor for the scale space i.e k.
% numScaleSpaceSize: number of layers in the scalespace.
% displayFlag: if true, surface plot for the filter is generated.

% RETURNS:
% filterBank: cell array of size [1 numScaleSpaceSize 2], contains sigma
% and filter masks for each layer at {1, numScaleSpaceSize, 1} and 
% {1, numScaleSpaceSize, 2} respectively.

    filterBank = cell(1, numScaleSpaceSize, 2);
    
    for scaleNum = 1:1:numScaleSpaceSize
        kernelSize = 2 * (ceil(3 * sigma)) + 1;
        filter = (sigma^2) * fspecial('log', kernelSize, sigma);
        filterBank{1, scaleNum, 1} = sigma;
        filterBank{1, scaleNum, 2} = filter;
        
        if displayFlag
            figure;surf(filter);
        end;

        sigma = sigma * scaleFactor;
    end;

end

