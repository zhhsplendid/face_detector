function [ hog ] = imageToHog( image, cell_size )
    single_image = single(image) / 255;
    if size(single_image, 3) == 3 %RGB
        single_image = rgb2gray(single_image);
    end
    
    hog = vl_hog(single_image, cell_size);

end

