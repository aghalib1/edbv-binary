%Author: Manuel Kröter

function [ final_points ] = hough_circles(img, radius_x, radius_y)
% Hough Transformation to detect zeros
%
%Input: 
%- aleady thinned black white image, foreground is white
%- radius_x: radius of the ellipse/zero (to be detected) in x-direction
%- radius_y: radius of the ellipse/zero (to be detected) in y-direction

%  The radius values depend on font style and size
%  Good values for Arial, Size 20, are:
%  radius_x = 4.8;
%  radius_y = 8;
%  UPDATE THIS INFO WHEN YOU FOUND BETTER VALUES!!

%Output:
%- Matrix containing x and y points (=center of found zeros)
%  Rows = Points
%  1.Column x, 2.Column y 


    height = size(img,1);
    width = size(img,2);

    houghRaum = zeros(size(img));
    
    for x=1:width
        
        for y=1:size(img,1)
            
            if img(y,x)>0 

                degreeCounter = 0;
                for t=1:5:360
                    
                    degreeCounter = degreeCounter + 1;
                    x_ellipse = round(x+radius_x*cosd(t));
                    y_ellipse = round(y+radius_y*sind(t));
                        
                    if x_ellipse>0 && y_ellipse>0 && x_ellipse<=width && y_ellipse<=height
                        houghRaum(y_ellipse,x_ellipse) = houghRaum(y_ellipse,x_ellipse) + 1;
                    end
                end
            end
        end
    end
    
    
    m = max(houghRaum(:));  %could also be a user input (how many pixels have to be on the ellipse to be considered as a result ellipse)
    
    %Comment the next two lines when using the function in final script
    %scale the values to 0-1 to show the result as an image
    scaledHough = double(houghRaum./m);
    imshow(scaledHough);
    
    %Which ellipse centers should be returned as results?
    %Now: Only the centers of those ellipses with the maximum amount of
    %pixels on it. So if there is a ellipse with only one pixel less, the
    %corresponding center is not returned.
    houghRaum(houghRaum<m)=0;
    [y x] = find(houghRaum);
    
    
    %TEMPORARY, Should be improved! When changed, also update the version for line detection!
    %merge nearby points, maybe use average pixel of all nearby pixels
    %now just the first pixel is chosen
    points = [x y];
    final_points = points(1,:);
    for i=2:size(points,1)
        insert = 1;
        for j=1:size(final_points,1)
            if abs(sqrt(final_points(j,1)^2+final_points(j,2)^2)-sqrt(points(i,1)^2+points(i,2)^2))<3 %which threshold distance?
                insert = 0;
            end
        end
        if insert == 1
            final_points(j+1,:)=points(i,:);
        end
    end
    
    
    final_points=[x y];

end



