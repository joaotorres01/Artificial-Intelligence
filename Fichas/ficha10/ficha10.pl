% Ficha10   

%---------------------------------------------------------------------
%Programacao em logica estendida
%Representacao de conhecimento imperfeito

%---------------------------------------------------------------------
:- op(900, xyf, '::').
:- dynamic '-'/1.
:- dynamic jogo/3.

%---------------------------------------------------------------------
-jogo(Jogo, Arbitro, Ajudas):-
    nao(jogo(Jogo, Arbitro, Ajudas)),
    nao(excecao(jogo(Jogo, Arbitro, Ajudas))).

%i)
jogo(1, aa, 500).

%ii)
jogo(2, bb, xpto123).
excecao(jogo(Id, Arb, Aj)):- jogo(_,_, xpto123).

%iii)
excecao(jogo(3,cc, 500)).
excecao(jogo(3,cc, 2000)).

%iv)
excecao(jogo(4,dd, Aj)):- Aj>=250 , Aj=< 750.

%v)
jogo(5,ee, AjImp).
excecao(jogo(Id,Arb, Valor)):- jogo(Id, Arb, AjImp).
nulo(AjImp).
+jogo(J,A,Ajuda)::(findall (Ajudas, 
                  (jogo(5,ee,Ajudas)),
                  nao(nulo(Ajudas)), S),
                  length(S, N),
                  N==0.

%vi)
excecao(jogo(6,ff, 250)).
excecao(jogo(6,ff, Aj)):- Aj>=5000.

%vii)
-jogo(7,gg,2500).

jogo(7,gg, xpto123).
excecao(jogo(Id, Arb ,Aj)):- jogo(_,_,xpto123). 

%viii)
%Considerei uma incerteza de 50%
excecao(jogo(8,hh,Aj)):- Aj>=1000*0.5, Aj=< 1000*1.5.

%ix)
%Considerei uma incerteza de 10%
excecao(jogo(9,ii, Aj)) :- Aj>=3000*0.9, Aj=< 3000*1.1.

%x)
+jogo(J,A,Ac):: findall( (J), (jogo(J,Arb,_)), Lista),
                length(Lista,N),
                N==1.

+jogo(J,A,Ac):: findall( (Arb), (jogo(J,Arb,_)), Lista),
                length(Lista,N),
                N=<3.

+jogo(J,A,Ac):: findall( (J1,J2), (jogo(J1,Arb,_)), (jogo(J2,Arb,_)), Lista),
                length(Lista,N),
                J2 is J1+1,
                N==0.


si(Q,verdadeiro):- Q.
si(Q, falso):- -Q.
si(Q, desconhecido):-
    nao(Q),
    nao(-Q).

evolucao(Termo):-
    findall(Inv, +Termo::Inv, Lista),
    insercao(Termo),
    teste(Lista).

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo), !, Fail.

teste([]).
teste([X|R]):- X, teste(R).



%Feito na Aula Prática

%ii)
jogo(2, bb, xpto123).
excecao(jogo(Id, Nome, Ajudas)):- jogo(_,_,xpto123).

%iii)
excecao(jogo(3,cc,500)).
excecao(jogo(3,cc,2500)).

%iv)
excecao(jogo(4,dd,X)):- X>=250, X=<750. 

%v)
excecao(5,ee,xpto123).

+jogo(J,A,Ajuda)::(findall (Ajudas, 
                  (jogo(5,ee,Ajudas)),
                  nao(nulo(Ajudas)),S),
                  length(S, N),
                  N==0.
