function [T, V, U, H, S] = Super_Water_Table(label, value, P)

% "label" specifies what "value" represents
% acceptable values for "label" include
% label = ['Temperature', 'Volume', 'Energy', 'Enthalpy', 'Entropy']

%P is for the pressure of the desired state                   

load('SuperWaterTable.mat')

[m,~] = size(SuperWaterTable);

if (P < 0.45 || P > 6000)
    error('Pressure value (P) must be between 1 and 6000')
end

idx =[];

%% Finding/Generating Pressure Table

Press = SuperWaterTable.P(1:m);
Pidx = find(Press == P);

if (isempty(Pidx) == false)
    
    Ridx = SuperWaterTable.N(Pidx);
    Ptable = SuperWaterTable{Pidx:(Pidx+Ridx-1),{'T','V','U','H','S'}};
    
else
    if (isempty(Pidx) == true)
        [~,Tsat,~,Vsat,~,~,Usat,~,~,Hsat,~,~,Ssat] = Sat_Water_Table('Pressure', P, 1);
        Ptable = [Tsat, Vsat, Usat, Hsat, Ssat];
        
        Psort = sort(abs(P-Press));
        
        if (Psort(1) == Psort(2))
            PI = find(abs(P-Press) == Psort(1));
            Pidx1 = PI(1);
            Pidx2 = PI(2);
        else
            Pidx1 = find(abs(P-Press) == Psort(1));
            Pidx2 = find(abs(P-Press) == Psort(2));
        end
        
        Ridx1 = SuperWaterTable.N(Pidx1);
        Ridx2 = SuperWaterTable.N(Pidx2);
        
        P1 = SuperWaterTable.P(Pidx1);
        P2 = SuperWaterTable.P(Pidx2);
        
        Ptable1 = SuperWaterTable{Pidx1:(Pidx1+Ridx1-1),{'T','V','U','H','S'}};
        Ptable2 = SuperWaterTable{Pidx2:(Pidx2+Ridx2-1),{'T','V','U','H','S'}};
        
       
        for x = 1:Ridx1
            Pidx = find(Ptable2(:,1) == Ptable1(x,1));
          
            if(isempty(Pidx) == false)
                Ptemp = Row_Interp(P, P1, P2, Ptable1(x,:), Ptable2(Pidx,:));
                Ptable = [Ptable; Ptemp];
            end
        end
    end
end

[n,~] = size(Ptable);

%% Temperature

if (strcmp('Temperature', label) == true)
    
    T = value;
    Y = Ptable(:,1);
    idx = find(Y == value);
    
     if (value > Y(n))
         str = strcat('Temperature cannot exceed ',32, num2str(Ptable(n)),32, 'degrees F for specified pressure'); 
         error(str)
    else 
        if (value < Y(1))
            str = strcat('Temperature cannot be less than ',32, num2str(Ptable(1)),32, 'degrees F for specified pressure'); 
            error(str)
        else
            if (isempty(idx) == false)
                V = Ptable(idx,2);
                U = Ptable(idx,3);
                H = Ptable(idx,4);
                S = Ptable(idx,5);
            else
                if (isempty(idx) == true)
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
                    Vals = Row_Interp(value, Y(idx1), Y(idx2), Ptable(idx1,:), Ptable(idx2,:));
                    V = Vals(2);
                    U = Vals(3);
                    H = Vals(4);
                    S = Vals(5);
                else
                    error('Error in Super_Water_Table while using Temperature. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
     end
end

%% Specific Volume

if (strcmp('Volume', label) == true)
    
    V = value;
    Y = Ptable(:,2);
    idx = find(Y == value);
    
     if (value > Y(n))
         str = strcat('Specific volume cannot exceed ',32, num2str(Y(n)),32, 'ft^3/lbm for specified pressure'); 
         error(str)
    else 
        if (value < Y(1))
            str = strcat('Specific volume cannot be less than ',32, num2str(Y(1)),32, 'ft^3/lbm for specified pressure'); 
            error(str)
        else
            if (isempty(idx) == false)
                T = Ptable(idx,1);
                U = Ptable(idx,3);
                H = Ptable(idx,4);
                S = Ptable(idx,5);
            else
                if (isempty(idx) == true)
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
                    Vals = Row_Interp(value, Y(idx1), Y(idx2), Ptable(idx1,:), Ptable(idx2,:));
                    T = Vals(1);
                    U = Vals(3);
                    H = Vals(4);
                    S = Vals(5);
                else
                    error('Error in Super_Water_Table while using Volume. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
     end
end

%% Energy

if (strcmp('Energy', label) == true)
    
    U = value;
    Y = Ptable(:,3);
    idx = find(Y == value);
    
     if (value > Y(n))
         str = strcat('Internal energy cannot exceed ',32, num2str(Y(n)),32, 'Btu/lbm for specified pressure'); 
         error(str)
    else 
        if (value < Y(1))
            str = strcat('Internal energy cannot be less than ',32, num2str(Y(1)),32, 'Btu/lbm for specified pressure'); 
            error(str)
        else
            if (isempty(idx) == false)
                T = Ptable(idx,1);
                V = Ptable(idx,2);
                H = Ptable(idx,4);
                S = Ptable(idx,5);
            else
                if (isempty(idx) == true)
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
                    Vals = Row_Interp(value, Y(idx1), Y(idx2), Ptable(idx1,:), Ptable(idx2,:));
                    T = Vals(1);
                    V = Vals(2);
                    H = Vals(4);
                    S = Vals(5);
                else
                    error('Error in Super_Water_Table while using Energyy. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
     end
end


%% Enthalpy

if (strcmp('Enthalpy', label) == true)
    
    H = value;
    Y = Ptable(:,4);
    idx = find(Y == value);
    
     if (value > Y(n))
         str = strcat('Enthalpy cannot exceed ',32, num2str(Y(n)),32, 'Btu/lbm for specified pressure'); 
         error(str)
    else 
        if (value < Y(1))
            str = strcat('Enthalpy cannot be less than ',32, num2str(Y(1)),32, 'Btu/lbm for specified pressure'); 
            error(str)
        else
            if (isempty(idx) == false)
                T = Ptable(idx,1);
                V = Ptable(idx,2);
                U = Ptable(idx,3);
                S = Ptable(idx,5);
            else
                if (isempty(idx) == true)
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
                    Vals = Row_Interp(value, Y(idx1), Y(idx2), Ptable(idx1,:), Ptable(idx2,:));
                    T = Vals(1);
                    V = Vals(2);
                    U = Vals(3);
                    S = Vals(5);
                else
                    error('Error in Super_Water_Table while using Enthalpy. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
     end
end

%% Entropy

if (strcmp('Entropy', label) == true)
    
    S = value;
    Y = Ptable(:,5);
    idx = find(Y == value);
    
     if (value > Y(n))
         str = strcat('Entropy cannot exceed ',32, num2str(Y(n)),32, 'Btu/lbm for specified pressure'); 
         error(str)
    else 
        if (value < Y(1))
            str = strcat('Entropy cannot be less than ',32, num2str(Y(1)),32, 'Btu/lbm for specified pressure'); 
            error(str)
        else
            if (isempty(idx) == false)
                T = Ptable(idx,1);
                V = Ptable(idx,2);
                U = Ptable(idx,3);
                H = Ptable(idx,4);
            else
                if (isempty(idx) == true)
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
                    Vals = Row_Interp(value, Y(idx1), Y(idx2), Ptable(idx1,:), Ptable(idx2,:));
                    T = Vals(1);
                    V = Vals(2);
                    U = Vals(3);
                    H = Vals(4);
                else
                    error('Error in Super_Water_Table while using Entropy. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
     end
end

end