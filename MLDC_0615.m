%This is the main file of the final lab
%-----------------generate signal-----------------
A=1e-22;
w0=0.001*2*pi;
phi0=pi/2;
alpha=pi/6;
delta=pi/6;
Fs=1/180;  %fullfill w0/(2*pi)<Fs/2
n=floor(31536000*Fs);
% Sbar=zeros(n,1);
% ybar=zeros(n,1);
% Nbar=zeros(n,1);
tbar=(0:(n-1))/Fs;
tbar=tbar';

Sbar=signal(A,w0,phi0,alpha,delta,tbar);


%---------generate noise(gaussian wihte noise here, can be changed to colored noise)----
Nbar=1e-22*(randn(n,1));       %

%[Sn,f]=pwelch(Nbar,1024,[],[],Fs);%as frequency % %
Sn=ones(n,1);%<<what is the right factor here?
%Sn=fft(Nbar).*conj(fft(Nbar));

%--------------------generate data-----------------------
ybar=Sbar+Nbar;

%----------------best fits search-------------------------
[Abest,w0best,phi0best,alphabest,deltabest]=Bestfitssearch(ybar,Sn,Fs);