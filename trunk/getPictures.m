%Author: Höller Benjamin 0925688
%Version: 3.12.2012


function [ A ] =getPictures(test)
%getPictures
%
%this funktion trys to read all files of the directory "pictures" as
%images. If possible, the picture gets Saved in A
%
% Output:
% A cellarray[picturedata, filename]

   disp('Importing pictures:')
   if test
  
        directory='testPictures';
        disp('Test Mode is active!:')
       
   else
        directory='pictures';
   end
   
   D=dir(directory);
    j = 1 ;    %counter
  
    A = cell(0,2); 
   
   for i = 1 : size( D, 1 )
       if D( i ).isdir == 0 
           try
            A{j,1} = imread (strcat([directory '/'],D( i ).name)) ;
            A{j,2} = [D( i ).name ];
            disp([num2str(j),':  ',A{j,2}]);
            j = j +1;
           catch exception
              disp(['Error at file ',D( i ).name]);
              disp('Maybe this file doesn´t contain imagedata!?');
           end
        end
        
    end

    disp([num2str(size(A,1)),' Pictures where imported.']);
  
end

