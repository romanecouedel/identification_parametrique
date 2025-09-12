clear all;
close all;
definit_parametres;
simule_systeme;


u=0.76;
%quantification et filtrage alpha 
alpha= 0.00001*round(alpha*100000);
alpha= filtfilt([1 u-1], u, alpha);

vit_alpha=0.0001*round(vit_alpha*10000);
vit_alpha = filtfilt([1 u-1], u, vit_alpha);

acc_alpha=0.001*round(acc_alpha*1000);
acc_alpha = filtfilt([1 u-1], u, acc_alpha);

%quantification et filtrage beta
beta= 0.00001*round(beta*100000);
beta = filtfilt([1 u-1], u, beta);

vit_beta=0.0001*round(vit_beta*10000);
vit_beta = filtfilt([1 u-1], u, vit_beta);

acc_beta=0.001*round(acc_beta*1000);
acc_beta = filtfilt([1 u-1], u, acc_beta);

%quantification et filtrage gamma
gamma= 0.00001*round(gamma*100000);
gamma = filtfilt([1 u-1], u, gamma);

vit_gamma=0.0001*round(vit_gamma*10000);
vit_gamma = filtfilt([1 u-1], u, vit_gamma);

acc_gamma=0.001*round(acc_gamma*1000);
acc_gamma = filtfilt([1 u-1], u, acc_gamma);


identifie_parametres;
p_chapeau
difference_p=p_chapeau-[k0;k1;k2;b0;b1;b2;m1;m2;m3]