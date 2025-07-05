% satellite_lune.m
% Programme principal pour simuler les trajectoires du satellite et de la Lune

% Paramètres physiques
G = 6.67e-11;  Mt = 5.9736e24;  ms = 1000; % Définir ms pour cohérence
Ml = Mt / 81;  R2 = 4e8;
Tmax = input('Entrez la durée de simulation (s) : ');
h = input('Entrez le pas de temps (s) : ');
N = Tmax / h;

% Conditions initiales pour le satellite (CI1 de simulation_satellite.m)
R0 = 4.223e7;  v0 = 3071;
CI1 = [R0; 0; 0; v0];

% Conditions initiales de la Lune (orbite circulaire autour de la Terre)
v_lune = sqrt(G * Mt / R2);
CIL = [R2; 0; 0; v_lune];

% Définition de la fonction différentielle avec la Terre, la Lune et le satellite
f_sat = @(t, Y) [Y(3); Y(4);
-G * Mt * Y(1) / (Y(1)^2 + Y(2)^2)^(3/2) - G * Ml * (Y(1) - CIL(1)) / ((Y(1) - CIL(1))^2 + (Y(2) - CIL(2))^2)^(3/2);
-G * Mt * Y(2) / (Y(1)^2 + Y(2)^2)^(3/2) - G * Ml * (Y(2) - CIL(2)) / ((Y(1) - CIL(1))^2 + (Y(2) - CIL(2))^2)^(3/2)];

f_lune = @(t, Y) [Y(3); Y(4);
-G * Mt * Y(1) / (Y(1)^2 + Y(2)^2)^(3/2);
-G * Mt * Y(2) / (Y(1)^2 + Y(2)^2)^(3/2)];

% Résolution par la méthode de Heun pour le satellite
s_h_s = m_heun_vecto(CI1, N, h, f_sat);

% Résolution par la méthode de Heun pour la Lune
s_h_l = m_heun_vecto(CIL, N, h, f_lune); % Correction : variable renommée s_h_l pour éviter écrasement

% Résolution avec ode23
[t, s_ode_sat] = ode23(f_sat, [0 Tmax], CI1);
[t, s_ode_lune] = ode23(f_lune, [0 Tmax], CIL);

% Tracé des trajectoires  
figure; hold on; grid on; axis equal;  
plot(s_h_s(1, :), s_h_s(2, :), 'y', 'DisplayName', 'Satellite - Heun');  
plot(s_ode_sat(:,1), s_ode_sat(:,2), 'g--', 'DisplayName', 'Satellite - ode23');  
plot(s_h_l(1, :), s_h_l(2, :), 'b', 'DisplayName', 'Lune - Heun'); % Correction : s_h_l
plot(s_ode_lune(:,1), s_ode_lune(:,2), 'p--', 'DisplayName', 'Lune - ode23');  
plot(0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', 'Terre');  

xlabel('x (m)'); ylabel('y (m)');  
title('Trajectoires du satellite et de la Lune autour de la Terre');  
legend show;  
xlim([-1.5*R2, 1.5*R2]); ylim([-1.5*R2, 1.5*R2]);