%Author: H�ller Benjamin 0925688
%Version: 8.11.2012


function [ output_args ] = test( input_args )
%X Testfunction for simpleGrayThresh
%   runs the standart matlab graythresh function and the
%   simpleGrayThres funktion for each picture. 
close All;
cd ../
A=getPictures(1); %add apropriate pictures for testing
cd graythresh
for i = 1 : size( A, 1 )
  p=A(i,1);
    if ~isempty(p)
      I(1)=  graythresh(p{1});
    
     I(2)=  simpleGrayThresh(p{1});
    disp([A(i,2),I(1),I(2)]);
     
    end
    
end

end

