function [y]=innerproduct(xbar,ybar,Sn)
%This function returns the result of innerproduct between two vectors 
%inputs:
%xbar, ybar as functions of time t (same size, even number)
%Sn is the PSD with respect to frequency f (column vector) %%single-sided or double?

n=length(xbar);
kNyq=floor(n/2)+1;
Xbar=fft(xbar);
Ybar=fft(ybar);
y=2*real(sum(Xbar(1:kNyq).*conj(Ybar(1:kNyq))./Sn(1:kNyq)));
%y=xbar'*ybar;
end
