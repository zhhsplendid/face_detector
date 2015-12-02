function [ outImage ] = cropImage( inputImage, rowBegin, colBegin, rowSize, colSize)
    
    if size(inputImage, 3) == 3 %RGB
        outImage = zeros(rowSize, colSize, 3);
        for i = 1:rowSize
            outImage(i, :, :) = inputImage(rowBegin - 1 + i, colBegin: colBegin + colSize - 1, :);
        end
    else
        outImage = zeros(rowSize, colSize);
        for i = 1:rowSize
            outImage(i, :) = inputImage(rowBegin - 1 + i, colBegin: colBegin + colSize - 1);
        end
    end


end

