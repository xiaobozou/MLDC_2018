function[s]=signal(A,w0,phi0,alpha,delta,tbar)
%generate signal
T=31536000;
w=2*pi/T;

%vectirize
coswtVec = cos(w*tbar);
sinwtVec = sin(w*tbar);
cos2Vec=coswtVec.^2;
sin2Vec=sinwtVec.^2;
cossinVec=coswtVec.*sinwtVec;

%have calculated R=R1'R2'R1 first, elements as below
R11=cos2Vec*1/2+sin2Vec;
R12=cossinVec*1/2;
R13=-cossinVec;
R21=R12;
R22=cos2Vec+sin2Vec*1/2;
R23=sinwtVec*sqrt(3)/2;
R31=-R13;
R32=-R23;
R33=1/2;

%calcuate arm vectors
r1=[1,0,0]';
r2=[-1/2,sqrt(3)/2,0]';
r3=[-1/2,-sqrt(3)/2,0]';
n10=(r1-r2)/sqrt(3);
n20=(r2-r3)/sqrt(3);

%vectorized n1 and n2
n11=R11*n10(1)+R12*n10(2)+R13*n10(3);
n12=R21*n10(1)+R22*n10(2)+R23*n10(3);
n13=R31*n10(1)+R32*n10(2)+R33*n10(3);
n21=R11*n20(1)+R12*n20(2)+R13*n20(3);
n22=R21*n20(1)+R22*n20(2)+R23*n20(3);
n23=R31*n20(1)+R32*n20(2)+R33*n20(3);

%detector tensor
D11=n11.^2-n21.^2;
D12=n11.*n12-n21.*n22;
D13=n11.*n13-n21.*n23;
%D21=D12;
D22=n12.^2-n22.^2;
D23=n12.*n13-n22.*n23;
%D31=D13;
%D32=D23;
D33=n13.^2-n23.^2;

%-----------------------calculate fplus and fcross vectors---------
%calculate ecross and eplus
ex=[sin(alpha) -cos(alpha) 0];
ey=[-cos(alpha)*sin(delta) -sin(alpha)*sin(delta) cos(delta)];
e_plus=ex'*ex-ey'*ey;
e_cross=ex'*ey+ey'*ex;

%calculate fplus and fcross vectors
f_plus=1/2*(D11*e_plus(1,1)+D22*e_plus(2,2)+D33*e_plus(3,3))+D12*e_plus(1,2)+D13*e_plus(1,3)+D23*e_plus(2,3);
f_cross=1/2*(D11*e_cross(1,1)+D22*e_cross(2,2)+D33*e_cross(3,3))+D12*e_cross(1,2)+D13*e_cross(1,3)+D23*e_cross(2,3);
%------------------------------------------------------------

s=h_plus(A,w0,phi0,alpha,delta,tbar).*f_plus+h_cross(A,w0,phi0,alpha,delta,tbar).*f_cross;
end
