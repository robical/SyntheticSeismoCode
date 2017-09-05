function [xf,xc_2]=fermat(x0,pric,s,v)

%punto di contatto al 2 strato
xc_2=(pric(:,1)-x0(1))/2;

for i=1:length(xc_2)

a= v(2)^2+v(1)^2;
b=2*x0(1)*v(1)^2-2*xc_2(i)*v(2)^2;
c1=v(2)^2*(s(2)-s(1))^2;
c2=v(1)^2*(s(1)-x0(2))^2;
c=xc_2(i)^2*v(2)^2 - x0(1)^2*v(1)^2 - c2 + c1;

temp=roots([a b c]);

if (isreal(temp(1))==1)
    xf(i)=temp(1);
else
    xf(i)=temp(2);
end

end



