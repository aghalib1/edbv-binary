%Author: Höller Benjamin 0925688
%Version: 22.11.2012

function [ out ] = simpleGrayThresh( I )
%SIMPLEGRAYTHRESH returns the greythresh value
%   
%This method first makes a brightness Histogram(H) according to the human
%perception, and than returns the mean of the two highest peaks.

max=0;
sum=uint32(0);

H(256)=0;
 for x=1:size(I,1);
    for y=1:size(I,2);
     
     
      r=0.299*I(x,y,1);
      g=0.587*I(x,y,2);
      b=0.114*I(x,y,3);
      pixel=r+g+b+1;
      H(pixel)=H(pixel)+1;
      sum=sum+double(pixel);
        
      if pixel > max
          max=pixel;
      end
      
    end
 end
 
 %figure
 %plot(H);
 
 %%
 %Finding the two maximas
 %if impossible: 128
  try
    [pks,locs] = findpeaks(H,'sortstr','descend');

    out=((locs(1)+locs(2))/2)/256   ;
  catch ex
    out=0.5;
  end
        
end

