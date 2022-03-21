close all; clc;
%initial parameters
%we will take the non-linear Navier-Stokes equation for conservation of mass and linearize them.
Nx = 100;
xmin = 0;
xmax = 1;
tmin = 0;
tmax = 100;
period = 0.4;
omega = 2*pi/period;
safety = 0.45; % have this less than 0.5

%conditions
A0 = .5;
beta = 10;
rho = 1;
P0=0;
c = sqrt(beta/(2*rho))*A0^(1/4);
FA = @(A,Q) Q;
FQ = @(A,Q) (beta/(2*rho))*sqrt(A0)*A;

%mesh in time and space
dx = (xmax-xmin)/(Nx+2);
dt = safety*dx/c;
Nt = floor(tmax/dt);

%Riemann invariant
l1 = c;
l2 = -c;
W1 = @(A,Q) ((Q/A0) + (c/A0)*A);
W2 = @(A,Q) ((Q/A0) - (c/A0)*A);
xvec = linspace(xmin,xmax,Nx+2);
tvec = linspace(tmin,Nt*dt,Nt);
Avec = zeros(Nx+2,1);
Qvec = zeros(Nx+2,1);
Avec_old = zeros(Nx+2,1);
Qvec_old = zeros(Nx+2,1);
Avec_poshalf = zeros(Nx+2,1);
Qvec_poshalf = zeros(Nx+2,1);
Avec_neghalf = zeros(Nx+2,1);
Qvec_neghalf = zeros(Nx+2,1);

%initial condition
for x = 1:length(xvec)
Avec(x,1) = A0;
Qvec(x,1) = 0.0;
end
Qmat=zeros(1,length(tvec));
Amat=zeros(1,length(tvec));
Pmat=zeros(1,length(tvec));

%Lax-Wendroff Scheme 2 step
for t = 1:length(tvec)-1
    disp(tvec(t))

    % compute extrapolated Riemann invariants
    xleft = xmin-l2*dt; % computing the tails of the characteristic curves.
    xright = xmax-l1*dt;
    Aleft = interp1(xvec,Avec(:,1),xleft);
    Qleft = interp1(xvec,Qvec(:,1),xleft);
    Aright = interp1(xvec,Avec(:,1),xright);
    Qright = interp1(xvec,Qvec(:,1),xright);
    W2left = W2(Aleft,Qleft);
    W1right = W1(Aright,Qright);
    
    % populate boundary conditions
    Qvec(1,1) = A0*W2left + Avec(1,1)*c;
    Qvec(end,1) = A0*W1right - Avec(end,1)*c;
    
    % store previous timestep
    Avec_old = Avec;
    Qvec_old = Qvec;
    
    %interior points
    for x = 2:length(xvec)-1
    Avec_poshalf(x,1) = .5*(Avec_old(x+1,1)+Avec_old(x,1))-(dt/(2*dx))*(FA(Avec_old(x+1,1),Qvec_old(x+1,1))-FA(Avec_old(x,1),Qvec_old(x,1)));
    Avec_neghalf(x,1) = .5*(Avec_old(x,1)+Avec_old(x-1,1))-(dt/(2*dx))*(FA(Avec_old(x,1),Qvec_old(x,1))-FA(Avec_old(x-1,1),Qvec_old(x-1,1)));
    Qvec_poshalf(x,1) = .5*(Qvec_old(x+1,1)+Qvec_old(x,1))-(dt/(2*dx))*(FQ(Avec_old(x+1,1),Qvec_old(x+1,1))-FQ(Avec_old(x,1),Qvec_old(x,1)));
    Qvec_neghalf(x,1) = .5*(Qvec_old(x,1)+Qvec_old(x-1,1))-(dt/(2*dx))*(FQ(Avec_old(x,1),Qvec_old(x,1))-FQ(Avec_old(x-1,1),Qvec_old(x-1,1)));
    end
    
    for x = 2:length(xvec)-1
    Avec(x,1) = Avec_old(x,1)-(dt/dx)*(FA(Avec_poshalf(x,1),Qvec_poshalf(x,1))-FA(Avec_neghalf(x,1),Qvec_neghalf(x,1)));
    Qvec(x,1) = Qvec_old(x,1)-(dt/dx)*(FQ(Avec_poshalf(x,1),Qvec_poshalf(x,1))-FQ(Avec_neghalf(x,1),Qvec_neghalf(x,1)));
    end
    
    % set boundary conditions for A
    if tvec(t)<period
    Avec(1,1) = ((sin(omega*tvec(t+1))/beta-P0/beta) + sqrt(A0))^2;
    Avec(end,1) = A0;
    else
    Avec(1,1)=A0;
    Avec(end,1)=A0;
    end
    
    Avec(1,1) = ((sin(omega*tvec(t+1))/beta-P0/beta) + sqrt(A0))^2;
    Avec(end,1) =A0;
    %Calculate flow in the future
    Qvec(1,1) = A0*W2left + Avec(1,1)*c;
    Qvec(end,1) = A0*W1right - Avec(end,1)*c;

    figure(1)
    subplot(2,1,1), plot(xvec,Qvec(:,1),'linewidth',4);
    ylim([-1 3])
    title("Flow v. Position");
    xlabel("Position");
    ylabel("Flow");
    subplot(2,1,2), plot(xvec,Avec(:,1),'linewidth',4);
    ylim([0 2])
    title("Area v. Position");
    xlabel("Position");
    ylabel("Area of Vessel");
    
    pause(0.001)
    Qmat(1,t)=Qvec(floor(Nx/2),1);
    Amat(1,t)=Avec(floor(Nx/2),1);
    Pmat(1,t)=P0 + beta.*(sqrt(Avec(floor(Nx/2),1)) - sqrt(A0));
end

figure(2)
plot(tvec,Qmat(1,:)); hold on
title("Flow over Time");
xlabel("Time");
ylabel("Flow");

figure(3)
plot(tvec,Amat(1,:)); hold on
title("Area over Time");
xlabel("Time");
ylabel("Area of Vessel");

figure(4)
plot(tvec,Pmat(1,:)); hold on
title("Pressure over Time");
xlabel("Time");
ylabel("Pressure");