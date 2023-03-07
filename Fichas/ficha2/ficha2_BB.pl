%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes aritmeticas.

/iii)/
operacao(X,Y, R) :- R is X+Y.
operacao(X,Y, R) :- R is X-Y.
operacao(X,Y, R) :- R is X*Y.
operacao(X,Y, R) :- R is X/Y.

/iv)/
max(X, Y, R) :- X >= Y, R is X.
max(X, Y, R) :- Y >= X, R is Y.

/v)/
max3(X, Y, Z, R) :- max(X, Y, L), max(L, Z, R).

/vi)/
min(X, Y, R) :- X >= Y, R is Y.
min(X, Y, R) :- Y >= X, R is X.

/vii)/
min3(X, Y, Z, R) :- min(X, Y, L), min(L, Z, R).

/viii)/
par(X) :- 0 is mod(X,2).

/ix)/
impar(X) :- not(par(X)).

/x)/ (O D serve para alguma coisa ???)
mdc(X,X,X).
mdc(X,Y, D):- X<Y, Y1 is X-Y, mdc(X,Y1, D).
mdc(X,Y, D):- X>Y, mdc (Y,X, D).

/xi)/
mmc(X,Y, D):- X* Y / mdc (X,Y, D).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Soma -> {V,F}

/i)/
soma( X,Y,Soma ) :-
    Soma is X+Y.

/ii)/
soma3(X,Y,Z, Soma):- Soma is X+Y+Z.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Z,Soma -> {V,F}

