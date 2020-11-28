% This algorithm calculates takes as input the number of followers of the 
% node, the rank(prob) and the number of links the node has towards the
% FNPs and calculates the number of votes to be removed when the node
% will be taken out. The flag "present_or_future" is used because this
% function is used both in the robustness of the network itself, but also
% on the predicted ("future") network and according to this aspect
% the parameter concerning the sum of the followers of the parties changes
% (see also the excel documents for the numbers put here).

function num_votes = num_votes(Num_follow,prob,n_link_to_FNP,present_or_future)
if(present_or_future==1)
    pol_party_sum = 8753133;
else
    pol_party_sum = 18005162;
end
whole_sum = (27847228 + 12335500)/2;
num_votes(1) = ceil(whole_sum*(Num_follow/pol_party_sum)*prob*(n_link_to_FNP*0.5+1));
num_votes(2) = ceil(whole_sum*(Num_follow/pol_party_sum)*prob*(n_link_to_FNP*1+1));
num_votes(3) = ceil(whole_sum*(Num_follow/pol_party_sum)*prob*(n_link_to_FNP*1.5+1));
end