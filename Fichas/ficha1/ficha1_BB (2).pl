%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial MIEI /3  LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai( P,F ) :- filho( F,P ).
pai(paulo,filipe).
pai(paulo,maria).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}
avo(A,N) :- filho (F,A) , filho (N,F).
neto(N,A) :- avo(A,N).

avo(antonio, nadia).
avo(ana,nuno).

sexo(joao,masculino).
sexo(jose,masculino).
sexo(maria,feminino).
sexo(joana,feminino).

//xvii)
avo(A,N):- descendente_grau(N,A,2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo(X,Y):- descendente_grau(Y,X,3).

trisavo(X,Y):- descendente_grau(Y,X,4).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}

descendente(X,Y):- filho (X,Y).
descendente(X,Y):- filho (X,A), descendente(A,Y). 





%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente_grau(X,Y,1):- filho (X,Y).
descendente_grau(X,Y,N):- filho (X,A), G is N-1, descendente_grau(A,Y,G).



