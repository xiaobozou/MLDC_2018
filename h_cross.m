function [h_cross]=h_cross(A,w0,phi0,alpha,delta,t)
phi=phifunction(w0,alpha,delta,t);
h_cross=A/2*cos(phi+phi0);
end