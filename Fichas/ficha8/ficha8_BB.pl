%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ITELIG�NCIA ARTIFI    CIAL - MiEI/LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.
:- dynamic idade/2.
:- dynamic avo/2.
:- dynamic neto/2.
:- dynamic descendente/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

filho(joao, jose).
filho(jose, manuel).
filho(carlos, jose).
:-discontiguous filho/2.

pai(paulo, filipe).
pai(paulo, maria).
:-discontiguous pai/2.

avo(antonio, nadia).
:-discontiguous avo/2.

neto(nuno, ana).
:-discontiguous neto/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai(P, F) :- filho(F, P).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo(A, N) :- filho(X, A), filho(N, X).

avoDesc(A, N):- descendente(A, N, 2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado neto: Avó,Neto -> {V,F}

neto(N, A):- avo(A, N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente(D, A, 1):- filho(D, A).
descendente(D, A, G):- filho(D, X), descendente(X, A, N), G is N+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido



% i) Não pode existir mais do que uma ocorrência da mesma evidência na relação filho/2

%+filho(F,P) :: (findall ( (F,P), (filho (F,P)), S), length(S,N), N==1).
+filho( F,P ) :: (findall( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N == 1).

%ii) Não pode existir mais do que uma ocorrência da mesma evidência na relação pai/2

+pai(P,F) :: (findall ( (P, F), pai(P,F), S ), 
                        length(S,N),
                        N==1.)

%iii) Não pode existir mais do que uma ocorrência da mesma evidência na relação neto/2

+neto(N,A) :: (findall ( (N, A), neto(N,A), S ), 
                length(S,N),
                N==1.)

%iv) Não pode existir mais do que uma ocorrência da mesma evidência na relação avô/2

+avo(A,N) :: (findall ( (A, N), avo(A,N), S ), 
                length(S,N),
                N==1.)

%v) Não pode existir mais do que uma ocorrência da mesma evidência na relação descendente/3

+descendente(A,N, G) :: (findall ( (A, N, G), descendente(A,N,G), S ), 
                        length(S,N),
                        N==1.)

% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo


%vi) Não podem existir mais do que 2 progenitores para um dado indivíduo, na relação filho/2 

+filho(F,P) :: (findall( (Fs), (filho(Fs, Ps)), S), 
                length(S,N), 
                N=<2).

%vii) Não podem existir mais do que 2 progenitores para um dado indivíduo, na relação pai/2 

+pai(P,F) :: (findall( (Fs), (pai(Ps, Fs)), S), 
                length(S,N), 
                N=<2).

%viii) Não podem existir mais do que 4 indivíduos identificados como avô na relação neto/2

+neto(N,A) :: (findall( (As), (neto(Ns, As)), S), 
                length(S,N), 
                N=<4).

%ix) Não podem existir mais do que 4 indivíduos identificados como avô na relação neto/2 

+avo(A,N) :: (findall ( (As, Ns), avo(As,Ns), S ), 
                length(S,N),
                N=<4.)


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens�o do predicado que permite a evolucao do conhecimento

evolucao(Termo) :- findall(Invariante, +Termo::Invariante,Lista),
                   insercao(Termo),
                   teste(Lista).

insercao(Termo):- assert(Termo).
insercao(Termo):- retract(Termo), !, fail.

teste([]).
teste([R|LR]):- R,
                teste(LR).

