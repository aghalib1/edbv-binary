%Author: Höller Benjamin 0925688
%Version: 3.12.2012

function [ S ] = getString(zeros,ones,plus,minus,mult)
%getString


%
% Sorts the zeros, ones and plus signs according to their x possition
%
% Input:
% zeros         positions of detected zeros (n by 2 matrix, 1.column: x, 2.column: y)
% ones          positions of detected ones (n by 2 matrix, 1.column: x, 2.column: y)
% plus          positions of detected plus signs (n by 2 matrix, 1.column: x, 2.column: y)
% minus         positions of detected minus signs (n by 2 matrix, 1.column: x, 2.column: y)
% mult          positions of detected multiplication signs (n by 2 matrix, 1.column: x, 2.column: y)
% Output:
% S     A String representing the given Values in the correct Order



X=cell(2,size(zeros,1)+size(ones,1)+size(plus,1));
c=1;%counter

%%
%ZERO
for i = 1 : size( zeros, 1 )
    X{1,c}=zeros(i,1);
    X{2,c}='0';
    c=c+1;
end
%%
%ONE
for i = 1 : size( ones, 1 )
    X{1,c}=ones(i,1);
    X{2,c}='1';
    c=c+1;
end
%%
%PLUS = 2
for i = 1 : size( plus, 1 )
    X{1,c}=plus(i,1);
    X{2,c}='+';
    c=c+1;
end

%%
%MINUS = 3
for i = 1 : size( minus, 1 )
    X{1,c}=minus(i,1);
    X{2,c}='-';
    c=c+1;
end

%%
%MULT = 4
for i = 1 : size( mult, 1 )
    X{1,c}=mult(i,1);
    X{2,c}='x';
    c=c+1;
end


%%

%Sort by Xposition
X=sortrows(X',1);

%Convert to String
S=char(X(:,2))';









