//
//
//
//
//
//
X=1;
is=512;
delta_t=1/512;
//
id=64;
N=2^13;
imax=1000;
//
//
//
F=1/(delta_t*is);
Td=delta_t*id;
Fd=1/Td;

x=zeros(1:N);
u=zeros(1:N);
xd=zeros(1:N);
sv=zeros(1:N);
xv=zeros(1:N);
for i=1:N
    //
    x(i)=X*sin(2*%pi*i/is);
    //
if(i/id)-floor(i/id)==0 then
    u(i)=1;
else u(i)=0;
end

xd(i)=x(i)*u(i);
end;
//
s=fft(x);
//
sd=fft(xd);
//
k1=floor(0.5*N/id);
for k=1:N
    if k<k1 then
        sv(k)=sd(k);
    else
        sv(k)=0;
    end
end
xv=ifft(sv);
//
x0=zeros(1:imax);
u0=zeros(1:imax);
xd0=zeros(1:imax);
xv0=zeros(1:imax);
for i0=1:imax
    x0(i0)=x(i0);
    u0(i0)=u(i0);
    xd0(i0)=xd(i0);
    xv0(i0)=xv(i0);
end
kmax=5*k1;
k=1:kmax;
f=zeros(1:kmax);
s0=zeros(1:kmax);
sv0=zeros(1:kmax);
sd0=zeros(1:kmax);
f=k/(delta_t*N);
for k=1:kmax
s0(k)=s(k)*2/N;
sd0(k)=sd(k)*2/N;    
end
xbasr();
subplot(3,2,1);
i0=[1:imax];
t=delta_t*i0;
plot2d(t,x0,style=[color("blue")]);
xtitle('Aналогове синусоїдальне коливання');
xgrid
subplot(3,2,2);
plot2d3(f,abs(s0),style=[color("blue")]);
xgrid
xtitle('spectr analogovoi synusoidu')
subplot(3,2,3)
plot2d3(t,u0)
xtitle('poslidovnist odyny4nuh vidlikiv')
subplot(3,2,4)
plot2d3(t,xd0)
xgrid
xtitle('duskretna synusoida')
subplot(3,2,5)
plot2d(f,abs(sd0),style=[color("red")])
xgrid
xtitle('спектр дискретної синусоїди')
subplot(3,2,6)
plot2d(t,xv0,style=[color("red")])
xgrid
xtitle('Відновлена аналогова синусоїда')
















