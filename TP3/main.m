clc
clear all

p=[1,1,1,1,0,0,0,0,0,0];
theta=[1,1,1];
dim=;
y1=mod_geom(theta,p);
h=10^(-6);
p2=p;
p2(dim)=p2(dim)+h
y2=mod_geom(theta,p2);
Jn=(y2-y1)/h;
Jc=jacobien(theta,p);
Jt=Jc(:,dim);
err=Jt-Jn

