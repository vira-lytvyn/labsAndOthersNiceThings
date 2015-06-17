wind = figure(); // Створення графічного вікна
set(wind,'position',[0,0,600,500]); // Задання розмірів нового вікна та початкових координат
set(wind,'figure_name','Дослідження вільних коливань лінійних динамічних систем'); // Задання назви новоствореного вікна

// Створення текстових міток для початкових умов задачі

delta=uicontrol(wind,'style','text','string','δ=','position',[380, 400, 60, 30]);
x_0=uicontrol(wind,'style','text','string','x(0)=','position',[380, 340, 60, 30]);
x_0_=uicontrol(wind,'style','text','string','x(0)*=','position',[380, 280, 60, 30]);

// Створення рядків вводу для початкових даних

edit_delta=uicontrol(wind,'style','edit','string','0.15','position',[460, 400, 80, 30]);
edit_x0=uicontrol(wind,'style','edit','string','0','position',[460, 340, 80, 30]);
edit_x00=uicontrol(wind,'style','edit','string','5','position',[460, 280, 80, 30]);

// Створення кнопок для побудови залежностей і кнопки закриття вікна

BtTwoGraphs=uicontrol('style','pushbutton','string','Графіки x(t), x*(t)','CallBack', '_TwoGraphs','position',[390, 150, 170, 30]); 
BtOneGraph=uicontrol('style','pushbutton','string','Графік x*(x)','CallBack', '_OneGraph','position',[390, 100, 170, 30]); 
BtClose=uicontrol('style','pushbutton','string','Закрити','CallBack', '_Close','position',[390, 50, 170, 30]); 

// Створення площин для побудови графіків

Axes1= newaxes(); Axes1.margins = [ 0 0 0 0]; Axes1.axes_bounds = [0.0453125,0.074364,0.5375,0.4344423];
Axes2= newaxes(); Axes2.margins = [ 0 0 0 0]; Axes2.axes_bounds = [0.0453125,0.5459883,0.5421875,0.3894325];

// Функція, що описує систему дифрівнь першого порядку

function dx = f (t, x)
    dx(1) = x(2);
    dx(2) = -delta*2*x(2)-x(1);
endfunction

// Обробник події натискання на кнопку закриття

function _Close() 
    close(wind);
endfunction 

// Обробник події натискання на кнопку побудови залежностей x(t), x'(t)

function _TwoGraphs()
    delta = strtod(get(edit_delta, 'string')); // конвертація в числовий тип даних, отриманих із рядка вводу
    x_0 = strtod(get(edit_x0, 'string'));
    x_00 = strtod(get(edit_x00, 'string'));
    sca(Axes1); // Активація першої площини для побудови графіків
    if ~isempty(Axes1.children) // Перевірка чи порожня площина для побудови першого графіка
        delete(Axes1.children); // Очищення площини для побудови першого графіка, якщо вона не порожня
    end
    t = 0:0.01:30; // Задання проміжку інтегрування
    y = ode([x_0; x_00], 0, t, f); // Розвязання системи дифрівнянь з початковими умовами x(0) та x(0)'
    plot(t, [y(1,:)', y(2, :)']); // Побудова графіків залежностей x(t) та x'(t)
endfunction

// Обробник події натискання на кнопку побудови фазового портрету

function _OneGraph()
    delta = strtod(get(edit_delta, 'string'));
    x_0 = strtod(get(edit_x0, 'string'));
    x_00 = strtod(get(edit_x00, 'string'));
    sca(Axes2);
    if ~isempty(Axes2.children)
        delete(Axes2.children);
    end
    t = 0:0.01:30;
    y = ode([x_0; x_00], 0, t, f);
    plot(y(1,:), y(2, :));
endfunction
