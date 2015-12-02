function [ hog ] = imageToHog( image, cell_size, dim)
    single_image = single(image) / 255;
    if size(single_image, 3) == 3 %RGB
        single_image = rgb2gray(single_image);
    end
    
    hog = vl_hog(single_image, cell_size);
    
    if nargin > 2
        hog = reshape(hog, [1, dim]);
    end
end

