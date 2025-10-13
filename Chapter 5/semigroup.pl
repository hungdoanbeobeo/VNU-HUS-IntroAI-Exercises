% Create a solution for Exercise 5.1, page 88. More precisely, you will attempt to prove the equality of left- and right-neutral elements of semigroups with PROLOG and fail. Try to explain why?


m(X, Y).
assoc(X, Y, Z) :-
    m(m(X, Y), Z) = m(X, m(Y, Z)).
left_neutral(E_l, X) :-
    m(E_l, X) = X.

right_neutral(E_r, X) :-
    m(X, E_r) = X.

prove_equal(E_l, E_r) :-
    left_neutral(E_l, X),
    right_neutral(E_r, X),
    E_l = E_r.
