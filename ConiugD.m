function [sol]=ConiugD(A,b)
% function [sol]=ConiugD(A,b)
%
% INPUT:
% A= matrice del sistema lineare di partenza (NxM)
% b= vettore dei termini noti
%
% OUTPUT:
% sol= soluzione del sistema lineare
%
% Casi possibili:
% quadrata simmetrica = si usa direttamente la matrice A ed il metodo ha soluzione unica
% a meno di perdite di rango
% 
% quadrata non simmetrica = si usa la matrice C=1/2*(A'+A), che corrisponde
% alla matrice che forma il sistema lineare la cui soluzione corrisponde
% alla minimizzazione della forma quadratica corrispondente alla matrice A
% 
% rettangolare (sovradeterminato N>M)= B=A'*A c=A'*b, si risolve il problema
% equivalente con direzioni coniugate B*sol=c, si ottiene soluzione ai
% minimi quadrati
%
% rettangolare (sottodeterminato N<M)= B=A*A' c=A*b, si risolve il problema
% equivalente con direzioni coniugate B*sol=c, si ottiene soluzione ai
% minimi quadrati
%

%check: in quale caso siamo