// bp - тип фільтра, фільтр загороджуючий.
// 111 - порядок фільтра.
// [.25 .35] - подвійний вектор частот зрізу.
// hm - тип вікна.
// [0 0] - подвійний вектор параметрів вікна.

[wft,wfm,fr]=wfir('bp',111,[.25 .35],'hm',[0 0]);

plot2d(fr,20*log10(wfm))

xtitle('SF filter using wfir with Hamming window', 'freq (Hz)','Amplitude (dB)')

// bp - тип фільтра, фільтр загороджуючий.
// 99 - порядок фільтра.
// [.25 .35] - подвійний вектор частот зрізу.
// ch - тип вікна.
// [.05 -1] - подвійний вектор параметрів вікна.

//[wft,wfm,fr]=wfir('bp',111,[.25 .35],'ch',[.05 -1]);

//plot2d(fr,20*log10(wfm))

//xtitle('SF filter using wfir with  Chebyshev window', 'freq (Hz)','Amplitude (dB)')


