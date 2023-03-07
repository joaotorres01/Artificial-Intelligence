%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes sobre listas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [X|L],N ) :-
    comprimento( L,N1 ),
    N is N1+1.
    

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado quantos: Lista,Comprimento -> {V,F}

diferentes([],0).
diferentes([X|T],N):-
    pertence(X,T),
    diferentes(T,N).
diferentes([X|T],N):-
    nao(pertence(X,T)),
    diferentes(T,N1),
    N is N1+1. 

/Outra opçao de resolucao/

quantos([],0).
quantos([X|XS], N):-
	quantos (XS, N0), (pertence(X,XS) -> N is N0; N is N0+1).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}

apaga1(X,[],[]).
apaga1(X, [X|T],T).
apaga1(X, [Y|T], [Y|L]):- apaga1(X,T,L).





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}

apagatudo(X,[],[]).
apagatudo(X, [X|T], L):- apagatudo(X, T, L).
apagatudo(X, [Y|T], [Y|L]):- apagatudo(X,T,L).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}

adicionar(X, T, L):- pertence(X,T).
adicionar(X, T, [X|T]) :- nao(pertence (X,T)).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}

concatenar(L,[],L).
concatenar([],L,L).
concatenar([X|T], Y, [X|Z]):- concatenar (T, Y, Z).
/ou substituir linha3 pela seguinte (sao iguais):/
/concatenar([X|T], Y, L):- concatenar (T, Y, L0), L=[X,L0]./



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}

inverter([], []).
inverter([X|T], L):- inverter(T, L0), concatenar(L0, [X], L). 


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

sublista([],L).
sublista([X|T], [X|L]):- sublista(T,L).
sublista([X|T], [Y|L]):- sublista([X|T], L).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
