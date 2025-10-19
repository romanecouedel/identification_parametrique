function p_optimized = resoud_id()
    % ========================================
    % 🔹 Résolution d’un problème d’identification
    % 🔹 Estimation de 10 paramètres via moindres carrés itératifs
    % ========================================
    p=[0.2 0.3 0.2 0.1 -0.1 0.08 0.1 0.03 0.025 0.6]
    creer_data(p)
    % Charger les données
    load("base.mat"); % 'data' doit contenir .theta et .cartesien

    % Paramètres initiaux
    np = 10;                         % nombre de paramètres à estimer
    p_hat = rand(1, np);             % estimation initiale aléatoire
    k_max = 20;                      % nombre max d’itérations

    % Historique
    P_history = zeros(k_max, np);
    E_history = zeros(k_max, 1);

    % Boucle principale d’estimation
    for k = 1:k_max
        err_all = [];
        J_all = [];

        % Parcourir chaque expérience
        for i = 1:length(data)
            th = data(i).theta';        % angles (vecteur)
            X  = data(i).cartesien';    % mesures (vecteur)

            % Calcul du modèle et du jacobien sur tout le vecteur
            X_model = mod_geom(th, p_hat);
            err = X - X_model;                     % vecteur d’erreur
            J = jacobien(th, p_hat);               % matrice N×np

            % Accumulation des résultats
            err_all = [err_all; err];
            J_all = [J_all; J];
        end

        % Mise à jour du vecteur de paramètres
        Dp = pinv(J_all) * err_all;                % estimation incrémentale
        p_hat = p_hat + Dp';                       % mise à jour des 10 paramètres

        % Historique
        P_history(k, :) = p_hat;
        E_history(k) = mean(err_all.^2);

        fprintf('Itération %d | Erreur = %.6f\n', k, E_history(k));
    end

    % Résultat final
    p_optimized = p_hat

    % ========================================
    % 🔹 Visualisation du coût J(p1) et de l’évolution de p1
    % ========================================

    figure;
    PHAT = 0:0.01:1;          % valeurs test pour p1
    Jcost = zeros(size(PHAT));

    % On fixe les autres paramètres à leur valeur finale
    th = data(1).theta';
    X = data(1).cartesien';

    for k = 1:length(PHAT)
        p_test = p_optimized;
        p_test(1) = PHAT(k);                  % on fait varier le 1er paramètre
        X_model = mod_geom(th, p_test);
        ERROR = X - X_model;
        Jcost(k) = mean(ERROR.^2);
    end

    % === Tracé principal ===
    plot(PHAT, Jcost, 'b', 'LineWidth', 2);
    hold on;
    grid on;

    figure;
    hold on; grid on;

    % Tracer l'évolution de chaque paramètre au fil des itérations
    for j = 1:np
        plot(1:k_max, P_history(:, j), 'LineWidth', 1.5);
        plot(k_max, P_history(end, j), 'xr', 'MarkerSize', 10, 'LineWidth', 1.5); % marqueur final
    end

    xlabel('Itérations');
    ylabel('Valeurs des paramètres estimés');
    title('Évolution et valeurs finales des 10 paramètres estimés');
    legend(arrayfun(@(j) sprintf('p_%d', j), 1:np, 'UniformOutput', false), ...
           'Location', 'bestoutside');
end
