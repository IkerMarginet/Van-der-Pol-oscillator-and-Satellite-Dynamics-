% calcul_energie.m
% Programme principal pour calculer et tracer l'énergie mécanique du satellite

% Calcul des énergies pour la méthode de Heun
E1_h = calculer_energie(Y1_h(3, :), Y1_h(4, :), Y1_h(1, :), Y1_h(2, :), ms, G, Mt);
E2_h = calculer_energie(Y2_h(3, :), Y2_h(4, :), Y2_h(1, :), Y2_h(2, :), ms, G, Mt);

% Calcul des énergies pour la méthode ode23
E1_ode = calculer_energie(sol1(:, 3), sol1(:, 4), sol1(:, 1), sol1(:, 2), ms, G, Mt);
E2_ode = calculer_energie(sol2(:, 3), sol2(:, 4), sol2(:, 1), sol2(:, 2), ms, G, Mt);

T = linspace(0, 10000, length(E1_h)); % Vecteur temps pour Heun
t1 = linspace(0, 10000, length(E1_ode)); % Vecteur temps pour ode23 (CI1)
t2 = linspace(0, 10000, length(E2_ode)); % Vecteur temps pour ode23 (CI2)

% Tracé des résultats
close all;

% Figure pour la méthode Heun
figure(1);
subplot(2, 1, 1);
plot(T, E1_h, 'r-', 'DisplayName', 'Heun - CI1');
hold on;
plot(T, E2_h, 'b--', 'DisplayName', 'Heun - CI2');
hold off;
xlabel('Temps (s)');
ylabel('Énergie (J)');
title('Comparaison Heun - CI1 et CI2');
legend show;

subplot(2, 1, 2);
plot(t1, E1_ode, 'g-', 'DisplayName', 'ode23 - CI1');
hold on;
plot(t2, E2_ode, 'm--', 'DisplayName', 'ode23 - CI2');
hold off;
xlabel('Temps (s)');
ylabel('Énergie (J)');
title('Comparaison ode23 - CI1 et CI2');
legend show;

figure(2);
subplot(2, 1, 1);
[ax, h1, h2] = plotyy(T, E1_h, t1, E1_ode);
set(h1, 'Color', 'r', 'DisplayName', 'Heun - CI1');
set(h2, 'Color', 'g', 'DisplayName', 'ode23 - CI1');
xlabel('Temps (s)');
ylabel(ax(1), 'Énergie (J)'); ylabel(ax(2), 'Énergie (J)');
title('Comparaison CI1');
legend([h1, h2]);

subplot(2, 1, 2);
[ax, h1, h2] = plotyy(T, E2_h, t2, E2_ode);
set(h1, 'Color', 'b', 'DisplayName', 'Heun - CI2');
set(h2, 'Color', 'm', 'DisplayName', 'ode23 - CI2');
xlabel('Temps (s)');
ylabel(ax(1), 'Énergie (J)'); ylabel(ax(2), 'Énergie (J)');
title('Comparaison CI2');
legend([h1, h2]);