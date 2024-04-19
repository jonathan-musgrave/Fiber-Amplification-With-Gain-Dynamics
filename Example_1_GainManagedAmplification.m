clear all;
% Check to make sure script is working by matching Chen et. al.

run('units.m')
addpath(strcat(cd,'/Plotting Function'))

%% Check doping concentration to Match the absorption at 976 and 920 given the commercial data of yb1200 6/125;
sys = struct; signal = struct; fiber = struct; pumps = struct;
fiber.Type = 'gain'; fiber.RareEarthDopant = 'yb'; fiber.Lz = 5*m;
fiber.DoubleCladded = 'yes'; 
fiber.NT = 15e25; % Match with Liekki Absorption
% fiber.NT = 25e25; % Match with RP fiber Power
% fiber.NT = 1e25; % Match with Chen paper
% Matching with 976;
sys.PlotResults = 'yes';
signal.InterCavityPower = 0;
signal.E0 = 1*pJ;
pumps.lambda = [976,976]*nm; pumps.Direction = {'f','b'}; pumps.Power0 = [5,0]*W;
sys.WinT = 17.5*ps; sys.nt = 2^12;
dz = 0.001;
[sys, signal, fiber, pumps] = Fiber_Prop_Lz_v1(sys, signal, fiber, pumps, dz);


options.units = 'gain';
options.ymin = 0;
options.ymax = 50;
sys = plot_FiberPropResults(sys,signal,pumps,fiber);
sys = plot_PowerOutput(sys,signal,pumps,fiber,options);
fig1 = figure(sys.fignum-1);



rmpath(strcat(cd,'/Plotting Function'))