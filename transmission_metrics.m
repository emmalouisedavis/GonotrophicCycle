
%%%%%%%%%%%%%%%%%%%%%%%%
% File name: transmission_metrics.m
% File purpose: calculate transmission metrics such as Rc, vectorial
% capacity, EIR, etc. for a variety of control measures and coverages
% File output: Individual files for each metric e.g. R0s.csv
%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%
% Example 1: Varying coverage 
% e.g. LLINs between 0 and 1, larvicides either 0% or 50%, no IRS
%%%%%%%%%%%%%%%%%%%%%%%%

parameters_malaria
parameters_gambiae
stepsize = 0.01;

% coverage values to explore
cov_larv = [0; 0.5];
cov_IRS = 0;
cov_LLINs = 0:stepsize:1;

theta = cov_larv.*theta_hat; %larvicides
gamma = cov_IRS; %IRS 
omega = cov_LLINs; %LLINs

%calculate vector control dependent parameters
beta = beta_0.*(1-theta);
q1 = (1-Q)+Q.*((1-omega)+omega.*sigmaL).*((1-gamma)+gamma.*sigmaI); %probability successful feed on single attempt
q2 = Q.*omega.*nuL.*(1-gamma*(1-sigmaI)); %probability death on single attempt
q3 = Q.*gamma.*nuI;
q4 = Q.*(gamma.*(1-sigmaI) + gamma.*sigmaI.*omega.*(1-sigmaL-nuL) + (1-gamma).*omega.*(1-sigmaL-nuL));
K = pi1*pi2*pi3*pi4.*q1.*(1-q3)./((pi2.*(q1+q2)+g_0).*(pi1+g_0).*(pi3+g_0).*(pi4+g_0)); %cycle survival probability
delta = 1./(pi2.*(1-q4)) + 1/pi3 + 1/pi4 + 1/pi1;
a = Q./delta;
g = -log(K)./delta;
B0 = beta./(pi2.*(q1+q2)+g);
M = B0.*(1-K.^(n+1))./(1-K);
m = M./H;
N = ceil(v./delta); %incubation period in nubmber of cycles

% Calculating measures %

%Total number of vectors, M:
M = B0.*(1-K.^(n+1))./(1-K);
%Total number of diseased vectors, D:
D = B0.*K.*((K-1).*(1-kappa)^(n+1).*K.^n + (1-K+kappa.*K).*K.^n-kappa)./((K-1).*(1-K+kappa.*K)); % == sum(Bn.*exposed)
%Total number of infectious vectors, Z:
Z = D.*K.^N;
%Now EIR:
E = m.*a.*Z./M;
%Vectorial capacity
V = (m.*a.^2.*exp(-g.*v))./g;
%R0
R0 = V.*b.*c./r;


%%%%%%%%%%%%%%%%%%%%%%%%
% Saving outs
%%%%%%%%%%%%%%%%%%%%%%%%

csvwrite('R0s.csv',R0)
csvwrite('Vs.csv',V)
csvwrite('Ds.csv',D)
csvwrite('Es.csv',E)
csvwrite('Ms.csv',M)
csvwrite('Zs.csv',Z)

%%%%%%%%%%%%%%%%%%%%%%%%
% Example 2: Varying bednet efficacy 
% insecticide efficacy
%%%%%%%%%%%%%%%%%%%%%%%%

parameters_malaria
parameters_gambiae
steps = 10;
stepsize = 0.25;

% coverage values to explore
cov_larv = [0; 0.5];
cov_IRS = 0;
cov_LLINs = 0.6;

theta = cov_larv.*theta_hat; %larvicides
gamma = cov_IRS; %IRS 
omega = cov_LLINs; %bednets

%varying bednet efficacy over time (half life of 2 years)
nuL = 0.051 + 0.443.*1./2.^((0:stepsize:steps)./2);
sigmaL = 0.564 - 0.444*1./2.^((0:stepsize:steps)./2);

%calculated vector control dependent parameters
beta = beta_0.*(1-theta);
q1 = (1-Q)+Q.*((1-omega)+omega.*sigmaL).*((1-gamma)+gamma.*sigmaI); %probability successful feed on single attempt
q2 = Q.*omega.*nuL.*(1-gamma*(1-sigmaI)); %probability death on single attempt
q3 = Q.*gamma.*nuI;
q4 = Q.*(gamma.*(1-sigmaI) + gamma.*sigmaI.*omega.*(1-sigmaL-nuL) + (1-gamma).*omega.*(1-sigmaL-nuL));
K = pi1*pi2*pi3*pi4.*q1.*(1-q3)./((pi2.*(q1+q2)+g_0).*(pi1+g_0).*(pi3+g_0).*(pi4+g_0)); %previously C, cycle survival probability
delta = 1./(pi2.*(1-q4)) + 1/pi3 + 1/pi4 + 1/pi1;
a = Q./delta;
g = -log(K)./delta;
B0 = beta./(pi2.*(q1+q2)+g);
M = B0.*(1-K.^(n+1))./(1-K);
m = M./H;
N = ceil(v./delta); %incubation period in nuLmber of cycles

% Calculating measures %

%Total number of vectors, M:
M = B0.*(1-K.^(n+1))./(1-K);
%Total number of diseased vectors, D:
D = B0.*K.*((K-1).*(1-kappa)^(n+1).*K.^n + (1-K+kappa.*K).*K.^n-kappa)./((K-1).*(1-K+kappa.*K)); % == sum(Bn.*exposed)
%Total number of infectious vectors, Z:
Z = D.*K.^N;
%Now EIR:
E = m.*a.*Z./M;
%Vectorial capacity
V = (m.*a.^2.*exp(-g.*v))./g;
%R0
R0 = V.*b.*c./r;

csvwrite('R0s_netdecay.csv',R0)
csvwrite('Vs_netdecay.csv',V)
csvwrite('Ds_netdecay.csv',D)
csvwrite('Es_netdecay.csv',E)
csvwrite('Ms_netdecay.csv',M)
csvwrite('Zs_netdecay.csv',Z)



