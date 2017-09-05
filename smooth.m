
function Z=smooth(w,dim_m,dim_p)
%function Z=smooth(w,dim_m,dim_p)
%
% INPUT:
% w= filtro
% dim_m= dimensione modello
% dim_p= dimensione modello riparametrizzato
%
% OUTPUT:
% Z= operatore di smoothing
if (size(w,1)~=1 && size(w,2)~=1)
    disp('w must be a column vector!');
    return;
end

w=w(:);    
    
dim_w=length(w);

%Triangle Smoothing
if (dim_m>=dim_w)
    Z=toeplitz([w;zeros(dim_m-dim_w,1)],[w(1) zeros(1,dim_p-1)]);
else
    Z=toeplitz([w(1:dim_m)],[w(1) zeros(1,dim_p-1)]);
end