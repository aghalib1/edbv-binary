%Author: Manuel Kröter

function [ result_one, result_zero, result_plus] = chainCode( img )
%UNTITLED Summary of this function goes here
%  TODO

% Lookup table for directions of chain code
code = [3,2,1;4,nan,0;5,6,7]; 

% intervalls for chain code mean values
zero_intervall = [3.68 3.9]; %TODO find values
one_intervall = [3.55, 4.1]; %TODO find values
plus_intervall = [3.0, 3.2]; %TODO find values

result_plus = [];
result_one = [];
result_zero = [];

[r,c] = find(img);
foreground = [r,c];

processed = [];

for i=1:size(foreground,1);
    if ismember(foreground(i,:),processed,'rows')==0

        %trace boundary
        
        %TODO implement boundary function
        boundary = bwtraceboundary(img,foreground(i,:),'NW',8,inf,'counterclockwise'); 
        
        processed = cat(1,processed,boundary);
        center = round(mean(processed));
        
        %convert to chain code
        boundary = diff(boundary)+2;
        idx = sub2ind(size(code),boundary(:,1),boundary(:,2));
        chain = code(idx); 
        
        %TODO maybe change chain values to make difference between classes bigger
        %TODO find perfect values plus corresponding intervall borders
        
        mean_chain = mean(chain);
        
        if mean_chain >= zero_intervall(1) && mean_chain < zero_intervall(2)
            result_zero= cat(1,result_zero,center);
        elseif mean_chain >= one_intervall(1) && mean_chain < one_intervall(2)
            result_one = cat(1,result_one,center);
        elseif mean_chain >= plus_intervall(1) && mean_chain < plus_intervall(2)
            result_plus = cat(1,result_plus,center);
        else
            
            %TODO what should be done when no class can be found for chain
            %code?
                        
        end
        
    end
end
    

end

