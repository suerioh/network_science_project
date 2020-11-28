% This software simply gathers the required data to compute the different
% attacks to the parties and shows the results.


clc
clear all
close all

A = inputf();
elections = struct();
num_followers = importdata('Num_Followers.txt');
geo = importdata('GEO.txt');
elections.regions = importdata('Regions.txt');

elections.parties = importdata('PSOE_Votes.txt');
elections.parties = [elections.parties importdata('PP_Votes.txt')];
elections.parties = [elections.parties importdata('CS_Votes.txt')];
elections.parties = [elections.parties importdata('UP_Votes.txt')];
elections.parties = [elections.parties importdata('VOX_Votes.txt')];

N = length(A);
total_region_votes = zeros(19,1);
for i=1:19
    for j=1:5
        total_region_votes(i) = total_region_votes(i) + elections.parties(i,j);
    end
end
elections.parties = [elections.parties total_region_votes];

kin  = full(sum(A,2));
kout = full(sum(A));


%--------------------------------------------------------------------------
%                               Robustness
%PageRank
rank = Pagerank(A);

% i = 1, PSOE attack
% i = 2, PP attack
% i = 3, CS attack
% i = 4, UP attack
% i = 5, VOX attack
i = 1;
[~,diff1,diff2,diff3] = robustness_rank(A,elections,num_followers,geo,rank,i,1);


% Results presentation
%ending number of vect and axis limits must be changed accorind to which 
%party is attacked
vect=0:15;
figure(1);
hold on
plot(vect,diff1(:,i),'-o');
hold on
plot(vect,diff2(:,i),'-o');
hold on
plot(vect,diff3(:,i),'-o');
hold on
grid on;
axis([0 15 -1*10^6 6*10^6]);
title('Attacking PSOE')
xlabel('Number of removed nodes')
ylabel('Number of votes for PSOE in Spain')
legend('FNP weight = 0.5','FNP weight = 1.0','FNP weight = 1.5','FNP weight = 0')

