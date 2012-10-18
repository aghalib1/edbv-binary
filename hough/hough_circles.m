%Author: Manuel Kröter

function [ final_points ] = hough_circles(img)
%function [ final_points ] = hough_circles img, scale_start, scale_end, min_pixels, max_pixels )
%
% THIS INFO HAS TO BE UPDATED!
%
%First try with Hough Transformation to detect zeros!
%Simplest version, does not consider connectivity of points!!
%Its hard to detect horizontal lines without using connectivity
%There are always a lot of pixels in a line of text horizontally...

%Input: 
%- aleady thinned black white image
%- start + end angles in degrees, start < end (angle of the corresponding normal!!)
%- minimum and maximum pixels on the line, when there are more or less pixels, the corresponding line is not detected

%Output:
%- Matrix containing x and y points of detected lines
%- Rows = Points
%- 1.Column x, 2.Column y 

%ATTENTION: The returned points MAY NOT LIE on the actual line segment!
%Die gelieferten Punkte sind Lotfußpunkte der Normalen (der gesuchten Geraden), welche zum Ursprung zeigt



%     if angle_end<=angle_start
%         disp 'Start angle has to be bigger than end angle';
%        return; 
%     end
%     if min_pixels>=max_pixels || min_pixels<0 || max_pixels<0
%         disp 'Error. Wrong parameter values.';
%        return; 
%     end
    
 %   total_degrees = angle_end-angle_start+1;

    height = size(img,1);
    width = size(img,2);
    
    scale = 8;

    houghRaum = zeros(size(img));
    
    for x=1:width
        
        for y=1:size(img,1)
            
            if img(y,x)>0 

                degreeCounter = 0;
                for t=1:5:360
                    
                    degreeCounter = degreeCounter + 1;
                    x_ellipse = round(x+scale*0.6*cosd(t));
                    y_ellipse = round(y+scale*1*sind(t));
                        
                    if x_ellipse>0 && y_ellipse>0 && x_ellipse<=width && y_ellipse<=height
                        houghRaum(y_ellipse,x_ellipse) = houghRaum(y_ellipse,x_ellipse) + 1;
                    end
                end
            end
        end
    end
    
    
    m = max(houghRaum(:));  %could also be a user input (how many pixels have to be on the ellipse to be considered as a result ellipse)
    
    %scale the values to 0-1 to show the result as an image
    scaledHough = double(houghRaum./m);
    imshow(scaledHough);
    
    temp = houghRaum;
    temp(temp<m)=0; %perhaps a litte buffer zone
    [y x] = find(temp);
    final_points=[x y];

end



