%This file generate the animation of LISA orbits

%These four parameters below can be modified:
n=100;          %number of points
m=2;            %number of loops 
Distance=5;     %149597870700;%;%separation between sun and and center of 3 satellites(earth)
Length=1;       %5*10^9;%arm length
% alpha=234;    %azimuthal angle of GWha
% delta=456;    %polar angle of GW

T=1;            %period: 1 year 
w=2*pi/T;       %angular frequency of the orbit
t=0:T/n:T-T/n;      %get the unit vector with respect to t in SSB frame:

Dvec=cell(length(t),1);%cell that contains unit column vectors from sun to centroid of 3 satellites(earth) of different time
C=cell(length(t),1);   %rotation tensors of different time
U=cell(length(t),3);   %locations of satellites in the SSB frame
Z=cell(length(t),3);   %What we want to plot
z1=ones(length(t),3);
z2=ones(length(t),3);
z3=ones(length(t),3);
% T=cell(length(t),3);
% n=[cos(delta).*cos(alpha),cos(delta).*sin(alpha),sin(delta)];%derection of source


%initial positions of three satellites here(unit vector):
V1=[1,0,0]';
V2=[-1/2,sqrt(3)/2,0]';
V3=[-1/2,-sqrt(3)/2,0]';

R2=[cos(pi/3) 0 sin(pi/3);0 1 0;-sin(pi/3) 0 cos(pi/3)];
for i=1:length(t)
R1=[cos(w.*t(i)) -sin(w.*t(i)) 0;sin(w.*t(i)) cos(w.*t(i)) 0; 0 0 1];
R=R1'*R2'*R1;
C{i,1}=R;
% T{i,1}=R1*V1;
% T{i,2}=R1*V2;
% T{i,3}=R1*V3;
U{i,1}=R*V1;
U{i,2}=R*V2;
U{i,3}=R*V3;
Dvec{i,1}=Distance*[cos(w.*t(i)) sin(w.*t(i)) 0]';%row vectors
  for j=1:3   
      Z{i,j}=Dvec{i,1}+Length/sqrt(3)*U{i,j};%row vectors
  end
z1(i,1:3)=Z{i,1}';
z2(i,1:3)=Z{i,2}';
z3(i,1:3)=Z{i,3}';
end

%M = moviein(m*n); 

% figure;
% plot(sqrt(z1(:,1).^2+z1(:,2).^2+z1(:,3).^2))
% pause

figure;
set(gcf,'Position',get(0,'ScreenSize'))

for j=1:m
for i=1:length(t)

clf
view(0,20)      %change the angle of ciew here
axis([-10 10 -10 10 -1.5,1.5])

hold on
%grid on
box on
axis equal
plot3(0,0,0,'ok')
plot3(z1(:,1),z1(:,2),z1(:,3),'r')
plot3(z2(:,1),z2(:,2),z2(:,3),'g')
plot3(z3(:,1),z3(:,2),z3(:,3),'b')
plot3(z1(i,1),z1(i,2),z1(i,3),'or')
plot3(z2(i,1),z2(i,2),z2(i,3),'og')
plot3(z3(i,1),z3(i,2),z3(i,3),'ob')
line([z1(i,1),z2(i,1)],[z1(i,2),z2(i,2)],[z1(i,3),z2(i,3)],'Color','r','LineWidth',5);
line([z2(i,1),z3(i,1)],[z2(i,2),z3(i,2)],[z2(i,3),z3(i,3)],'Color','g','LineWidth',5);
line([z3(i,1),z1(i,1)],[z3(i,2),z1(i,2)],[z3(i,3),z1(i,3)],'Color','b','LineWidth',5);
pause(0.025); 
 %M(i)=getframe;
end
end
