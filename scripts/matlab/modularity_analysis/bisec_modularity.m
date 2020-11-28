% Function that takes as input the Adjacency matrix and divides the
% related network into 2 subnetworks assigning the label1 to the nodes
% that belong to the 1st component, and label2 to the second component,
% if they exists, othersiwe the algorithm puts 1 and 2 respectively.
% K is the matrix that cointains in the entry (i,j) the product of kout of
% i, kin of j and normalises it to the number of links.
% The output of the function is the value of modularity of the clustering
% made and the vector of length the number of nodes which contains label1
% and label2.

function [Q,comm_vector] = bisec_modularity(A,label1,label2,K)
N = length(A);
comm_vector = zeros(N,1);
if ~exist('K')
    kout = sum(A);
    kin = sum(A,2);
    K = zeros(N,N);
    for i=1:N
        for j=1:N
            K(i,j)=(kout(1,i)*kin(j,1))/(sum(kin));
        end
    end
end
B = A - K;
C = B+B';
[eigvectors,eigenvalues] = eigs(C);
max_eigval_ind = find(max(max(eigenvalues)));
s = sign(eigvectors(:,max_eigval_ind));
comm1=find(s==1);
comm2=find(s==-1);
Q = s'*C*s/(4*(sum(kin)));

if ~(exist('label1')&&(exist('label2')))
    comm_vector(comm1)=1;
    comm_vector(comm2)=2;
else
    comm_vector(comm1)=label1;
    comm_vector(comm2)=label2;
end
end