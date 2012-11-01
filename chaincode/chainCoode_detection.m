%Author: Manuel Kröter

function [ result_one, result_zero, result_plus] = chainCoode_detection( img )
%UNTITLED Summary of this function goes here

%  TODO


result_plus = [];
result_one = [];
result_zero = [];

[r,c] = find(img);
foreground = [r,c];

processed = [];

for i=1:size(foreground,1)

    if ismember(foreground(i,:),processed,'rows')==0

        %workaround, otherwise endless loop when getting to center pixel of
        %a plus sign
        if img(foreground(i,1)+1,foreground(i,2))==1 && img(foreground(i,1)-1,foreground(i,2))==1 ...
            && img(foreground(i,1),foreground(i,2)+1)==1 && img(foreground(i,1),foreground(i,2)-1)==1

            processed = cat(1,processed,foreground(i,:));
            
        else

            [chain, boundary] = getChainCode(img,foreground(i,:));

            processed = cat(1,processed,boundary);
            center = round(mean(boundary));

            chain(chain==4)=0;
            chain(chain==5)=1;
            chain(chain==6)=2;
            chain(chain==7)=3;

            vertical = sum(chain==0)/size(chain,2);
            diagonal_up = sum(chain==1)/size(chain,2);
            horizontal = sum(chain==2)/size(chain,2);
            diagonal_down = sum(chain==3)/size(chain,2);

            if vertical+diagonal_up >= 0.8 && vertical >= 0.6
                result_one= cat(1,result_one,center);
            elseif vertical >= 0.35 && (diagonal_up-diagonal_down) > -0.1 && (diagonal_up-diagonal_down) < 0.1 && horizontal<vertical
                result_zero = cat(1,result_zero,center);
            elseif (horizontal-vertical) > -0.1 && (horizontal-vertical) < 0.1 && (diagonal_down+diagonal_up)<0.2
                result_plus = cat(1,result_plus,center);
            end

        end
    end

    
end
    

end

