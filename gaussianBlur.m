function clean = gaussianBlur(im, radius, std)
    im_size = size(im);
    padded = uint8(zeros(im_size(1)+radius+radius, im_size(2)+radius+radius));
    padded(radius+1: end-radius , radius+1: end-radius) = im;
    [X, Y] = meshgrid(-radius:radius, -radius:radius);
    filter = exp(-(X.^2+Y.^2) / (2*(std * std)));
    filter = filter ./ sum(filter(:));
    for row = 1:im_size(1)
        for col = 1:im_size(2)
           temp = filter .* double(padded(row:row+2*radius, col:col+2*radius)); 
           padded(row+radius,col+radius) = uint8(sum(temp(:)));
        end
    end
    clean = padded(radius+1:end-radius, radius+1:end-radius);
end