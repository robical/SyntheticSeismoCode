function [dir]=Acondir(A)
% function [dir]=Acondir(A)
% Fornisce le direzioni coniugate create via Gram-Schmidt
%
% INPUT:
% A= matrice rappresentante il sistema lineare da risolvere
%
% OUTPUT:
% dir= matrice delle direzioni A coniugate
%
%

U=eye(min(size(A)));
B=A'*A; %deve essere definita positiva e simmetrica

dir=U;
for i=2:size(U,2)
    for kk=1:1:(i-1)
        dir(:,i)=dir(:,i) - ((U(:,i)'*B*dir(:,kk))/(dir(:,kk)'*B*dir(:,kk)))*dir(:,kk);
    end
end