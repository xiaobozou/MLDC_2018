%input: Fplus and Fcross vectors
%output: the factor a
function[a]=afunction(f_plus,f_cross)
a=sqrt(f_plus.^2+f_cross.^2/4);
end