% Function that calculates the stochastic vector used in the calculation
% of the votes. It uses the Pagerank random walk seen in the theory.

function rank = Pagerank(A)
kout = sum(A);
N = length(A);
inv = 1./kout;
M = A*diag(inv);
[~,eigval] = eigs(M);
c = 0.85;
q = zeros(N,1);
ind = find(kout~=0);
q(:) = 1/N;

%Metodo con risoluzione del sistema lineare
% a = (eye(N) - c*M)\((1-c)*q);

%Metodo con iterazioni
rank = q;
for i=1:35
    old_p = rank;
    rank = c*M*rank + (1-c) * q;
    rank = rank/sum(rank);
end

%Valutazione convergenza
% norm(a-rank)/sqrt(N)
% lambda1 = eigval(1,1);
% lambda2 = eigval(3,3);
% (lambda2/lambda1)^35

end