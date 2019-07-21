############ Function ####################

[T, V, U, H, S] = Super_Water_Table(label, value, P)

############ Description #################

Super_Water_Table is a function that searches the Superheated Water Pressure Tables
and outputs the values associated with an input value. The function automatically 
interpolates between rows in the table for values not in the table itself. 
The input value, however, must lie between certain bounds which are outlined below.

The function also interpolates between tables for pressures found between the 
available pressure tables. This interpolation creates an entire table of values for the 
specified pressure and then outputs the values associated with the input values.

The function Super_Water_Table utilizes the companion table SuperWaterTable.mat 
as well as the functions Row_Interp.m and Sat_Water_Table.m and its companion table SatWaterTable.mat

SuperWaterTable.mat is the superheated water pressure table from "Thermodynamics: An Engineering Approach, 8th Ed."
in English units.

SatWaterTable.mat is the saturated water pressure table from "Thermodynamics: An Engineering Approach, 8th Ed."
in English units.

########### Outputs ######################

Super_Water_Table outputs 5 variables [T, V, U, H, S]
which correspond to the following:

	T = Temperature 	(degrees F)

	V = Specific Volume (ft^3/lbm)
	
	U = Internal Energy (Btu/lbm)

	H = Enthalpy 		(Btu/lbm)
	
	S = Enthalpy 		(Btu/lbm*R)

########### Inputs #######################
-------------------------------------------------------
$$$$$$$$$ Input values must be in English Units $$$$$$$
-------------------------------------------------------

Super_Water_Table relies on 3 inputs (label, value, P)

The variable "value" is the input number to be referenced and should be type double.

The variable "label" denotes what the number in "value" represents (i.e. temperature, enthalpy, etc)
	Acceptable inputs for "label" are as follows:

	'Temperature', 'Volume', 'Energy', 'Enthalpy', 'Entropy'

	where 'Volume' refers to specific volume and 'Energy' refers to internal energy.

The variable "P" denotes the pressure at that state.

	The pressure value determines the table of values that "value" is compared against.

############ Value Bounds ################	

Bounds for pressure is as follows:

		P = [1, 6000] 		(psi)
		
		Exact Value Tables for P are:
		
		P = [1, 5, 10, 15, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 225, ...
				250, 275, 300, 350, 400, 450, 500, 600, 700, 800, 1000, 1250, ...
					1500, 1750, 2000, 2500, 3000, 3500, 4000, 5000, 6000]

Pressures that do not match exact values will generate tables by interpolating between
the tables that the value lies between. These generated tables have a certain  degree of accuracy
that is mostly untested. Some tested values were found to deviate by 1%. Use with caution.		
		
Bounds for other values are based on the value for pressure. 
If value specified falls outside the determined bounds an error message 
will appear with the bound that has been exceeded.

		
############ Example 1 ###################
label = 'Temperature';
value = 700;
P = 15;

[T, V, U, H, S] = Super_Water_Table(label, value, P)

Returns:

T = 700
V = 45.981
U = 1256.3
H = 1383.9
S = 2.0156

############ Example 2 ###################
label = 'Temperature';
value = 100;
P = 15;

[T, V, U, H, S] = Super_Water_Table(label, value, P)

Returns:

Error using Super_Water_Table (line 82)
Temperature cannot be less than 212.99 degrees F for specified pressure

############ Example 3 ###################

To return only desired values use ~ to block off undesired values during output.

For example, if the input is temperature and desired outputs are H and S.

label = 'Temperature';
value = 1000;
P = 15;

[~, ~, ~, H, S] = Super_Water_Table(label, value, P)

Returns:

H = 1534.8
S = 2.1312

############ Example 4 ###################

To return only a single value, one does not need to use ~ on the values following it in the list.

For example, if the input is temperature and the desired output is only internal energy.

label = 'Temperature';
value = 1000;
P = 15;

[~, ~, U] = Super_Water_Table(label, value, P)

Returns:

U = 1374