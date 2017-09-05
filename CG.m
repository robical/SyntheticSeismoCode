function [sol]=CG(B,MaxItr,tol,y)
% function [sol]=CG(A,b)
%
% INPUT:
% A= matrice del sistema lineare da risolvere
% b= termini noti
% MaxItr= max numero di iterazioni permesse
% tol= tolleranza sulla norma del residuo
%
%
% OUTPUT:
% sol= soluzioni del sistema 
%

%Impostazione del problema (sovradeterminato)

% B=(A'*A + e*eye(size(A))); %matrice definita positiva (nel caso fosse semidef, si può aggiustare con damping)
% y=A'*b; %nuovi dati

%Step CG

i=1;
y=y(:);
beta(i)=0; %coefficiente costruzione base A-ortogonale con Gram Schmidt
x(:,i)=zeros(size(B,2),1); %soluzione iniziale
r(:,i)= y - B*x(:,i); %redisuo
d(:,i)= r(:,i); %direzione di ricerca
while(i<MaxItr && norm(r(:,i))>tol)
temp1=r(:,i)'*r(:,i);
temp2=B*d(:,i);
alfa(i)=(temp1)/(d(:,i)'*temp2); %passo nella direzione di ricerca
x(:,i+1)=x(:,i) + alfa(i)*d(:,i); %nuova soluzione
r(:,i+1)=r(:,i) - alfa(i)*temp2; %nuovo residuo
beta(i+1)= (r(:,i+1)'*r(:,i+1))/temp1; %coefficiente costruzione base A-ortogonale con Gram Schmidt
d(:,i+1)= r(:,i+1) + beta(i+1)*d(:,i); %nuova direzione A-ortogonale
i=i+1;
end

if ((i-1)==MaxItr)
    disp('Raggiunto numero massimo di iterazioni.')
    sol=x(:,end);
else
    disp('Raggiunta norma del residuo desiderata.')
    sol=x(:,end);
end
