clc
clear all
close all

%% question 1 et 2
p=[1,1,1,1,0,0,0,2,1,pi/2];
theta=[0,0,0];
plot_robot(theta,p);
y1=mod_geom(theta,p);
h=10^(-6);
p2=p;
p2(6)=p2(6)+h;
y2=mod_geom(theta,p2)
Jn=(y2-y1)/h
Jc=jacobien(theta,p);
Jt=Jc(:,6)
err=Jt-Jn

%% question 3
p=[0.2,0.3,0.2,0.1,-0.1,0.08,0.1,0.03,0.025,0.6];
theta=[0,pi/2,0];
