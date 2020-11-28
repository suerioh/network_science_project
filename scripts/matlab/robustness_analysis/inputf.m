function Adj_Matrix = inputf()

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
disp(find((kin+kout')==0)); %indexes put in python
A = A(pos,pos);% remove nodes which are not connected 
N = size(A,1);
G = digraph(A);
bin = conncomp(G);
[~,ind] = max(histc(bin,unique(bin)));
unique_bin = unique(bin);
pos1 = find(bin==unique_bin(ind));
disp(find(bin~=unique_bin(ind))); %indexes put in python
A = A(pos1,pos1);

Adj_Matrix = A;

end
