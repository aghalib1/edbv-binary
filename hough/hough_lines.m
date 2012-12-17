%Author: Manuel Kröter
% Version: 6.11.2012

function [ final_points ] = hough_lines( img, angle_start, angle_end)
%function [ final_points ] = hough_lines( img, angle_start, angle_end, min_pixels, max_pixels )

% Hough Transformation to detect lines!

% Use angle around 0 to detect ones, e.g. -5 to 5

%Simplest version, does not consider connectivity of points!!
%Its hard to detect horizontal lines without using connectivity
%There are always a lot of pixels in a line of text horizontally...

%Input: 
%- aleady thinned black white image, foreground is white
%- start + end angles in degrees, start < end (angle of the corresponding normal!!)
%- minimum and maximum pixels on the line, when there are more or less pixels, the corresponding line is not detected

%Output:
%- Matrix containing x and y points of detected lines
%- Rows = Points
%- 1.Column x, 2.Column y 

%ATTENTION: The returned points MAY NOT LIE on the actual line segment!
%Die gelieferten Punkte sind Lotfußpunkte der Normalen (der gesuchten Geraden), welche zum Ursprung zeigt



    if angle_end<=angle_start
        disp 'Start angle has to be bigger than end angle';
       return; 
    end
%     if min_pixels>max_pixels || min_pixels<0 || max_pixels<0
%         disp 'Error. Wrong pixel parameters.';
%        return; 
%     end
    
    total_degrees = angle_end-angle_start+1;

    height = size(img,1);
    width = size(img,2);
    

    max_d = sqrt((height/2)^2 + (width/2)^2);
    houghRaum = zeros(ceil(2*max_d),total_degrees);
    
    for x=1:width
        
        x_pos = x - round(width/2);
       
        for y=1:size(img,1)
            
            if img(y,x)>0 

                y_pos = -(y - round(height/2));
                degreeCounter = 0;
                
                for alpha = angle_start:1:angle_end
                    degreeCounter = degreeCounter + 1;
                    d = x_pos * cosd(alpha) + y_pos * sind(alpha);
                    d = d + max_d + 1;
                    d = round(d); %round ok?
                    houghRaum(d,degreeCounter) = houghRaum(d,degreeCounter) + 1;
                end

            end

        end

    end
    
    
    m = max(houghRaum(:));
    
    %Comment the next two lines when using the function in final script
    %scale the values to 0-1 to show the result as an image
    scaledHough = double(houghRaum./m);
    
  % imshow(scaledHough);
    
  %  temp(temp<min_pixels)=0;
  %  temp(temp>max_pixels)=0;
    
    %currently only these lines with the maximum amount of points on it
    %will be returned as a result
     houghRaum(houghRaum<m)=0; 
     
    [d alpha] = find(houghRaum);
    
    d = d - max_d - 1;
    alpha = alpha-1+angle_start;
    
    x = round(cosd(alpha).*d)+round(width/2);
    y = (-round(sind(alpha).*d))+round(height/2);
    
    
    
    %TEMPORARY, Should be improved
    %merge nearby points, maybe use average pixel of all nearby pixels
    %now just the first pixel is chosen
    points = [x y];
    final_points = points(1,:);
    for i=2:size(points,1)
        insert = 1;
        for j=1:size(final_points,1)
            if abs(sqrt(final_points(j,1)^2+final_points(j,2)^2)-sqrt(points(i,1)^2+points(i,2)^2))<3 %which threshold distance?
                insert = 0;
                final_points(j,1) = (final_points(j,1)+points(i,1))/2;
                final_points(j,2) = (final_points(j,2)+points(i,2))/2;
            end
        end
        if insert == 1
            final_points(j+1,:)=points(i,:);
        end
    end
    
    


end



