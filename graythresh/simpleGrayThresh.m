function [ out ] = simpleGrayThresh( I )
%SIMPLEGRAYTHRESH Summary of this function goes here
%   Detailed explanation goes here

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
 figure
 plot(H);
 
 %%
 %Finding the two maximas
 index1=0;
 index2=-100;
 max1=0;
 max2=0;
 
 for i=1:size(H,2)
    if H(i)>max1 
        if(i>index2+100)
        index2=index1;
        max2=max1;
        end
        index1=i;
        max1=H(i);
    end
    
 end
 
 index1
 index2
 out=(index1+index2/2)/256
 
 %out=double(sum)/double((size(I,1)*size(I,2)*255));
 
     
        
end

