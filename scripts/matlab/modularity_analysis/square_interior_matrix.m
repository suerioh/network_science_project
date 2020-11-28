% Function used to return the linear indexes given the subscript indexes of
% a matrix.

function matrix_indexes = square_interior_matrix(N,begin_couple,final_couple)
L = final_couple(2) - begin_couple(2) + 1;

matrix_indexes = 1:L*L;
k = 1;

for i=1:L
    for j=1:L
        matrix_indexes(k) = N*(begin_couple(1)-1) + begin_couple(2) - 1 + N * (i-1) + j;
        k = k + 1;
    end
end

end