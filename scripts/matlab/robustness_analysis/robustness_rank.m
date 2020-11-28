%The function attacks a single party, which party depends on the variable
%"which_party". Inside that party it removes the node with the highest
%rank, calculates the number of votes to be removed according to the
%num_votes function, removes this number on the region the profile is
%localized, updates the election's structure, the adjacency matrix, the
%rank, the geo, the number of followers. Then it removes the new node with
%the highest rank and so on until no nodes of the party remain.

function [copy_A,different_elections1,different_elections2,different_elections3] = robustness_rank(copy_A,copy_elections1,copy_nf,copy_geo,copy_rank,which_party,present_or_future)
copy_elections2 = struct();
copy_elections3 = struct();
copy_elections2.parties = copy_elections1.parties;
copy_elections3.parties = copy_elections1.parties;
copy_N = max(size(copy_A));
if (present_or_future==1)       %indexes taken from the excel documents
    switch which_party
        case 1              %PSOE
            starting_ind = 1;
            end_ind = 15;
        case 2              %PP
            starting_ind = 16;
            end_ind = 31;
        case 3              %CS
            starting_ind = 47;
            end_ind = 66;
        case 5              %VOX
            starting_ind = 32;
            end_ind = 46;
    end
else
    switch which_party
        case 1              %PSOE
            starting_ind = 1;
            end_ind = 20;
        case 2              %PP
            starting_ind = 21;
            end_ind = 39;
        case 3              %CS
            starting_ind = 77;
            end_ind = 96;
        case 4              %UP
            starting_ind = 60;
            end_ind = 76;
        case 5              %VOX
            starting_ind = 40;
            end_ind = 59;
    end
end
num_cycles = end_ind - starting_ind + 1;
vect = (1:copy_N);
different_elections1 = zeros(num_cycles+1,5);
different_elections2 = zeros(num_cycles+1,5);
different_elections3 = zeros(num_cycles+1,5);

for j=1:5
    for k=1:19
        different_elections1(1,j) = different_elections1(1,j) + copy_elections1.parties(k,j);
        different_elections2(1,j) = different_elections2(1,j) + copy_elections1.parties(k,j);
        different_elections3(1,j) = different_elections3(1,j) + copy_elections1.parties(k,j);
    end
end
for i=1:num_cycles
    [r_m,r_ind] = max(copy_rank(starting_ind:end_ind));
    r_ind = r_ind + starting_ind - 1;
    if(present_or_future==1)
        n_link_to_FNP = sum(copy_A(copy_N-6:copy_N,r_ind));
    else
        n_link_to_FNP = sum(copy_A(copy_N-16:copy_N,r_ind));
    end
    if(present_or_future==1)
        votes = num_votes(copy_nf(r_ind),r_m,n_link_to_FNP,1);
    else
        votes = num_votes(copy_nf(r_ind),r_m,n_link_to_FNP,0);
    end
    region_index = lookup_table(copy_geo(r_ind));
    
    if(region_index<20)
        copy_elections1.parties(region_index,which_party) = copy_elections1.parties(region_index,which_party) - votes(1);
        copy_elections2.parties(region_index,which_party) = copy_elections2.parties(region_index,which_party) - votes(2);
        copy_elections3.parties(region_index,which_party) = copy_elections3.parties(region_index,which_party) - votes(3);
        split_votes = votes./4;
        for j=1:5
            if(j~=which_party)
                copy_elections1.parties(region_index,j) = copy_elections1.parties(region_index,j) + split_votes(1);
                copy_elections2.parties(region_index,j) = copy_elections2.parties(region_index,j) + split_votes(2);
                copy_elections3.parties(region_index,j) = copy_elections3.parties(region_index,j) + split_votes(3);
            end
        end
    end
    for j=1:5
        for k=1:19
            different_elections1(i+1,j) = different_elections1(i+1,j) + copy_elections1.parties(k,j);
            different_elections2(i+1,j) = different_elections2(i+1,j) + copy_elections2.parties(k,j);
            different_elections3(i+1,j) = different_elections3(i+1,j) + copy_elections3.parties(k,j);
        end
    end
    indexes = find(vect~=r_ind);
    copy_A = copy_A(indexes,indexes);
    copy_nf = copy_nf(indexes);
    copy_geo = copy_geo(indexes);
    copy_rank = Pagerank(copy_A);
    end_ind = end_ind - 1;
    copy_N = copy_N - 1;
    vect = 1:copy_N;
end

end