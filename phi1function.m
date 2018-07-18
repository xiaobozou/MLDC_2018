
function[phi1]=phi1function(f_plus,f_cross)
%return phi1 vector
%f_plus, f_cross are column vector corresponding to the F_plus, F_cross
%functions
phi1=atan2(f_cross/2,f_plus);%vector
end
