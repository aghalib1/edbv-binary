%Manuel Kröter 0820478
%Sascha Wiplinger 0702060
%
%Version: 3.12.2012
%Function thin
%
%Skeletizes a black-white-image.
%Input: img     a black and white image; white == foreground, black == background
%       prune   how much should the result be pruned? 'prune' has to be an
%               integer >=0.
%               0 = no pruning
%
%Output: the thinned black and white picture.

function [ thinned ] = thin( img, prune )

thinned = img;

%Kernels for Thinning
S1 = [-1,-1,-1;
       0,1,0;
       1,1,1];
S2 = [-1,-1,0;
      -1,1,1;
       0,1,1]; 

%Kernels for Pruning - actually not needed anymore, because results did get worse with pruning.
P1 =  [-1,-1,-1;
       -1, 1,-1;
       -1, 0, 0];
   
P2 =  [-1,-1,-1;
       -1, 1,-1;
        0, 0,-1];  
   

%While loop control
cc = 0; 
changed = 1;
while changed && cc < 20;
    
    changed = 0;
    cc = cc + 1;

    for i=1:4 %look for hits with kernel 1 at 0, 90, 180 and 270 degrees rotated.
        markMatrix = bwmatch(thinned,S1);
        if sum(markMatrix(:)) > 0
            changed = 1;
        end
        thinned(markMatrix > 0) = 0;
        S1 = rot90(S1);
    end
    
    
    for i=1:4 %same here with kernel 2
        markMatrix = bwmatch(thinned,S2);
        if sum(markMatrix(:)) > 0
            changed = 1;
        end
        thinned(markMatrix > 0) = 0;
        S2 = rot90(S2);
    end

end


%Pruning - works similar to normal thinning, but the loop goes from 1 to
%prune (parameter)

for i=1:prune

    
   for j=1:4
     markMatrix = bwmatch(thinned,P1);
     thinned(markMatrix > 0) = 0;
     P1 = rot90(P1);
       
   end
   
   for j=1:4
     markMatrix = bwmatch(thinned,P2);
     thinned(markMatrix > 0) = 0;
     P2 = rot90(P2);
       
   end
   
  
end


end

% Function bwmatch
%
% returns a matrix containing 1 for pixels that can be removed and 0 for
% those which have to be kept.
%
% Input:
% bw1: black-white-image
% kernel: the kernel for matching.
%   1: there has to be a 1.
%  -1: there has to be a 0.
%   0: don't care.
%
% Output:
% the matrix marking the deletable pixels with 1.

function [bw2] = bwmatch(bw1, kernel)

bw2 = false(size(bw1)); %matrix mit groesze von bw1, aber mit 0 gefuellt.
s = size(bw1);
for j= 1:s(2)
    for i = 1:s(1)
        if(bw1(i,j)==1) %run-time-optimization
            sub = bw1( max(1,i-1):min(i+1,s(1)), max(1,j-1):min(j+1,s(2)) ); %sub-matrix of the picture being tested
            
            %comparision of the subset with the kernel. only if the pixel is
            %not on the border.
            if(size(sub)==size(kernel))
                if (sub(kernel==-1) == 0) %2 ifs, because && only works for singular true/false
                    if (sub(kernel==1)==1)
                        bw2(i,j)=1;
                    end
                end
            end
        end
    end
end

end