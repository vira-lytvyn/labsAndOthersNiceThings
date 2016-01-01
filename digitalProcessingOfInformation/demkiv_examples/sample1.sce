//Frequency components of a signal
//----------------------------------
// build a noised signal sampled at 1000hz  containing  pure frequencies 
// at 50 and 70 Hz
sample_rate=800;
t = 0:1/sample_rate:0.1;
N=size(t,'*'); //number of samples
s=2*sin(2*%pi*50*t)+2*sin(2*%pi*280*t+%pi/4)+0*grand(1,N,'nor',0,1);
 
y=fft(s);
y1=ifft(y);
//s is real so the fft response is conjugate symmetric and we retain only the first N/2 points
k1=N/4;
sf=zeros(1:N);
for k=1:N/2
    if k<k1 then
        sf(k)=y(k);
    else
        sf(k)=0;
    end
end
f=sample_rate*(0:(N/2))/N; //associated frequency vector
n=size(f,'*')
clf()
//plot(f,abs(y(1:n)))
s1=ifft(sf);
subplot(3,2,1);
plot(t,s)
subplot(3,2,2);
plot(f,abs(y(1:n)))
subplot(3,2,3);
plot(t,y1)
subplot(3,2,4);
plot(f,abs(sf(1:n)))
subplot(3,2,5);
plot(t,s1)

