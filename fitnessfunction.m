function[f]=fitnessfunction(ybar,w0,alpha,delta,tbar,Sn,D11,D22,D33,D12,D13,D23)
%calculate ecross and eplus
ex=[sin(alpha) -cos(alpha) 0];
ey=[-cos(alpha)*sin(delta) -sin(alpha)*sin(delta) cos(delta)];
e_plus=ex'*ex-ey'*ey;
e_cross=ex'*ey+ey'*ex;

%calculate fplus and fcross vectors
f_plus=1/2*(D11*e_plus(1,1)+D22*e_plus(2,2)+D33*e_plus(3,3))+D12*e_plus(1,2)+D13*e_plus(1,3)+D23*e_plus(2,3);
f_cross=1/2*(D11*e_cross(1,1)+D22*e_cross(2,2)+D33*e_cross(3,3))+D12*e_cross(1,2)+D13*e_cross(1,3)+D23*e_cross(2,3);

qbar1=qfunction(w0,0,alpha,delta,tbar,Sn,f_plus,f_cross);%two template functions
qbar0=qfunction(w0,pi/2,alpha,delta,tbar,Sn,f_plus,f_cross);
f=innerproduct(ybar,qbar1,Sn)^2+innerproduct(ybar,qbar0,Sn)^2;
end