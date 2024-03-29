%Author: Manuel Kr�ter
%Version: 14.12.2012

function [ result_one, result_zero, result_plus, result_minus, result_mult] = chainCode_detection( img )
%chainCode_detection
%
% Detects zeros, ones and operators (+,-,x) in an image
% Returns the center positions of the detected ones, zeros and operator signs
% Independent of digit size!
%
% Input:
% img      Binary image (should be already thinned), white = foreground
%          Lnies of Digits have to be horizontally, e.g. not rotated 
%
% Output:
% result_one	positions of detected ones (n by 2 matrix, 1.column: x, 2.column: y)
% result_zero   positions of detected zeros (n by 2 matrix, 1.column: x, 2.column: y)
% result_plus   positions of detected plus signs (n by 2 matrix, 1.column: x, 2.column: y)
% result_minus  positions of detected minus signs (n by 2 matrix, 1.column: x, 2.column: y)
% result_mult   positions of detected multiplication signs (n by 2 matrix, 1.column: x, 2.column: y)


%init arrays
result_plus = [];
result_one = [];
result_zero = [];
result_mult = [];
result_minus = [];
processed = [];

%find all the foreground pixels
[r,c] = find(img);
foreground = [c,r];

%imshow(img)

%go through all foreground points
for i=1:size(foreground,1)
    

    %if they are not already processed
    if ismember(foreground(i,:),processed,'rows')==0

        %this check is necessary to prevent endless loops (can happen when a foreground point is not on an object boundary)
        %   (when a neighbour point was already processed, dont process the current point
        if ismember([foreground(i,1)+1,foreground(i,2)],processed,'rows')==1 || ismember([foreground(i,1)-1,foreground(i,2)],processed,'rows')==1 ...
            || ismember([foreground(i,1),foreground(i,2)+1],processed,'rows')==1 || ismember([foreground(i,1),foreground(i,2)-1],processed,'rows')==1 ...
            || ismember([foreground(i,1)+1,foreground(i,2)-1],processed,'rows')==1 || ismember([foreground(i,1)-1,foreground(i,2)+1],processed,'rows')==1 ...
            || ismember([foreground(i,1)+1,foreground(i,2)+1],processed,'rows')==1 || ismember([foreground(i,1)-1,foreground(i,2)-1],processed,'rows')==1
        
            processed = cat(1,processed,foreground(i,:));

        else
            
            %get chain code + boundary of current object
            [chain, boundary] = getChainCode(img,[foreground(i,2),foreground(i,1)]);
            
            %mark all the pixels on the current boundary as processed
            processed = cat(1,processed,boundary);
            
            %get the center pixel of the current object
            center = round(mean(boundary));

            %use the chain code to classify the found object as one, zero, plus sign or ignore it
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            chain(chain==4)=0;
            chain(chain==5)=1;
            chain(chain==6)=2;
            chain(chain==7)=3;

            if size(chain,2)>=5
                horizontal = sum(chain==0)/size(chain,2);
                diagonal_up = sum(chain==1)/size(chain,2);
                vertical = sum(chain==2)/size(chain,2);
                diagonal_down = sum(chain==3)/size(chain,2);
                
                %[horizontal vertical diagonal_up diagonal_down]
                
                %TODO FIND PERFECT VALUES FOR DETECTION !!

                %detect 1
                if diagonal_up > 1.2*diagonal_down && horizontal*1.1<vertical
                    result_one= cat(1,result_one,center);
                %detect 0
                elseif horizontal<0.28 && vertical >= 0.4 && abs(diagonal_up-diagonal_down) < 0.05 && horizontal*1.5<vertical && (diagonal_up+diagonal_down)>0.15
                    result_zero = cat(1,result_zero,center);
                %detect +
                elseif abs(horizontal-vertical) < 0.2 && (diagonal_down+diagonal_up)<0.29 && abs(diagonal_up-diagonal_down) < 0.05
                    result_plus = cat(1,result_plus,center);
                %detect -
                elseif horizontal > 0.7
                    result_minus = cat(1,result_minus,center);
                %detect x
                elseif (diagonal_down+diagonal_up) > 0.47 && abs(diagonal_down-diagonal_up) < 0.05
                    result_mult = cat(1,result_mult,center);             
                    
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
    end

    
end
    

end

