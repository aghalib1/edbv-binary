% Gruppennummer AG_A_5
% Meinhardt Christoph (0925318)
% Kr�ter Manuel (0820478)
% Wiplinger Sascha (0702060)
% Schiffner Philipp (0925766)
% H�ller Benjamin (0925688)



% Authors
% H�ller Benjamin 0925688
% Manuel Kr�ter 0820478

close all;
clc;

disp('Bilder einlesen')
A=getPictures;
%jedes Bild analysieren

%use chain code (= 1) or hough detection (= 0) ?
chain = 0;

for i = 1 : size( A, 1 )
  
    if ~isempty(A(i,1))
    figure;
    analyze(A(i,1),A(i,2),chain); 
    end
    
end
