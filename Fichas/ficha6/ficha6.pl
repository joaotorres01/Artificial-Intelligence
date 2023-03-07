%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Problemas utilizando Pesquisa Informada
% Problema de Pesquisa -> Problema de Estado Único

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Notas:
% Partindo de qualquer nó, queremos chegar ao nó t

% Base de Conhecimento
% -> Definição das arestas: aresta(nó1, nó2, custo)

aresta(s, e, 2).
aresta(s, a, 2).
aresta(a, b, 2).
aresta(b, c, 2).
aresta(c, d, 3).
aresta(d, t, 3).
aresta(t, g, 2).
aresta(g, f, 2).
aresta(f, e, 5).

% -> Definição dos nodos: node(nó, estimativaDoCusto)

node(s,10).
node(a, 5).
node(b, 4).
node(c, 4).
node(d, 3).
node(t, 0).
node(g, 2).
node(f, 4).
node(e, 7).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Devolve nó adjacente e custo a essa adjacência, por unificação 
adjacente(X, Y, C):- aresta(X, Y, C).
adjacente(X, Y, C):- aresta(Y, X, C).

%ii) Depth First Search
depthFirstSearch(Ei, Path, CustoTotal):- 
    depthFirstSearchAux(Ei,t,[], Path, 0).

depthFirstSearchAux(t,t,Visited, Path, Total).
depthFirstSearchAux(Ei,t, Visited, Path, Total):-
    adjacente(Ei,E,Cost),
    nao(pertence(E, Visited)),
    newTotal is Total+Cost,
    depthFirstSearchAux(E,t,[E|Visited], Path, newTotal).

%iii) Greedy Search

listaAdj(Ei, listaAdj):- findall(Y, adjacente(Ei,Y,_), listaAdj).

menorCustoAdj(List, MenorNodo):-
    Z is 100000,
    menorCustoAjdAux(List, Z, MenorNodo).

menorCustoAjdAux([], C, MenorNodo).
menorCustoAjdAux([H|Tail)], C, MenorNodo):-
    node(H,Y),
    Y>=C,
    menorCustoAjdAux(Tail, C, MenorNodo).
menorCustoAjdAux([H|Tail)], C, MenorNodo):-
    node(H,Y),
    Y<C,
    menorCustoAjdAux(Tail, Y, H).

gulosa(Ei, t, Path, CustoTotal):-
    gulosaAux(Ei, t, [], Path, 0).

gulosaAux(t, t, Visited, Custo, Path, Custo):- reverse([t|Visited], Path).
gulosaAux(Ei, t, Visited, Custo, Path, Total):-
    listaAdj(Ei, List),
    menorCustoAjd(List, MenorNodo),
    nao(member(MenorNodo, Visited)),
    adjacente(Ei,MenorNodo, CustoDist),
    NewCost is Custo+CustoDist,
    gulosaAux(MenorNodo, t, [MenorNodo|Visited], NewCost, Path, Total).

%iv) A* Search

listaAdj(Ei, listaAdj):- 
    findall(Y, adjacente(Ei,Y,_), listaAdj).


menorNodo(Ei, List, Nodo):-
    node(Ei, CustoAprox),
    Z is CustoAprox*100000;
    menorNodoAux(Ei, List, Z , Nodo).

menorNodoAux(Ei, [], MC, Nodo).
menorNodoAux(Ei, [H|T], MC, Nodo):-
    adjacente(Ei, H, V),
    node(H,Y),
    Z is V+Y,
    Z>=MC,
    menorNodoAux(Ei, T, MC, Nodo).
menorNodoAux(Ei, [H|T], MC, Nodo):-
    adjacente(Ei, H, V),
    node(H,Y),
    Z is V+Y,
    Z<MC,
    menorNodoAux(Ei, T, Z, H).


aEstrela(Ei, t, Path, CustoTotal):-
    aEstrelaAux(Ei,t,[],0,Path,Total).

aEstrelaAux(t, t, Visited, Custo, Path, Custo):- reverse([t|Visited],Path).
aEstrelaAux(Ei,t, Visited, Custo, Path, Total):-
    listaAdj(Ei, ListaAdj),
    menorNodo(Ei, ListaAdj, Nodo),
    nao(member(Nodo, Visited)),
    adjacente(Ei,Nodo, CustoDist),
    NewCost is Custo+CustoDist,
    aEstrelaAux(Nodo,t,[Nodo|Visited], NewCost, Path, Total).

    



