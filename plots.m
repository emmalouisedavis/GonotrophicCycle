
%%%%%%%%%%%%%%%%%%%%%
% Plotting examples
%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
% Example 1: Varying coverage 
% e.g. LLINs between 0 and 1, larvicides either 0% or 50%, no IRS
%%%%%%%%%%%%%%%%%%%%%%%%

parameters_malaria
parameters_gambiae
stepsize = 0.01;

R0s = csvread('R0s.csv');
Vs = csvread('Vs.csv');
Ds = csvread('Ds.csv');
Es = csvread('Es.csv');
Ms = csvread('Ms.csv');
Zs = csvread('Zs.csv');

% Rc (under control)
R0_b = R0s(1,:); %LLINs only
R0_bl = R0s(2,:); %LLINs + 50% larvicides

% number of vectors (population size)
M_b = Ms(1,:); %LLINs only
M_bl = Ms(2,:); %LLINs + 50% larvicides

% Rc, reproduction number under vector control
% log-scale y-axis
figure
semilogy(0:stepsize:1,R0_b,'LineWidth',2.5,'Color',[0    0.4470    0.7410])
hold on
semilogy(0:stepsize:1,R0_bl,'--','LineWidth',2.5,'Color',[0.9290, 0.6940, 0.1250])
legend({'LLINs','LLINs + 50% larvicides'},'FontSize',14)
[ax,h1]=suplabel('intervention coverage');
[ax,h2]=suplabel('R_c','y');
yline(1,'--','LineWidth',1,'HandleVisibility','off')
set(h1,'FontSize',18)
set(h2,'FontSize',18) 
xSize = 16; ySize = 12;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[300 600 xSize*50 ySize*50])
set(gca,'fontsize',18)

% Rc, reproduction number under vector control
% linear-scale y-axis
figure
plot(0:stepsize:1,R0_b,'LineWidth',2.5,'Color',[0    0.4470    0.7410])
hold on
plot(0:stepsize:1,R0_bl,'--','LineWidth',2.5,'Color',[0.9290, 0.6940, 0.1250])
legend({'LLINs','LLINs + 50% larvicides'},'FontSize',14)
[ax,h1]=suplabel('intervention coverage');
[ax,h2]=suplabel('R_c','y');
ylim([0, 60])
yline(1,'--','LineWidth',1,'HandleVisibility','off')
set(h1,'FontSize',18)
set(h2,'FontSize',18) 
xSize = 16; ySize = 12;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[300 600 xSize*50 ySize*50])
set(gca,'fontsize',18)

% Number of vectors (population size)
figure
plot(0:stepsize:1,M_b,'LineWidth',1.5)
hold on
plot(0:stepsize:1,M_bl,'LineWidth',1.5)
legend({'LLINs','LLINs + larvicides'},'FontSize',14)
[ax,h1]=suplabel('intervention intensity');
[ax,h2]=suplabel('number of vectors','y');
set(h1,'FontSize',16)
set(h2,'FontSize',16) 
xSize = 16; ySize = 12;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[300 600 xSize*50 ySize*50])
set(gca,'fontsize',14)

%%%%%%%%%%%%%%%%%%%%%%%%
% Example 2: Varying bednet efficacy 
% insecticide efficacy
%%%%%%%%%%%%%%%%%%%%%%%%

parameters_malaria
parameters_gambiae
steps = 10;
stepsize = 0.25;

R0s = csvread('R0s_netdecay.csv');
Vs = csvread('Vs_netdecay.csv');
Ds = csvread('Ds_netdecay.csv');
Es = csvread('Es_netdecay.csv');
Ms = csvread('Ms_netdecay.csv');
Zs = csvread('Zs_netdecay.csv');

% Rc (under control)
R0_bv = R0s(1,:); %LLINs (varying efficacy) only
R0_bv_l = R0s(2,:); %LLINs (varying efficacy) + 50% larvicides

% number of vectors (population size)
M_bv = Ms(1,:); %LLINs (varying efficacy) only
M_bv_l = Ms(2,:); %LLINs (varying efficacy) + 50% larvicides

% Rc, reproduction number under vector control
% linear-scale y-axis
figure
plot(2*(0:stepsize:steps),R0_bv,'LineWidth',2.5,'Color',[0    0.4470    0.7410])
hold on
plot(2*(0:stepsize:steps),R0_bv_l,'LineWidth',2.5,'Color',[0.9290, 0.6940, 0.1250],'LineStyle','--')
legend({'60% LLINs','60% LLINs + 50% larvicides'},'FontSize',14)
yline(1,'--','LineWidth',1,'HandleVisibility','off')
xlim([0,10])
[ax,h1]=suplabel('time (years)');
[ax,h2]=suplabel('R_c','y');
set(h1,'FontSize',18)
set(h2,'FontSize',18) 
xSize = 16; ySize = 12;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[300 600 xSize*50 ySize*50])
set(gca,'fontsize',18)

% Number of vectors (population size)
figure
plot(2*(0:stepsize:steps),M_bv,'LineWidth',2.5,'Color',[0    0.4470    0.7410])
hold on
plot(2*(0:stepsize:steps),M_bv_l,'LineWidth',2.5,'Color',[0.9290, 0.6940, 0.1250],'LineStyle','--')
legend({'60% LLINs','60% LLINs + 50% larvicides'},'FontSize',14)
xlim([0,10])
[ax,h1]=suplabel('time (years)');
[ax,h2]=suplabel('vector population size','y');
set(h1,'FontSize',18)
set(h2,'FontSize',18) 
xSize = 16; ySize = 12;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[300 600 xSize*50 ySize*50])
set(gca,'fontsize',18)
