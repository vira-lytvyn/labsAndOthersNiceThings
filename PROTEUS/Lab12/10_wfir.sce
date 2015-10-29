// sb - тип фільтра, фільтр режекторний.
// 81 - порядок фільтра.
// [.1 .4] - подвійний вектор частот зрізу.
// hm - тип вікна.
// [0 0] - подвійний вектор параметрів вікна.

//[wft,wfm,fr]=wfir('sb',81,[.1 .4],'hm',[0 0]);

//plot2d(fr,20*log10(wfm))

//xtitle('RF filter using wfir with Hamming window', 'freq (Hz)','Amplitude (dB)')

// sb - тип фільтра, фільтр режекторний.
// 81 - порядок фільтра.
// [.1 .4] - подвійний вектор частот зрізу.
// ch - тип вікна.
// [.05 -1] - подвійний вектор параметрів вікна.

[wft,wfm,fr]=wfir('sb',81,[.1 .4],'ch',[.05 -1]);

plot2d(fr,20*log10(wfm))

xtitle('RF filter using wfir with  Chebyshev window', 'freq (Hz)','Amplitude (dB)')


