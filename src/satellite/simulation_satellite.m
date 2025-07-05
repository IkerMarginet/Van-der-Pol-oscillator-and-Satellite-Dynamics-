% simulation_satellite.m
% Programme principal pour simuler la trajectoire d'un satellite

% Paramètres et Conditions initiales
G = 6.67e-11;  Mt = 5.9736e24;  R0 = 4.223e7;  v0 = 3071;  ms = 1000;
R1 = R0; v1 = 1.2 * v0;
CI1 = [R0; 0; 0; v0]; CI2 = [R1; 0; 0; v1];

% Choix de Tmax et du pas de temps h par l'utilisateur
Tmax = input('Entrez la durée de simulation (s) : ');
h = input('Entrez le pas de temps (s) : ');
N = Tmax / h;

% Définition de la fonction différentielle
f = @(t, Y) [Y(3); Y(4); 
    -G * Mt * Y(1) / (Y(1)^2 + Y(2)^2)^(3/2);
    -G * Mt * Y(2) / (Y(1)^2 + Y(2)^2)^(3/2)];

% Appel de la méthode Heun vectorisée
Y1_h = m_heun_vecto(CI1, N, h, f);
Y2_h = m_heun_vecto(CI2, N, h, f);

% Résolution avec ode23
[t1, sol1] = ode23(f, [0 Tmax], CI1);
[t2, sol2] = ode23(f, [0 Tmax], CI2);

figure;
% Tracé des trajectoires pour CI1
subplot(1,2,1);
plot(Y1_h(1, :), Y1_h(2, :), 'r', 'DisplayName', 'Méthode Heun - CI1');
hold on;
plot(sol1(:,1), sol1(:,2), 'g--', 'DisplayName', 'ode23 - CI1');
hold off;
xlabel('x (m)'); ylabel('y (m)');
title('Trajectoire du satellite - CI1');
legend show;
axis equal;

% Tracé des trajectoires pour CI2
subplot(1,2,2);
plot(Y2_h(1, :), Y2_h(2, :), 'b', 'DisplayName', 'Méthode Heun - CI2');
hold on;
plot(sol2(:,1), sol2(:,2), 'k--', 'DisplayName', 'ode23 - CI2');
hold off;
xlabel('x (m)'); ylabel('y (m)');
title('Trajectoire du satellite - CI2');
legend show;
axis equal;