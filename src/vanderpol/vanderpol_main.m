% vanderpol_main.m
% Programme principal pour simuler l'oscillateur de Van der Pol avec Euler et Heun

clc; clear; close all;

% Paramètres (pas, temps et iterations) et conditions initiales
epsilon = 2;
T = input('Entrez la durée de simulation (s) : '); % 50 bon temps
h = input('Entrez le pas de temps (s) : '); % 0.01 pas ideal
N = T / h;

% Conditions initiales : [theta_0, omega_0]
CI = [0.5, 0.0; 1.0, -2.5];

% Fonction "anonyme" f(theta, omega)
f = @(theta, omega) epsilon * (1 - theta^2) * omega - theta;

% Boucle sur les conditions initiales
for i = 1:size(CI, 1)
    % Initialisation des variables pour Euler et Heun
    theta_e = zeros(1, N);  omega_e = zeros(1, N);
    theta_h = zeros(1, N);  omega_h = zeros(1, N);

    % Conditions initiales
    theta_e(1) = CI(i, 1);  omega_e(1) = CI(i, 2);
    theta_h(1) = CI(i, 1);  omega_h(1) = CI(i, 2);

    % Boucle Euler
    for n = 1:N-1
        theta_e(n+1) = theta_e(n) + h * omega_e(n);
        omega_e(n+1) = omega_e(n) + h * f(theta_e(n), omega_e(n));
    end

    % Boucle Heun
    for n = 1:N-1
        i1_theta = h * omega_h(n);    
        i1_omega = h * f(theta_h(n), omega_h(n));    
        
        i2_theta = h * (omega_h(n) + i1_omega);    
        i2_omega = h * f(theta_h(n) + i1_theta, omega_h(n) + i1_omega);    
        
        theta_h(n+1) = theta_h(n) + 0.5 * (i1_theta + i2_theta);    
        omega_h(n+1) = omega_h(n) + 0.5 * (i1_omega + i2_omega);
    end

    % Tracer les résultats pour les deux méthodes
    figure;
    plot(theta_e, omega_e, 'DisplayName', 'Euler');
    hold on;
    plot(theta_h, omega_h, 'DisplayName', 'Heun');
    title(['Portrait de phase pour les CI']);
    xlabel('\theta');  ylabel('\omega');
    legend;
    hold off;
end

% Analyse d'erreurs
h_err = 10.^(-2:-1:-6);
erreurs = [];

for j = 1:length(h_err)
    h = h_err(j);
    N = T / h;
    
    % Ré-exécuter les boucles pour chaque h
    for i = 1:size(CI, 1)
        % Initialisation des variables pour Euler et Heun
        theta_e = zeros(1, N);  omega_e = zeros(1, N);
        theta_h = zeros(1, N);  omega_h = zeros(1, N);

        % Conditions initiales
        theta_e(1) = CI(i, 1);  omega_e(1) = CI(i, 2);
        theta_h(1) = CI(i, 1);  omega_h(1) = CI(i, 2);

        % Boucle Euler
        for n = 1:N-1
            theta_e(n+1) = theta_e(n) + h * omega_e(n);
            omega_e(n+1) = omega_e(n) + h * f(theta_e(n), omega_e(n));
        end

        % Boucle Heun
        for n = 1:N-1
            i1_theta = h * omega_h(n);    
            i1_omega = h * f(theta_h(n), omega_h(n));    
            
            i2_theta = h * (omega_h(n) + i1_omega);    
            i2_omega = h * f(theta_h(n) + i1_theta, omega_h(n) + i1_omega);    
            
            theta_h(n+1) = theta_h(n) + 0.5 * (i1_theta + i2_theta);    
            omega_h(n+1) = omega_h(n) + 0.5 * (i1_omega + i2_omega);
        end

        % Calcul de l'erreur relative
        theta_th = max(theta_h);
        theta_exp = max(theta_e);
        err_rel = abs((theta_exp - theta_th) / theta_th);
        erreurs = [erreurs, err_rel];
    end

    % Tracé des solutions en fonction du temps
    t = 0:h:T-h;
    figure;
    plot(t, theta_e, 'r', 'DisplayName', 'Euler');
    hold on;
    plot(t, theta_h, 'b', 'DisplayName', 'Heun');
    xlabel('Temps (s)');
    ylabel('\theta');
    title(['Évolution de \theta en fonction du temps pour h = ', num2str(h)]);
    legend;
    grid on;
    hold off;
end

% Affichage du tableau des erreurs
fprintf('h Erreur Relative\n');
for i = 1:length(h_err)
    fprintf('%e %e\n', h_err(i), erreurs(i));
end

% Tracé unique de log(erreur relative) vs log(h)
figure;
loglog(h_err, erreurs, '-o');
xlabel('log(h)');
ylabel('log(erreur relative)');
title('Erreur relative en fonction du pas de temps h');