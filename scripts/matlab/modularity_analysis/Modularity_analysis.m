% The software takes the matrix A and tries to divide it among 2
% subnetworks. Anyway, trying to divide the 2 subnetworks doesn't give a
% value of Modularity greater than the initial one. So only 2 clustered are
% found.
% After this step, the network is restricted to a network containing only
% the parties. Applying a fast filtering on the matrix K used previously a
% modularity formula is used to see if the parties are well clustered.

clc
clear all
close all

A = inputf();

N = length(A);

kin  = full(sum(A,2));
kout = full(sum(A));

%--------------------------------------------------------------------------
%                   Modularity for directed networks

comm = zeros(N,2);
[Q,comm_vector] = bisec_modularity(A,1,2);

A1 = sparse(A(find(comm_vector==1),find(comm_vector==1)));
A2 = sparse(A(find(comm_vector==2),find(comm_vector==2)));

comm2 = find(comm_vector==2);

[Q1,comm_vector1] = bisec_modularity(A1,4,5);
[Q2,comm_vector2] = bisec_modularity(A2,2,3);
%Both Q1 and Q2 <Q, networks indivisible

%--------------------------------------------------------------------------

B = sparse(zeros(66,66));
K = zeros(N,N);
for i=1:N
    for j=1:N
        K(i,j)=(kout(1,i)*kin(j,1))/(sum(kin));
    end
end
B(square_interior_matrix(66,[1 1],[15 15])) = K(1:15,1:15);
B(square_interior_matrix(66,[16 16],[31 31])) = K(16:31,16:31);
B(square_interior_matrix(66,[32 32],[46 46])) = K(32:46,32:46);
B(square_interior_matrix(66,[47 47],[66 66])) = K(47:66,47:66);
 
C = sparse(full(A(1:66,1:66)) - B);
QB = sum(sum(C))/sum(kin(1:66));
%The value of QB shows that the groups of politician profiles are clustered
%well.
