%Author: Manuel Kröter

function [ final_points ] = hough_lines( img, angle_start, angle_end )
%First try with Hough Transformation to detect lines!
%Simplest version, does not consider stuff like minimal line length oder
%connectivity

%input is an aleady thinned black white image
%and the start + end angles, start < end

%output is the hough accumulator
%columns = degrees from 1 to 180 (Grad der Normalen der Gerade zur X-Achse)
%rows = distance to origin, distance 0 is in the middle (e.g. entries at row/2 are lines through the origin)
%origin of the input image is also considered in the center of the image.


    if angle_end<=angle_start
        disp 'Start angle has to be bigger than end angle';
       return; 
    end
    
    total_degrees = angle_end-angle_start+1;

    height = size(img,1);
    width = size(img,2);
    

    max_d = sqrt((height/2)^2 + (width/2)^2);
    %min_d = -max_d;
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
    
    
    m = max(houghRaum(:));  %could also be a user input (how many pixels have to be on the line to be considered as a result line)
    
    %scale the values to 0-1 to show the result as an image
    scaledHough = double(houghRaum./m);
    imshow(scaledHough);
    

    temp = houghRaum;
    temp(temp<m)=0; %evtl nicht alles wegschneiden, puffer lassen zu maximum
    [d alpha] = find(temp);
    
    d = d - max_d - 1;
    alpha = alpha-1+angle_start;
    
    x = round(cosd(alpha).*d)+round(width/2);  %d and alpha always same size???
    y = (-round(sind(alpha).*d))+round(height/2);
    
    
    %TEMPORARY, Should be improved
    %merge nearby points, maybe use average pixel of all nearby pixels
    %now just the first pixel is chosen
    points = [x y];
    final_points = points(1,:);
    for i=2:size(points,1)
        insert = 1;
        for j=1:size(final_points,1)
            if abs(sqrt(final_points(j,1)^2+final_points(j,2)^2)-sqrt(points(i,1)^2+points(i,2)^2))<2
                insert = 0;
            end
        end
        if insert == 1
            final_points(j+1,:)=points(i,:);
        end
    end
    
    


end



