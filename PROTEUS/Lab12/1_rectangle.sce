// lp - тип фільтра, фільтр низьких частот.
// 50 - порядок фільтра.
// [.15 0] - подвійний вектор частот зрізу.
// re - тип вікна.
// [0 0] - подвійний вектор параметрів вікна.

[wft,wfm,fr]=wfir('lp',50,[.15 0],'re',[0 0]);

plot2d(fr,20*log10(wfm))

xgrid()

xtitle('Low-Pass filter using wfir - rectangle window', 'freq (Hz)','Amplitude (dB)')
