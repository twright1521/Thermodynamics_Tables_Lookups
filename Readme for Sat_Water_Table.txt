############ Function ####################

[P,T,Vf,Vg,Uf,Ufg,Ug,Hf,Hfg,Hg,Sf,Sfg,Sg] = Sat_Water_Table(label, value, x)

############ Description #################

Sat_Water_Table is a function that searches the Saturated Water Pressure Tables
and outputs the values associated with an input value. The function automatically 
interpolates between rows in the table for values not in the table itself. 
The input value, however, must lie between certain bounds which are outlined below.

The function Scat_Water_Table utilizes the companion table SatWaterTable.mat 
as well as the function Row_Interp.m

SatWaterTable.mat is the saturated water pressure table from "Thermodynamics: An Engineering Approach, 8th Ed."
in English units.

########### Outputs ######################

Scat_Water_Table outputs 13 variables [P,T,Vf,Vg,Uf,Ufg,Ug,Hf,Hfg,Hg,Sf,Sfg,Sg]
which correspond to the following:

	P = Pressure (psia)
	T = Temperature (degrees F)

	Vf = Specific Volume of Saturated Liquid (ft^3/lbm)
	Vg = Specific Volume of Saturated Vapor (ft^3/lbm)

	Uf = Internal Energy of Saturated Liquid (Btu/lbm)
	Ufg = Internal Energy of Evaporation (Btu/lbm)
	Ug = Internal Energy of Saturated Vapor (Btu/lbm)

	Hf = Enthalpy of Saturated Liquid (Btu/lbm)
	Hfg = Enthalpy  of Evaporation (Btu/lbm)
	Hg = Enthalpy of Saturated Vapor (Btu/lbm)

	Sf = Enthalpy of Saturated Liquid (Btu/lbm*R)
	Sfg = Enthalpy  of Evaporation (Btu/lbm*R)
	Sg = Enthalpy of Saturated Vapor (Btu/lbm*R)

########### Inputs #######################
-------------------------------------------------------
$$$$$$$$$ Input values must be in English Units $$$$$$$
-------------------------------------------------------

Scat_Water_Table relies on 3 inputs (label, value, x)

The variable "value" is the input number to be referenced and should be type double.

The variable "label" denotes what the number in "value" represents (i.e. pressure, temperature, etc)
	Acceptable inputs for "label" are as follows:

	'Pressure', 'Temperature', 'Volume', 'Energy', 'Enthalpy', 'Entropy'

	where 'Volume' refers to specific volume and 'Energy' refers to internal energy.

The variable "x" denotes moisture content in the transition phase from liquid to gas
	such that it follows the formula 	y = yf + x*yfg
	where y is v, u, h, or s

	The variable "x" is not required for searches involving 'Pressure' or 'Temperature'

	For 'Volume', 'Energy', 'Enthalpy', and 'Entropy', "x" is a required value.

	If the input value being searched for is yf then "x" should equal zero.

	If the input value being searched for is yg then "x" should equal one.

	Otherwise all other values for y need an accompanying "x" that is between zero and one.
	
	One cannot search by a value of yfg.

############ Value Bounds ################	

Bounds for each values is as follows:

		P = [1, 3200.1] 		(psi)
		T = [101.69, 705.1] 	(degrees F)
		
		V = [0.01614, 333.49]	(ft^3/lbm)
		Vf = [0.01614, 0.04975] (ft^3/lbm)
		Vg = [0.04975, 333.49] 	(ft^3/lbm)
		
		U = [69.72, 1043.7]		(Btu/lbm)
		Uf = [69.72, 866.61] 	(Btu/lbm)
		Ug = [866.61, 1043.7] 	(Btu/lbm)
		
		H = [69.72, 1105.4] 	(Btu/lbm)
		Hf = [69.72, 896.07]	(Btu/lbm)
		Hg = [896.07, 1105.4] 	(Btu/lbm)
		
		S = [0.13262, 1.9776]	(Btu/lbm*R)		
		Sf = [0.13262, 1.05257] (Btu/lbm*R)
		Sg = [1.05257, 1.9776]	(Btu/lbm*R)
		
		Values of V, U, H, and S are dependant on x
		may result in an error if they do not match with the table
		
############ Example 1 ###################

label = 'Enthalpy';
value = 1000;
x = 0.8;

[P,T,Vf,Vg,Uf,Ufg,Ug,Hf,Hfg,Hg,Sf,Sfg,Sg] = Sat_Water_Table(label, value, x)

Output values are:

	P = 72.00985
	T = 304.7912

	Vf = 0.017496
	Vg = 6.050409

	Uf = 274.433
	Ufg = 826.368
	Ug = 1100.802

	Hf = 274.662
	Hfg = 906.673
	Hg = 1181.323

	Sf = 0.443648
	Sfg = 1.186025
	Sg = 1.629689
	
############ Example 2 ###################
	
label = 'Enthalpy';
value = 100;
x = 0.8;

[P,T,Vf,Vg,Uf,Ufg,Ug,Hf,Hfg,Hg,Sf,Sfg,Sg] = Sat_Water_Table(label, value, x)

Returns:

Error using Sat_Water_Table (line 326)
Enthalpy value based on designated x is not in this table. Please choose a new value for Enthalpy or x.

############ Example 3 ###################

To return only desired values use ~ to block off undesired values during output.

For example, if the input is pressure and desired output is only Hf, Hfg, Sf, and Sfg.

label = 'Pressure';
value = 300;
x = 0.8;

[~,~,~,~,~,~,~,Hf,Hfg,~,Sf,Sfg,~] = Sat_Water_Table(label, value, x)

Returns:

	Hf = 393.94
	Hfg = 809.41
	Sf = 0.5882
	Sfg = 0.9229

############ Example 4 ###################

To return only a single value, one does not need to use ~ on the values following it in the list.

For example, if the input is pressure and the desired output is only temperature.

label = 'Pressure';
value = 300;
x = 0.8;

[~, T] = Sat_Water_Table(label, value, x)

Returns:

	T = 417.35
	
Or the desired output is only Hf.

[~,~,~,~,~,~,~,Hf] = Sat_Water_Table(label, value, x)

Returns:

	Hf = 393.94