% Average Blood Flow for adult is 1m/sec

%% Variables
pi = 3.14;
deltaP = 40; % change in pressure (mmHg)
r = 625;     % radius (mm)
eta = 4;     % viscosity (Pascals seconds) * Need to know the unit converstion
lambda = 17; % length of vessel (mm)

%% Hagen - Poiseuille Flow Equation
bf = ((pi)*(deltaP)*r)/(8*(eta)*(lambda)) % Units = m/sec

