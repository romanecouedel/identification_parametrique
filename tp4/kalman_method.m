function kalman_method()
load("releve_vit_cste_axe2.mat");

%% Paramètres connus a priori
kc2 = 0.0525;  % constante de couple axe 2
N2 = 4.5;      % inverse du rapport de réduction de l’axe 2

kc1 = 0.0525;
N1 = 20.25;

%% --- Plot initial ---
figure(1)
clf;
h = plot3(q2, qpfil2, kc2 * N2 * ifil2, 'x');
set(h, 'LineWidth', 1.5);
hold on;
title('Relation entre position, vitesse et couple de l''axe 2');
legend('\Gamma_2 filtré', 'modèle');
grid on;
xlabel('$q_2$', 'Interpreter', 'latex');
ylabel('$\dot{q}_2$', 'Interpreter', 'latex');
zlabel('$\tau$', 'Interpreter', 'latex');

%% --- Paramètres généraux ---
n = 4; % nombre de paramètres
maxIter = 20000;

Rk_values = [0.01, 0.1, 0.5, 1];
Qk_values = [0.01, 0.1, 0.5, 1];

%% ======================================================
% ========== FIGURE 1 : Effet de Rk =====================
%% ======================================================

theta_hist_all_Rk = zeros(maxIter, n, length(Rk_values));

for r = 1:length(Rk_values)
    Rk = Rk_values(r);
    Qk = 0; % Qk fixe ici
    theta = zeros(n,1);
    P = 1;

    for k = 1:maxIter
        yk = kc2 * N2 * ifil2(k);
        Ak = [cos(q2(k)), sign(qpfil2(k)), qpfil2(k), 1];

        e = yk - Ak * theta;
        S = Ak * (P+Qk) * Ak' + Rk;
        Kk = (P+Qk) * Ak' / S;
        theta = theta + Kk * e;
        P = (eye(n) - Kk * Ak) * (P + Qk);

        theta_hist_all_Rk(k,:,r) = theta';
    end
end

% --- Tracé ---
figure;
for i = 1:n
    subplot(n,1,i);
    hold on; grid on;
    for r = 1:length(Rk_values)
        plot(1:maxIter, theta_hist_all_Rk(:,i,r), 'LineWidth', 1.5, ...
            'DisplayName', sprintf('Rk=%.2f', Rk_values(r)));
    end
    xlabel('Itération');
    ylabel(sprintf('\\theta_%d', i));
    title(sprintf('Évolution de \\theta_%d pour différentes valeurs de Rk', i));
    legend show;
end

%% ======================================================
% ========== FIGURE 2 : Effet de Qk =====================
%% ======================================================

theta_hist_all_Qk = zeros(maxIter, n, length(Qk_values));

for q = 1:length(Qk_values)
    Qk = Qk_values(q);
    Rk = 1; % Rk fixe ici
    theta = zeros(n,1);
    P = eye(n);

    for k = 1:maxIter
        yk = kc2 * N2 * ifil2(k);
        Ak = [cos(q2(k)), sign(qpfil2(k)), qpfil2(k), 1];

        e = yk - Ak * theta;
        S = Ak * P * Ak' + Rk;
        Kk = P * Ak' / S;
        theta = theta + Kk * e;
        P = (eye(n) - Kk * Ak) * P + Qk * eye(n);

        theta_hist_all_Qk(k,:,q) = theta';
    end
end

% --- Tracé ---
figure;
for i = 1:n
    subplot(n,1,i);
    hold on; grid on;
    for q = 1:length(Qk_values)
        plot(1:maxIter, theta_hist_all_Qk(:,i,q), 'LineWidth', 1.5, ...
            'DisplayName', sprintf('Qk=%.2f', Qk_values(q)));
    end
    xlabel('Itération');
    ylabel(sprintf('\\theta_%d', i));
    title(sprintf('Évolution de \\theta_%d pour différentes valeurs de Qk', i));
    legend show;
end

end
