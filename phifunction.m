function[phi]=phifunction(w0,alpha,delta,tbar)
%return phi vector with the same length as tbar 
%wo,alpha,delta constants
T=31536000;
w=2*pi/T;
c=3*10^8;%speed of light in meters
Distance=149597870700;%distance between the sun and centroid in meters
phi=w0*(tbar+(cos(alpha)*cos(delta)*cos(w*tbar)+sin(alpha)*cos(delta)*sin(w*tbar))*Distance/c);
end
