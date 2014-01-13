This knowledge base contains various clauses and facts which help to find out whether the given input is a group or not. And by extension, whether the input is an abelian group or not.  

How to give input:  
	The input is given as two lists, the list of elements S and another list of triplets Op [a*b, a, b]. where a*b is the result of the binary operation defined on the elements in S.

Methods / Clauses available:  
1. has([list],element)  
2. isClosed(S,Op)  
3. hasIdent(Op,X)  
4. hasLInverse(S,Op)  
5. isAssociative(Op)  
6. isGroup(S,Op)  
7. isAbel(S,Op)  
8. isCommutative(Op)  
where X is an arbitrary variable  
Explanation / how to use :  
call the respective clauses where S is the list of elements of the group S = [item1,item2,..],Op = [[a*b,a,b],...] and X is arbitrary.	
