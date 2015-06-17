T=0.001;
Ng=10;
Ne=300;
h=T/Ne;
w = 0 : h : 1.01e-3;
A=0.6e-3 * ones(w);
B=1e-3 * ones(w);
s=zeros(w);
for i = 1:Ne  
    if (w(i) >= 0) & (w(i) <= A(i)) then  
        s(i)=(7/A(i))*w(i);  
    elseif (w(i) > A(i)) & (w(i) <= B(i)) then 
        s(i)=7;  
    else 
        s(i)=0;  
    end;  
end;
plot(w, s);

wn = 2 * %pi / T;
ak=zeros(1, Ng);
bk=zeros(1, Ng);
for i = 1:Ng 
    TM = i * wn; 
    G = 0; 
    D = 0; 
    for k = 1:Ne 
        S = TM * w(k); 
        G = G + s(k) * cos(S); 
        D = D + s(k) * sin(S); 
    end; 
    ak(i) = 2 * G / Ne; 
    bk(i) = 2 * D / Ne; 
end;
a0 = 0;
for i = 1:Ne
    a0 = a0 + s(i);
end;
a0 = a0 / Ne;
res = zeros(w);
for i = 1:Ne
    S = 0;
    D = w(i) * wn;
    for k = 1:Ng
        TM = k * D;
        S = S + bk(k) * sin(TM) + ak(k) * cos(TM);
    end;
    res(i) = a0 + S;
end;
plot(w, res);
