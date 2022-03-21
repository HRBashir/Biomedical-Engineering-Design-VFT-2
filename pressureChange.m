% Change in Pressure in the Artery

%% Variables

dynamicViscosity = 0.004;   % Dynamic viscosity of blood pascal seconds
lengthA = 0.017             % Length of artery (m)
radiusA = 0.00367;          % Radius of artery (m)
flowRate = 19;              % m^3/s
pi = 3.14;
%% Chagne in Pressure Calculation
detaP = -(8*(dynamicViscosity)*(lengthA)*(flowRate)/(pi)*(radiusA^4))
