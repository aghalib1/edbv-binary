% Gruppennummer AG_A_5
% Wiplinger Sascha (0702060)


%assumption: 1 means 'white', 0 means 'black'
%precondition: picture has at least 3 rows and 3 columns and is a
    %rectangular matrix.
%precondition: the only values contained are 1 (white) and 0 (black).
%precondition: the border is completely white (haven't checked for this 
    %'special case', but inserting a white border should not be a big 
    %problem, i guess)
%postcondition: the black areas will be thinned to curves which have the
    %width of 1 pixel.
%postcondition: the resulting curves are 8-joined.

function [thinnedPicture] = thin(BWPicture) %input: 2D-Matrix (values 1 or 0), return: matrix with thinned picture (also values 1 and 0)

thinnedPicture = (BWPicture-1)*-1; %invert pic, so 0 means background and 1 means foreground (easier for calculation of connected components)
picSize = size(thinnedPicture);


%for i=0:3
%starting in the upper left corner
thinnedPictureLeftToBottom=thinnedPicture;
row=1;
col=1;
%count=1;
while(row+2<=picSize(1) )
    while(col+2<=picSize(2))
       if  thinnedPictureLeftToBottom(row+1,col+1) == 1
           kernel = thinnedPictureLeftToBottom(row:row+2,col:col+2);
           thinnedPictureLeftToBottom(row+1,col+1)=1-deleteable(kernel);
           %debug-stuff
           %if count <= 1
            %   kernel
            %   [value, num1, num2, neighbour] = deleteable(kernel);
            %   if value==0
            %       num1
            %       num2
            %       neighbour
            %   end
            %   count = count+1;
           %end
       end
       col=col+1;
    end
    %count=1;
    col=1;
    row=row+1;
end

%starting in the upper right corner
thinnedPictureRightToBottom = thinnedPicture;
row=1;
col=picSize(2);
while(row+2<=picSize(1) )
    while(col>=3)
       if  thinnedPictureRightToBottom(row+1,col-1) == 1
           kernel = thinnedPictureRightToBottom(row:row+2,col-2:col);
           thinnedPictureRightToBottom(row+1,col-1)=1-deleteable(kernel);
       end
       col=col-1;
    end
    col=picSize(2);
    row=row+1;
end

%thinnedPictureLeftToUpper=thinnedPicture;
%row=picSize(1);
%col=1;
%while(row>=3 )
%    while(col+2<=picSize(2))
%       if  thinnedPictureLeftToUpper(row-1,col+1) == 1
%           kernel = thinnedPictureLeftToUpper(row-2:row,col:col+2);
%           thinnedPictureLeftToUpper(row-1,col+1)=1-deleteable(kernel);
%       end
%       col=col+1;
%    end
%    col=1;
%    row=row-1;
%end

%thinnedPictureRightToUpper = thinnedPicture;
%row=picSize(1);
%col=picSize(2);
%while(row>=3 )
%    while(col>=3)
%       if  thinnedPictureRightToUpper(row-1,col-1) == 1
%           kernel = thinnedPictureRightToUpper(row-2:row,col-2:col);
%           thinnedPictureRightToUpper(row-1,col-1)=1-deleteable(kernel);
%       end
%       col=col-1;
%    end
%    col=picSize(2);
%    row=row-1;
%end

thinnedPicture = (thinnedPictureLeftToBottom );%& thinnedPictureRightToBottom);% | (thinnedPictureRightToUpper & thinnedPictureRightToBottom);
thinnedPicture = (thinnedPicture-1).*-1; %returned to 1 for white and 0 for black
end

%checks if it is OK to delete the pixel.
%postcondition: returns 1 if it is OK, 0 if it is not OK.
function [value, num1, num2, neighbour] = deleteable(kernel)
    value=0;
    testKernel = kernel;
    testKernel(2,2)=0; %Kernel with center Pixel set to 0
    
    %the pixel can be deleted if it does not keep together a componant and
    %if it is not an end pixel.
    %a pixel is an end pixel if it has 0 or 1 neighbours.
    [L1, num1] = bwlabel(kernel, 4); 
    [L2, num2] = bwlabel(testKernel, 4); %have to write that myself yet
    
    neighbour=0;
    for x=1 : 9
        neighbour=neighbour+testKernel(x);
    end
    if num1 == num2 && neighbour>1
        value=1;
    end
end

%looks for 4-connected components in the kernel
function [] = CCL4 (kernel)
    


end