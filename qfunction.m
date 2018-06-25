function [q,q0]=qfunction(w0,phi0,alpha,delta,tbar,Sn,f_plus,f_cross) % template funvtion
% %tabr and Sn are column vectors
phi=phifunction(w0,alpha,delta,tbar);%vector
phi1=phi1function(f_plus,f_cross);%vector
phio=phi0*ones(length(tbar),1);
q0=afunction(f_plus,f_cross).*sin(phi+phi1+phio);%% afunction factor here or not?
N2=innerproduct(q0,q0,Sn);
q=q0/sqrt(N2);
end