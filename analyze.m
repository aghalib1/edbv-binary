% Gruppennummer AG_A_5

% Authors
% Höller Benjamin 0925688
% Manuel Kröter 0820478

% Version: 6.11.2012



function [ ] = analyze(picture,filename,chain)
%ANALYZE Summary of this function goes here 
%   Detailed explanation goes here
%
%   TODO Beschreibung der Funktion + Code kommentieren
%

disp(['Analyzing ',filename])


img=picture{1};%da als cell übergeben
img_thin = im2bw(img,graythresh(img));        %TODO
img_thin = bwmorph(1-img_thin,'thin','inf');  %TODO



if chain 
    cd chaincode
    [ones, zeros, plus] = chainCode_detection(img_thin);
    cd ..    
else
   
    %TODO 
    %Gute Werte für Hough Transformation finden
    
   cd hough
   subplot(4,1,1);
   zeros = hough_circles(img_thin,4.8,8);
   subplot(4,1,2);
   %ones = hough_circles(img_thin,0,8);
   ones = hough_lines(img_thin,-5,5);
   subplot(4,1,3);
   plus = hough_plus(img_thin,5,10);
   cd ..
   subplot(4,1,4);
   
    if size(ones,1)>0  
        if size(zeros,1)>0
            ones(:,2) = zeros(1,2); 
        elseif size(plus,1)>0
            ones(:,2) = plus(1,2);    
        end 
    end

end



%SETTING MARKERS
image(img);
hold on;

if size(zeros,1)>0
	line(zeros(:,1),zeros(:,2),'Marker','o','Linestyle','none','markersize',8,'color','b');
end
if size(plus,1)>0
    line(plus(:,1),plus(:,2),'Marker','+','Linestyle','none','markersize',8,'color','g');
end
if size(ones,1)>0
    line(ones(:,1),ones(:,2),'Marker','*','Linestyle','none','markersize',8,'color','r');
end

hold off;



%Converting Array to String
S = getString(zeros,ones,plus);
disp(['string: ',S]);

%TODO
%S interprätieren



 
end

