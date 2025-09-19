%% CE PROGRAMME PERMET D'IDENTIFIER LES PARAMETRES DU MODELE
%% DE L'AXE 2 POUR DES MOUVEMENTS A VITESSE CONSTANTE
%% G. MOREL - 29-12-05.
%% M. Khoramshahi 02-02-2023

%close all
%clc
%clear all; %% efface toutes les variables existantes
load releve_vit_cste_axe1; %% charge les relevés expérimentaux

%% Paramètres connus a priori:
kc2=0.0525; %% constante de couple de l'axe 2.
N2=4.5; %% inverse du rapport de réduction de l'axe 2.

kc1=0.0525;
N1=20.25;
%% Construction de la matrice Y.
for k=1:29344
    i=randi(29344);
    Y1(k,:) = [cos(q1(i)) sign(qp1(i)) qp1(i) 1 ];
    u1(k,:) = N1*kc1*i1(i);
end

%% Calcul des paramètres
p1=inv(Y1'*Y1)*Y1'*u1;
%% Affichage des résultats.
format long
disp('Paramètres estimés à partir des données brutes :');
%p'
p1'
figure(1)
clf; %% clear figure
h=plot3(q1,qp1,kc1*N1*i1,'x');
set(h,'LineWidth',0.5);
hold on; %% permet de conserver le graphique et d'en ajouter d'autres sur la même fig.
%h=plot3(q1,qp1,Y1*p1,'.');
set(h,'LineWidth',1.5);
title('Résultats de l''identification sans filtrage');
legend('\Gamma_2 non filtré', 'modèle');
grid on;
xlabel('$q_2$','Interpreter','latex')
ylabel('$\dot{q}_2$','Interpreter','latex')
zlabel('$\tau$','Interpreter','latex')


%% Extra plots to check the quality of the identification

figure;
qqplot(Y1*p1-u1)
grid on
axis equal
axis square

figure;
plot(u1,Y1*p1,'.')
hold on
plot([min(u) max(u)],[min(u) max(u)],'--g','LineWidth',2)
grid on
xlabel('$y$','Interpreter','latex','FontSize',16)
ylabel('$\hat{y}$','Interpreter','latex','FontSize',16)
xlim([-0.25 0.25])
ylim([-0.25 0.25])
axis equal
axis square