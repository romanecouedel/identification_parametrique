clear all
load releve_mvts_combines;
ident_axe1_v_cste
ident_axe2_v_cste

%% constantes connues
kc1=0.0525;
N1=20.25;
kc2=0.0525;
N2=4.5;

%% Paramètres identifiés à vitesse constante
%% Pour l'axe 1 : 
alpha1=p11(1);
a1=p11(2);
b1=p11(3);
c1=p11(4);
%% Pour l'axe 2 :
alpha2=p(1);
a2=p(2);
b2=p(3);
c2=p(4);

%% identification à partir des données filtrées
for(i=1:7992) 
    
    Z(2*i-1:2*i,1:3)=[qpp1(i) qpp2(i)*cos(q1(i)-q2(i))-(qp2(i)^2)*sin(q2(i)-q1(i)) 0 
        0 qpp2(i)*cos(q2(i)-q1(i))+(q1(i)^2)*sin(q2(i)-q1(i)) qpp2(i)];
    u(2*i-1,1)=N1*kc1*i1(i)-alpha1*cos(q1(i))-a1*sign(q1(i))-b1*qp1(i)+c1;
    u(2*i,1)=N2*kc2*i2(i)-alpha2*cos(q2(i))-a2*sign(q2(i))-b2*qp2(i)+c2;
end

p=inv(Z'*Z)*Z'*u;
format long
disp('Paramètres estimés à partir des données filtrées :');
p';

% reconstruction du modele complet
p1=p(1)
p2=p(2)
p3=p(3)

for(i=1:length(t)) 
    %% couple d'inertie
    ciner(2*i-1,1)=N1*kc1*i1(i); %% AXE 1 
    ciner(2*i,1)=N2*kc2*i2(i); %%AXE 2
    %% couple centrifuge
    ccentri(2*i-1,1)=alpha1*cos(q1(i)); %% AXE 1
    ccentri(2*i,1)= alpha2*cos(q2(i));
    %% couple de gravité
    cgravi(2*i-1,1) = a1*sign(q1(i))+b1*qp1(i)+c1; %% AXE 1
    cgravi(2*i,1) = a2*sign(q2(i))+b2*qp2(i)+c2; %% AXE 2
    %% couple de frottements
    cfrott(2*i-1,1)=a1*sign(q1(i))+b1*q1(i)+c1; %% AXE 1
    cfrott(2*i,1)=a2*sign(q2(i))+b2*q2(i)+c2; %% AXE 2
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
legend('\Gamma_1 mesuré','\Gamma_1 filtré','inertie','gravité','centrifuge','frottements','modèle total');
title('Résultats axe 1 ; identification à partir de données filtrées');
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
legend('\Gamma_2 mesuré','\Gamma_2 filtré','inertie','gravité','centrifuge','frottements','modèle total');
title('Résultats axe 2 ; identification à partir de données filtrées');