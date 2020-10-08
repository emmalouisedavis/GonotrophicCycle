% Parameters for malaria, anopheles gambiae

%human parameters
H = 100; %population density of humans/pop size (relative to vector pop size)
x = 0.4; %prevalence of disease in humans

%disease specific parameters
c = 0.55; %prob infectious bite infects vector
v = 10; %vector incubation period (days)
u = 12; %incubation period in humans (days)
r = 1/14; %human recovery rate
b = 0.037; %prob infectious bite infects human
kappa = c*x; %probability vector infected after human blood feed
