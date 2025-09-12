%% tailles des mesures
definit_parametres;
close all;

t = 0:0.01:8; % toutes les 10 ms dans le temps de 0 à 8 sec

f = ones(size(t));   % échelon unitaire

alpha = zeros(size(t));
vit_alpha = zeros(size(t));
acc_alpha = zeros(size(t));

beta = zeros(size(t));
vit_beta = zeros(size(t));
acc_beta = zeros(size(t));

gamma = zeros(size(t));
vit_gamma = zeros(size(t));
acc_gamma = zeros(size(t));

%% Définition des fonctions de transfert
% Termes propres et couplages pour chaque masse
s=tf('s');
f1=-k0-k1-(b0+b1)*s-m1*s^2;
f2=k1+b1*s;
f3=k1+b1*s;
f4=-k1-k2-(b1+b2)*s-m2*s^2;
f5=k2+b2*s;
f6=k2+b2*s;
f7=-k2-b2*s-m3*s^2;

% Fonctions de transfert G1, G2, G3
G1 =-1/(f1-f2*f3/(f4-f5*(f6/f7)));

G2 = -f3*G1/(f4-f5*f6/f7);

G3 =-f6*G2/f7;


%% Réponse à un échelon
figure('Name','Réponses du système','NumberTitle','off');
% --- Alpha ---
subplot(3,1,1);
[alpha,t] = lsim(G1,f,t);
step(G1,t)
grid on;
xlabel('Temps (s)','FontSize',12);
ylabel('\alpha (m)','FontSize',12);
title('Réponse de G1 : position \alpha','FontSize',14);
% vitesses et accélérations
[vit_alpha,~] = lsim(tf([1 0],1)*G1,f,t);
[acc_alpha,~] = lsim(tf([1 0 0],1)*G1,f,t);

% --- Beta ---
subplot(3,1,2);
[beta,~] = lsim(G2,f,t);
step(G2, t);
grid on;
xlabel('Temps (s)','FontSize',12);
ylabel('\beta (m)','FontSize',12);
title('Réponse de G2 : position \beta','FontSize',14);
% vitesses et accélérations
[vit_beta,~] = lsim(tf([1 0],1)*G2,f,t);
[acc_beta,~] = lsim(tf([1 0 0],1)*G2,f,t);

% --- Gamma ---
subplot(3,1,3);
[gamma,~] = lsim(G3,f,t);
step(G3, t);
grid on;
xlabel('Temps (s)','FontSize',12);
ylabel('\gamma (m)','FontSize',12);
title('Réponse de G3 : position \gamma','FontSize',14);
% vitesses et accélérations
[vit_gamma,~] = lsim(tf([1 0],1)*G3,f,t);
[acc_gamma,~] = lsim(tf([1 0 0],1)*G3,f,t);