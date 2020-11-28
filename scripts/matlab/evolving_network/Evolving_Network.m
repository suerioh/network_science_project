% The software takes the adjacecy matrix without filtering the nodes
% because it applies 2 different criteria, to obtain thus 2 differente
% "future_A" adjancecy matrixes, in which some links are added into the
% initial network. After this step the robustness_rank function is applied
% to attack the parties in order to see the differences with respect to the
% real attacks done in the Robustness_analysis software.

clc
clear all
close all


N = 159;

inputf = importdata('M_labeled.txt');
total = max(size(inputf));

A = zeros(N,N);

for i=1:total
    x = inputf(i,1);
    y = inputf(i,2);
    A(y,x) = A(y,x) + 1;
end

inputf = importdata('RT_labeled.txt');
total = max(size(inputf));

for i=1:total
    x = inputf(i,1);
    y = inputf(i,2);
    A(x,y) = A(x,y) + 1;
end

A = sparse(A);
A = A - diag(diag(A));          %rimuovo self_loop

kin  = full(sum(A,2));
kout = full(sum(A));

pos = find((kin+kout')~=0);
removed_nodes = find((kin+kout')==0);
A = A(pos,pos);% remove nodes which are not connected 
N = size(A,1);

kin  = full(sum(A,2));
kout = full(sum(A));

elections = struct();

evolv_ntw_nf = importdata('evolv-network_Num_Followers.txt');
evolv_ntw_geo = importdata('evolv-network_GEO.txt');
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

%--------------------------------------------------------------------------
%                   Common neighbours link prediction

future_A = A;

SCN = sparse(full(future_A'*future_A));

SCN = SCN - diag(diag(SCN));

[~,in_index] = max(SCN,[],2);
[~,out_index] = max(SCN);

for j=1:N
    future_A(j,out_index(j)) = future_A(j,out_index(j)) + 1;
    future_A(in_index(j),j) = future_A(in_index(j),j) + 1;
end


%Trovo il secondo massimo e modifico future_A
for j=1:N
    vect = full(SCN(j,:));
    [~,ind] = max(vect(vect<max(vect)));
    if ~(isempty(ind))
        future_A(j,ind) = future_A(j,ind) + 1;      %aggiungo link entrante
    end
    vect = full(SCN(:,j));
    [~,ind] = max(vect(vect<max(vect)));
    if ~(isempty(ind))
        future_A(ind,j) = future_A(ind,j) + 1;      %aggiungo link uscente
    end
end

kin  = full(sum(future_A,2));
kout = full(sum(future_A));

G = digraph(future_A);
bin = conncomp(G);
[~,ind] = max(histc(bin,unique(bin)));
unique_bin = unique(bin);
pos1 = bin==unique_bin(ind);
removed = find(bin~=unique_bin(ind));
future_A = future_A(pos1,pos1);

future_rank = Pagerank(future_A);


% i = 1, PSOE attack
% i = 2, PP attack
% i = 3, CS attack
% i = 4, UP attack
% i = 5, VOX attack
i = 5;
[~,CNdiff1,CNdiff2,CNdiff3] = robustness_rank(future_A,elections,evolv_ntw_nf,evolv_ntw_geo,future_rank,i,0);

%--------------------------------------------------------------------------
%                 Neighbours of neighbours link prediction
future_A = A;
SN = sparse(full(future_A*future_A)); %nella entry i,j c'è il numero di vicini di i
                        %che si collegano a j
SN = SN - diag(diag(SN));

[~,in_index] = max(SN,[],2);
[~,out_index] = max(SN);

for j=1:N
    future_A(j,out_index(j)) = future_A(j,out_index(j)) + 1;
    future_A(in_index(j),j) = future_A(in_index(j),j) + 1;
end

for j=1:N
    vect = full(SN(j,:));
    [~,ind] = max(vect(vect<max(vect)));
    if ~(isempty(ind))
        future_A(j,ind) = future_A(j,ind) + 1;
    end
    vect = full(SN(:,j));
    [~,ind] = max(vect(vect<max(vect)));
    if ~(isempty(ind))
        future_A(ind,j) = future_A(ind,j) + 1;
    end
end

pos = find((kin+kout')~=0);
removed_nodes = find((kin+kout')==0);
future_A = future_A(pos,pos);% remove nodes which are not connected 
N = size(future_A,1);
G = digraph(future_A);
bin = conncomp(G);
[~,ind] = max(histc(bin,unique(bin)));
unique_bin = unique(bin);
pos1 = bin==unique_bin(ind);
removed = find(bin~=unique_bin(ind));
future_A = future_A(pos1,pos1);

future_rank = Pagerank(future_A);

kin  = full(sum(future_A,2));
kout = full(sum(future_A));
[~,NNdiff1,NNdiff2,NNdiff3] = robustness_rank(future_A,elections,evolv_ntw_nf,evolv_ntw_geo,future_rank,i,0);



%Results presentation
vect=0:20;
figure(3)
subplot(1,2,1)
plot(vect,CNdiff1(:,i),'-o');
hold on
plot(vect,CNdiff2(:,i),'-o');
hold on
plot(vect,CNdiff3(:,i),'-o');
grid on
hold off
title('Attacking evolved (CN) VOX')
xlabel('Number of removed nodes')
ylabel('Number of votes for VOX in Spain')
legend('FNP weight = 0.5','FNP weight = 1.0','FNP weight = 1.5')
axis([vect(1) length(vect) 3.4*10^6 3.8*10^6])
subplot(1,2,2)
plot(vect,NNdiff1(:,i),'-o');
hold on
plot(vect,NNdiff2(:,i),'-o');
hold on
plot(vect,NNdiff3(:,i),'-o');
grid on
hold off
title('Attacking evolved (NoN) VOX')
xlabel('Number of removed nodes')
ylabel('Number of votes for VOX in Spain')
legend('FNP weight = 0.5','FNP weight = 1.0','FNP weight = 1.5')
axis([vect(1) length(vect) 3.4*10^6 3.8*10^6])