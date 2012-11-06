%Author: Manuel Kr�ter
% Version: 6.11.2012

function [ final_points ] = hough_plus(img, scale, min_pixels)
% Hough Transformation to detect plus

% VERY SIMPLE FIRST TRY, PLUS SHOULD NOT BE ROTATED, NOT EVEN A LITTLE

%
%Input: 
%- aleady thinned black white image, foreground is white
%- scale, how big are the plus signs to be detected, have to be integers,
%  should be the "radius" of the plus sign in pixels
%- min_pixels, minimum amount of pixels to be considered as center of a plus sign

% scale and min_pixels depend on the font style and size
% Good values for Arial, Size 20:
%
%  TO BE DONE
%

%Output:
%- Matrix containing x and y points (=center of found plus)
%  Rows = Points
%  1.Column x, 2.Column y 

    height = size(img,1);
    width = size(img,2);

    houghRaum = zeros(size(img));
    
    [y, x] = find(img);
    
    for i=1:size([y, x],1);

        for x_loop=-scale:1:scale
            for y_loop=1:1:1
            	y_plus = round(y(i)+y_loop);
            	x_plus = round(x(i)+x_loop);
                        
                if y_plus>0 && x_plus>0 && y_plus<=height && x_plus<=width    
                	houghRaum(y_plus,x_plus) = houghRaum(y_plus,x_plus) + 1;
                end
            end
        end
        for y_loop=-scale:1:scale
            for x_loop=1:1:1
            	y_plus = round(y(i)+y_loop);
                x_plus = round(x(i)+x_loop);
                        
                if y_plus>0 && x_plus>0 && y_plus<=height && x_plus<=width    
                    houghRaum(y_plus,x_plus) = houghRaum(y_plus,x_plus) + 1;
                end
            end
        end                        

    end


    m = max(houghRaum(:));
    
    if m<min_pixels
        final_points = [];
        return;
    end
    
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
            if (abs(sqrt(final_points(j,1)^2+final_points(j,2)^2)-sqrt(points(i,1)^2+points(i,2)^2)))<5 %which threshold distance?
                insert = 0;
            end
        end
        if insert > 0
            final_points(j+1,:)=points(i,:);
        end
    end
    
   size(houghRaum)

end



