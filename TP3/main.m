clc
clear all
%% question 1 et 2
p=[1,1,1,1,0,0,0,3,0,0];
theta=[0,0,0];
plot_robot(theta,p);
dim=9;
y1=mod_geom(theta,p)
h=10^(-6);
p2=p;
p2(dim)=p2(dim)+h
y2=mod_geom(theta,p2);
Jn=(y2-y1)/h;
Jc=jacobien(theta,p);
Jt=Jc(:,dim);
err=Jt-Jn
%% question 3

%% question 4
creer_data(p);
