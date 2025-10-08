function plot_robot(theta, p)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TRACE DU ROBOT 3R PLAN AVEC DÉCALAGE l0 ET REPÈRE CAMÉRA
    % 
    % p = [l0 l1 l2 l3 theta1_offset theta2_offset theta3_offset xc yc alphac]
    % theta = [theta1 theta2 theta3]
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % --- Extraction des paramètres
    l0 = p(1); l1 = p(2); l2 = p(3); l3 = p(4);
    o1 = p(5); o2 = p(6); o3 = p(7);
    xc = p(8); yc = p(9); alphac = p(10);

    % --- Angles corrigés
    th1 = theta(1) + o1;
    th2 = theta(2) + o2;
    th3 = theta(3) + o3;

    % --- Positions successives (dans R0)
    O0 = [0 0];                     % base
    O1 = O0 + [0 l0];               % décalage de la base
    O2 = O1 + [l1*cos(th1) , l1*sin(th1)];
    O3 = O2 + [l2*cos(th1+th2) , l2*sin(th1+th2)];
    OT = O3 + [l3*cos(th1+th2+th3) , l3*sin(th1+th2+th3)];

    % --- Création du graphique
    figure; hold on; grid on; axis equal;
    title('Robot 3R plan et repère caméra');
    xlabel('x_0'); ylabel('y_0');

    % --- Tracé du robot dans R0
    plot([O0(1) O1(1) O2(1) O3(1) OT(1)], ...
         [O0(2) O1(2) O2(2) O3(2) OT(2)], 'o-b', 'LineWidth', 2);
    text(OT(1)+0.05, OT(2)+0.05, 'O_T', 'FontWeight', 'bold');

    % --- Tracé du repère de base R0
    quiver(O0(1), O0(2), 0.4, 0, 0, 'r', 'LineWidth', 1.5);
    quiver(O0(1), O0(2), 0, 0.4, 0, 'g', 'LineWidth', 1.5);
    text(O0(1)+0.1, O0(2)+0.1, 'R_0', 'FontWeight', 'bold');

    % --- Tracé du repère terminal R_T
    alphaT = th1 + th2 + th3;
    quiver(OT(1), OT(2), 0.3*cos(alphaT), 0.3*sin(alphaT), 0, 'r', 'LineWidth', 1);
    quiver(OT(1), OT(2), -0.3*sin(alphaT), 0.3*cos(alphaT), 0, 'g', 'LineWidth', 1);
    text(OT(1)+0.1, OT(2)+0.1, 'R_T', 'FontWeight', 'bold');

    % --- Tracé du repère caméra (indépendant)
    Oc = [xc, yc];
    quiver(Oc(1), Oc(2), 0.5*cos(alphac), 0.5*sin(alphac), 0, 'r', 'LineWidth', 1.5);
    quiver(Oc(1), Oc(2), -0.5*sin(alphac), 0.5*cos(alphac), 0, 'g', 'LineWidth', 1.5);
    text(Oc(1)+0.1, Oc(2)+0.1, 'R_c', 'FontWeight', 'bold');

    % --- Limites d'affichage
    axis([-1.5 3 -1 3]);
    legend({'Liens du robot', 'x_0', 'y_0', 'x_c', 'y_c'}, 'Location','best');
end
