% Gruppennummer AG_A_5
% Meinhardt Christoph (0925318)
% Kröter Manuel (0820478)
% Wiplinger Sascha (0702060)
% Schiffner Philipp (0925766)
% Höller Benjamin (0925688)


close all;
clc;

disp('Bilder einlesen')
A=getPictures;
A
%jedes Bild analysieren
for i = 1 : size( A, 1 )
    if ~isempty(A(i,1))
    analyze(A(i,1),A(i,2)); 
    end
end
