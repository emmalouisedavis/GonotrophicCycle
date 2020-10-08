
%bednet and IRS parameters (Ngufor 2011 hut trials for Anopheles Gambiae)
%LLINs:
sigmaL = 0.121; %feed with bednet 0.121 (0.054-0.188, 6 holes), 0.318 (0.231,0.405, 80 holes)
nuL = 0.495; %prop of deaths with bednet 0.495 (0.392-0.597, 6 holes), 0.373 (0.282-0.463, 80 holes)

%IRS:
nuI_p = 0.443; %mortality rate, pyrethroids
nuI_o = 0.876; %mortality rate organophosphates
deter_p = 0.056; %deterrence (pre-entering), pyrethroids
deter_o = 0.423; %deterrence (pre-entering), organophosphates
inhib_p = 0.182; %feeding inhibition, pyrethroids
inhib_o = 0.071; %feeding inhibition, organophosphates
sigmaI_p = (1-deter_p)*(1-inhib_p);
sigmaI_o = (1-deter_o)*(1-inhib_o);

%pick pyrethroids or organophosphates:
nuI = nuI_p;
sigmaI = sigmaI_p;


%larvicide parameters (Kroeger 1995) ANOPHELES
theta_hat = 0.6; %average adult density reduction by weekly spraying (0.5-0.7)
%will be scaled later by proportion of sites sprayed for overall reduction:
%e.g. theta = theta_hat*0.3 for 30% sites treated.

%vector parameters
cyclelength = 3;  %make it a 3 day cycle
pi2 = 1/0.68; %hunting time
pi1 = 1/0.16;
pi3 = 1/2;
pi4 = 1/0.16;
%cyclelength == 1/pi1 + 1/pi2 + 1/pi3 + 1/pi4;
n = 10; %maximum number of cycles a vector will live through
Q = 0.9; %prop feed on humans (indoors?) 0.9-0.95 [16]
g_0 = 1/14; %natural death rate - two weeks CDC
beta_0 = 10000; %natural birth rate %malaria: gives R0 approx = 60 with host prev=0.4
