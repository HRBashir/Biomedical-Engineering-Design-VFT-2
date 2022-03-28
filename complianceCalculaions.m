%% title: Compliance Calculations at varying volumes
% Authors: Hayaan & Liam 
% Description: 
% Pulse pressure method calculation. Change in pressure is assumed to be 
% systolic and diastolic pressure. Compliance increases as volume increases
% and remains constant at 40mmHg. Drawing the graph by hand, there is a gap
% in the y-axis, this shows a systematic error of 60 %. A systematic error
% is a consistent error that will never disapear no matter how many times
% the experiment is repeated.


%% Future work
% Have graph start the y-axis at 0 to show the systematic error
% Continue to look into pulse wave velocity (PWV) and how that can be used
% to measure compliance
%% Clear function
clear all 
close all 
clc
%% Variables 
deltaP = 40;     % Pressure difference from systolic to diastolic (mmHg)
v1 = 90;         % Volume between 60 - 100 ml/beat (cm^3)        
v2 = 60;
v3 = 70;
v4 = 80;
v5 = 90;
v6 = 100;

%% Compliance Calculations
c1 = v1 / deltaP;   % Compliance of a vessel (cm^3 / mmHg)
c2 = v2 / deltaP; 
c3 = v3 / deltaP;
c4 = v4 / deltaP; 
c5 = v5 / deltaP;
c6 = v6 / deltaP;

complianceArray = [c1 c2 c3 c4 c5 c6];
volumeArray = [v1 v2 v3 v4 v5 v6];
%% Output
complianceTable = table(c1,c2,c3,c4,c5,c6)   % Table of compliance for varying volumes
plot(complianceArray,volumeArray)            % Plot of volume vs compliance
xlabel('Compliance (cm^3 / mmHg)');
ylabel('Volume (cm^3)');
title ('Compliance vs Volume')