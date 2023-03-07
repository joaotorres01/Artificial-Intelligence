%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial LEI - Projeto Prático

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%------------INTERFACE---------------


menu :-
        menu('Queries',
        [ option_1 : 'Estafeta Mais Ecologico'
        , option_2 : 'Estafetas to Cliente'
        , option_3 : 'Clientes from Estafeta'
        , option_5 : 'Top 3 ruas maior volume'
        , option_6 : 'Classificação Média Estafeta by Cliente'
        , menuQ    : 'Queries Num intervalo de tempo'
        , menuD    : 'Queries para Dia'
        , quit     : 'Quit'
        ], Choice),
        do_query(Choice).


menuDia:-
        menu('Queries para Dia',
                [ option_4  : 'Faturacao Dia'
                , option_10 : 'Peso Total Dia'
                , option_11 : 'Entregas por Dia da Semana'
                , voltar     :  'Voltar Menu'
                ], Choice),
        do_query(Choice).

menuEntreDatas:-
        menu('Queries Num Intervalo de Tempo',
                [ option_7 : 'Entregas por Meio de Transporte entre Datas'
                , option_8 : 'Entregas por Estafetas entre Datas'
                , option_9 : 'Encomendas entregues ou não entre Datas'
                , voltar     : 'Voltar Menu'
                ], Choice),
        do_query(Choice).

do_query(voltar):-menu.
do_query(menuD):-menuDia.
do_query(menuQ):-menuEntreDatas.

do_query(option_1):-
        nl,nl,
        maisEcologico(Res),
        write("Estafeta mais ecológico -> "),write(Res),
        nl,endQuery.

do_query(option_2):-
        nl,
        write("Id do Cliente"),nl,
        read(X),
        toCliente(X,Res),
        write("Estafetas -> "),write(Res),
        nl,endQuery.

do_query(option_3):-
        nl,
        write("Id do Estafeta"),nl,
        read(X),
        byEstafeta(X,Res),
        write("Clientes -> "),write(Res),
        nl,endQuery.


do_query(option_4):-
        ask("Ano",Ano),
        ask("Mes",Mes),
        ask("Dia",Dia),
        faturadoDia(Ano,Mes,Dia,Res),
        write("Faturação -> "),write(Res),
        nl,endQuery.

do_query(option_5):-    
        nl,
        zonaMaiorVolume(Res),
        write("Top 3 Zonas -> "),write(Res),
        nl,endQuery.

do_query(option_6):-
        ask("Id_Cliente",Id_Cliente),
        ask("Id_Estafeta",Id_Estafeta),
        rankClienteEstafetaMedia(Id_Cliente,Id_Estafeta,Res),
        write("Classificação média -> "),write(Res),
        nl,endQuery.

do_query(option_7):-
        askData("De:",Before),
        askData("Até:",After),
        periodoTempoTransportes(Before,After,Res),
        write("Entregas Meios de Transporte -> "),write(Res),
        nl,endQuery.

do_query(option_8):-
        askData("De:",Before),
        askData("Até:",After),
        periodoTempoEstafetas(Before,After,Res),
        write("Entregas Estafetas -> "),write(Res),
        nl,endQuery.

do_query(option_9):-
        askData("De:",Before),
        askData("Até:",After),
        periodoTempoEntregues(Before,After,Entregues,NaoEntregues),
        write("Entregues -> "),write(Entregues),
        write("Não Entregues -> "),write(NaoEntregues),
        nl,endQuery.

do_query(option_10):-
        askData("Data",Data),
        pesoPorEstafeta(Data,Res),
        write("Peso Total Estafetas -> "),write(Res),
        nl,endQuery.

do_query(option_11):-nl,nl,
        diasSemana(Res),
        write("Entregas por Dia da Semana -> "),write(Res),
        nl,endQuery.


askData(Str,Res):-
        nl,
        write(Str),
        ask("Ano",Ano),
        ask("Mes",Mes),
        ask("Dia",Dia),
        Res = date(Ano,Mes,Dia).


ask(Str,Res):-
        nl,write(Str),nl,
        read(Res).
endQuery:-
        nl,
        write('1. Voltar Menu'),nl,
        write('2. Quit'),nl,
        read(Choice),endQuery(Choice).

endQuery(1):-menu.
endQuery(_):-fail.

%------------BASE DE CONHECIMENTO---------------

%morada(rua, número, andar, freguesia, cidade).
morada(ruaX, 45, 3, s_vicente, braga).

%estafeta(Nome).
estafeta(ricardo).
estafeta(antonio).
estafeta(joao).
estafeta(diogo).
% listing

%id prazo
prazolimite(1,date(2020,10,30),5).
prazolimite(2,date(2020,10,30),5).
prazolimite(3,date(2020,10,30),5).
prazolimite(4,date(2020,10,30),5).
prazolimite(5,date(2020,10,30),5).

%produto(id, preco,?)

%encomenda(id, artigo, morada, preço, peso, volume,data,tempo).
encomenda(1, radio, saoLazaro      , 70 , 3, 15,date(2020,9,30),time(20,30,0)).
encomenda(2, radio, saoVicente     , 60 , 25, 20,date(2020,9,30),time(20,30,0)).
encomenda(3, radio, adaufe         , 50 , 35, 10,date(2020,9,30),time(20,30,0)).
encomenda(4, radio, saoLazaro      , 40 , 45, 25,date(2020,9,30),time(20,30,0)).
encomenda(5, radio, nogueiro       , 30 , 55, 12,date(2020,9,30),time(20,30,0)).

%meioTransporte(Veiculo,velMedia,PesoMax).
meioTransporte(bicicleta,10,5).
meioTransporte(mota     ,35,20).
meioTransporte(carro    ,25,100).

%ecologico(veiculo, nr_ecologico).
ecologico(bicicleta,1).
ecologico(mota,2).
ecologico(carro,3).

%entrega(idEncomenda,cliente, estafeta, meioTransporte, preçoEntrega, prazolimite, rank,date,time).
entrega(1,      antonio,      ricardo,  mota,           60, 24, 4,date(2021,10,1),time(10,0,0)).
entrega(2,      diogo,        ricardo,  bicicleta,      60, 24, 4,date(2020,10,1),time(10,0,0)).
entrega(3,      joao,         diogo,    bicicleta,      60, 24, 4,date(2020,10,2),time(10,0,0)).
entrega(4,      diogo,        ricardo,  bicicleta,      30, 24, 5,date(2020,10,1),time(10,0,0)).
entrega(5,      diogo,        diogo,    mota,           30, 24, 4,date(2020,10,1),time(10,0,0)).

%precoEncomenda(encomenda(_,_,_,X,_,_,_), X). 

%precoEntrega(precoEncomenda, TempoEntrega, meioTranporte).
precoEntrega(Preco, Tempo, mota,Res):-Res is      3*Tempo+Preco.
precoEntrega(Preco, Tempo, carro,Res):-Res is     5*Tempo+Preco.
precoEntrega(Preco, Tempo, bicicleta,Res):-Res is 1*Tempo+Preco.



%------------QUERIES---------------


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%identificar o estafeta que utilizou mais vezes um meio de transporte mais ecológico;


% Função auxiliar que dada uma lista de listas, indica qual a lista com maior comprimento
maiorLista([],R,_,R).
maiorLista([H | T],L,Len,R) :- length(H,Len2), 
        (Len2 > Len ->
                maiorLista(T,H,Len2,R);
                maiorLista(T,L,Len,R)).         

maiorLista([H|T],R) :- length(H,Len),
                maiorLista(T,H,Len,R).  

maisEcologico(Eco,X) :- 
        estafeta(Nome),
        findall(Nome,entrega(_,_,Nome,Eco,_,_,_,_,_),X),
        length(X,Len), Len >0.


maisEcologico(Res) :- ecologico(Eco,1),
        findall(X,maisEcologico(Eco,X),L),      %[[ricardo, ricardo], [diogo]].
        maiorLista(L,R),                        %[ricardo, ricardo]. 
        R = [Res | _].                          %ricardo

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%identificar que estafetas entregaram determinada(s) encomenda(s) a um determinado cliente

toCliente(Id,Res):- findall(X,entrega(_,Id,X,_,_,_,_,_,_),L),
                sort(L,Res).

                
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%identificar os clientes servidos por um determinado estafeta;

byEstafeta(Id,Res):- findall(X,entrega(_,X,Id,_,_,_,_,_,_),L),
                sort(L,Res).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%4- calcular o valor faturado pela Green Distribution num determinado dia


faturadoDia(Y,M,D,Res):- 
        findall(X,entrega(_,_,_,_,X,_,_,date(Y,M,D),_),L),
        sumlist(L,Res).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%-5-identificar quais as zonas (e.g., rua ou freguesia) com maior volume de entregas por parte da Green Distribution;

listIndexZona([],[]).
listIndexZona([H | T], [X-H |Res]) :- 
        encomenda(H,_,X,_,_,_,_,_),
        %localidade(X,A), FREGUESIA EM VEZ DE RUA
        listIndexZona(T,Res).

%Função Auxiliar que transforma uma lista de pares (zona-List) numa lista de pares(zona-number), onde number é a length da Lista que formava o par    
lengthPair([],[]).
lengthPair([A-B | T],[A-Len | Res]):-
        length(B,Len),
        lengthPair(T,Res). 

% Função auxilar para ficar com os primeiros Number elementos da lista
take(_,[],[]).
take(0,_,[]).
take(Number,[H | T],[H|Res]) :- NewNumber is Number-1,take(NewNumber,T,Res).


zonaMaiorVolume(Res):-
        findall(X,entrega(X,_,_,_,_,_,_,_,_),L),                % Lista com todos os nr de Encomenda das Entregas
        listIndexZona(L,N),                                     % Lista de Pares (Rua-Encomenda)
        sort(1, @=<, N, Ps),
        group_pairs_by_key(Ps,PairList),                        % Lista de Pares (Rua-[Encomenda])
        lengthPair(PairList,LengthList),                        % Lista de Pares (Rua-Length)
        sort(2, @>=, LengthList, ListRes),                      % Sort by length
        take(3,ListRes,Res).                                    % Retorna as 3 zonas com maior volume de entregas


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%calcular a classificação media de satisfação de cliente para um determinado estafeta

rankClienteEstafetaMedia(Cliente,Estafeta,Res) :- 
        findall(X,entrega(_,Cliente,Estafeta,_,_,_,X,_,_),L),   %Lista das classificações das entregas feitas com Cliente e Estafeta
        sumlist(L,Sum), length(L,Len),                          %Somar Lista | Ver Length
        Res is Sum/Len.                                         %Calcular classificação media

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%identificar o número total de entregas pelos diferentes meios de transporte, num determinado intervalo de tempo;


%Verifica se Date está entre Before e After, inclusive
beetweenDate(Before,After,Date):-
        Before @=< Date,
        After  @>= Date, !.
beetweenDate(_,_,_,_):- fail.

%Conta o nr de elementos (Datas) que estão entre Before e After
beetweenDateList(_,_,[],0).
beetweenDateList(Before,After,[H | T],Res) :-
        beetweenDate(Before,After,H),                                                   % Verificar se Data está entre Before e After
        beetweenDateList(Before,After,T,NewRes),                                        % Recursiva com o novo resultado
        Res is NewRes+1,!.                                                              % Incrementar Resultado
beetweenDateList(Before,After,[_|T],Res) :- beetweenDateList(Before,After,T,Res).       % Recursiva com o mesmo resultado

beetweenDateAll(_,_,[],[]).
beetweenDateAll(Before,After,[A-B|T],[A-New | Res]) :-
        beetweenDateList(Before,After,B,New),        
        beetweenDateAll(Before,After,T, Res).
        
        
periodoTempoTransportes(Before,After,Res):-
        findall(A-B,entrega(_,_,_,A,_,_,_,B,_),L),      %Lista Pares (MeioTransporte-Data)
        sort(1, @>=, L, Ps),                            
        group_pairs_by_key(Ps,N),                       %Lista Pares (MeioTransporte-[Data])
        beetweenDateAll(Before,After,N,Res).            %Lista Pares (MeioTransporte-Res)  


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%identificar o número total de entregas pelos estafetas, num determinado intervalo de tempo

periodoTempoEstafetas(Before,After,Res):-
        findall(A-B,entrega(_,_,A,_,_,_,_,B,_),L),      %Lista Pares (Estafeta-Data)
        sort(1, @>=, L, Ps),                             
        group_pairs_by_key(Ps,N),                       %Lista Pares (Estafeta-[Data])
        beetweenDateAll(Before,After,N,Res).            %Lista Pares (Estafeta-Res)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%calcular o número de encomendas entregues e não entregues pela Green Distribution, num determinado período de tempo

%Função auxiliar para verificar se a encomenda foi entregue num intervalo de tempo, com uso de acumuladores de resultado
beetweenDateListPair(_,_,[],Entregues,NaoEntregues,Entregues-NaoEntregues).
beetweenDateListPair(Before,After,[A-B| T],Entrega,NaoEntrega,Res) :-
        beetweenDate(Before,After,A),                                                   %verifica se a encomenda foi feita no intervalo de tempo
        (entrega(B,_,_,_,_,_,_,Date,_),beetweenDate(Before,After,Date) ->               %Verifica se a encomenda foi entregue e se a entrega foi feita no intervalo de tempo
                NewEntrega is Entrega+1, NewNEntrega = NaoEntrega                       %Caso sim, incrementa nr de Entregues
        ;       NewNEntrega is NaoEntrega+1,NewEntrega = Entrega),                      %Caso não, incrementa nr de Não Entregues
        beetweenDateListPair(Before,After,T,NewEntrega,NewNEntrega,Res),!.              %Recursiva com os novos resultados
beetweenDateListPair(Before,After,[_|T],E,EN,Res) :- beetweenDateListPair(Before,After,T,E,EN,Res).


periodoTempoEntregues(Before,After,C,D):-
        findall(B-A,encomenda(A,_,_,_,_,_,B,_),N),
        beetweenDateListPair(Before,After,N,0,0,C-D).
        %Res =[entregues-C,naoEntregues-D].

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%calcular o peso total transportado por estafeta num determinado dia.

%Função auxiliar para transformar uma lista de nr de encomenda no seu respetivo peso
listIndexPesoEncomenda([],[]).
listIndexPesoEncomenda([H | T], [X |Res]) :- 
        encomenda(H,_,_,_,X,_,_,_),
        listIndexPesoEncomenda(T,Res).


pesoTotal([],[]).
pesoTotal([A-B | T],[A-Sum | Res]) :- 
        listIndexPesoEncomenda(B,Y),    % Tranformar lista de encomendas numa lista dos seus pesos
        sumlist(Y,Sum),                 % Somar o peso total
        pesoTotal(T,Res).              

pesoPorEstafeta(Y,M,D,Res) :- 
        findall((B-A),entrega(A,_,B,_,_,_,_,date(Y,M,D),_),X),  %Lista de pares (Estafeta-NrEncomenda)
        sort(1, @>=, X, Ps),                                    %Ordenar lista por nome
        group_pairs_by_key(Ps,V),                               %Agrupar encomendas de cada estafeta -> Lista de Par (Estafeta-[NrEnconmeda])
        pesoTotal(V,Res).                                       

pesoPorEstafeta(date(Y,M,D),Res):-pesoPorEstafeta(Y,M,D,Res).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Identificar o número de entregas feitas em cada dia da semana

diaNome(1,segunda).
diaNome(2,terca).
diaNome(3,quarta).
diaNome(4,quinta).
diaNome(5,sexta).
diaNome(6,sabado).
diaNome(7,domingo).

%Função auxiliar que transforma uma lista de datas numa lista do respetivos dias da semana
toWeekDay([],[]).
toWeekDay([H | T], [N-Day | Res]) :- 
        day_of_the_week(H,Day),         %Dia da semana em number
        diaNome(Day,N),                 %Dia da semana em texto
        toWeekDay(T,Res).

diasSemana(Res):-
        findall(X,entrega(_,_,_,_,_,_,_,X,_),L),        % Lista das datas das entregas
        toWeekDay(L,N),                                 % Lista de Pares (dia-[x])
        sort(1, @=<, N, Ps),
        group_pairs_by_key(Ps,PairList),                % Lista de Pares (dia-Length)
        lengthPair(PairList,Res).
        


% ---------------------------2ºFASE---------------------------------


 % Base de Conhecimento


%% Definição das arestas: aresta(nó1, nó2, custo)
aresta(centro,	        saoPedro ,      2.0).
aresta(centro,          saoVitor,       3.8).
aresta(centro,          nogueiro,       4.5).
aresta(centro,          adaufe,         3.6).
aresta(nogueiro,        espinho,        4.7).
aresta(nogueiro,        lamacaes,       1.1).
aresta(saoPedro,        navarra ,       6.9).
aresta(saoPedro,        espinho,        4.1).
aresta(adaufe,          navarra,        3.1).
aresta(adaufe,          palmeira,       4.9).
aresta(adaufe,          saoVicente,     2.8).
aresta(palmeira,        real,           5.7).
aresta(palmeira,        saoVicente,     2.4).
aresta(saoVicente,      real,           3.7).
aresta(saoVicente,      maximinos,      5.0).
aresta(saoVicente,      saoLazaro,      4.8).
aresta(saoVicente,      saoVitor,       4.9).
aresta(maximinos,       saoLazaro,      2.7).
aresta(maximinos,       real,           3.1).
aresta(saoVitor,        saoLazaro,      2.8).
aresta(saoVitor,        lamacaes,       2.7).
aresta(lamacaes,        saoLazaro,      3.4).

% -> Definição dos nodos: nodo(Destino,nó, estimativaDoCusto:nó->Destino)

%custos aproximados das respetivas cidades até ao centro
nodo(centro, centro,    0).
nodo(centro, saoPedro,  1.55). 
nodo(centro, saoVitor,  2.35). 
nodo(centro, nogueiro,  2.26). 
nodo(centro, adaufe,    2.21).  
nodo(centro, espinho,   3.19). 
nodo(centro, lamacaes,  2.86). 
nodo(centro, navarra,   4.14).  
nodo(centro, saoVicente,2.98). 
nodo(centro, saoLazaro, 4.18). 
nodo(centro, palmeira,  4.11).  
nodo(centro, real,      5.14).  
nodo(centro, maximinos, 5.34). 

%custos aproximados das respetivas cidades até São Pedro
nodo(saoPedro, centro,    1.55).
nodo(saoPedro, saoPedro,  0). 
nodo(saoPedro, saoVitor,  3.05). 
nodo(saoPedro, nogueiro,  2.12). 
nodo(saoPedro, adaufe,    3.55). 
nodo(saoPedro, espinho,   1.78). 
nodo(saoPedro, lamacaes,  2.85). 
nodo(saoPedro, navarra,   5.05).  
nodo(saoPedro, saoVicente,4.40). 
nodo(saoPedro, saoLazaro, 4.76). 
nodo(saoPedro, palmeira,  6.54).  
nodo(saoPedro, real,      6.29).  
nodo(saoPedro, maximinos, 6.08). 

%custos aproximados das respetivas cidades até São Vitor
nodo(saoVitor, centro    ,  2.35).
nodo(saoVitor, saoPedro  ,  3.05). 
nodo(saoVitor, saoVitor  ,  0). 
nodo(saoVitor, nogueiro  ,  1.47). 
nodo(saoVitor, adaufe    ,  3.57). 
nodo(saoVitor, espinho   ,  3.73). 
nodo(saoVitor, lamacaes  ,  1.33). 
nodo(saoVitor, navarra   ,  6.13).  
nodo(saoVitor, saoVicente,  2.31). 
nodo(saoVitor, saoLazaro ,  1.84). 
nodo(saoVitor, palmeira  ,  5.10).  
nodo(saoVitor, real      ,  3.35).  
nodo(saoVitor, maximinos ,  3.07).

%custos aproximados das respetivas cidades até Nogueiró
nodo(nogueiro, centro    ,  2.26).
nodo(nogueiro, saoPedro  ,  2.12). 
nodo(nogueiro, saoVitor  ,  1.47). 
nodo(nogueiro, nogueiro  ,  0). 
nodo(nogueiro, adaufe    ,  4.16). 
nodo(nogueiro, espinho   ,  2.28). 
nodo(nogueiro, lamacaes  ,  0.73). 
nodo(nogueiro, navarra   ,  6.41).  
nodo(nogueiro, saoVicente,  3.67). 
nodo(nogueiro, saoLazaro ,  2.80). 
nodo(nogueiro, palmeira  ,  6.34).  
nodo(nogueiro, real      ,  4.77).  
nodo(nogueiro, maximinos ,  4.17). 

%custos aproximados das respetivas cidades até ao Adaúfe
nodo(adaufe,  adaufe,    0). 
nodo(adaufe,  centro,    2.21).
nodo(adaufe,  saoPedro,  3.55). 
nodo(adaufe,  saoVitor,  3.57). 
nodo(adaufe,  nogueiro,  4.16).  
nodo(adaufe,  espinho,   5.27). 
nodo(adaufe,  lamacaes,  4.55). 
nodo(adaufe,  navarra,   2.66).  
nodo(adaufe,  saoVicente,2.54). 
nodo(adaufe,  saoLazaro, 5.15). 
nodo(adaufe,  palmeira,  3.27).  
nodo(adaufe,  real,      5.09).  
nodo(adaufe,  maximinos, 5.92). 

%custos aproximados das respetivas cidades até Espinho
nodo(espinho, centro    ,  3.19).
nodo(espinho, saoPedro  ,  1.78). 
nodo(espinho, saoVitor  ,  3.73). 
nodo(espinho, nogueiro  ,  2.28). 
nodo(espinho, adaufe    ,  5.27). 
nodo(espinho, espinho   ,  0). 
nodo(espinho, lamacaes  ,  2.84). 
nodo(espinho, navarra   ,  6.82). 
nodo(espinho, saoVicente,  5.68). 
nodo(espinho, saoLazaro ,  5.0). 
nodo(espinho, palmeira  ,  8.09).  
nodo(espinho, real      ,  7.07).  
nodo(espinho, maximinos ,  6.40).


%custos aproximados das respetivas cidades até Lamaçães
nodo(lamacaes, centro    ,  2.86).
nodo(lamacaes, saoPedro  ,  2.85). 
nodo(lamacaes, saoVitor  ,  1.33). 
nodo(lamacaes, nogueiro  ,  0.73). 
nodo(lamacaes, adaufe    ,  4.55). 
nodo(lamacaes, espinho   ,  2.84). 
nodo(lamacaes, lamacaes  ,  0). 
nodo(lamacaes, navarra   ,  6.95).  
nodo(lamacaes, saoVicente,  3.66). 
nodo(lamacaes, saoLazaro ,  2.17). 
nodo(lamacaes, palmeira  ,  6.40).  
nodo(lamacaes, real      ,  4.36).  
nodo(lamacaes, maximinos ,  3.55).

% custos aproximados das respetivas cidades até Navarra
nodo(navarra, centro    ,  4.14).
nodo(navarra, saoPedro  ,  5.05). 
nodo(navarra, saoVitor  ,  6.13). 
nodo(navarra, nogueiro  ,  6.41). 
nodo(navarra, adaufe    ,  2.66). 
nodo(navarra, espinho   ,  6.82). 
nodo(navarra, lamacaes  ,  6.95). 
nodo(navarra, navarra   ,  0).  
nodo(navarra, saoVicente,  5.12). 
nodo(navarra, saoLazaro ,  7.80). 
nodo(navarra, palmeira  ,  4.70).  
nodo(navarra, real      ,  7.62).  
nodo(navarra, maximinos ,  8.50).

%custos aproximados das respetivas cidades até São Vicente
nodo(saoVicente, centro    ,  2.98).
nodo(saoVicente, saoPedro  ,  4.40). 
nodo(saoVicente, saoVitor  ,  2.31). 
nodo(saoVicente, nogueiro  ,  3.67). 
nodo(saoVicente, adaufe    ,  2.54). 
nodo(saoVicente, espinho   ,  5.68). 
nodo(saoVicente, lamacaes  ,  3.66). 
nodo(saoVicente, navarra   ,  5.12).  
nodo(saoVicente, saoVicente,  0). 
nodo(saoVicente, saoLazaro ,  3.15). 
nodo(saoVicente, palmeira  ,  2.80).  
nodo(saoVicente, real      ,  2.56).  
nodo(saoVicente, maximinos ,  3.55).

%custos aproximados das respetivas cidades até ao São Lazaro 
nodo(saoLazaro, centro,    4.18). 
nodo(saoLazaro, saoPedro,  4.76). 
nodo(saoLazaro, saoVitor,  1.84).
nodo(saoLazaro, nogueiro,  2.8). 
nodo(saoLazaro, adaufe,    5.15).
nodo(saoLazaro, espinho,   5.0). 
nodo(saoLazaro, lamacaes,  2.17).
nodo(saoLazaro, navarra,   7.8). 
nodo(saoLazaro, saoVicente,3.15). 
nodo(saoLazaro, saoLazaro, 0).  
nodo(saoLazaro, palmeira,  5.8). 
nodo(saoLazaro, real,      2.52). 
nodo(saoLazaro, maximinos, 1.4).


%custos aproximados das respetivas cidades até Palmeira
nodo(palmeira, centro    ,  4.11).
nodo(palmeira, saoPedro  ,  6.54). 
nodo(palmeira, saoVitor  ,  5.10). 
nodo(palmeira, nogueiro  ,  6.34). 
nodo(palmeira, adaufe    ,  3.27). 
nodo(palmeira, espinho   ,  8.09). 
nodo(palmeira, lamacaes  ,  6.40). 
nodo(palmeira, navarra   ,  4.70).  
nodo(palmeira, saoVicente,  2.80). 
nodo(palmeira, saoLazaro ,  5.8). 
nodo(palmeira, palmeira  ,  0).  
nodo(palmeira, real      ,  4.19).  
nodo(palmeira, maximinos ,  5.82).

%custos aproximados das respetivas cidades até Real
nodo(real, centro    ,  5.14).
nodo(real, saoPedro  ,  6.29). 
nodo(real, saoVitor  ,  3.35). 
nodo(real, nogueiro  ,  4.77). 
nodo(real, adaufe    ,  5.09). 
nodo(real, espinho   ,  7.07). 
nodo(real, lamacaes  ,  4.36). 
nodo(real, navarra   ,  7.62).  
nodo(real, saoVicente,  2.56). 
nodo(real, saoLazaro ,  2.52). 
nodo(real, palmeira  ,  4.19).  
nodo(real, real      ,  0 ).  
nodo(real, maximinos ,  1.8).

%custos aproximados das respetivas cidades até Maximinos
nodo(maximinos, centro    ,  5.34).
nodo(maximinos, saoPedro  ,  6.08). 
nodo(maximinos, saoVitor  ,  3.07). 
nodo(maximinos, nogueiro  ,  4.17). 
nodo(maximinos, adaufe    ,  5.92). 
nodo(maximinos, espinho   ,  6.40). 
nodo(maximinos, lamacaes  ,  3.55). 
nodo(maximinos, navarra   ,  8.50).  
nodo(maximinos, saoVicente,  3.55). 
nodo(maximinos, saoLazaro ,  1.40). 
nodo(maximinos, palmeira  ,  5.82).  
nodo(maximinos, real      ,  1.80).  
nodo(maximinos, maximinos ,  0).


%--------------------------------- - - - - - - - - - -  -  -  -  -      -
% Devolve nó adjacente e custo a essa adjacência, por unificação
adjacente(X,Y,K) :- aresta(X,Y,K).
adjacente(X,Y,K) :- aresta(Y,X,K).

%Decréscimo da velocidade por Kilo
decrescimoVelocidade(bicicleta,0.7).
decrescimoVelocidade(mota,0.5).
decrescimoVelocidade(carro,0.1).


%Dado um MeioTransporte e um peso, devolve o resultado do cálculo consoante o decréscimo
velocidadeEntrega(MeioTransporte,Peso,Res):- 
        meioTransporte(MeioTransporte,VelMedia,_),
        decrescimoVelocidade(MeioTransporte,Decrescimo),
        Res is VelMedia - (Peso*Decrescimo).
        

%--------------------------------------------------------------------------------------------------
% Gerar os circuitos de entrega, caso existam, que cubram um determinado território (e.g. rua ou freguesia);

caminho(Partida,Destino,Resultado-B):-
        caminho(Partida,Destino,[Partida],A-B),
        reverse(A,Resultado).


%Todos os caminhos

caminho(D,D,Caminho,Caminho-Custo):- custoTotalCaminho(Caminho,Custo),!.

caminho(P,D,Caminho,Resultado):-
        adjacente(P,C,_),
        not(member(C,Caminho)),
        caminho(C,D,[C | Caminho],Resultado).


%Lista com todos os caminhos até ao destinho
allCaminhos(Destino,Res):-
        findall(X,caminho(centro,Destino,X),Res).


%-------------------------------------------------------------------------------------------------------
%Pesquisa não informada (cega):

%Primeiro em profundidade (DFS - Depth-First Search);

depthFirst(Destino,Resultado,CustoTotal):- 
        depthFirstAux(centro,Destino,[centro],Resultado,0,CustoTotal),!.


depthFirstAux(D,D,Caminho,Resultado,CustoTotal,CustoTotal):- reverse(Caminho,Resultado).
depthFirstAux(P,D,Caminho,Resultado,Custo,CustoTotal):-
        adjacente(P,C,CustoNodo),
        not(member(C,Caminho)),
        NewCusto is Custo + CustoNodo,
        depthFirstAux(C,D,[C | Caminho],Resultado,NewCusto,CustoTotal).

%--------------------------------------------------------------------------------------------------

%Primeiro em largura (BFS - Breadth-First Search);


breadthFirst(Destino, Caminho):- breadthFirstAux(Destino,[[centro]],Caminho),!.

breadthFirstAux(Destino,[[Destino|T]|_],Caminho):- reverse([Destino|T],Caminho). 
breadthFirstAux(Destino,[LA|Outros], Caminho):- 
        LA=[Atual|_], 
	findall([X|LA], (adjacente(Atual,X,_),\+member(X,LA)), Novos),
	append(Outros,Novos,Todos),
 	breadthFirstAux(Destino,Todos, Caminho).

%Busca Iterativa Limitada em Profundidade.

%--------------------------------------------------------------------------------------------------

%Busca Iterativa Limitada em Profundidade


buscaIterativa(Limite,Destino,Resultado):-
        Limite >=0,
        buscaIterativaAux(Limite,0,centro,Destino,[centro],Resultado),!.



buscaIterativaAux(_,_,D,D,Caminho,Resultado):-reverse(Caminho,Resultado).
buscaIterativaAux(Limite,Acc,_,_,_,_):-Acc==Limite, !,fail.
buscaIterativaAux(Limite,Acc,P,D,Caminho,Resultado):-
        adjacente(P,C,_),
        not(member(C,Caminho)),
        NewAcc is Acc +1,
        buscaIterativaAux(Limite,NewAcc,C,D,[C | Caminho],Resultado).


%Pesquisa informada (heurística):

%--------------------------------------------------------------------------------------------------

%Gulosa;

%Lista de adjacentes ao Nodo que ainda não tenham sido visitados
listaAdj(Nodo, Visited,ListaAdj):- findall(Y, (adjacente(Nodo,Y,_),\+member(Y,Visited)), ListaAdj).

menorCustoAdj(Destino,[H | T], MenorNodo):-
        nodo(H,Destino,Valor),
        menorCustoAdjAux(Destino,T, Valor, H,MenorNodo).

%Dado um Destino e uma lista de Nodos, devolve o nodo que tiver uma distância estimada menor até ao Destino
menorCustoAdjAux(_,[],_, MenorNodo,MenorNodo).
menorCustoAdjAux(Destino,[H|Tail],C, MenorNodo,Res):-
        nodo(H,Destino,Y),
        (Y<C)-> 
        menorCustoAdjAux(Destino,Tail,Y,H,Res);
        menorCustoAdjAux(Destino,Tail,C, MenorNodo,Res).


gulosa(Destino,Path,CustoTotal):-
        gulosaAux(centro,Destino,[centro],Path,0,CustoTotal),!.

gulosa(Partida,Destino,Path, CustoTotal):-
        gulosaAux(Partida,Destino, [Partida], Path,0,CustoTotal),!.

gulosaAux(Destino,Destino, Visited,  Path,Custo, Custo):-reverse(Visited,Path).
gulosaAux(Atual, Destino, Visited, Path,Custo, Total):-
        listaAdj(Atual, Visited,List),
        menorCustoAdj(Destino,List,MenorNodo),
        adjacente(Atual,MenorNodo, CustoDist),
        NewCost is Custo+CustoDist,
        gulosaAux(MenorNodo, Destino, [MenorNodo|Visited], Path,NewCost, Total).


%--------------------------------------------------------------------------------------------------


%Calcula o Custo Total de um Caminho
custoTotalCaminho(Path,Custo):-
        custoTotalCaminho(Path,0,Custo),!.

custoTotalCaminho([_| []],Custo,Custo).
custoTotalCaminho([Fst,Snd| T],Custo,Res):- 
        adjacente(Fst,Snd,CustoAresta),
        NewCost is CustoAresta + Custo,
        custoTotalCaminho([Snd|T],NewCost,Res).

%--------------------------------------------------------------------------------------------------


%Pesquisa informada A*

%Dado um Par Custo-Path, e uma lista de nodos adjacentes ao último do Path, devolve uma Lista de Custo-Path com as novas possibilidades
makeListPairEstrela(_,[],Res,Res).
makeListPairEstrela(L,[H | T],List,Res):- 
        L=Valor-LA,
        LA=[A|_],
        adjacente(A,H,CustoAresta),
        Soma is Valor+CustoAresta,
        NewList=Soma-[H | LA],
        makeListPairEstrela(L,T,[NewList | List],Res).

%Dado o Destino, e uma lista de pares Custo-Path, devolve o Par com menor custo e a lista dos restantes Pares       
menorCustoEstrela(Destino,[H | T],MenorNodo,Resultado):-
        H=CustoCaminho-[Nodo | _],
        nodo(Nodo,Destino,CustoEstimado),
        CustoTotal is CustoCaminho+CustoEstimado,
        menorCustoEstrelaAux(Destino,T,CustoTotal,H,MenorNodo,[],Resultado).


menorCustoEstrelaAux(_,[],_,MenorNodo,MenorNodo,PossiveisTotal,PossiveisTotal).
menorCustoEstrelaAux(Destino,[H | T],C, MenorNodo,Res,PossiveisTotal,ResPossiveis):-
        H=CustoCaminho-[Nodo | _],
        nodo(Nodo,Destino,CustoEstimado),
        CustoTotal is CustoCaminho+CustoEstimado,
        (CustoTotal < C)->
                menorCustoEstrelaAux(Destino,T,CustoTotal,H,Res,[MenorNodo| PossiveisTotal],ResPossiveis);
                menorCustoEstrelaAux(Destino,T,C,MenorNodo,Res,[H | PossiveisTotal],ResPossiveis).




estrela(Partida,Destino,Path,CustoTotal):-
        Par=0-[Partida],
        estrelaAux(Par,Destino,[Partida],[],Path,CustoTotal),!.

estrela(Destino,Path,CustoTotal):-
        Par=0-[centro],
        estrelaAux(Par,Destino,[centro],[],Path,CustoTotal),!.




estrelaAux(Custo-[Destino| T],Destino,_,_,Path,Custo):-reverse([Destino|T],Path).
estrelaAux(ParAtual,Destino,Visited,Possiveis,Path,Custo):-
        ParAtual=_-[Atual| _],
        listaAdj(Atual,Visited,List),
        makeListPairEstrela(ParAtual,List,[],PossiveisNew),
        append(PossiveisNew,Possiveis,PossiveisTotal),
        menorCustoEstrela(Destino,PossiveisTotal,Par,NewPossiveisTotal),
        Par=_-[Nodo|_],
        estrelaAux(Par,Destino,[Nodo | Visited],NewPossiveisTotal,Path,Custo).
        

%Transforma um path de ida, num path de ida e volta       
fullPath(Path,Res):-
        reverse(Path,[_| T]),append(Path,T,Res).

/*
endEstrela(_,[]).
endEstrela(Menor,[Valor-_|T]):-Menor=<Valor,endEstrela(Menor,T).
endEstrela(Menor,[Valor-_|_]):-Menor>Valor,fail.
*/

%-------------------------------------------------------------------------------------------------------



%Representação dos diversos pontos de entrega em forma de grafo, tendo em conta que apenas se devem ter localizações (rua e/ou freguesia) disponíveis;


%--------------------------------------------------------------------------------------------------


%Identificar quais os circuitos com maior número de entregas (por volume e peso)        ;


%agrupar em listas com a mesma morada
agrupaPorMorada([],ListaRes,ListaRes).
agrupaPorMorada( [H|T],List,Res):-
        H=(_,Morada,_,_),
        countAllPesoVolume([H|T],Morada,[],NewList,0,Soma),
        agrupaPorMorada(NewList,[Morada-Soma | List],Res).


%Soma o peso e volume de uma Morada, adiciona os que não pertencem à Morada à Lista
countAllPesoVolume([],_,List,List,Res,Res).
countAllPesoVolume([H | T],Morada,List,ListRes,Acc,Res):-
        H=(_,M,P,V),
        (M=Morada ->
        Soma is P+V+Acc,countAllPesoVolume(T,Morada,List,ListRes,Soma,Res);
        countAllPesoVolume(T,Morada,[H|List],ListRes,Acc,Res)).


toCircuitoListPar([],[]).
toCircuitoListPar([A-B | T],[Caminho-B |Res]):-
        getCircuito(A,Caminho,_),
        toCircuitoListPar(T,Res).


top3CircuitoPesoVolume(Res):-
        findall( (X,M,P,V) , (encomenda(X,_,M,_,P,V,_,_),entrega(X,_,_,_,_,_,_,_,_)), List),
        agrupaPorMorada(List,[],AgrupadoList),
        sort(2,@>=, AgrupadoList, ListSort),
        take(3,ListSort,Top3),!,
        toCircuitoListPar(Top3,Res).                     

%--------------------------------------------------------------------------------------------------
        

%Devolve o melhor caminho para um determinado destino, 
%através da pesquisa informada A*, assim como o seu custo.
getCircuito(Destino,Res,Custo):-
        estrela(Destino,Res,Custo).


%Devolve veiculo a ser utilizado numa entrega, tendo em atenção o peso da encomenda
getVeiculo(Peso, X):-  
        ecologico(X,_),
        meioTransporte(X,_,PesoMax),
        PesoMax > Peso.


%Devolve veiculo capaz de realizar a entrega e o seu tempo, tendo em atençao o peso e o prazo limite
getVeiculoParaEntrega(Id,Veiculo,Time):-
        encomenda(Id,_,Destino,_,Peso,_,_,_),
        getVeiculo(Peso,Veiculo),
        velocidadeEntrega(Veiculo,Peso,Vel), %velocidade de entrega, em km/h
        getCircuito(Destino,_,Custo),
        Time is Custo/Vel,
        prazolimite(Id,_,H),
        Time<H.

%Transforma uma lista: o par Veiculo-Hora em Veiculo-Minutos
toMinutos([],[]).
toMinutos([A-Time | T],[A-NewTime |Res]):-
        NewTime is Time*60,
        toMinutos(T,Res).

%Devolve uma lista de par Veiculo-Minutos, com todos os veículos capazes de realizar a entrega da encomenda ID
circuitoVeiculoTempoEntrega(Id,Res):-
        findall(Veiculo-Time,getVeiculoParaEntrega(Id,Veiculo,Time),List),
        toMinutos(List,Res).



%Lista com todos os veículos capazes de fazer a entrega, ordenados por menor tempo para a efetuar
compararPorProdutividade(Id,Res):-
        circuitoVeiculoTempoEntrega(Id,List),
        sort(2, @=<, List, Res). 


%--------------------------------------------------------------------------------------------------

%Escolher o circuito mais rápido (usando o critério da distância);

caminhoMaisRapidoDistancia(Id,H,carro):-
        encomenda(Id,_,Destino,_,_,_,_,_),
        findall(Par,caminho(centro,Destino,Par),List),
        sort(2, @<, List, [H | _]).

%--------------------------------------------------------------------------------------------------

%Escolher o circuito mais ecológico (usando um critério de tempo);

caminhoMaisEcologicoTempo(Id,Res):-
        circuitoVeiculoTempoEntrega(Id,[Res | _]).

%--------------------------------------------------------------------------------------------------


