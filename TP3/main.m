clc
clear all
 
    theta=[pi/4 -pi/3 pi/6]
p=[4,3,2,1,0.1,0.2,0.3,1,1,pi/8];

dim=10;
y1=mod_geom(theta,p)
h=10^(-6);
p2=p;
p2(dim)=p2(dim)+h
y2=mod_geom(theta,p2);
Jn=(y2-y1)/h;
Jc=jacobien(theta,p);
Jt=Jc(:,dim);
err=Jt-Jn
plot_robot(theta,p)
theta(1)=pi/2;
theta(2)=pi/3;
theta(3)=pi/4;
p=[0.2 0.3 0.2 0.1 -0.1 0.08 0.1 0.03 0.025 0.6];
Jf=jacobien(theta,p);
for k=1:9
    
    theta(1)=(rand() - 0.5) * pi;
    theta(2)=(rand() - 0.5) * pi;
    theta(3)=(rand() - 0.5) * pi;
    J=jacobien(theta,p);
    Jf=[Jf;J];

end

