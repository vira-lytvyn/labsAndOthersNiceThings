// 50 - довжина фільтра.
// [0 .15;.2 .5] - матриця розміром Mx2, що визначає границі для кожної зі смуг пропускання фільтра.
// [1 0] - тип вікна.
// [.025 1] - подвійний вектор параметрів вікна.

hn=eqfir(50,[0 .15;.2 .5],[1 0],[.025 1]);

xsetech([0,.5,1,.5])
[hm,fr]=frmag(hn,256);
subplot(2,2,2)
plot2d(fr,20*log10(hm))


xgrid()

xtitle('Low-Pass filter using wfir - rectangle window', 'freq (Hz)','Amplitude (dB)')
