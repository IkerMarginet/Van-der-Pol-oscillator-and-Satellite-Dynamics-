% calculer_energie.m
% Fonction pour calculer l'énergie mécanique

function E = calculer_energie(vx, vy, x, y, ms, G, Mt)
    E = 0.5 * ms * (vx.^2 + vy.^2) - ms * G * Mt ./ sqrt(x.^2 + y.^2);
end