%Author: Manuel Kröter

function [ houghRaum ] = hough_lines( img )
%First try with Hough Transformation to detect lines!
%Simplest version, does not consider stuff like minimal line length oder
%connectivity

%input is an aleady thinned black white image
%output is the hough accumulator
%columns = degrees from 1 to 180 (Grad der Normalen der Gerade zur X-Achse)
%rows = distance to origin, distance 0 is in the middle (e.g. entries at row/2 are lines through the origin)
%origin of the input image is also considered in the center of the image.


    height = size(img,1);
    width = size(img,2);

    max_d = sqrt((height/2)^2 + (width/2)^2);
    %min_d = -max_d;
    houghRaum = zeros(ceil(2*max_d),180); %ceil ok?

    for x=1:width
        
        x_pos = x - round(width/2); %round ok?
       
        for y=1:size(img,1)
            
            if img(y,x)>0 

                y_pos = -(y - round(height/2)); %round ok?

                for alpha = 1:1:180
                    d = x_pos * cosd(alpha) + y_pos * sind(alpha);
                    d = d + max_d + 1; % +1
                    d = round(d); %round ok?
                    houghRaum(d,alpha) = houghRaum(d,alpha) + 1;
                end

            end

        end

    end
    
    %scale the values to 0-1 to show the result as an image
    m = max(houghRaum(:));
    scaledHough = double(houghRaum./m);
    imshow(scaledHough);
    

end



