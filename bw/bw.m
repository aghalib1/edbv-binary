%Gruppennummer: AG_A_5
%
%Author: Philipp Schiffner (0925766) e0925766@student.tuwien.ac.at
%Version: 16.12.2012


function [ bwimg ] = bw (img, thresh, bg)
%Function: bw
%
%converts the input image to a binary image
%
%Input:		img: 	intensity picture
%		thresh: greythresh between 0 and 1 (output value of function simpleGrayThresh)
%		bg: 	brightness value of the background (output value of function simpleGrayThresh)
%
%Output: 	bwing:  binary image (white==foreground; black==background)


    bwimg = ones(size(img,1),size(img,2));
    for y = 1:size(img,2)
        for x = 1:size(img,1)
            r=0.299*img(x,y,1);
            g=0.587*img(x,y,2);
            b=0.114*img(x,y,3);
	    
	    %compare color intensity with threshold
            if( r+b+g <= (thresh*255))
                bwimg(x,y)=0;
            end
        end
    end
    if median(single(bwimg(:)))==1
        bwimg = 1-bwimg;
    end
end