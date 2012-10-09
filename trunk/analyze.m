% Gruppennummer AG_A_5
% Höller Benjamin 0925688


function [ ] = analyze(picture,filename)
%ANALYZE Summary of this function goes here
%   Detailed explanation goes here
picture=picture{1};%da als cell übergeben
disp('Analyzing ...');

%zurzeit große testbilder etwas verkleinern
picture = imresize(picture,.5,'bicubic');

 subplot(1,2,1);imshow(picture); title(filename{1})
 
 %in ein binärbild umwandeln
 threshold=graythresh ( picture );
 blackwhite = im2bw( picture , threshold );
 subplot(1,2,2);imshow(blackwhite); title('threshold'+threshold)
 figure;
        
 
        %zur darstellung wie man Filter anwendet:
        %Wende den Sobel Filter auf das Original und das 16x16 Bild an
        SobX = [ -1 0 1; -2 0 2; -1 0 1 ]; % Filterkerne 
        SobY = [ 1 2 1; 0 0 0; -1 -2 -1]; % * 1/4 weil das Bild sonst zu intensiv werden würde

        % Kantenbild des kleinen Walters
        GxP = imfilter(blackwhite, SobX); % Vertikale Kanten
        GyP = imfilter(blackwhite, SobY); % Horizontale Kanten
        GxyP = abs(GxP) + abs(GyP); % die Kombination aus beiden
        subplot(2,2,1); imshow(GxP); title('Vertikale Kanten');
        subplot(2,2,2); imshow(GyP); title('Horizontale Kanten');
        subplot(2,2,3); imshow(GxyP); title('Kombination der beiden');
        figure;

        
 
end

