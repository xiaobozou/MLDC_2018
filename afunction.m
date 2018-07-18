function[a]=afunction(f_plus,f_cross)
%input: Fplus and Fcross vectors
%output: the factor a
a=sqrt(f_plus.^2+f_cross.^2/4);
end
