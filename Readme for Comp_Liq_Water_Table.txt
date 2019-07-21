############ Function ####################

[T, V, U, H, S] = Comp_Liq_Water_Table(label, value, P)

############ Description #################

Comp_Liq_Water_Table is a function that searches the Compressed Liquid Water Pressure Tables
and outputs the values associated with an input value. The function automatically 
interpolates between rows in the table for values not in the table itself. 
The input value, however, must lie between certain bounds which are outlined below.

The function also interpolates between tables for pressures found between the 
available pressure tables. This interpolation creates an entire table of values for the 
specified pressure and then outputs the values associated with the input values.

The function Comp_Liq_Water_Table utilizes the companion table CompLiqWaterTable.mat 
as well as the functions Row_Interp.m and Sat_Water_Table.m and its companion table SatWaterTable.mat

CompLiqWaterTable.mat is the compressed liquid water pressure table from "Thermodynamics: An Engineering Approach, 8th Ed."
combined with select values from <https://www.thermexcel.com/english/tables/eau_atm.htm> in English units.

SatWaterTable.mat is the saturated water pressure table from "Thermodynamics: An Engineering Approach, 8th Ed."
in English units.

########### Outputs ######################

Comp_Liq_Water_Table outputs 5 variables [T, V, U, H, S]
which correspond to the following:

	T = Temperature 	(degrees F)

	V = Specific Volume (ft^3/lbm)
	
	U = Internal Energy (Btu/lbm)

	H = Enthalpy 		(Btu/lbm)
	
	S = Enthalpy 		(Btu/lbm*R)

$*$*$*$* WARNING $*$*$*$*$*

Pressures below 362.594 psi do not contain values for Internal Energy, U.

At P = 362.594 psi, Temperatures below 68 degrees F do not contain values for Internal Energy, U.

########### Inputs #######################
-------------------------------------------------------
$$$$$$$$$ Input values must be in English Units $$$$$$$
-------------------------------------------------------

Comp_Liq_Water_Table relies on 3 inputs (label, value, P)

The variable "value" is the input number to be referenced and should be type double.

The variable "label" denotes what the number in "value" represents (i.e. temperature, enthalpy, etc)
	Acceptable inputs for "label" are as follows:

	'Temperature', 'Volume', 'Energy', 'Enthalpy', 'Entropy'

	where 'Volume' refers to specific volume and 'Energy' refers to internal energy.

The variable "P" denotes the pressure at that state.

	The pressure value determines the table of values that "value" is compared against.

############ Value Bounds ################	

Bounds for pressure is as follows:

		P = [14.6959488, 5000] 		(psi)
		
		Exact Value Tables for P are:
		
		P = [14.6959488, 100, 200, 362.594, 500, 1500, 2000, 3000, 5000]

Pressures that do not match exact values will generate tables by interpolating between
the tables that the value lies between. These generated tables have a certain  degree of accuracy
that is mostly untested. Use with caution.		
		
Bounds for other values are based on the value for pressure. 
If value specified falls outside the determined bounds an error message 
will appear with the bound that has been exceeded.
