function [  ] = StringInterpret(S)

%Author: Christoph Meinhardt
%String S interpretieren

%�berpr�fen ob ein '+' oder '-' oder 'x' am Anfang oder am Ende steht
if (S(1)) ~= '+' || '-' || 'x'
    if (S(length(S))) ~= '+' || '-' || 'x'
        
        %%
        %�berpr�fen ob nur 1 Operator vorhanden ist
        numberOfOperators = length(find(S=='+')) + length(find(S=='-')) + length(find(S=='x'));
        %disp(numberOfOperators);
        if (numberOfOperators) == 1
            
            %Wenn ein '+' gefunden wurde
            if (length(find(S=='+'))) == 1
            operator = '+';
            zahl1 = S(1 : strfind(S,'+') - 1);
            zahl2 = S(strfind(S,'+') +1 :length(S));
            end
            
            %Wenn ein '-' gefunden wurde
            if (length(find(S=='-'))) == 1
            operator = '-';
            zahl1 = S(1 : strfind(S,'-') - 1);
            zahl2 = S(strfind(S,'-') +1 :length(S));
            end
            
            %Wenn ein 'x' gefunden wurde
            if (length(find(S=='x'))) == 1
            operator = 'x';
            zahl1 = S(1 : strfind(S,'x') - 1);
            zahl2 = S(strfind(S,'x') +1 :length(S));
            end
            
            %disp(['Zahl 1: ',zahl1]);
            %disp(['Zahl 2: ',zahl2]);
            
            %%
            %Umwandeln der Bin�rzahl in eine Dezimalzahl
            
            %zahl1
            dec1 = 0;
            for i = 1 : length(zahl1)
                dec1 = dec1 + str2num(zahl1(i)) * 2^(length(zahl1) - i);
            end
            
            %zahl2
            dec2 = 0;
            for i = 1 : length(zahl2)
                dec2 = dec2 + str2num(zahl2(i)) * 2^(length(zahl2) - i);
            end
            
            %%
            %Berechnen vom Ergebnis
            negative = false;
            
            if (operator) == '+'
                dezResult = dec1 + dec2;
            end
            
            if (operator) == '-'
                dezResult = dec1 - dec2;
                if (dezResult) < 0
                    negative = true;
                    dezResult = dezResult * (-1);
                else
                    negative = false;
                end
            end
            
            if (operator) == 'x'
                dezResult = dec1 * dec2;
            end
            
            binResult = dec2bin(dezResult);
            
            %%
            %Ausgabe vom Ergebnis:
            
            
            if (negative) == false
                dezAusgab = strcat('Decimal: ',num2str(dec1),operator,num2str(dec2),'=',num2str(dezResult));
                binaryAusgabe = strcat('Binary: ',zahl1,operator,zahl2,'=',num2str(binResult));
            else
                dezAusgab = strcat('Decimal: ',num2str(dec1),operator,num2str(dec2),'= -',num2str(dezResult));
                binaryAusgabe = strcat('Binary: ',zahl1,operator,zahl2,'= -',num2str(binResult));
            end
                
                
            disp(dezAusgab);
            disp(binaryAusgabe);
            
        end
        %Wenn mehr als 1 Operator vorkommt
        if  (numberOfOperators) > 1
            disp('Error: Too many Operators found');
        end
        %Wenn kein Operator vorkommt
        if (numberOfOperators) == 0
            disp(['Binary: ',S])
            dec0 = 0;
            for i = 1 : length(S)
                dec0 = dec0 + str2num(S(i)) * 2^(length(S) - i);
            end
            disp(['Decimal: ', num2str(dec0)]);
        end
    end
    %Wenn am Ende ein Operator steht
    if strfind(S,'+') == length(S)
        disp('Error: Plus at the End of the String');
    end
    
    if strfind(S,'-') == length(S)
        disp('Error: Minus at the End of the String');
    end
    
    if strfind(S,'x') == length(S)
        disp('Error: Multiple at the End of the String');
    end
end
%%
%Wenn am Anfang ein Operator steht
if strfind(S,'+') == 1
    disp('Error: Plus at the Beginning of the String');
end

if strfind(S,'-') == 1
    disp('Error: Minus at the Beginning of the String');
end

if strfind(S,'x') == 1
    disp('Error: Multiple at the Beginning of the String');
end
end
