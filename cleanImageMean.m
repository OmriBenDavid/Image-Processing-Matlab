function clean = cleanImageMean(im, radius)
    image_size = size(im);
    padded = uint8(zeros(image_size(1)+2*radius, image_size(2)+2*radius));
    padded(radius+1:end-radius, radius+1:end-radius) = im;
    filter = ones(radius,radius);
    filter = filter./sum(filter(:));
    for row = 1:image_size(1)
       for col = 1:image_size(2)
           res = double(padded(row:row+2*radius, col:col+2*radius)) .* filter;
           res = uint8(sum(res(:)));
           padded(row+radius,col+radius) =uint8(res);
       end
    end
    clean = uint8(padded(radius+1:end-radius, radius+1:end-radius));
end