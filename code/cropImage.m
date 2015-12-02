function [ outImage ] = cropImage( inputImage, rowBegin, colBegin, rowSize, colSize)
    
    if size(inputImage, 3) == 3 %RGB
        outImage = zeros(rowSize, colSize, 3);
        outImage(i, :, :) = inputImage(rowBegin:rowBegin + rowSize - 1, ...
                colBegin: colBegin + colSize - 1, :);
    else
        outImage = zeros(rowSize, colSize);
        outImage(1:rowSize, :) = inputImage(rowBegin:rowBegin + rowSize - 1, ...
            colBegin: colBegin + colSize - 1);
    end


end

