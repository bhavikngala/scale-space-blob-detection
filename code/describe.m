function describe(matx)
%DESCRIBE Summary of this function goes here
%   Detailed explanation goes here
    fprintf('max: %f\n', max(matx(:)));
    fprintf('min:  %f\n', min(matx(:)));
    fprintf('mean: %f\n', mean(matx(:)));
    fprintf('median: %f\n', median(matx(:)));
    fprintf('mode: %f\n', mode(find(matx(:) > 0)));

end

