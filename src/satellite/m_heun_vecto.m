function Y = m_heun_vecto(CI, N, h, f)
    % Initialisation du tableau des solutions (4 variables : x, y, vx, vy)
    Y = zeros(4, N);
    Y(:, 1) = CI;

    for n = 1:N-1
        k1 = f(0, Y(:, n));               % Première estimation
        k2 = f(0, Y(:, n) + h * k1);      % Estimation corrigée

        Y(:, n+1) = Y(:, n) + (h/2) * (k1 + k2);
    end
end