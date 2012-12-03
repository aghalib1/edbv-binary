% Gruppennummer AG_A_5

% Authors
% Höller Benjamin 0925688
% Manuel Kröter 0820478

% Version: 3.12.2012



function [ ] = analyze(picture,filename,chain)
%ANALYZE Main function for binary calculator
%   Detects binary numbers and an operator and computes the result
%   
%   Input:
%   picture     Picture containing the binary numbers (see report for
%               detailed description of the picture)
%   filename    filename of the picture, not really necessary
%   chain       Use chain code detection or hough detecion
%               chain = 1 -> chain code
%               chain = 0 -> hough transform
%
%   Output:
%   - Diplays the detected operator and numbers in binary/decimal form
%     and the result of the computation in the console
%   - Shows the input picure with marked positions of the detected letters 

    %INFO:
    %At first, it was planned to do everything with hough detection. But
    %then the Hough Transform was replaced by Chain Code Detection. 
    %At this stage, the Hough Detecion was already implemented.
    %We did not remove it from the code. You can choose between Hough and
    %Chain Code using the input parameter 'chain' (chain = 0 -> Use Hough)
    %But Hough Detection only works for a fixed font style and size (see report). 
    %In addition to that, the only operator supported is the plus sign.

disp(' ');  
disp(['Analyzing: ',filename{1}]);

img=picture{1};%da als cell übergeben

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd graythresh
[value, background]=simpleGrayThresh(img);
img_thin = im2bw(img,value);        %TODO:im2bw, foreground detection

if median(single(img_thin(:)))==1 
    img_thin = 1-img_thin;  
end
cd ..



cd thin
img_thin = thin(img_thin,0);
cd ..
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if chain
    %%
    cd chaincode
    [ones, zeros, plus, minus, mult] = chainCode_detection(img_thin);
    cd ..
else
    %%
    %TODO
    %Gute Werte für Hough Transformation finden
    
    cd hough
    subplot(4,1,1);
    zeros = hough_circles(img_thin,4.8,8);
    subplot(4,1,2);
    %ones = hough_circles(img_thin,0,8);
    ones = hough_lines(img_thin,-5,5);
    subplot(4,1,3);
    plus = hough_plus(img_thin,5,15);
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

%%
%SETTING MARKER

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
if size(minus,1)>0
    line(minus(:,1),minus(:,2),'Marker','^','Linestyle','none','markersize',8,'color','c');
end
if size(mult,1)>0
    line(mult(:,1),mult(:,2),'Marker','x','Linestyle','none','markersize',8,'color','m');
end

hold off;


%%
%Converting Array to String

S = getString(zeros,ones,plus,minus,mult);
%disp(['string: ',S]);
if size(S)==0
    disp('No string found');
else
StringInterpret(S);
end
end