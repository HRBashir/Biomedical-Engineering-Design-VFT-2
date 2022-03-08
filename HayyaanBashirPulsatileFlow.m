%Toolkit for Pulsatile blood flow in arteries
%Hayyaan Bashir & Liam Brosnan
%8th March 2022

%Used to generate pulsatile blood flow profile
%With Navier-Stokes Equations

%Pulsatile blood flow is the rhythmic, intermittent propagation of fluid
%Same as turbulent blood flow
%Essentially the opposite of laminar flow
%Turbulent flow primarily found in the aorta

%Toolkit uses the function as follows

u=PulsatileFlow(r,ru,mu,freq,p0,pn,phi,timestep,grid)

%r= radius of vessel
%ru= density of fluid
%mu= viscosity of fluid
%freq= frequency of oscillation
%p0= pressure gradient
%pn= array of amplitude parameters
%phi= array of phase change
%timestep= number of time frames 
%grid= number of spacial positions

u=PulsatileFlow(0.001,1060,0.0035,1.4,0,[0.78,1.32,-0.74],[-0.01,-1.45,-0.46],16,32);

%SurfMovie(u) function can then be used to produce a flow velocity
%distribution diagram

SurfMovie(u);

%ta function can also be used to produce an array of wall shear stress on
%the vessel in different time frames

ta(k)=-mu*p0*rtst/2/mu+real(i*kapa/ru/omega/snw)*(CBJ1/CBJ0)*zt(k)