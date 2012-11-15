% Gruppennummer AG_A_5
% Meinhardt Christoph (0925318)
% Kröter Manuel (0820478)
% Wiplinger Sascha (0702060)
% Schiffner Philipp (0925766)
% Höller Benjamin (0925688)


% Authors
% Höller Benjamin 0925688
% Manuel Kröter 0820478

%Version: 8.11.2012

close all;
clc;

A=getPictures;

%use chain code (= 1) or hough detection (= 0) ?
chain = 1;


%analyze every picture
for i = 1 : size( A, 1 )
  
    if ~isempty(A(i,1))
    figure;
    analyze(A(i,1),A(i,2),chain); 
    end
    
end
