function p_optimized = resoud_id_final()
    % ========================================
    % 🔹 Identification de 10 paramètres via moindres carrés itératifs
    % 🔹 Génération de 10 mesures et récupération exacte des paramètres
    % ========================================

    % --- Paramètres réels ---
    p_real = [0.2 0.3 0.2 0.1 -0.1 0.08 0.1 0.03 0.025 0.6];

    % --- Création des données ---
    N = 10; % nombre de mesures
    for i = 1:N
        th = 2*pi*rand(3,1);  % vecteur colonne 3x1
        data(i).theta = th;
        data(i).cartesien = mod_geom(th, p_real);
    end
    save('base.mat', 'data');

    % --- Chargement des données ---
    load('base.mat');

    % --- Initialisation de l'estimation ---
    np = 10;
    p_hat = p_real + 0.1*rand(1,np); % estimation initiale différente
    k_max = 20;

    % --- Historique ---
    P_history = zeros(k_max, np);
    E_history = zeros(k_max,1);

    % --- Boucle d'estimation ---
    for k = 1:k_max
        err_all = [];
        J_all = [];

        for i = 1:length(data)
            th = data(i).theta;
            X  = data(i).cartesien;

            X_model = mod_geom(th, p_hat);
            err = X - X_model;
            J = jacobien(th, p_hat);

            err_all = [err_all; err];
            J_all   = [J_all; J];
        end

        Dp = pinv(J_all)*err_all;
        p_hat = p_hat + Dp';
        P_history(k,:) = p_hat;
        E_history(k) = mean(err_all.^2);
    end

    % --- Résultat final ---
    p_optimized = p_hat;
    fprintf('Paramètres réels :\n');
    disp(p_real);
    fprintf('Paramètres estimés :\n');
    disp(p_optimized);
    fprintf('Erreur finale moyenne : %.6e\n', mean((p_optimized - p_real).^2));
    fprintf('Rang de la Jacobienne : %d\n', rank(J_all));

    % --- Visualisation ---
    figure;
    PHAT = 0:0.01:1;
    Jcost = zeros(size(PHAT));
    th = data(1).theta;
    X = data(1).cartesien;

    for k = 1:length(PHAT)
        p_test = p_optimized;
        p_test(1) = PHAT(k);
        X_model = mod_geom(th, p_test);
        ERROR = X - X_model;
        Jcost(k) = mean(ERROR.^2);
    end

    plot(PHAT, Jcost, 'b','LineWidth',2);
    hold on; grid on;

    % Affichage de tous les paramètres finaux sur le graphe
    for i = 1:np
        plot(p_optimized(i), mean((X - mod_geom(th, p_optimized)).^2), 'xr', 'MarkerSize',10,'LineWidth',2);
    end

    xlabel('p_1 (ou valeurs finales des paramètres)');
    ylabel('Erreur J(p)');
    title('Coût et paramètres finaux estimés');
    legend('J(p_1)','Paramètres finaux','Location','best');
end
