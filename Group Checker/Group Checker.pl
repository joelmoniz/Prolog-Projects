hasIdent(B,E1) :- hasIdentCheck1(B,B,E1),print('Has identity'),nl.
hasIdentCheck1([[Bo,Ba,Bb]|B2],C,E1) :- ((Ba = Bo; Bb = Bo)
				         -> ((Ba = Bo)
					    ->	E1 = Bb
					    ;	E1 = Ba),
					     hasIdentCheck(C,E1),hasUniversalIdentCheck(C,E1),isIdentOnlyLOrRIdent(C,E1)
				    ;	hasIdentCheck1(B2,C,E1)).
hasIdentCheck([[Mo,Ma,Mb]|M2],E) :- (  (Ma = Mo ; Mb = Mo)
				         ->  ((Ma = Mo , Mb = E)
					     ->	 hasIdentCheck(M2,E)
					     ;	 ((Ma = E , Mb = Mo)
						 ->   hasIdentCheck(M2,E)
						 ;   false))
				    ;	hasIdentCheck(M2,E)).
hasIdentCheck([],_) :- true.
hasUniversalIdentCheck([[Uo,Ua,Ub]|U],E1):- ((\+(Ua = E1) , \+(Ub=E1)),(Ua = Uo ; Ub = Uo) %if one is identity and the other element is identical to Ua*Ub
						-> false
						;  hasUniversalIdentCheck(U,E1)).
hasUniversalIdentCheck([],_):- true.
isIdentOnlyLOrRIdent([[Lo,La,Lb]|L],E1):- ((La = E1 , \+(Lb = Lo));(Lb = E1 , \+(La = Lo))
					      ->  false
					      ;	   isIdentOnlyLOrRIdent(L,E1)).
isIdentOnlyLOrRIdent([],_):- true.
% identity is unique
%


hasInverse(L,B):- hasIdent(B,E),hasInverseCheck(L,B,B,E).
hasInverseCheck([],_,_,_):- print('Inverse is present').

hasInverseCheck([A|L],[[Co,Ca,Cb]|C],B,E):- ((Co=E,(Ca=A;Cb=A))
					    ->	(Ca=A
						->  I = Cb
						;   I = Ca),
					    duplicateInverseCheck([A|L],C,B,E,I)
					    ;	hasInverseCheck([A|L],C,B,E)).
duplicateInverseCheck([_|L],[],B,E,_):- hasInverseCheck(L,B,B,E).
duplicateInverseCheck([A|L],[[Co,Ca,Cb]|C],B,E,I):- ((Co=E,\+(Ca=I),\+(Cb=I),(Ca=A;Cb=A))
						    ->	print('No inverse exists')
						    ;	duplicateInverseCheck([A|L],C,B,E,I)).

hasLInverse(L,B):- hasIdent(B,E),hasLInverseCheck(L,B,B,E),!.
hasLInverseCheck([],_,_,_):- print('Left Inverse is present'),nl.

hasLInverseCheck([A|L],[[Co,Ca,Cb]|C],B,E):- ((Co=E,Cb=A)
					    ->	I = Ca,
					    duplicateLInverseCheck([A|L],C,B,E,I)
					    ;	hasLInverseCheck([A|L],C,B,E)).
duplicateLInverseCheck([_|L],[],B,E,_):- hasLInverseCheck(L,B,B,E).
duplicateLInverseCheck([A|L],[[Co,Ca,Cb]|C],B,E,I):- ((Co=E,\+(Ca=I),(Cb=A))
						    ->	print('No inverse exists')
						    ;	duplicateLInverseCheck([A|L],C,B,E,I)).




isUniqueAOB([[Co,Ca,Cb]|T],O,A,B):- ((Ca = A, Cb = B, \+(Co = O))
				    ->	false
				    ;	isUniqueAOB(T,O,A,B)).
isUniqueAOB([],_,_,_):- true,!.


% a*b is unique
% b*a will occur
isCommutative(L):- isCommutative2(L,L),print('Is commutative'),nl.
isCommutative2([[O,A,B]|T],L):- isCommuChecker(T,L,L,O,A,B).
isCommutative2([],_):- !.
isCommuChecker(T,[[Co,Ca,Cb]|TAIL],ORIGINAL,O,A,B):- ((Ca = B, Cb = A, \+(Co = O))
				       ->  false
				       ;   ((Ca = B, Cb = A, Co = O)
					   ->  isCommutative2(T,ORIGINAL)
					   ;   isCommuChecker(T,TAIL,ORIGINAL,O,A,B))).

%same assumptions as assoc
%a*(b*c) and (a*b)*c both exist
isAssociative(L):- isAssociative2(L,L),print('Is associative'),nl,!.
isAssociative2(L,[[O,A,B]|T]):- isAssociativeCheck(L,L,T,O,A,B).
isAssociative2(_,[]):- !.
isAssociativeCheck(L,[[O2,O1,C]|T],REMAINING,O,A,B):- (O=O1
					      ->  isAssociativeCheck2(L,L,A,B,C,O2,REMAINING)
					      ;	  isAssociativeCheck(L,T,REMAINING,O,A,B)).
isAssociativeCheck(L,[],REMAINING,_,_,_):- isAssociative2(L,REMAINING).
isAssociativeCheck2(L,[[O1,B1,C1]|T],A,B,C,O,REMAINING):- ((B=B1,C=C1)
						->  isAssociativeCheck3(L,L,A,O1,O,REMAINING)
						;   isAssociativeCheck2(L,T,A,B,C,O,REMAINING)).
isAssociativeCheck3(L,[[O2,A2,Ocheck]|T],A,O1,O,REMAINING):- ((A2=A,Ocheck=O1)
						   ->  (O2=O
						       ->  isAssociative2(L,REMAINING)
						       ;   false)
						   ;   isAssociativeCheck3(L,T,A,O1,O,REMAINING)).



len([],0).
len([_|T],N) :- len(T,X), N is X+1.
has([],_):-false.
has([H|T],X):-
	H\==X->has(T,X);true.
isClosed(S,[[A,_,_]|Y]):-
	has(S,A),isClosed(S,Y),!.
isClosed(_,[]):-true,print('Is closed'),nl,!.


isGroup(S,Op):-
	len(S,X),len(Op,Y),X*X =:= Y,isClosed(S,Op)
	,isAssociative(Op),hasLInverse(S,Op).


isAbel(S,Op):-
	isGroup(S,Op),isCommutative(Op).






