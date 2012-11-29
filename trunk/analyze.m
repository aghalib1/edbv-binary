% Gruppennummer AG_A_5

% Authors
% Höller Benjamin 0925688
% Manuel Kröter 0820478

% Version: 29.11.2012



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

    
disp(['Analyzing ',filename]);

img=picture{1};%da als cell übergeben

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd graythresh
img_thin = im2bw(img,simpleGrayThresh(img));        %TODO:im2bw, foreground detection
img_thin = 1-img_thin;  %temporary, foreground has to be white!
cd ..

cd thin
%img_thin = thin(img_thin); %still not working correctly, therefore commented.
img_thin = bwmorph(img_thin,'thin','inf');  %TODO
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
if size(minus,1)>0
    line(minus(:,1),minus(:,2),'Marker','-','Linestyle','none','markersize',8,'color','c');
end
if size(mult,1)>0
    line(mult(:,1),mult(:,2),'Marker','x','Linestyle','none','markersize',8,'color','m');
end

hold off;


%%
%Converting Array to String

S = getString(zeros,ones,plus,minus,mult);
disp(['string: ',S]);
if size(S)==0
    disp('No string found');
else
%%
%S interpretieren
%Author: Christoph Meinhardt


%anmerkung höller benjamin 15.11.
%bitte ausgaben auf englisch und etwas ansprechender formatieren
%wie wärs mit:
%
%binär:    100101+1110101=10011010
%dezimal:  37+117=154
%
%
%kein + ist übrigens kein fehler!

%Überprüfen ob ein '+' am Anfang oder am Ende steht
if (S(1)) ~= '+'
    if (S(length(S))) ~= '+'
        %Überprüfen ob nur 1 '+' vorhanden ist
        numberOfPlus = length(find(S=='+'));
        %disp('Anzahl der Plus:');
        %disp(numberOfPlus);
        if (numberOfPlus) == 1
            
            zahl1 = S(1 : strfind(S,'+') - 1);
            zahl2 = S(strfind(S,'+') +1 :length(S));
            
            disp(['Zahl 1: ',zahl1]);
            disp(['Zahl 2: ',zahl2]);
            
            %Umwandeln der Binärzahl in eine Dezimalzahl
            
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
            disp('Ergebnis als Binärzahl:');
            disp(binResult);
        end
        %Wenn mehr als 1 Plus vorkommt
        if  (numberOfPlus) > 1
            disp('Fehler: Zu viele Plus');
        end
        %Wenn kein '+' vorkommt
        if (numberOfPlus) == 0
            disp('Fehler: Kein Plus vorhanden');
            disp(['Die Zahl als Binärzahl:',S])
            dec0 = 0;
            for i = 1 : length(S)
                dec0 = dec0 + str2num(S(i)) * 2^(length(S) - i);
            end
            disp('Die Zahl als Dezimalzahl:');
            disp(dec0);
        end
    end
    %Wenn am Ende ein '+' steht
    if strfind(S,'+') == length(S)
        disp('Fehler: Am Ende steht ein Plus');
    end
end
%Wenn am Anfang ein '+' steht
if strfind(S,'+') == 1
    disp('Fehler: Am Anfang steht ein Plus');
end

end
end