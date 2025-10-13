% Create a solution for Exercises 5.2 and 5.3, page 88 using plan.pl
start :- 
    action(state(left,left,left,left),
            state(right,right,right,right)).

action(Start,Goal) :-
    plan(Start,Goal,[Start],Path),
    nl,write('Solution:'),nl,
    write_path(Path).
%   write_path(Path), fail. % all solutions output

plan(Start,Goal,Visited,Path) :-
    go(Start,Next),
    safe(Next),
    \+ member(Next,Visited),
    plan(Next,Goal,[Next|Visited],Path).
plan(Goal,Goal,Path,Path).

go(state(X,X,Z,K),state(Y,Y,Z,K)) :- across(X,Y). % farmer, wolf
go(state(X,W,X,K),state(Y,W,Y,K)) :- across(X,Y). % farmer, goat
go(state(X,W,Z,X),state(Y,W,Z,Y)) :- across(X,Y). % farmer, cabbage
go(state(X,W,Z,K),state(Y,W,Z,K)) :- across(X,Y). % farmer alone

across(left,right).
across(right,left).

safe(state(B,W,Z,K)) :- across(W,Z), across(Z,K).
safe(state(B,B,B,K)).
safe(state(B,W,B,B)).

% ==========================
% Exercise 5.2
% ==========================

% (a) write_move(+State1, +State2)
write_move(state(F1,W1,G1,C1), state(F2,W2,G2,C2)) :-
    % xác định hướng di chuyển
    (F1 = left, F2 = right -> Dir = 'from left to right'
    ; F1 = right, F2 = left -> Dir = 'from right to left'),
    % xác định Farmer đi với ai
    (W1 \= W2 -> Thing = 'wolf'
    ; G1 \= G2 -> Thing = 'goat'
    ; C1 \= C2 -> Thing = 'cabbage'
    ; Thing = 'alone'),
    % in ra thông điệp
    (Thing = 'alone' ->
        format('Farmer crosses ~w.~n', [Dir])
    ;
        format('Farmer and ~w cross ~w.~n', [Thing, Dir])).

% (b) write_path(+Path)
write_path([_]).
write_path([S1, S2 | Rest]) :-
    write_move(S1, S2),
    write_path([S2 | Rest]).



