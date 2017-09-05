function [sol,itr]=SD(R,b,tol,Maxitr,damp)
% function [sol]=SD(R,b,tol,Maxitr,damp)
% metodo iterativo SD per risoluzione di sistemi sovradeterminati
% R è NxM con N>M
%
% INPUT:
%
% R= matrice forward del problema
% b= vettore dei dati
% tol= tolleranza sulla norma 2 dell'errore della soluzione tra 2 passi a convergenza
% Maxitr= iterazioni massime eseguibili da SD
% damp= va usato solo se la matrice di Gram di R risulta semidef pos, e
% questo si può controllare se SD non converge anche per alte tolleranze,
% questo evidenzierebbe perdite di rango in R, dunque 0 se converge e una
% quantità da scegliere accuratamente se non converge
%
% OUTPUT:
%
% sol= soluzione
% itr= iterazioni eseguite effettivamente dall'algoritmo


%Si riformula il problema in modo che possa essere risolto con una tecnica 
%iterativa, in questo caso con Steepest Descent

V=(R'*R + damp*eye(size(R,2))); %semi def pos <--- fondamentale, è possibile aggiungere damping nel caso 
%non converga in tempo utile
v=R'*b;


i=1;
a(:,i)=ones(size(R,2),1); %inizializzazione modello

%redisuo nei dati all'iterazione 1
e(:,i)=V*a(:,i)-v; %questo è anche il gradiente
al(i)=-((e(:,i)'*e(:,i))/(e(:,i)'*V*e(:,i))); %ottimizzo passo di aggiornamento

while(i==1 || (((a(:,i)-a(:,i-1))'*(a(:,i)-a(:,i-1)))>tol && i<Maxitr)) %nel caso sovradeterminato non posso annullare il residuo
    i=i+1;
    a(:,i)=a(:,i-1)+al(i-1)*e(:,i-1); %aggiorno la soluzione
    e(:,i)=V*a(:,i)-v; %questo è anche il gradiente
    al(i)=-((e(:,i)'*e(:,i))/(e(:,i)'*V*e(:,i))); %ottimizzo passo di aggiornamento
end


sol=a(:,end);
itr=i-1; %numero di iterazioni fatte