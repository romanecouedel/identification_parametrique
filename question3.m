clear all;
close all;
definit_parametres;
k1=5000;
b1=400;
simule_systeme;
%quantification alpha 
alpha= 0.000001*round(alpha*1000000);
vit_alpha=0.0001*round(vit_alpha*10000);
acc_alpha=0.001*round(acc_alpha*1000);
%quantification beta
beta= 0.000001*round(beta*1000000);
vit_beta=0.0001*round(vit_beta*10000);
acc_beta=0.001*round(acc_beta*1000);
%quantification gamma
gamma= 0.000001*round(gamma*1000000);
vit_gamma=0.0001*round(vit_gamma*10000);
acc_gamma=0.001*round(acc_gamma*1000);

identifie_parametres;

p_chapeau
difference_p=p_chapeau-[k0;k1;k2;b0;b1;b2;m1;m2;m3]