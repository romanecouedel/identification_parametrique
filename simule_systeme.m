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

F_alpha_1 = tf([m1, -b0+b1, k0+k1], 1);  % masse m1
F_alpha_2 = tf([ b1, k1 ], 1);        

F_beta_2  = tf([-m2, -(b1+b2), -(k1+k2)], 1);  % masse m2
F_beta_1 = tf([ b1, k1 ], 1);          
F_beta_3 = tf([ b2, k2 ], 1);           

F_gamma_3 = tf([-m3, -b2, -k2], 1);            % masse m3
F_gamma_2 = tf([ b2, k2 ], 1);                 

% Fonctions de transfert G1, G2, G3
G1 = minreal( 1 / ( F_alpha_1 - F_alpha_2*F_beta_2 / ...
                   ( F_beta_1 - F_beta_3*F_gamma_2 / F_gamma_3 ) ) );

G2 = minreal( -F_beta_1 * G1 / ...
              ( F_beta_2 - F_beta_3*F_gamma_2 / F_gamma_3 ) );

G3 = minreal( -F_gamma_2 * G2 / F_gamma_3 );


%% Réponse à un échelon
figure('Name','Réponses du système','NumberTitle','off','Position',[100 100 1200 800]);
% --- Alpha ---
subplot(3,1,1);
[alpha,t] = lsim(G1,f,t);
plot(t, alpha, 'b-', 'LineWidth', 1.5);
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
plot(t, beta, 'r-', 'LineWidth', 1.5);
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
plot(t, gamma, 'g-', 'LineWidth', 1.5);
grid on;
xlabel('Temps (s)','FontSize',12);
ylabel('\gamma (m)','FontSize',12);
title('Réponse de G3 : position \gamma','FontSize',14);
% vitesses et accélérations
[vit_gamma,~] = lsim(tf([1 0],1)*G3,f,t);
[acc_gamma,~] = lsim(tf([1 0 0],1)*G3,f,t);