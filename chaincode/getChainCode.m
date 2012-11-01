%%Author: Manuel Kröter

function [ code, boundary_pixels ] = getChainCode( img, start )

directions = [ 1, 0
               1,-1
               0,-1
              -1,-1
              -1, 0
              -1, 1
               0, 1
               1, 1];
                     
start = start-1;

[size_y size_x] = size(img);
%start = [floor(indx/size_y),0];
%start(2) = indx-(start(1)*sz(2));

code = [];       % The chain code
coord = start; % Coordinates of the current pixel
boundary_pixels = coord+1;
dir = 1;       % The starting direction
while 1
   newcoord = coord + directions(dir+1,:);
   if all(newcoord>=0) && newcoord(1)<size_y && newcoord(2)<size_x ...
         && img(newcoord(1)+1,newcoord(2)+1)
      code = [code,dir];
      coord = newcoord;
      boundary_pixels = [boundary_pixels;coord+1];
      dir = mod(dir+2,8);

   else
      dir = mod(dir-1,8);
   end
   if all(coord==start) && dir==1 % back to starting situation
      break;
   end
end



end