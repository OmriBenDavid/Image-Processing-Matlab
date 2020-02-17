function cleanIm = cleanImageMedian(im,radius)
    image_size = size(im);
    rows = image_size(1);
    cols = image_size(2);
    
    padded = uint8(zeros(rows+2*radius, cols+2*radius));
    padded(radius+1:end-radius, radius+1:end-radius)= im;
    cleanIm = zeros(image_size);
    for row = 1:rows
       for col = 1:cols
           
           window = padded(row:row+2*radius, col:col+2*radius);
           med = median(window(:));
           padded(row+radius,col+radius) = med;
           
       end
    end
    
    cleanIm = padded(radius+1:end-radius, radius+1:end-radius);
end