# Numerical Simulation of Differential Equations with MATLAB

## 📘 Project Overview

This project presents a numerical study of differential equations using MATLAB, applied to two distinct dynamic systems:

1. **The Van der Pol Oscillator** – investigation of nonlinear oscillations for various initial conditions and damping parameters (ε).
2. **Satellite Orbital Dynamics** – simulation of a satellite orbiting the Earth under gravitational influence, including an extension with lunar perturbation.

The numerical methods implemented are:
- **Euler's method**
- **Heun's method**
- MATLAB's built-in solver **`ode23`**

Analyses include phase portraits, error estimation, energy conservation, and the impact of varying parameters on system behavior.

> 🗒️ **Note**: The accompanying report is written in **French**.

---

## 📁 Repository Contents

- `simulation_vanderpol.m`: Van der Pol oscillator simulation
- `simulation_satellite.m`: Satellite orbit simulation
- `m_heun_vecto.m`: Vectorized Heun method implementation
- `calculer_energie.m`: Function to compute mechanical energy
- `rapport.pdf`: Full project report with explanations, plots, and physical interpretations (in French)
- `README.md`: Project description

---

## ⚙️ Features

- User-defined time duration and time step
- Comparison of numerical accuracy (relative error between methods)
- Phase portrait and trajectory plotting
- Mechanical energy analysis and conservation check
- Moon-Earth-satellite interaction modeling

---

## 📊 Sample Results

- **Phase portraits** showing convergence to limit cycles or divergence
- **Orbital trajectories** under different initial conditions
- **Energy variation plots** over long simulations
- **Comparison** between fixed-step (Heun) and adaptive-step (`ode23`) methods
- **Effect of lunar gravity** on satellite paths

---

## 🔍 Possible Extensions

- Implementing 3D motion and orbital inclination
- Including other celestial bodies (e.g. Sun, Jupiter)
- Switching to more advanced integrators like `ode45` or symplectic solvers

---

## 👤 Author

**Iker Marginet Ballester**  
Project completed as part of an introduction to numerical differential equation solving using MATLAB.

---

## 📄 License

This project is freely available for educational use. Please credit the author when reusing or adapting the content.
