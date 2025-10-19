function resoud_id()
    load("base.mat"); % contient 'data'
    N = length(data);
  
    phat = rand(1,10)
    
   
    for iter = 1:20
        J = [];      
        ERROR = []; 
        
        for i = 1:N
            th = data(i).theta';      
            x = data(i).cartesien'; 
            
            x_model = mod_geom(th, phat);
            e = x - x_model;           % vecteur d'erreur
            
            % Calcul du Jacobien pour cette mesure
            Jj = jacobien(th, phat)
            
            % Empiler les données
            J = [J; Jj];
            ERROR = [ERROR; e];
        end
        
        % Calcul de la mise à jour des paramètres
        dp = pinv(J) * ERROR;
        
        % Mise à jour des paramètres estimés
        phat = phat + dp';
        
   
    end

end