%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Grafos (Ficha 9)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Diferentes representacaoes de grafos
%
%lista de adjacencias: [n(b,[c,g,h]), n(c,[b,d,f,h]), n(d,[c,f]), ...]
%
%termo-grafo: grafo([b,c,d,f,g,h,k],[e(b,c),e(b,g),e(b,h), ...]) or
%            digrafo([r,s,t,u],[a(r,s),a(r,t),a(s,t), ...])
%
%clausula-aresta: aresta(a,b)


%---------------------------------

g( grafo([madrid, cordoba, braga, guimaraes, vilareal, viseu, lamego, coimbra, guarda],
  [aresta(madrid, corboda, 400, a4),
   aresta(braga, guimaraes,25, a11),
   aresta(braga, vilareal, 107, a11),
   aresta(guimaraes, viseu, 174, a24),
   aresta(vilareal, lamego, 37, a24),
   aresta(viseu, lamego,61, a24),
   aresta(viseu, coimbra, 119, a25),
   aresta(viseu,guarda, 75, a25)]
 )).

%--------------------------------- 
%alinea 1)

adjacente(X,Y,K,E, grafo(_,Es)) :- member(aresta(X,Y,K,E),Es).
adjacente(X,Y,K,E, grafo(_,Es)) :- member(aresta(Y,X,K,E),Es).

%--------------------------------- 
%alinea 2)

caminho(G,A,B,P):- caminhoAux(G,A,B,P,[B],[B]).

caminhoAux(G,A,A,P, Visited, Ret).
caminhoAux(G,A,B,P, Visited, Ret):-
      adjacente(C,B,_,_,G),
      not(member(C,Visited)),
      caminhoAux(G,C,B,P, [C|Visited], [C|Ret]).

%--------------------------------- 
%alinea 3)

ciclo(G,A,P):- 
      adjacente(B,A,_,_,G),
      caminho(G,B,A,P1),
      length(P1, L), L > 2, append(P1, [A], P).
      


%--------------------------------- 
%alinea 4)

caminhoK(G,A,B,P, Km, Es):- caminhoKAux(G,A,B,P,[B],[B], 0, []).

caminhoKAux(G,A,A,P, Visited, Ret, Km, Es).
caminhoKAux(G,A,B,P, Visited, Ret, Km, Es):-
      adjacente(C,B,Est,Dist,G),
      not(member(C,Visited)),
      Km1 is Dist + Km,
      caminhoKAux(G,C,B,P, [C|Visited], [C|Ret], Km1,[Est|Es]).

%--------------------------------- 
%alinea 5)

cicloK(G,A,P, Km, Es):- 
      adjacente(B,A, Km1, Es1,G),
      caminhoK(G,B,A,P1, Km2, Es2),
      length(P1, L), L > 2, append(P1, [A], P),
      Km is Km1 + Km2.
      

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).
