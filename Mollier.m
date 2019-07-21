function [P,T,V] = Mollier(H,S)

% H - enthalpy value
% S - entropy value

% P - Pressure
% T - Temperature
% V - Specific Volume
load('SuperWaterTable.mat')

[m,~] = size(SuperWaterTable);

Press = SuperWaterTable.P(1:m);
Pval = SuperWaterTable.P(1:m);
Pval(isnan(Pval)) = [];

[b,~] = size(Pval);

%% Part 1 - Get Entropy Data

for x = 1:b
    
    Pidx = find(Press == Pval(x));
    
    Ridx = SuperWaterTable.N(Pidx);
    Ptable = SuperWaterTable{Pidx:(Pidx+Ridx-1),{'P','T','V','H','S'}};
    
    [n,~] = size(Ptable);
    
    Y = Ptable(:,5);
    Sidx = find(Y == S);

    if (S > Y(n))
        Tval(x) = NaN;
        Vval(x) = NaN;
        Hval(x) = NaN;
    else 
        if (S < Y(1))
            Tval(x) = NaN;
            Vval(x) = NaN;
            Hval(x) = NaN;
        else
            if (isempty(Sidx) == false)
                Tval(x) = Ptable(Sidx,2);
                Vval(x) = Ptable(Sidx,3);
                Hval(x) = Ptable(Sidx,4);
            else
                if (isempty(Sidx) == true)
                    Ysort = sort(abs(S-Y));   

                    if (Ysort(1) == Ysort(2))
                        I = find(abs(S-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(S-Y) == Ysort(1));
                        idx2 = find(abs(S-Y) == Ysort(2));
                    end

                    Vals = Row_Interp(S, Y(idx1), Y(idx2), Ptable(idx1,:), Ptable(idx2,:));
                    Tval(x) = Vals(2);
                    Vval(x) = Vals(3);
                    Hval(x) = Vals(4);
                else
                    error('Error in Mollier while finding Entropy. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
     end
end

%% Part 2 - Find Enthalpy Value

Hidx = find(Hval == H);

if (H > Hval(b))
    error(strcat('Well fuck, H is greater than',32,num2str(Hval(n))))    
else 
    if (H < Hval(1))
        error(strcat('Well fuck, H is less than',32,num2str(Hval(1))))
    else
        if (isempty(Hidx) == false)
            T = Tval(Hidx);
            V = Vval(Hidx);
            P = Pval(Hidx);
        else
            if (isempty(Hidx) == true)
                Hsort = sort(abs(H-Hval));   

                if (Hsort(1) == Hsort(2))
                    I = find(abs(H-Hval) == Hsort(1));
                    idx1 = I(1);
                    idx2 = I(2);
                else
                    idx1 = find(abs(H-Hval) == Hsort(1));
                    idx2 = find(abs(H-Hval) == Hsort(2));
                end

                T = Row_Interp(H, Hval(idx1), Hval(idx2), Tval(idx1), Tval(idx2));
                V = Row_Interp(H, Hval(idx1), Hval(idx2), Vval(idx1), Vval(idx2));
                P = Row_Interp(H, Hval(idx1), Hval(idx2), Pval(idx1), Pval(idx2));
            else
                error('Error in Mollier while finding Enthalpy. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
            end
        end
    end
end

end
