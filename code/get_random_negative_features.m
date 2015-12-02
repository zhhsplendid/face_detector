% Starter code prepared by James Hays for CS 143, Brown University
% This function should return negative training examples (non-faces) from
% any images in 'non_face_scn_path'. Images should be converted to
% grayscale, because the positive training data is only available in
% grayscale. For best performance, you should sample random negative
% examples at multiple scales.

function features_neg = get_random_negative_features(non_face_scn_path, feature_params, num_samples)
% 'non_face_scn_path' is a string. This directory contains many images
%   which have no faces in them.
% 'feature_params' is a struct, with fields
%   feature_params.template_size (probably 36), the number of pixels
%      spanned by each train / test template and
%   feature_params.hog_cell_size (default 6), the number of pixels in each
%      HoG cell. template size should be evenly divisible by hog_cell_size.
%      Smaller HoG cell sizes tend to work better, but they make things
%      slower because the feature dimensionality increases and more
%      importantly the step size of the classifier decreases at test time.
% 'num_samples' is the number of random negatives to be mined, it's not
%   important for the function to find exactly 'num_samples' non-face
%   features, e.g. you might try to sample some number from each image, but
%   some images might be too small to find enough.

% 'features_neg' is N by D matrix where N is the number of non-faces and D
% is the template dimensionality, which would be
%   (feature_params.template_size / feature_params.hog_cell_size)^2 * 31
% if you're using the default vl_hog parameters

% Useful functions:
% vl_hog, HOG = VL_HOG(IM, CELLSIZE)
%  http://www.vlfeat.org/matlab/vl_hog.html  (API)
%  http://www.vlfeat.org/overview/hog.html   (Tutorial)
% rgb2gray
    STEP = feature_params.neg_sample_step;
    image_files = dir( fullfile( non_face_scn_path, '*.jpg' ));
    num_images = length(image_files);
    dimensionality = (feature_params.template_size / feature_params.hog_cell_size)^2 * 31;
    

    random_permutation = randperm(num_images);
    features_neg = zeros(num_samples, dimensionality);
    template_size = feature_params.template_size;

    fprintf('read negative samples\n');
    count = 0;
    for i = 1:random_permutation   
       
        image = imread( [non_face_scn_path, '\', image_files(random_permutation(i)).name] );
    
        isize = size(image);
        if (isize(1) < template_size || isize(2) < template_size)
            resize(image, [max(isize(1), template_size), max(isize(1), template_size)]);
        end
        
        for rowBegin = 1:STEP:size(image, 1) - template_size + 1
            for colBegin = 1:STEP:size(image, 2) - template_size + 1;
                
                crop = cropImage(image, rowBegin, colBegin, template_size, template_size);
                if feature_params.mirror
                    hog = imageToHog(crop, feature_params.hog_cell_size);
                    count = count + 1;
                    fprintf('read negetive %d data, total %d samples\n', count, num_samples);
                    features_neg(count, :) = reshape(hog, [1, dimensionality]);
                    if count == num_samples
                        return;
                    end
                    
                    mirror_hog = imageToHog(mirrorImage(crop), feature_params.hog_cell_size);
                    count = count + 1;
                    fprintf('read negetive %d data, total %d samples\n', count, num_samples);
                    features_neg(count, :) = reshape(mirror_hog, [1, dimensionality]);
                    if count == num_samples
                        return;
                    end
                    
                else
                    hog = imageToHog(crop, feature_params.hog_cell_size);
                    count = count + 1;
                    fprintf('read negetive %d data, total %d samples\n', count, num_samples);
                    features_neg(count, :) = reshape(hog, [1, dimensionality]);
                    if count == num_samples
                        return;
                    end
                end 
            end
        end
    end
end
