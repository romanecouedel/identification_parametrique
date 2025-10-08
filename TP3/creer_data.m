function creer_data(p)
    % Fonction pour créer une base de données de positions aléatoires
    % p : paramètre passé à la fonction mod_geom

    for i = 1:10
        th1 = mod(rand(),2 * pi);   % Angle aléatoire entre 0 et 2π
        th2 = mod(rand(),2 * pi); 
        th3 = mod(rand(),2 * pi); 

        theta = [th1, th2, th3];

        % Structure des données
        data(i).theta = theta;  
        x = mod_geom(theta, p);
        X=[x(1),x(2),x(3)];
        data(i).cartesien = X;             
    end

    save('base.mat', 'data');
end
