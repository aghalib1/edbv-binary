% Gruppennummer AG_A_5
% Höller Benjamin 0925688


function [ ] = analyze(picture,filename)
%ANALYZE Summary of this function goes here
%   Detailed explanation goes here
picture=picture{1};%da als cell übergeben
disp('Preprocessing');

% in Binärblid umwandeln
picture=im2bw(picture) %ACHTUNG! NICHT ERLAUBTE METHODE im2bw
picture=imcomplement(picture); %ACHTUNG! NICHT ERLAUBTE METHODE imcomplement
% thinning

disp('HoughTransformation');
path('hough',path);
figure();
zeros=hough_circles(picture,4.8,8)
ones=hough_lines(picture,-5,5)
plus=hough_plus(picture, 5, 1)


disp('Calculating');
%zeros ones und plus auswerten
%marker setzen



 
end

