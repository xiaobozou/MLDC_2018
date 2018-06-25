function [Abest,w0best,phi0best,alphabest,deltabest]=Bestfitssearch(ybar,Sn,Fs)
%Matched filter best fits search
%pso method
%including:
%    1.antenna pattern function: F_plus(alpha,delta,t), F_cross(alpha,delta,t), (armlength=5*10^9);
%inputs:
%    1.Data: ybar (Fs);
%    2.sampling frequency: Fs
%    3.PSD: vector Sn (Fs=1/60 s^(-1));    {%question: Sn(i)=Snfunction(Fs/n*i or (i-1))?}
%outputs:
%    1.amplitude A;
%    2.signal circular frequency,w0 (0.001~0.01)
%    3.initial phase phi0;
%    4.azimuthal angle alpha;
%    5.polar angle delta;
% 

% if mod(n,2)==1
%     ybar=ybar(1:end-1);% in case n is an odd number
% end
n=length(ybar);
tbar=(0:(n-1))/Fs;
tbar=tbar';

%-------------------get detector tensor vectors----------------------------------
%calcuata fplus fcross vectors first
T=31536000;
w=2*pi/T;
coswtVec = cos(w*tbar);
sinwtVec = sin(w*tbar);
cos2Vec=coswtVec.^2;
sin2Vec=sinwtVec.^2;
cossinVec=coswtVec.*sinwtVec;

%calculate R=R1'R2'R1
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
n11=R11*n10(1)+R12*n10(2)+R13*n10(3);
n12=R21*n10(1)+R22*n10(2)+R23*n10(3);
n13=R31*n10(1)+R32*n10(2)+R33*n10(3);
n21=R11*n20(1)+R12*n20(2)+R13*n20(3);
n22=R21*n20(1)+R22*n20(2)+R23*n20(3);
n23=R31*n20(1)+R32*n20(2)+R33*n20(3);
D11=n11.^2-n21.^2;
D12=n11.*n12-n21.*n22;
D13=n11.*n13-n21.*n23;
%D21=D12;
D22=n12.^2-n22.^2;
D23=n12.*n13-n22.*n23;
%D31=D13;
%D32=D23;
D33=n13.^2-n23.^2;

%-----------------------Best fits search------------------------------------------

[~,rlocation] = PSOforfinal(ybar,tbar,Sn,D11,D22,D33,D12,D13,D23,Fs);
w0best=rlocation(1);
alphabest=rlocation(2);
deltabest=rlocation(3);

%-----------------------calculate best fit fPlus and fcross vectors--------------------------------------------

%calculate ecross and eplus
ex=[sin(alphabest) -cos(alphabest) 0];
ey=[-cos(alphabest)*sin(deltabest) -sin(alphabest)*sin(deltabest) cos(deltabest)];
e_plus=ex'*ex-ey'*ey;
e_cross=ex'*ey+ey'*ex;

%calculate fplus and fcross vectors
f_plusbest=1/2*(D11*e_plus(1,1)+D22*e_plus(2,2)+D33*e_plus(3,3))+D12*e_plus(1,2)+D13*e_plus(1,3)+D23*e_plus(2,3);
f_crossbest=1/2*(D11*e_cross(1,1)+D22*e_cross(2,2)+D33*e_cross(3,3))+D12*e_cross(1,2)+D13*e_cross(1,3)+D23*e_cross(2,3);

%---------------------------------------------------------------------------------------------------------------

qbar1best=qfunction(w0best,0,alphabest,deltabest,tbar,Sn,f_plusbest,f_crossbest);
qbar0best=qfunction(w0best,pi/2,alphabest,deltabest,tbar,Sn,f_plusbest,f_crossbest);
X=innerproduct(ybar,qbar1best,Sn);
Y=innerproduct(ybar,qbar0best,Sn);
phi0best=atan2(Y,X);
[~,q0barbest]=qfunction(w0best,phi0best,alphabest,deltabest,tbar,Sn,f_plusbest,f_crossbest);
N2=innerproduct(q0barbest,q0barbest,Sn);
B=sqrt(X^2+Y^2);
Abest=B/sqrt(N2);

end
