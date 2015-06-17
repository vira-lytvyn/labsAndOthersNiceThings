T=0.001;
Ng=10;
Ne=300;
h=T/Ne;
w = 0 : h : 1.1e-3;
A=0.6e-3 * ones(w);
B=1e-3 * ones(w);
s=zeros(w);
for i = 1:Ne  
    if (w(i) >= 0) & (w(i) <= A(i)) then  
        s(i)=(A(i)/15.5e-3)*i;  
    elseif (w(i) > A(i)) & (w(i) <= B(i)) then 
        s(i)=7;  
    else 
        s(i)=0;  
    end;  
end;
plot(w, s);
