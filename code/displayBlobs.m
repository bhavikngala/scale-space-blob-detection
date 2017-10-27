function displayBlobs(im, imNonMaximum)

% This function calculates radius for each blob detected in all the layers.
% It then filters the centers, it selects the center with the largest
% radius only. After this step it performs one more step to remove the
% nested blobs. Once the centers are filtered, show_all_circles.m script is
% called to display all the blobs on the original image.

% INPUTS:
% im: original image on which blob detection is performed.
% imNonMaximum: non-maximum suppressed filter responses.

% OUTPUTS:
% displays the blobs on the original image.

% RETURNS: None

    cxyr = [0 , 0, 0];
    
%     Step 1
%     find the centres and radii across all the layers
    for i=1:1:size(imNonMaximum, 2)
        imNonMax = imNonMaximum{1, i, 2};
        [cx, cy] = ind2sub(size(imNonMax), find(imNonMax));
        cxyr = cat(1, cxyr, [cx, cy, ...
            ones(size(cx)) * (imNonMaximum{1, i, 1} * sqrt(2))]);
    end;
%     Step 1 end

%     Step 2
%     select blobs with largest radius only
    r = size(cxyr, 1);
    new_cxyr = [0, 0, 0];
    m = 1;
    
    for i=1:1:r        
        for k=1:1:size(new_cxyr, 1)
            if new_cxyr(k, 1) == cxyr(i, 1) && new_cxyr(k, 2) == cxyr(i, 2)
                continue;
            end;
        end;
        tempr = cxyr(i, 3);
        
        for  j=1:1:r
            if i == j
                continue;
            elseif cxyr(i, 1) == cxyr(j, 1) &&  cxyr(i, 2) == cxyr(j, 2)
                if cxyr(i, 3) > cxyr(j, 3) && cxyr(i, 3) > tempr
                    tempr = cxyr(i, 3);
                elseif cxyr(j, 3) > tempr
                    tempr = cxyr(j, 3);
                end;
            end;
        end;
        new_cxyr(m, 1) = cxyr(i, 1);
        new_cxyr(m, 2) = cxyr(i, 2);
        new_cxyr(m, 3) = tempr;
        m = m + 1;
    end;
%     Step 2 end

%     Step 3
%     remove smaller blobs inside bigger blobs
%     apply formula: Eucledian Dist between Centers + radius of smaller
%     blob < radius of bigger blob, then remove smaller blob
    r = size(new_cxyr, 1);
    new_cxyr = sortrows(new_cxyr, -3);
    i = 1;
    while i < r-1
        j = i + 1;
        while j < r
            disr = sqrt(((new_cxyr(i, 1) - new_cxyr(j, 1)) ^ 2) +...
                ((new_cxyr(i, 2) - new_cxyr(j, 2)) ^ 2)) + new_cxyr(j, 3);
            
            if (disr <= new_cxyr(i, 3)) || (disr <= 1.3 * new_cxyr(i, 3))
                new_cxyr(j, :) = [];
                r = r - 1;
                continue;
            end;
            
            j = j + 1;
        end;
        i = i + 1;
    end;
%     Step 3 end
    
    show_all_circles(im, new_cxyr(:, 2), new_cxyr(:, 1), new_cxyr(:, 3));
end

