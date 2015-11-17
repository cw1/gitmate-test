function[x, g, A] = simplex(A, b, c);
# Simplex algorithm in standard form:
# c*x = max
# A*x <= b
# x_i > 01
#
# Output parameters:
# A - final tableau of the simplex method
# subs - indices of the basic variables in the final tableau
# x - optimal solution
# z - value of the objective function at x.
  c = -c;
  [m, n] = size(A);
   
  A = [A eye(m) b];
  d = [c' zeros(1,m+1)];
  A = [A;d];

  disp("TABLEAU")
  A

  while min(A(m+1, 1:m+n)) < 0
    # Determine Pivot Element into column, line
    [_, column] = min(A(m+1, 1:(m+n)));
    [_, line] = min(arrayfun(@weirdquotient, A(1:m, m+n+1), A(1:m, column)));
    
    # Turn non pivot elements in column to zero
    A(line, :) = A(line, :)./A(line, column);
    pivot_line = A(line, :);
    for _line = 1:m+1
      if _line ~= line
        A(_line, :) = A(_line, :) - (pivot_line*A(_line, column)/1);
      endif
    endfor
    
    disp("New tableau:")
    A
  endwhile
  
  # Determine numbers of cows and sheep
  x = eye(n,1);
  for i = 1:n
    if sum(A(:, i)) == 1 & max(A(:, i)) == 1
      [_, line] = max(A(:, i));
      x(i) = A(line, m+n+1);
    else
      x(i) = 0;
    endif
  endfor
  
  g = A(m+1, m+n+1);
  
endfunction

function q = weirdquotient(a, b)
# Calculates something that isn't exactly a quotient
  if (b > eps)
    q = a / b;
  else
    q = inf;
  endif
endfunction
