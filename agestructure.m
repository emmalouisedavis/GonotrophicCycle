
%%%%%%%%%%%%%%%%%%%%%%%%
% File name: agestructure.m
% File purpose: calculate population distributions and infection profiles 
% for specific combinations of vector control measures
% File output: Bar plot showing age structure and infection status for
% scenario selected
%%%%%%%%%%%%%%%%%%%%%%%%

% input parameters
parameters_malaria
parameters_gambiae

% set bednet coverage:
omega = 0.5; % always use 0.5 for comparing single and joint interventions
% set IRS death coverage:
gamma = 0.5;
% set larvicide coverage:
theta = 0.5;

beta = beta_0*(1-theta*theta_hat); %birth rate

%incubation period is 10.3 - 10.7 for Anopheles gambiae [16]
%i.e. approx 4-5 cycles

q1 = (1-Q)+Q.*((1-omega)+omega.*sigmaL).*((1-gamma)+gamma.*sigmaI); %probability successful feed on single attempt
q2 = Q.*omega.*nuL.*(1-gamma*(1-sigmaI)); %probability death on single attempt
q3 = Q.*gamma.*nuI;
q4 = Q.*(gamma.*(1-sigmaI) + gamma.*sigmaI.*omega.*(1-sigmaL-nuL) + (1-gamma).*omega.*(1-sigmaL-nuL));

K = pi1*pi2*pi3*pi4.*q1.*(1-q3)./((pi2.*(q1+q2)+g_0).*(pi1+g_0).*(pi3+g_0).*(pi4+g_0));

steps=n+1;
delta = 1./(pi2.*(1-q4)) + 1/pi3 + 1/pi4 + 1/pi1;
a = Q./delta;
g = -log(K)./delta;
B0 = beta./(pi2.*(q1+q2)+g);
M = B0.*(1-K^(n+1))/(1-K);
m = M./H;
N = ceil(v./delta); %incubation period in nuLmber of cycles

sum_val = 0;

Bn = zeros(1,steps);
Bn(1) = B0; %Bn(1) = B0, Bn(2) = B1,...
Bn_approx = Bn;

for i = 2:steps
    Bn(i) = K*Bn(i-1);
end

%total number in the population:
M = B0*(1-K^(n+1))/(1-K); % == sum(Bn)
%total number of disease mosquitoes:
D = B0*K*((K-1)*(1-kappa)^(n+1)*K^n + (1-K+kappa*K)*K^n-kappa)/((K-1)*(1-K+kappa*K)); % == sum(Bn.*exposed)
%number of infectious mosquitoes:
Z = D*K^N; % == sum(En.*infected)
%total number of exposed mosquitoes:
Y = D - Z;
%total nuLmber of susceptible mosquitoes:
S = M - D;

% probability of being infected by generation n
p = zeros(1,20);
p(1) = kappa;

for i = 2:steps
    p(i) = p(i-1) + p(1)*(1-p(1))^(i-1);
    for j = (N+1):steps
        sum_val = sum_val+Bn(i)*p(i-1);
    end
end

FoI = pi2*q1*sum_val;

% Calculating mean and median
meanCycles = sum(Bn.*(0:10))/sum(Bn);
mid = M/2;
total = 0;
for i=1:n
    total = total + Bn(i);
    if total > mid
        break
    end
end
medCycles = i-1;

% Bar plot showing age-structure and infectious status of the vector
% population
bar(0:length(Bn)-1,Bn,'FaceColor',[0.4660, 0.6740, 0.1880],'EdgeColor','none')
hold on
exposeds = [0,p(1:(n))];
bar(0:length(Bn)-1,Bn.*exposeds,'FaceColor',[0.9290, 0.6940, 0.1250],'EdgeColor','none')
hold on
infecteds = [zeros(1,N),p(1:(n-N+1))];
bar(0:length(Bn)-1,Bn.*infecteds,'FaceColor',[0.8500, 0.3250, 0.0980],'EdgeColor','none')
hold on
xline(meanCycles,'--','LineWidth',1.5)
xline(medCycles,'-.','LineWidth',1.5)
legend('S', 'E','I')
title('LLINs, IRS and larvicides')
xlim([-0.5,10.5])
ylim([0, 8000])

[ax,h1]=suplabel('generation (number of cycles)');
[ax,h2]=suplabel('count','y');
set(h1,'FontSize',18)
set(h2,'FontSize',18) 
xSize = 14; ySize = 14;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[300 600 xSize*50 ySize*50])

