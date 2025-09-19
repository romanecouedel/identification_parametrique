clear all;
load releve_mvts_combines;

%% constantes connues
kc1=0.0525;
N1=20.25;
kc2=0.0525;
N2=4.5;

%% Param�tres identifi�s � vitesse constante
%% Pour l'axe 1 : 
alpha1=??;
a1=??;
b1=??;
c1=??;
%% Pour l'axe 2 :
alpha2=??;
a2=??;
b2=??;
c2=??;

%% identification � partir des donn�es filtr�es
for(i=1:length(t)) 
    Z(2*i-1:2*i,1:3)=[?? ?? ??
        ?? ?? ??];
    u(2*i-1,1)=??;
    u(2*i,1)=??;
end

p=??;
format long
disp('Param�tres estim�s � partir des donn�es filtr�es :');
p'

% reconstruction du modele complet
p1=p(1);
p2=p(2);
p3=p(3);

for(i=1:length(t)) 
    %% couple d'inertie
    ciner(2*i-1,1)=??; %% AXE 1 
    ciner(2*i,1)=??; %%AXE 2
    %% couple centrifuge
    ccentri(2*i-1,1)=??; %% AXE 1
    ccentri(2*i,1)=??; %% AXE 2
    %% couple de gravit�
    cgravi(2*i-1,1) = ??; %% AXE 1
    cgravi(2*i,1) = ??; %% AXE 2
    %% couple de frottements
    cfrott(2*i-1,1)=??; %% AXE 1
    cfrott(2*i,1)=??; %% AXE 2
    %% couple total
    ctotal(2*i-1:2*i,1)=ciner(2*i-1:2*i,1)+ccentri(2*i-1:2*i,1)+cgravi(2*i-1:2*i,1)+cfrott(2*i-1:2*i,1);
end

%% Affichage des commandes.
figure(1) %% pour l'axe 1
clf
hold on
grid on
h=plot(t,N1*kc1*i1,'y');
h=plot(t,N1*kc1*ifil1,'b');
set(h,'LineWidth',1.5);
h=plot(t,ciner(1:2:length(ctotal)),'r');
set(h,'LineWidth',1.5);
h=plot(t,cgravi(1:2:length(ctotal)),'m');
set(h,'LineWidth',1.5);
h=plot(t,ccentri(1:2:length(ctotal)),'k');
set(h,'LineWidth',1.);
h=plot(t,cfrott(1:2:length(ctotal)),'g');
set(h,'LineWidth',1.);
h=plot(t,ctotal(1:2:length(ctotal)),'c--');
set(h,'LineWidth',1.5);
legend('\Gamma_1 mesur�','\Gamma_1 filtr�','inertie','gravit�','centrifuge','frottements','mod�le total');
title('R�sultats axe 1 ; identification � partir de donn�es filtr�es');
figure(2)
clf
hold on
grid on
h=plot(t,N2*kc2*i2,'y');
h=plot(t,N2*kc2*ifil2,'b');
set(h,'LineWidth',1.5);
h=plot(t,ciner(2:2:length(ctotal)),'r');
set(h,'LineWidth',1.5);
h=plot(t,cgravi(2:2:length(ctotal)),'m');
set(h,'LineWidth',1.5);
h=plot(t,ccentri(2:2:length(ctotal)),'k--');
set(h,'LineWidth',1);
h=plot(t,cfrott(2:2:length(ctotal)),'g');
set(h,'LineWidth',1);
h=plot(t,ctotal(2:2:length(ctotal)),'c--');
set(h,'LineWidth',1.5);
legend('\Gamma_2 mesur�','\Gamma_2 filtr�','inertie','gravit�','centrifuge','frottements','mod�le total');
title('R�sultats axe 2 ; identification � partir de donn�es filtr�es');