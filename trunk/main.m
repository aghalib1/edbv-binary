% Gruppennummer AG_A_5
% Meinhardt Christoph (0925318)
% Kröter Manuel (0820478)
% Wiplinger Sascha (0702060)
% Schiffner Philipp (0925766)
% Höller Benjamin (0925688)


% Authors
% Höller Benjamin 0925688
% Manuel Kröter 0820478

%Version: 3.12.2012

close all;
clc;

%if testmode is active, the folder testPictures will be read
%else the normal pictures Folder
test=0;
A=getPictures(test);

%use chain code (= 1) or hough detection (= 0) ?
chain = 1;

%use Medianfilter (=1) or not (=0)
med = 0;


%analyze every picture
for i = 1 : size( A, 1 )
  
    if ~isempty(A(i,1))
    figure;
    analyze(A(i,1),A(i,2),med,chain); 
    end
    
end
