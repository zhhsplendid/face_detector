function [ outImage ] = mirrorImage( inputImage )
    outImage = inputImage;
    row = size(inputImage, 2);
    mid = floor(row);
    if size(inputImage, 3) == 3
        
        for i = 1:mid
            outImage(:,i,:) = inputImage(:,row + 1 - i,:);
            outImage(:,row + 1 - i,:) = inputImage(:,i,:);
        end
    else
        for i = 1:mid
            outImage(:,i) = inputImage(:,row + 1 - i);
            outImage(:,row + 1 - i) = inputImage(:,i);
        end
    end
end

