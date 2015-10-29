// hp - тип фільтра, фільтр високих частот.
// 99 - порядок фільтра.
// [.35 0] - подвійний вектор частот зрізу.
// hm - тип вікна.
// [0 0] - подвійний вектор параметрів вікна.

[wft,wfm,fr]=wfir('hp',99,[.35 0],'hm',[0 0]);

plot2d(fr,20*log10(wfm))

xtitle('High-Pass filter using wfir with Hamming window', 'freq (Hz)','Amplitude (dB)')

// hp - тип фільтра, фільтр високих частот.
// 99 - порядок фільтра.
// [.35 0] - подвійний вектор частот зрізу.
// ch - тип вікна.
// [.05 -1] - подвійний вектор параметрів вікна.

//[wft,wfm,fr]=wfir('hp',99,[.35 0],'ch',[.05 -1]);

//plot2d(fr,20*log10(wfm))

//xtitle('High-Pass filter using wfir with  Chebyshev window', 'freq (Hz)','Amplitude (dB)')

