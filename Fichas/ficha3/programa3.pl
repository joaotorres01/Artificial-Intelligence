//i
pertence(X,[X|T]).  
pertence(X,[H|T]):-
X\=H, 
pertence (X,T).

//ii
comprimento([],0).
comprimento([X|T],N):-
    comprimento (T,N),
    N is N1+1.

//iii
diferentes([],0).
diferentes([X|T],N):-
    pertence(X,T),
    diferentes(T,N).
diferentes([X|T],N):-
    nao(pertence(X,T)),
    diferentes(T,N1),
    N is N1+1.

nao(Questao):-
    Questao, !, Fail.
nao(Questao).
    