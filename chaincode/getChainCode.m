%Author: Manuel Kröter
%Version: 6.11.2012

function [ code, boundary_pixels ] = getChainCode( img, start )
%getChainCode
%
% Returns the boundary and corresponding chain code of an object
% Boundary is always closed (for example a one pixel thick horizontal line 
% will have the chain code represented as [0 0 0 0 ... 4 4 4 4 ...], also
% the boundary list will contain each pixel of the line twice)
%
% Input:
% img       Binary image, white = foreground
% start     coordinate of start pixel, has to be on the object boundary! 
%           start = [y_coord x_coord]
%
% Output:
% code              The chain code, a one dimensional array
%                   Generated with following encoding for the directions:
%                       3 2 1
%                       4 x 0
%                       5 6 7
%
% boundary_pixels   positions of all the pixels on the object boundary
%                   (n by 2 matrix, 1.column: x, 2.column: y) 



directions = [ 0, 1
              -1, 1
              -1, 0
              -1,-1
               0,-1
               1,-1
               1, 0
               1, 1];           
              
%get image width and height
[height width] = size(img);

code = [];       % The chain code
coord = start;   % Coordinates of the current pixel
boundary_pixels = [start(2) start(1)];
dir = 1;       % start direction: diagonal up

while 1
    
   %check neighbour pixel in current direction
   newcoord = coord + directions(dir+1,:);
   
   %if coords of neighbour pixel inside image + pixel is on foreground
   if all(newcoord>0) && newcoord(1)<=height && newcoord(2)<=width ...
         && img(newcoord(1),newcoord(2))
     
      %go to this neigbour pixel (set as current) and 
      %add direction to chain code
      coord = newcoord;
      code = [code,dir];
    

      %add pixel coordinate to boundary list
      boundary_pixels = cat(1,boundary_pixels,[coord(2), coord(1)]);
      
      %turn 90 degree left
      dir = mod(dir+2,8);

   else
       
      %if neighbour pixel outside image or not on foreground
      %turn 45 degree right
      dir = mod(dir-1,8);
      
   end
   
   %finished, if at starting position again
   if all(coord==start) && dir==1
      break;
   end
   
   
end



end