clc
clear all

p=[1,1,1,1,0,0,0,0,0,0];
theta=[1,1,1];
y1=mod_geom(theta,p);
h=10^(-6);
p2=p;
p2(6)=p2(6)+h;
y2=mod_geom(theta,p2)
Jn=(y2-y1)/h
Jc=jacobien(theta,p);
Jt=Jc(:,6)
err=Jt-Jn

