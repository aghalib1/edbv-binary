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


ergebnis = 'haha';
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


%S interprätieren
%Author: Christoph Meinhardt

zahl1 = S(1 : strfind(S,'+') - 1);
zahl2 = S(strfind(S,'+') +1 :length(S));

disp(['Zahl 1: ',zahl1]);
disp(['Zahl 2: ',zahl2]);

%Converting the binary number into a hexadezimal number

%zahl1
dec = 0;
for i = 1 : length(zahl1)
    dec = dec + str2num(zahl1(i)) * 2^(length(zahl1) - i);
end
disp('Zahl 1 als Dezimalzahl:');
disp(dec);

%zahl2

dec2 = 0;
for i = 1 : length(zahl2)
    dec2 = dec2 + str2num(zahl2(i)) * 2^(length(zahl2) - i);
end
disp('Zahl 2 als Dezimalzahl:');
disp(dec2);

%Addieren der 2 Zahlen

dezResult = dec + dec2;
disp('Ergebnis als Dezimalzahl:');
disp(dezResult);

%Addieren der Binärzahlen:

binResult = dec2bin(dezResult);
disp(binResult);
 
end

