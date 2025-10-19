function robustness_study()
    p_real = [0.2 0.3 0.2 0.1 -0.1 0.08 0.1 0.03 0.025 0.6];
    N = 10;               % nombre de mesures
    sigma_theta = 0.01;   % bruit articulaire
    sigma_X = 0.005;      % bruit cartésien
    num_trials = 20;      % tirages aléatoires

    err_results = zeros(num_trials,1);

    for trial = 1:num_trials
        % --- Générer mesures avec bruit ---
        data = struct([]);
        for i = 1:N
            th = 2*pi*rand(3,1);
            th_noisy = th + sigma_theta*randn(3,1);
            X = mod_geom(th, p_real);
            X_noisy = X + sigma_X*randn(size(X));
            data(i).theta = th_noisy;
            data(i).cartesien = X_noisy;
        end

        % --- Initialisation aléatoire ---
        p_hat = p_real + 0.1*rand(1,10);
        k_max = 20;

        % --- Boucle d’identification ---
        for k = 1:k_max
            err_all = [];
            J_all = [];
            for i = 1:N
                th = data(i).theta;
                X  = data(i).cartesien;
                X_model = mod_geom(th, p_hat);
                err = X - X_model;
                J = jacobien(th, p_hat);
                err_all = [err_all; err];
                J_all = [J_all; J];
            end
            Dp = pinv(J_all)*err_all;
            p_hat = p_hat + Dp';
        end

        err_results(trial) = mean((p_hat - p_real).^2);
    end

    % --- Analyse ---
    fprintf('Erreur finale moyenne : %.6e\n', mean(err_results));
    fprintf('Écart type des erreurs : %.6e\n', std(err_results));
    histogram(err_results,10);
    xlabel('Erreur finale');
    ylabel('Nombre de trials');
    title('Robustesse de l’identification avec bruit et initialisation aléatoire');
end
