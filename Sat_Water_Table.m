function [P,T,Vf,Vg,Uf,Ufg,Ug,Hf,Hfg,Hg,Sf,Sfg,Sg] = Sat_Water_Table(label, value, x)

% "label" specifies what "value" represents
% acceptable values for "label" include
% label = ['Pressure', 'Temperature', 'Volume', 'Energy', 'Enthalpy', 'Entropy']

% if "label" is the former two ('Pressure', 'Temperature')
% "x" is disregarded

% if "label" is of the latter three ('Volume', 'Energy', 'Enthalpy', 'Entropy')
% "x" is a required component of these labels as specified
% "x" denotes the value of x such that   value = yf - x*yfg
% where y = [v, u, h, s]

load('SatWaterTable.mat')

[m,~] = size(SatWaterTable);

if (x > 1 || x < 0)
    error('x must be between zero and one. (0 < x < 1)')
end

idx = [];

%% Pressure

if (strcmp('Pressure', label) == true)
    
    P = value;
    Y = SatWaterTable.P(1:m);
    idx = find(Y == value);
    
    if (value > SatWaterTable.P(m))
        error('Pressure value cannot exceed 3200.1 psi')
    else 
        if (value < SatWaterTable.P(1))
            error('Pressure must not be less than 0.45 psi')
        else
            if (isempty(idx) == false)
                T = SatWaterTable.T(idx);
                Vf = SatWaterTable.Vf(idx);
                Vg = SatWaterTable.Vg(idx);
                Uf = SatWaterTable.Uf(idx);
                Ufg = SatWaterTable.Ufg(idx);
                Ug = SatWaterTable.Ug(idx);
                Hf = SatWaterTable.Hf(idx);
                Hfg = SatWaterTable.Hfg(idx);
                Hg = SatWaterTable.Hg(idx);
                Sf = SatWaterTable.Sf(idx);
                Sfg = SatWaterTable.Sfg(idx);
                Sg = SatWaterTable.Sg(idx);
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
        
                    T = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.T(idx1), SatWaterTable.T(idx2));
                    Vf = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Vf(idx1), SatWaterTable.Vf(idx2));
                    Vg = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Vg(idx1), SatWaterTable.Vg(idx2));
                    Uf = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Uf(idx1), SatWaterTable.Uf(idx2));
                    Ufg = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Ufg(idx1), SatWaterTable.Ufg(idx2));
                    Ug = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Ug(idx1), SatWaterTable.Ug(idx2));
                    Hf = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Hf(idx1), SatWaterTable.Hf(idx2));
                    Hfg = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Hfg(idx1), SatWaterTable.Hfg(idx2));
                    Hg = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Hg(idx1), SatWaterTable.Hg(idx2));
                    Sf = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Sf(idx1), SatWaterTable.Sf(idx2));
                    Sfg = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Sfg(idx1), SatWaterTable.Sfg(idx2));
                    Sg = Row_Interp(value, SatWaterTable.P(idx1), SatWaterTable.P(idx2), SatWaterTable.Sg(idx1), SatWaterTable.Sg(idx2));
                else 
                    error('Error in Sat_Water_Table while using Pressure. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
    end
end

%% Temperature

if (strcmp('Temperature', label) == true)
    
    T = value;
    Y = SatWaterTable.T(1:m);
    idx = find(Y == value);
    
    if (value > SatWaterTable.T(m))
        error('Temperature cannot exceed 705.1 degrees F')
    else 
        if (value < SatWaterTable.T(1))
            error('Temperature cannot be less than 76.35 degrees F')
        else
            if (isempty(idx) == false)
                P = SatWaterTable.P(idx);
                Vf = SatWaterTable.Vf(idx);
                Vg = SatWaterTable.Vg(idx);
                Uf = SatWaterTable.Uf(idx);
                Ufg = SatWaterTable.Ufg(idx);
                Ug = SatWaterTable.Ug(idx);
                Hf = SatWaterTable.Hf(idx);
                Hfg = SatWaterTable.Hfg(idx);
                Hg = SatWaterTable.Hg(idx);
                Sf = SatWaterTable.Sf(idx);
                Sfg = SatWaterTable.Sfg(idx);
                Sg = SatWaterTable.Sg(idx);
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
        
                    P = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.P(idx1), SatWaterTable.P(idx2));
                    Vf = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Vf(idx1), SatWaterTable.Vf(idx2));
                    Vg = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Vg(idx1), SatWaterTable.Vg(idx2));
                    Uf = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Uf(idx1), SatWaterTable.Uf(idx2));
                    Ufg = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Ufg(idx1), SatWaterTable.Ufg(idx2));
                    Ug = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Ug(idx1), SatWaterTable.Ug(idx2));
                    Hf = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Hf(idx1), SatWaterTable.Hf(idx2));
                    Hfg = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Hfg(idx1), SatWaterTable.Hfg(idx2));
                    Hg = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Hg(idx1), SatWaterTable.Hg(idx2));
                    Sf = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Sf(idx1), SatWaterTable.Sf(idx2));
                    Sfg = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Sfg(idx1), SatWaterTable.Sfg(idx2));
                    Sg = Row_Interp(value, SatWaterTable.T(idx1), SatWaterTable.T(idx2), SatWaterTable.Sg(idx1), SatWaterTable.Sg(idx2));
                else 
                    error('Error in Sat_Water_Table while using Temperature. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
    end
end        

%% Specific Volume

if (strcmp('Volume', label) == true)
    
    Yf = SatWaterTable.Vf(1:m);
    Yg = SatWaterTable.Vg(1:m);
    
    if (x == 0)
        idx = find(Yf == value);
        if (value < SatWaterTable.Vf(1) || value > SatWaterTable.Vf(m))
            error('Specific Volume must be between 0.016064257028112 and 0.04975 ft^3/lbm if x = 0')
        end
    end
    
    if (x == 1)
        idx = find(Yg == value);
        if (value < SatWaterTable.Vg(1) || value > SatWaterTable.Vg(m))
            error('Specific Volume must be between 0.04975 and 708.44 ft^3/lbm if x = 1')
        end
    end
    
    if (value > SatWaterTable.Vg(1))
        error('Specific Volume cannot exceed 708.44 ft^3/lbm')
    else 
        if (value < SatWaterTable.Vf(1))
            error('Specific Volume cannot be less than 0.016064257028112 ft^3/lbm')
        else
            if (isempty(idx) == false)
                P = SatWaterTable.P(idx);
                T = SatWaterTable.T(idx);
                Vf = SatWaterTable.Vf(idx);
                Vg = SatWaterTable.Vg(idx);
                Uf = SatWaterTable.Uf(idx);
                Ufg = SatWaterTable.Ufg(idx);
                Ug = SatWaterTable.Ug(idx);
                Hf = SatWaterTable.Hf(idx);
                Hfg = SatWaterTable.Hfg(idx);
                Hg = SatWaterTable.Hg(idx);
                Sf = SatWaterTable.Sf(idx);
                Sfg = SatWaterTable.Sfg(idx);
                Sg = SatWaterTable.Sg(idx);
            else 
                if (isempty(idx) == true)
                    Y = Yf + x.*(Yg - Yf);
                    
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
                    if (idx1 ~= (idx2 -1))
                        error('Specific Volume value based on designated x is not in this table. Please choose a new value for specific volume or x.')
                    end
        
                    P = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.P(idx1), SatWaterTable.P(idx2));
                    T = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.T(idx1), SatWaterTable.T(idx2));
                    Vf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Vf(idx1), SatWaterTable.Vf(idx2));
                    Vg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Vg(idx1), SatWaterTable.Vg(idx2));
                    Uf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Uf(idx1), SatWaterTable.Uf(idx2));
                    Ufg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Ufg(idx1), SatWaterTable.Ufg(idx2));
                    Ug = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Ug(idx1), SatWaterTable.Ug(idx2));
                    Hf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hf(idx1), SatWaterTable.Hf(idx2));
                    Hfg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hfg(idx1), SatWaterTable.Hfg(idx2));
                    Hg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hg(idx1), SatWaterTable.Hg(idx2));
                    Sf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sf(idx1), SatWaterTable.Sf(idx2));
                    Sfg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sfg(idx1), SatWaterTable.Sfg(idx2));
                    Sg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sg(idx1), SatWaterTable.Sg(idx2));
                else 
                    error('Error in Sat_Water_Table while using Volume. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
    end
end                

%% Internal Energy

if (strcmp('Energy', label) == true)
    
    Yf = SatWaterTable.Uf(1:m);
    Yg = SatWaterTable.Ug(1:m);
    Yfg = SatWaterTable.Ufg(1:m);
    
    if (x == 0)
        idx = find(Yf == value);
        if (value < SatWaterTable.Uf(2) || value > SatWaterTable.Uf(m))
            error('Internal energy must be between 69.72 and 866.61 Btu/lbm if x = 0')
        end
    end
    
    if (x == 1)
        idx = find(Yg == value);
        if (value < SatWaterTable.Ug(2) || value > SatWaterTable.Ug(m))
            error('Internal energy must be between 866.61 and 1043.7 Btu/lbm if x = 1')
        end
    end
    
    if (value > SatWaterTable.Ug(2))
        error('Internal energy cannot exceed 1043.7 Btu/lbm')
    else 
        if (value < SatWaterTable.Uf(2))
            error('Internal energy cannot be less than 69.72 Btu/lbm')
        else
            if (isempty(idx) == false)
                P = SatWaterTable.P(idx);
                T = SatWaterTable.T(idx);
                Vf = SatWaterTable.Vf(idx);
                Vg = SatWaterTable.Vg(idx);
                Uf = SatWaterTable.Uf(idx);
                Ufg = SatWaterTable.Ufg(idx);
                Ug = SatWaterTable.Ug(idx);
                Hf = SatWaterTable.Hf(idx);
                Hfg = SatWaterTable.Hfg(idx);
                Hg = SatWaterTable.Hg(idx);
                Sf = SatWaterTable.Sf(idx);
                Sfg = SatWaterTable.Sfg(idx);
                Sg = SatWaterTable.Sg(idx);
            else 
                if (isempty(idx) == true)
                    Y = Yf + x.*(Yfg);
                    
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
                    if (idx1 ~= (idx2 -1))
                        error('Internal entergy value based on designated x is not in this table. Please choose a new value for internal energy or x.')
                    end
        
                    P = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.P(idx1), SatWaterTable.P(idx2));
                    T = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.T(idx1), SatWaterTable.T(idx2));
                    Vf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Vf(idx1), SatWaterTable.Vf(idx2));
                    Vg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Vg(idx1), SatWaterTable.Vg(idx2));
                    Uf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Uf(idx1), SatWaterTable.Uf(idx2));
                    Ufg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Ufg(idx1), SatWaterTable.Ufg(idx2));
                    Ug = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Ug(idx1), SatWaterTable.Ug(idx2));
                    Hf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hf(idx1), SatWaterTable.Hf(idx2));
                    Hfg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hfg(idx1), SatWaterTable.Hfg(idx2));
                    Hg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hg(idx1), SatWaterTable.Hg(idx2));
                    Sf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sf(idx1), SatWaterTable.Sf(idx2));
                    Sfg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sfg(idx1), SatWaterTable.Sfg(idx2));
                    Sg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sg(idx1), SatWaterTable.Sg(idx2));
                else 
                    error('Error in Sat_Water_Table while using Energy. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
    end
end                

%% Enthalpy

if (strcmp('Enthalpy', label) == true)
    
    Yf = SatWaterTable.Hf(1:m);
    Yg = SatWaterTable.Hg(1:m);
    Yfg = SatWaterTable.Hfg(1:m);
    
    if (x == 0)
        idx = find(Yf == value);
        if (value < SatWaterTable.Hf(1) || value > SatWaterTable.Hf(m))
            error('Enthalpy must be between 69.72 and 896.07 Btu/lbm if x = 0')
        end
    end
    
    if (x == 1)
        idx = find(Yg == value);
        if (value < SatWaterTable.Hg(1) || value > SatWaterTable.Hg(m))
            error('Enthalpy must be between 896.07 and 1105.4 Btu/lbm if x = 1')
        end
    end
    
    if (value > SatWaterTable.Hg(1))
        error('Enthalpy cannot exceed 1105.4 Btu/lbm')
    else 
        if (value < SatWaterTable.Hf(1))
            error('Enthalpy cannot be less than 69.72 Btu/lbm')
        else
            if (isempty(idx) == false)
                P = SatWaterTable.P(idx);
                T = SatWaterTable.T(idx);
                Vf = SatWaterTable.Vf(idx);
                Vg = SatWaterTable.Vg(idx);
                Uf = SatWaterTable.Uf(idx);
                Ufg = SatWaterTable.Ufg(idx);
                Ug = SatWaterTable.Ug(idx);
                Hf = SatWaterTable.Hf(idx);
                Hfg = SatWaterTable.Hfg(idx);
                Hg = SatWaterTable.Hg(idx);
                Sf = SatWaterTable.Sf(idx);
                Sfg = SatWaterTable.Sfg(idx);
                Sg = SatWaterTable.Sg(idx);
            else 
                if (isempty(idx) == true)
                    Y = Yf + x.*(Yfg);
                    
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
                    if (idx1 ~= (idx2 -1))
                        error('Enthalpy value based on designated x is not in this table. Please choose a new value for Enthalpy or x.')
                    end
        
                    P = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.P(idx1), SatWaterTable.P(idx2));
                    T = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.T(idx1), SatWaterTable.T(idx2));
                    Vf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Vf(idx1), SatWaterTable.Vf(idx2));
                    Vg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Vg(idx1), SatWaterTable.Vg(idx2));
                    Uf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Uf(idx1), SatWaterTable.Uf(idx2));
                    Ufg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Ufg(idx1), SatWaterTable.Ufg(idx2));
                    Ug = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Ug(idx1), SatWaterTable.Ug(idx2));
                    Hf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hf(idx1), SatWaterTable.Hf(idx2));
                    Hfg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hfg(idx1), SatWaterTable.Hfg(idx2));
                    Hg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hg(idx1), SatWaterTable.Hg(idx2));
                    Sf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sf(idx1), SatWaterTable.Sf(idx2));
                    Sfg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sfg(idx1), SatWaterTable.Sfg(idx2));
                    Sg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sg(idx1), SatWaterTable.Sg(idx2));
                else 
                    error('Error in Sat_Water_Table while using Enthalpy. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
    end
end                

%% Entropy

if (strcmp('Entropy', label) == true)
    
    Yf = SatWaterTable.Sf(1:m);
    Yg = SatWaterTable.Sg(1:m);
    Yfg = SatWaterTable.Sfg(1:m);
    
    if (x == 0)
        idx = find(Yf == value);
        if (value < SatWaterTable.Sf(1) || value > SatWaterTable.Sf(m))
            error('Entropy must be between 0.13262 and 1.05257 Btu/lbm*R if x = 0')
        end
    end
    
    if (x == 1)
        idx = find(Yg == value);
        if (value < SatWaterTable.Sg(1) || value > SatWaterTable.Sg(m))
            error('Entropy must be between 1.05257 and 1.9776 Btu/lbm*R if x = 1')
        end
    end
    
    if (value > SatWaterTable.Sg(1))
        error('Entropy cannot exceed 1.9776 Btu/lbm*R')
    else 
        if (value < SatWaterTable.Sf(1))
            error('Entropy cannot be less than 0.13262 Btu/lbm*R')
        else
            if (isempty(idx) == false)
                P = SatWaterTable.P(idx);
                T = SatWaterTable.T(idx);
                Vf = SatWaterTable.Vf(idx);
                Vg = SatWaterTable.Vg(idx);
                Uf = SatWaterTable.Uf(idx);
                Ufg = SatWaterTable.Ufg(idx);
                Ug = SatWaterTable.Ug(idx);
                Hf = SatWaterTable.Hf(idx);
                Hfg = SatWaterTable.Hfg(idx);
                Hg = SatWaterTable.Hg(idx);
                Sf = SatWaterTable.Sf(idx);
                Sfg = SatWaterTable.Sfg(idx);
                Sg = SatWaterTable.Sg(idx);
            else 
                if (isempty(idx) == true)
                    Y = Yf + x.*(Yfg);
                    
                    Ysort = sort(abs(value-Y));   
                    
                    if (Ysort(1) == Ysort(2))
                        I = find(abs(value-Y) == Ysort(1));
                        idx1 = I(1);
                        idx2 = I(2);
                    else
                        idx1 = find(abs(value-Y) == Ysort(1));
                        idx2 = find(abs(value-Y) == Ysort(2));
                    end
                    
%                     if (idx1 ~= (idx2 -1))
%                         error('Entropy value based on designated x is not in this table. Please choose a new value for entropy or x.')
%                     end
        
                    P = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.P(idx1), SatWaterTable.P(idx2));
                    T = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.T(idx1), SatWaterTable.T(idx2));
                    Vf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Vf(idx1), SatWaterTable.Vf(idx2));
                    Vg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Vg(idx1), SatWaterTable.Vg(idx2));
                    Uf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Uf(idx1), SatWaterTable.Uf(idx2));
                    Ufg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Ufg(idx1), SatWaterTable.Ufg(idx2));
                    Ug = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Ug(idx1), SatWaterTable.Ug(idx2));
                    Hf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hf(idx1), SatWaterTable.Hf(idx2));
                    Hfg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hfg(idx1), SatWaterTable.Hfg(idx2));
                    Hg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Hg(idx1), SatWaterTable.Hg(idx2));
                    Sf = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sf(idx1), SatWaterTable.Sf(idx2));
                    Sfg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sfg(idx1), SatWaterTable.Sfg(idx2));
                    Sg = Row_Interp(value, Y(idx1), Y(idx2), SatWaterTable.Sg(idx1), SatWaterTable.Sg(idx2));
                else 
                    error('Error in Sat_Water_Table while using Entropy. Please make sure all inputs are of the correct type and are not empty. If the problem persists make a record of inputs and troubleshoot.')
                end
            end
        end
    end
end                


end