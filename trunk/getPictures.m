% Gruppennummer AG_A_5
% Höller Benjamin 0925688


function [ A ] =getPictures()
   
    disp('Bilder werden eingelesen ...')
    D = dir('pictures'); %erzeugt eine Liste aller Datein des Ordners
    j = 1 ;    %Zähler für die Bilder
    D
    A = cell(size(D,2),2); 
    %in diesem Cell Array die Bilddaten Gespeichert:
    % 1 Bild | 2 Dateiname des Bildes
    
    %Diese Schleife speichert alle in pictures befindlichen bilder in A
    for i = 1 : size( D, 1 )
       if D( i ).isdir == 0 %hier bildeinschränkungen möglich
            A{j,1} = imread (strcat('pictures/',D( i ).name)) ;
            A{j,2} = [D( i ).name ];
            j = j +1;
        end
        
    end

end

