function marked = imFindCirclesHough(im,minrad,maxrad,std)
    % Functions return image after marking circles om im
    % im - a grayscale image
    % minrad - minimal radius circle to look for
    % maxrad - maximal radius circle to look for
    % std - standard diviation for gaussian blur (1 default)
    
    if nargin<4
        std=1;
    end
    
    edges = edge(im, 'Canny',[0.2,0.7]);% edge detection 
    [h,margin] = circle_hough(edges,minrad:maxrad);% circle hough transform 
    peaks = circle_houghpeaks(h,30:70,margin,'Smoothxy',std);% looking for strong peaks slight blur
    peaks_size = size(peaks);
    peaks_size = peaks_size(2);

    marked = im;% Innitializing marked image to original

    for i=1:peaks_size
        % Getting circle characterisitcs 
        x = peaks(2,i);
        y = peaks(1,i);
        radius = peaks(3,i);
   
    %Getting circle points 
        [pointsX, pointsY] = circlepoints(radius);
        pointsX = pointsX+x;
        pointsY = pointsY+y;
   
        pointsNum = size(pointsX);
        pointsNum = pointsNum(2);
   
        %Marking points on image
        for p=1:pointsNum
            marked(pointsX(p)-1:pointsX(p)+1,pointsY(p)-1:pointsY(p)+1)=0;
        end
   
    end
    
end