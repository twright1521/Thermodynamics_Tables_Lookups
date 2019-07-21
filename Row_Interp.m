function [y] = Row_Interp(x,x1,x2,y1,y2)
% Interpolating between two rows
% where x is known value and y is desired value
% for example known pressure is x, desired temperature is y, etc. etc.

% Pairs (x1, y1) and (x2, y2) are from the two rows 
% that the known value, x, lies between
% typically x1 < x2

y = y1 + (x-x1).*((y2 - y1)./(x2 - x1));

end

