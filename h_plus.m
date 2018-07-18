function [h_plus]=h_plus(A,w0,phi0,alpha,delta,t)
phi=phifunction(w0,alpha,delta,t);
h_plus=A*sin(phi+phi0);
end
