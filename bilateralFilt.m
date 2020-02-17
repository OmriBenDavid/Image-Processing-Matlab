function cleanIm = bilateralFilt(im, radius, stdSpatial, stdIntensity)
   image_size = size(im);
   padded = uint8(zeros(image_size + 2*[radius radius]));
   padded(radius+1:end-radius, radius+1:end-radius) = im;
   
   [X, Y] = meshgrid(-radius:radius, -radius:radius);
   
   spatial = exp(-(X.^2+Y.^2) / (2*(stdSpatial^2)));
   spatial = spatial / sum(spatial(:));
   
   [X, Y] = meshgrid(-255:255, 1);
   photometric = exp(-(X.^2+Y.^2) / (2*(stdIntensity^2)));
   photometric = photometric / sum(photometric);
   
   for row = 1:image_size(1)
      for col = 1:image_size(2)
         window = padded(row:row+2*radius, col:col+2*radius);
         mask = uint8(window - padded(row+radius, col+radius));
         mask = photometric(256 + mask);
         mask = mask .* spatial;
         mask = mask / sum(mask(:));
         window = uint8(double(window) .* mask);
         color = sum(window(:));
         padded(row+radius, col+radius) = color;
         
      end
   end
   
   cleanIm = padded(radius+1:end-radius, radius+1:end-radius);
end