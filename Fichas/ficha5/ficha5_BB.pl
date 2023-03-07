%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Problema dos jarros -> Problema de Estado Único

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Notas:
% Jarro A -> capacidade= 8
% Jarro B -> capacidade= 5
% Par(A, B) -> jarros(A, B)
% Estado Inicial -> jarros(0, 0)
% Estado Objetivo -> jarros(_, 4) ou jarros(4, _)
% Estado Inicial <-> Estado Objetivo -> Operadores


%---------------------------------
% Estado Inicial:

estadoInicial(jarro(0,0)).

%---------------------------------
% Estado Final:

estadoFinal(jarro(4,_)).
estadoFinal(jarro(_,4)).

%---------------------------------
% Operadores

transicao(jarro(A,B), encher(1), jarro(8,B)):- A<8.
transicao(jarro(A,B), encher(2), jarro(A,5)):- B<5.
transicao(jarro(A,B), esvaziar(1), jarro(0,B)):- A>0.
transicao(jarro(A,B), esvaziar(2), jarro(A,0)):- A>0.
transicao(jarro(A,B), transferir(1,2), jarro(A1,B1)):-
                                                    A>0,
                                                    A1 is max(0, A-5+B),
                                                    A1<A,
                                                    B1 is B+A-A1.

transicao(jarro(A,B), transferir(2,1), jarro(A1,B1)):-
                                                    B > 0, 
                                                    B1 is max(0,B-8+A),
                                                    B1 < B,
                                                    A1 is A + B - B1.

%---------------------------------
% Procura em profundidade

profundidade(Ei,Ef, Path):- profAux(Ei, Ef, [], Path).

profAux(Ei, Ei, Visited, Path):- reverse([Ei|Visited], Path).
profAux(Ei, Ef, Visited, Path):- 
                            not(member(Ei, Visited)),
                            transicao(Ei,T,E),
                            profAux(E,Ef,[Ei|Visited], Path).



%-----------------------------------
% Breadth First Search	

breadthFirst(Orig, Dest, Cam):- breadthFirstAux(Dest,[[Orig]],Cam).

breadthFirstAux(Dest,[[Dest|T]|_],Cam):- reverse([Dest|T],Cam). 

breadthFirstAux(Dest,[LA|Outros],Cam):- LA=[Act|_], 
	findall([X|LA], (transicao(Act, T, X),\+member(X,LA)), Novos),
	append(Outros,Novos,Todos),
 	breadthFirstAux(Dest,Todos,Cam).
