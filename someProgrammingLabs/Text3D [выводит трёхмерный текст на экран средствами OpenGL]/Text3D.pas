{******************************************************************************}
//                                                                            //
//         Компонент вывода на экран анимированного 3D текста                 //
//         с использованием OpenGL.                                           //
//         Версия 1.2                                                         // 
//                                                                            //
//         Создано при использовании книги Краснова "OpenGL в Delphi"         //
//                                                                            //
//         Oe-5ye@yandex.ru                                                   //
//         Дегтярев Константин © 2003                                         //
//                                                                            //
{******************************************************************************}
unit Text3D;

interface
uses
  Forms,
  Graphics,
  Messages,
  Windows,
  OpenGL,
  Classes,
  ExtCtrls;

const
  YAYA_SCALE = 0.7;            // Буква Я :-)
  INIT_STRING = 'Инициализация OpenGL...';
  FONT_WEIGHT_SCALER = 0.08;  // масштабный множитель соотношения длины буквы в пикселах и в пространстве
  FONT_HEIGHT = -28;           // высота создаваемого шрифта

  FONT_SIZE_SCALE = 0.125;     // масштабный множитель размера шрифта
  DEFAULT_PAUSE = 10;          // пауза поумолчанию
  DEFAULT_FONT_SIZE = 40;      // размер шрифта по умолчанию
  GLF_START_LIST = 1000;       // номер для компиляции букв
  BASE_SCALE = 0.08;           // единичный масштаб

  LITERA_HEIGHT = 2;           // высота буквы
  DEFAULT_DELTA_ROW = 3;       // расстояние между строками по умолчанию
  WAVE_AMPLITUDE = 0.3;        // амплитуда волны по умолчанию

  ROTATED_LITERAS = 2;         // количество буковок, которые будут вращаться вместе с центральной
  ROTATION_FRAMES = 20;        // число кадров, за которое повернется буковка (для atRotation)

  INIT_LINE_STEPS = 20;        // количество кадров для инициализации/финализации
  START_POINT_POS = 40;        // начальная удаленность прилетающего текста

  ROTATION_SPEED = 1;          // количество оборотов строки между кадрами для atFixedRotation
  DEFAULT_ROTATION_PERIOD = 6000; // период вращения надписи при нулевом времени переключения
  DIFFUSION_SCALE = pi/8;        // масштаб изменения угла для диффузного изменения строк
  DIFFUS_WAVE_SCALE = 0.1;         // амплитуда диффузного безобразия
  DIFFUS_OFFSET = 5;           // смещение колбасности букв

type
  // качество букв
  TQualityType = (qtFastest,
                  qtBest);

  // возможные виды анимации
  TAnimationType = (atFixedRotation,  // обычное вращение всего текста
                    atWave,           // волна
                    atHorWave,        // волна в плоскости горизонта
                    atSingleWave,     // единичная волна
                    atHorSingleWave,  // единичная волна в плоскости горизонта
                    atZoomWave,       // единичная волна с увеличением
                    atRotation);      // буковки вращаются

  TAnimationSet = set of TAnimationType;

  // описывает текущее состояние текста (прилетает, улетает, просто показывается)
  TTextCondition = (tcNormal, tcInit, tcGetOut);

  // тип смены линий
  TChangeStyle = (csSwitch,            // просто переключение
                  csRightToLeft,       // справа налево
                  csLeftToRight,       // слева направо
                  csLeftAndRight,      // вразбежку (в зависимости от индекса строки)
                  csBottomToTop,       // снизу вверх
                  csTopToBottom,       // сверху вниз
                  csTopAndBottom,      // верх и низ
                  csLiterasUpDown,              // буквы разлетаются вверх и вниз по отдельности
                  csDiffusion          // диффузия
                  );

  TText3D = class (TCustomPanel)
  private
    FDefaultRotationPeriod : word;
    // событие, возникающее при окончании некоторого цикла анимации
    FOnAnimateCycleDone : TNotifyEvent;
    // событие, возникающее при смене строк
    FOnLinesChanging : TNotifyEvent;
    // набор стилей анимации
    FAnimationSet : TAnimationSet;
    // интенсивность света
    FLightIntensity : byte;
    // характеристики шрифта - имя
    FFontName : TFontName;
    // характеристики шрифта - размер
    FFontSize : integer;
    // характеристики шрифта - стиль
    FFontStyle : TFontStyles;
    // характеристики шрифта - набор символов
    FFontCharset : TFontCharset;
    // характеристики шрифта - цвет
    FFontColor : TColor;
    // амплитуда волны
    FWaveAmplitude : glFloat;
    // вид смены строк
    FChangeStyle : TChangeStyle;
    // описание текущего состояния текста
    FTextCondition : TTextCondition;
    // угол обзора - по умолчанию 30 градусов
    FVisionAngle : word;
    // смещение влево
    FLeftOffset : glFloat;
    // смещение вверх
    FTopOffset : glFloat;
    // расстояние между буквами
    FLiterasGap : glFloat;
    // расстояние между столбцами
    FRowsGap : glFloat;
    // толщина шрифта
    FLiteraDepth : glFloat;
    // количество отображаемых строк , 0 - все строки
    FLinesCount : word;
    // реально отображаемое количество строк
    FShownRows : word;
    // FRedraw - флаг перерисовки при выключении активности
    FRedraw : boolean;
    // мастштаб
    FScale : glFloat;
    // пауза между строками в кадрах
    FNewRowDelay : integer;
    // угол по оси y ( поворот в плоскости горизонта)
    FAngleY : glFloat;
    // и по оси Х - поворот вдоль вертикали
    FAngleX : glFloat;
    // подсчет кадров
    FCounter:integer;
    // внутренний счетчик для периодических действий
    FTmpCounter : integer;
    // индекс текущей строки
    FRowIndex:word;
    // флаг активности
    FActive : boolean;
    // цвет фона
    FBackColor : TColor;
    // список со строками
    FItems : TStringList;
    // внутренний таймер
    FTimer : TTimer;
    // частота обновления (мс)
    FRefreshDelay: word;
    // качество букв
    FQualityType : TQualityType;

    FGuidDC : HDC; // контекст вывода для GUID
    FGLDC : HGLRC; // контекст вывода для OpenGL

    // установка качества
    procedure SetQuality(aQuality : TQualityType);
    // процедура установки вручную нового индекса
    procedure SetRowIndex(Value : word);
    // установка стилей анимации
    procedure SetAnimationSet(Value : TAnimationSet);
    // установка угла обзора
    procedure SetVisionAngle(Value : word);
    // установка названия шрифта
    procedure SetFontName(Value : TFontName);
    // установка стиля шрифта
    procedure SetFontStyle(Value : TFontStyles);
    // установка набора символов
    procedure SetFontCharset(Value : TFontCharset);
    // установка размеров шрифта
    procedure SetFontSize(Value : integer);
    // установка строк
    procedure SetItems(Value: TStringList);
    // SetActive - включение и выключение активности анимации
    procedure SetActive(State: boolean);
    // SetRefreshDelay - определяет паузу между перерисовками
    procedure SetRefreshDelay(Delay:word);
    // OnFTimer - собственно все тут и рисуется!
    procedure OnFTimer(Sender:TObject);
    // процедура ввода новой строки с анимацией
    procedure InitNewText;
    // процедура уничтожения новой строки с анимацией
    procedure GetTextOut;
    // InitOpenGL и UnloadOpenGL - активация и выгружение ОпенГЛ
    procedure OutText(Text3D: string);
    procedure InitOpenGL;
    procedure UnloadOpenGL;

    // для корректного масштабирования
    procedure OnResize(var Msg:TWMSize); message WM_SIZE;
    // из-за перерисовок сбрасывается размер шрифта канвы - надо исправлять :-)
    procedure OnPaint(var Msg:TWMPaint); message WM_PAINT;
  public
    // анимированная смена строк вручную
    procedure ChangeLines;
    // текущий индекс
    property RowIndex : word read FRowIndex write SetRowIndex;
    // создание - удаление
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  published
    // публикации в окне инспектора
    property QualityType : TQualityType read FQualityType write SetQuality;
    property RefreshDelay : word read FRefreshDelay write SetRefreshDelay default 30;
    property Active : boolean read FActive write SetActive;
    property Items : TStringList read FItems write SetItems;
    property BackColor : TColor read FBackColor write FBackColor;
    property AngleX : glFloat read FAngleX write FAngleX;
    property AngleY : glFloat read FAngleY write FAngleY;
    property NewRowDelay : integer read FNewRowDelay write FNewRowDelay;
    property Scale : glFloat read FScale write FScale;
    property LinesCount : word read FLinesCount write FLinesCount;
    property LiteraDepth : glFloat read FLiteraDepth write FLiteraDepth;
    property LiterasGap : glFloat read FLiterasGap write FLiterasGap;
    property LeftOffset : glFloat read FLeftOffset write FLeftOffset;
    property TopOffset : glFloat read FTopOffset write FTopOffset;
    property VisionAngle : word read FVisionAngle write SetVisionAngle;
    property ChangeStyle : TChangeStyle read FChangeStyle write FChangeStyle;
    property RowsGap : glFloat read FRowsGap write FRowsGap;
    property WaveAmplitude : glFloat read FWaveAmplitude write FWaveAmplitude;
    property FontName : TFontName read FFontName write SetFontName;
    property FontSize : integer read FFontSize write SetFontSize;
    property FontStyle : TFontStyles read FFontStyle write SetFontStyle;
    property FontCharset : TFontCharset read FFontCharset write SetFontCharset;
    property FontColor : TColor read FFontColor write FFontColor;
    property LightIntensity : byte read FLightIntensity write FLightIntensity;
    property AnimationSet : TAnimationSet read FAnimationSet write SetAnimationSet;
    property DefaultRotationPeriod : word read FDefaultRotationPeriod write FDefaultRotationPeriod;

    property OnLinesChanging : TNotifyEvent read FOnLinesChanging write FOnLinesChanging;
    property OnAnimateCycleDone : TNotifyEvent read FOnAnimateCycleDone write FOnAnimateCycleDone;
    // от предков
    property Align;
    property Caption;
    property BorderStyle;
    property BorderWIdth;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

procedure TText3D.SetQuality(aQuality : TQualityType);
begin
  // установка нового значения качества
  FQualityType := aQuality;
  if FActive then
  begin
    SetActive(false);
    SetActive(true);
  end;
end;

procedure TText3D.ChangeLines;
begin
  // говорим о финализации
  FTextCondition := tcGetOut;
  FTmpCounter := 0;
end;

procedure TText3D.SetRowIndex(Value : word);
begin
  if Value < FItems.Count then
    FRowIndex := Value
  else
    FRowIndex := FItems.Count - 1;
end;

procedure TText3D.SetFontSize(Value : integer);
begin
  FFontSize := Value;
  Self.Canvas.Font.Size := Value;
end;

procedure TText3D.SetFontCharset(Value : TFontCharset);
begin
  Self.Canvas.Font.Charset := Value;
  // перекомпиляция - штука долгая
  if FFontCharset = Value then
    Exit;

  FFontCharset := Value;
  if FActive then
  begin
    SetActive(false);
    SetActive(true);
  end;
end;

procedure TText3D.SetFontStyle(Value : TFontStyles);
begin
  Self.Canvas.Font.Style := Value;
  // перекомпиляция - штука долгая
  if FFontStyle = Value then
    Exit;

  FFontStyle := Value;
  if FActive then
  begin
    SetActive(false);
    SetActive(true);
  end;
end;

procedure TText3D.SetFontName(Value : TFontName);
begin
  Self.Canvas.Font.Name := Value;
  // перекомпиляция - штука долгая
  if FFontName = Value then
    Exit;

  FFontName := Value;
  if FActive then
  begin
    SetActive(false);
    SetActive(true);
  end;
end;

procedure TText3D.InitNewText;
var
  TextLength : glFloat;
  InitDone : boolean;
  TmpStr : string;
  i,j :word;
begin
  InitDone := false;
  // если тупое переключение, то уходим отсюда
  if FChangeStyle = csSwitch then
    InitDone := true;
  // приращение внутреннего счетчика
  inc(FTmpCounter);

  // система ввода текста
  if not (FChangeStyle = csSwitch) then
  for j:=1 to FShownRows do
  begin
    // сохраню-ка я в стек позицию фронтального взгляда
    glPushMatrix;
    //позиционируем левую верхнюю новой строки +- верх и низ, если надо
    case FChangeStyle of
      csBottomToTop : // снизу вверх
      glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
        (LITERA_HEIGHT)/2 - (START_POINT_POS - FTmpCounter), 0.0);

      csTopToBottom : // сверху вниз
      glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
        (LITERA_HEIGHT)/2 + (START_POINT_POS - FTmpCounter), 0.0);

      csTopAndBottom : // итак и сяк
      if (j mod 2)= 0 then
        glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
          (LITERA_HEIGHT)/2 + (START_POINT_POS - FTmpCounter), 0.0)
      else
        glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
          (LITERA_HEIGHT)/2 - (START_POINT_POS - FTmpCounter), 0.0);

      else // для всех остальных случаев
      glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
        (LITERA_HEIGHT)/2, 0.0);
    end; {case}

    // сохранение во временную переменную текущей строки
    TmpStr := Self.FItems[Self.FRowIndex+j-1];

    // определяю длину строки в пространстве с учетом промежутков
    TextLength := Self.Canvas.TextWidth(TmpStr)*FONT_WEIGHT_SCALER +
      FFontSize/DEFAULT_FONT_SIZE*FLiterasGap*(Length(TmpStr)-1);

    // сдвиг влево на половину длины строки +- всякие приращения, если надо
    case FChangeStyle of
      csRightToLeft : // справа налево
      glTranslatef( -(TextLength/2)+(START_POINT_POS - FTmpCounter), 0.0, 0.0);

      csLeftToRight : // слева направо
      glTranslatef( -(TextLength/2)-(START_POINT_POS - FTmpCounter), 0.0, 0.0);

      csLeftAndRight : // и так и сяк
      if (j mod 2) = 0 then
        glTranslatef( -(TextLength/2)+(START_POINT_POS - FTmpCounter), 0.0, 0.0)
      else
        glTranslatef( -(TextLength/2)-(START_POINT_POS - FTmpCounter), 0.0, 0.0);

      else // во всех остальных случаях
      glTranslatef( -(TextLength/2), 0.0, 0.0);
    end; {case}

    for i := 1 to Length(TmpStr) do
    begin
      if (FChangeStyle = csLiterasUpDown) then
      begin
        glTranslatef(0.0, (START_POINT_POS - FTmpCounter)*sin(i*pi+pi/2), 0.0);
        // зарисую буковку
        OutText(TmpStr[i]);
        glTranslatef(0.0, -(START_POINT_POS - FTmpCounter)*sin(i*pi+pi/2), 0.0);
      end
      // зарисую буковку
      else
      if (FChangeStyle = csDiffusion) then
      begin
        glTranslatef(0.0, DIFFUS_WAVE_SCALE*(START_POINT_POS - FTmpCounter)*sin((i+DIFFUS_OFFSET+FTmpCounter)*DIFFUSION_SCALE), 0.0);
        // зарисую буковку
        OutText(TmpStr[i]);
        glTranslatef(0.0, -DIFFUS_WAVE_SCALE*(START_POINT_POS - FTmpCounter)*sin((i+DIFFUS_OFFSET+FTmpCounter)*DIFFUSION_SCALE), 0.0);
      end
      else
      OutText(TmpStr[i]);

      // подвинусь на расстояние между буквами
      glTranslatef(FLiterasGap,0,0);
    end;
    // восстановим вид спереди
    glPopMatrix;
    // проверка на завершение ввода строки в эксплуатацию
    if FTmpCounter = START_POINT_POS then
      InitDone := true;
  end;

  // если ввод завершен
  if InitDone then
  begin
    // то надо перевести состояние на нормальное
    FTextCondition := tcNormal;
    FTmpCounter := 0;
  end;
end;

procedure TText3D.GetTextOut;
var
  TextLength : glFloat;
  GetOutDone : boolean;
  TmpStr : string;
  i,j :word;
begin
  GetOutDone := false;
  // приращение внутреннего счетчика
  inc(FTmpCounter);

  if FChangeStyle = csSwitch then
    GetOutDone := true;

  // система вывода текста
  if not (FChangeStyle = csSwitch) then
  for j:=1 to FShownRows do
  begin
    // сохраню-ка я в стек позицию фронтального взгляда
    glPushMatrix;
    
    //позиционируем левую верхнюю новой строки +- верх и низ, если надо
    case FChangeStyle of
      csBottomToTop : // снизу вверх
      glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
        (LITERA_HEIGHT)/2 + FTmpCounter, 0.0);

      csTopToBottom : // сверху вниз
      glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
        (LITERA_HEIGHT)/2 - FTmpCounter, 0.0);

      csTopAndBottom : // итак и сяк
      if (j mod 2)= 0 then
        glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
          (LITERA_HEIGHT)/2 - FTmpCounter, 0.0)
      else
        glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
          (LITERA_HEIGHT)/2 + FTmpCounter, 0.0);

      else // для всех остальных случаев
      glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
        (LITERA_HEIGHT)/2, 0.0);
    end; {case}

    // сохранение во временную переменную текущей строки
    TmpStr := Self.FItems[Self.FRowIndex+j-1];

    // определяю длину строки в пространстве с учетом промежутков
    TextLength := Self.Canvas.TextWidth(TmpStr)*FONT_WEIGHT_SCALER +
      FFontSize/DEFAULT_FONT_SIZE*FLiterasGap*(Length(TmpStr)-1);

    // сдвиг влево на половину длины строки +- всякие приращения, если надо
    case FChangeStyle of
      csRightToLeft : // справа налево
      glTranslatef( -(TextLength/2)- FTmpCounter, 0.0, 0.0);

      csLeftToRight : // слева направо
      glTranslatef( -(TextLength/2)+ FTmpCounter, 0.0, 0.0);

      csLeftAndRight : // и так и сяк
      if (j mod 2) = 0 then
        glTranslatef( -(TextLength/2) + FTmpCounter, 0.0, 0.0)
      else
        glTranslatef( -(TextLength/2) - FTmpCounter, 0.0, 0.0);

      else // во всех остальных случаях
      glTranslatef( -(TextLength/2), 0.0, 0.0);
    end; {case}

    for i := 1 to Length(TmpStr) do
    begin
      if (FChangeStyle = csLiterasUpDown) then
      begin
        glTranslatef(0.0, - FTmpCounter*sin(i*pi+pi/2), 0.0);
        // зарисую буковку
        OutText(TmpStr[i]);
        glTranslatef(0.0,  FTmpCounter*sin(i*pi+pi/2), 0.0);
      end
      // зарисую буковку
      else
      if (FChangeStyle = csDiffusion) then
      begin
        glTranslatef(0.0, - DIFFUS_WAVE_SCALE*FTmpCounter*sin((i+DIFFUS_OFFSET+FTmpCounter)*DIFFUSION_SCALE), 0.0);
        // зарисую буковку
        OutText(TmpStr[i]);
        glTranslatef(0.0,   DIFFUS_WAVE_SCALE*FTmpCounter*sin((i+DIFFUS_OFFSET+FTmpCounter)*DIFFUSION_SCALE), 0.0);
      end
      else
      OutText(TmpStr[i]);

      // подвинусь на расстояние между буквами
      glTranslatef(FLiterasGap,0,0);
    end;
    // восстановим вид спереди
    glPopMatrix;
    // проверка на завершение вывода строки из строя
    if FTmpCounter = START_POINT_POS then
      GetOutDone := true;
  end;

  // если вывод завершен
  if GetOutDone then
  begin
    // событие смены строк
    if Assigned(FOnLinesChanging) then
    begin
      FTimer.Enabled := false;
      FOnLinesChanging(Self);
      FTimer.Enabled := true;
    end;  

    // то надо перевести состояние на инициализацию следующей строки
    FTextCondition := tcInit;
    FTmpCounter := 0;

    // смена индекса текущей строки
    inc(FRowIndex, FLinesCount);
    // но при этом не надо выходить за край!
    if FRowIndex > FItems.Count - 1 then
    begin
      FRowIndex := 0;
      FCounter := 0;
    end;
  end;
end;

procedure TText3D.SetVisionAngle(Value : word);
var
  RestoreSize:integer;
begin
  FVisionAngle := Value;
  // кидаю сообщение о ресайзе для задания режима перспективы
  RestoreSize := Self.Height * $FFFF + Self.Width;
  Self.Perform(WM_SIZE, SIZE_RESTORED, RestoreSize);
end;

procedure TText3D.SetItems(Value: TStringList);
begin
  FCounter := 0;
  FRowIndex := 0;
  if FItems <> Value then
    FItems.Assign(Value);
end;

procedure TText3D.SetAnimationSet(Value:TAnimationSet);
// изменение типа показа
begin
//  Self.FCounter := 0;
  Self.FAnimationSet := Value;
end;

procedure TText3D.SetRefreshDelay(Delay:word);
begin
  FRefreshDelay := Delay;
  FTimer.Interval := Delay;
end;

procedure TText3D.OnPaint(var Msg:TWMPaint);
begin
  inherited;
  // установка сбрасываемого шрифта
  if Self.Canvas.Font.Size <> FFontSize then
  Self.Canvas.Font.Size := FFontSize;
end;

procedure TText3D.OnResize(var Msg:TWMSize);
begin
  inherited;
  if not FActive then
  exit;// если нет режима ОпенГЛ, то дальше ниче делать не надо...

  // здесь задается режим перспективы
  glMatrixMode(GL_PROJECTION); // сделать текущей матрицу проекции
  glLoadIdentity;              // заменяет текущую матрицу на единичную
  // определение перспективы - из библиотеки glu32.dll
  gluPerspective(FVisionAngle,           // угол видимости в направлении оси Y
                 Self.Width/Self.Height,      // угол видимости в направлении оси X - через аспект
                 1,            // расстояние от наблюдателя до ближней плоскости отсечения
                 15.0);          // расстояние от наблюдателя до дальней плоскости отсечения
  glViewport(0, 0, Self.Width, Self.Height);
  glMatrixMode(GL_MODELVIEW);    // сделать текущей видовую матрицу
end;

procedure TText3D.InitOpenGL;
// инициализация ОпенГЛ
const
  LightPos: TGLArrayf4 = (3,3,3,0);
  LightDirect: TGLArrayf3 = (-1, -1, -3);
var
  aQuality : glFloat;
  RestoreSize:integer;
  lf : TLOGFONT;
  hFontNew, hOldFont : HFONT;

  procedure SetDCPixelFormat (hdc : HDC);
  var
   pfd : TPixelFormatDescriptor; // данные формата пикселей
   nPixelFormat : Integer;
  Begin
    FillChar(pfd, SizeOf(pfd), 0);
    With pfd do begin
      dwFlags   := PFD_DRAW_TO_WINDOW or
                   PFD_SUPPORT_OPENGL or
                   PFD_DOUBLEBUFFER;
      cDepthBits:= 32;
    end;
    nPixelFormat := ChoosePixelFormat (hdc, @pfd); // запрос системе - поддерживается ли выбранный формат пикселей
    SetPixelFormat (hdc, nPixelFormat, @pfd);      // устанавливаем формат пикселей в контексте устройства
  End;

begin
  // устанавливаем значение качаства
  aQuality := 0;
  case FQualityType of
    qtFastest: aQuality := 1000;
    qtBest: aQuality := 0;
  end; {case}
    
  FGuidDC := GetDC (Self.Handle);
  SetDCPixelFormat (FGuidDC);
  FGLDC := wglCreateContext (FGuidDC); // создание контекста воспроизведения
  wglMakeCurrent (FGuidDC, FGLDC);    // установить текущий контекст воспроизведения

  //********* Компиляция буковок ***********************************************
  FillChar(lf, SizeOf(lf), 0);
  lf.lfHeight               :=   FONT_HEIGHT ;
  lf.lfWeight               :=   FW_NORMAL ;
  lf.lfCharSet              :=   FFontCharset;
  lf.lfOutPrecision         :=   OUT_DEFAULT_PRECIS ;
  lf.lfClipPrecision        :=   CLIP_DEFAULT_PRECIS ;
  lf.lfQuality              :=   DEFAULT_QUALITY ;
  lf.lfPitchAndFamily       :=   FIXED_PITCH;
  lf.lfPitchAndFamily       :=   FF_DONTCARE OR DEFAULT_PITCH;
  lf.lfItalic               :=   Byte(fsItalic in FFontStyle);
  if (fsBold in FFontStyle) then
  lf.lfWeight               :=   900 else
  lf.lfWeight               :=   0;
  lstrcpy (lf.lfFaceName, PChar(FFontName)) ;
  hFontNew := CreateFontIndirect(lf);
  hOldFont := SelectObject(FGuidDC,hFontNew);
  wglUseFontOutlines(FGuidDC, 0, 255, GLF_START_LIST, aQuality, 1,
    WGL_FONT_POLYGONS, nil);

  DeleteObject(SelectObject(FGuidDC,hOldFont));
  DeleteObject(SelectObject(FGuidDC,hFontNew));
  //************************************************************************

  glEnable(GL_DEPTH_TEST); // глубина цвета для объемности
  glEnable(GL_LIGHTING); // вкл. поддержка источника света
  glEnable(GL_LIGHT0);  // вкл. лампочка 0

  // кидаю сообщение о ресайзе для задания режима перспективы
  RestoreSize := Self.Height * $FFFF + Self.Width;
  Self.Perform(WM_SIZE, SIZE_RESTORED, RestoreSize);
end;

procedure TText3D.UnloadOpenGL;
// уничтожение ОпенГЛ
begin
  wglMakeCurrent (FGuidDC, 0);
  wglDeleteContext (FGLDC); // удаление контекста воспроизведения
end;

procedure TText3D.SetActive(State:boolean);
// процедура включения опенГЛ
var
  OldCaption : string;
begin
  FTimer.Enabled := State;
  FActive := State;

  if State then
  begin
    OldCaption := Self.Caption;
    Self.Caption := INIT_STRING;
    Application.ProcessMessages;
    InitOpenGL;
    Self.Caption := OldCaption;
  end
  else begin
    UnloadOpenGL;
    if FRedraw then
    InvalidateRect(Self.Handle, nil, false);
  end;
end;

procedure TText3D.OutText (Text3D : String);
var
  YaYa : boolean;
begin
  YaYa := false;
  // масштаб на каждую букву
  glScale(FFontSize*FONT_SIZE_SCALE, FFontSize*FONT_SIZE_SCALE, FLiteraDepth);
  glTranslatef(0,0,1/2);

  // русская буква Я - большой геморрой
  if Text3D = 'я' then
  begin
    Text3D := 'Я';
    YaYa := true;
    glScale(YAYA_SCALE,YAYA_SCALE,1);
  end;


  glListBase(GLF_START_LIST);
  glCallLists(Length (Text3D), GL_UNSIGNED_BYTE, PChar(Text3D));

  if YaYa then
    glScale(1/YAYA_SCALE,1/YAYA_SCALE,1);

  glTranslatef(0,0,-1/2);
  // восстановление масштаба
  glScale(1/FFontSize/FONT_SIZE_SCALE, 1/FFontSize/FONT_SIZE_SCALE, 1/FLiteraDepth);
end;

procedure SetMaterial(R,G,B,A:GLfloat);
var
  // массив свойств материала
  MaterialColor: Array[0..3] of GLfloat;
begin
  MaterialColor[0] := R;
  MaterialColor[1] := G;
  MaterialColor[2] := B;
  MaterialColor[3] := A;
  glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @MaterialColor);
end;

function Max(A,B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

procedure TText3D.OnFTimer;
// рисование по таймеру
var
  TmpAngle, // переменная для хранения угла для читабельности
  TextLength : glFloat; // длина текущего текста в пикселах
  MaxLength:word; // для вращающихся буковок
  i, j:word;
  TmpStr:string;
begin
  // проверю, не за пределами ли границ индекс?
  if FRowIndex > FItems.Count - 1 then
    FRowIndex := FItems.Count - 1;
    
  FShownRows := FLinesCount;
  // проверим, не пора ли переходить на новую строку
  if FNewRowDelay > 0 then // при нулевом промежутке пользователь сам заботится о переключении
  if FTextCondition = tcNormal then // переключение только при нормальном показе
  if not((FRowIndex = 0 ) and (FLinesCount  >= FItems.Count)) then
  if FCounter * FRefreshDelay > (FRowIndex/FLinesCount+1)*FNewRowDelay then
  begin
    // говорим о финализации
    FTextCondition := tcGetOut;
    FTmpCounter := 0;
  end;

  // если список букв пуст - то выходим
  if FItems.Count = 0 then
  exit;

  // счетчик кадров только для режма показа (не инициализации и финализации строк)
  if FTextCondition = tcNormal then
  inc(FCounter);

  // определю реальное кол-во строк для показа (оно может отличаться от FLinesCount)
  if FLinesCount > FItems.Count - FRowIndex then
  FShownRows := (FItems.Count - FRowIndex);

  // очистка буферов
  glClear(GL_DEPTH_BUFFER_BIT or GL_COLOR_BUFFER_BIT);
  // заменяет текущую матрицу на единичную
  glLoadIdentity;
  // ********************* рисование... ********************************
  // цвет очистки фона
  glClearColor(GetRValue(Self.FBackColor)/255, GetGValue(Self.FBackColor)/255, GetBValue(Self.FBackColor)/255, 0.0);
  // ставим цвет как в сказке
  SetMaterial(GetRValue(Self.FFontColor)/255*FLightIntensity/255,
    GetGValue(Self.FFontColor)/255*FLightIntensity/255,
      GetBValue(Self.FFontColor)/255*FLightIntensity/255, 1);
  // отступ назад на 3 шага
  glTranslatef(0.0, 0.0, -3.0);
  // сохраню-ка я в стек позицию фронтального взгляда
  glPushMatrix;
  // общий поворот на углы
  glRotatef(FAngleX, 1.0, 0.0, 0.0);
  glRotatef(FAngleY, 0.0, 1.0, 0.0);
  // шкала
  glScale(BASE_SCALE * FScale, BASE_SCALE * FScale, BASE_SCALE * FScale);
  // смещение влево (по X)
  glTranslatef( -FLeftOffset, 0.0, 0.0);
  // смещение вверх (по X)
  glTranslatef( 0.0, FTopOffset, 0.0);

  // система анимации
  if FTextCondition = tcNormal then
  begin
    // если в множестве присутствует флаг общего поворота, то все повернем
    if (atFixedRotation in FAnimationSet) then
    begin
      if FNewRowDelay <> 0 then
        // поворот с учетом того, что при смене строки все должно быть на месте
        glRotatef(FCounter*360/(FNewRowDelay/FRefreshDelay)*ROTATION_SPEED, 0.0, 1.0, 0.0)
      else
        // поворот с учетом того, что при смене строки все должно быть на месте
        glRotatef(FCounter*360/(FDefaultRotationPeriod/FRefreshDelay)*ROTATION_SPEED, 0.0, 1.0, 0.0);
    end;

    for j:=1 to FShownRows do
    begin
      // сохранение во временную переменную текущей строки
      TmpStr := Self.FItems[Self.FRowIndex+j-1];

      if (atRotation in FAnimationSet) or (atSingleWave in FAnimationSet)
        or (atZoomWave in FAnimationSet) or (atHorSingleWave in FAnimationSet) then
      begin
        MaxLength := 0;
        // счетчик периодики
        inc(FTmpCounter);

        // определяюм максимальную по длине строку
        for i := 1 to FShownRows do
        MaxLength := Max(MaxLength, Length(Self.FItems[Self.FRowIndex+i-1]));
        // обрамляем пробелами
        inc(MaxLength, 4 * ROTATED_LITERAS);
        for i:=1 to (ROTATED_LITERAS*2) do
        TmpStr := ' '+TmpStr+' ';

        // сброс счетчика при переполнении
        if FTmpCounter > MaxLength*ROTATION_FRAMES then
        begin
          FTmpCounter := 0;
          // событие окончания цикла анимации
          if Assigned(FOnAnimateCycleDone) then
          begin
            FTimer.Enabled := false;
            OnAnimateCycleDone(Self);
            FTimer.Enabled := true;
          end;  
        end;
      end;

      // сохраню-ка я в стек позицию фронтального взгляда
      glPushMatrix;
      // позиционируем левую верхнюю новой строки
      glTranslatef( 0.0, (LITERA_HEIGHT + FRowsGap)*((FShownRows-1)/2 - j + 1) -
        (LITERA_HEIGHT)/2, 0.0);

      // определяю длину строки в пространстве с учетом промежутков
      TextLength := Self.Canvas.TextWidth(TmpStr)*FONT_WEIGHT_SCALER +
        FFontSize/DEFAULT_FONT_SIZE*FLiterasGap*(Length(TmpStr)-1);
      // сдвиг влево на половину длины строки
      glTranslatef( -(TextLength/2), 0.0, 0.0);
      for i := 1 to Length(TmpStr) do
      begin
        // сохраню-ка я в стек позицию буковки
        glPushMatrix;

        // если есть флаг волны на всю строку в плоскости горизонта
        if (atHorWave in FAnimationSet) then
        // сплаваю на немного вперед/зад
        glTranslatef(0.0, 0.0, FWaveAmplitude*sin(Self.FCounter/10+i));

        // если есть флаг единичной волны в плоскости горизонта
        if (atHorSingleWave in FAnimationSet) then
        // определяю, не входит ли буква в диапазон
        if (i >= (FTmpCounter div ROTATION_FRAMES)+1 - ROTATED_LITERAS) and
          (i <= (FTmpCounter div ROTATION_FRAMES)+1 + ROTATED_LITERAS) then
        begin
          // заумный угол поворота
          TmpAngle :=((FTmpCounter div ROTATION_FRAMES)-i+ROTATED_LITERAS+1)*180/(ROTATED_LITERAS*2+1)+
            (FTmpCounter - (FTmpCounter div ROTATION_FRAMES)*ROTATION_FRAMES)*180/ROTATION_FRAMES/(ROTATED_LITERAS*2+1);
          glTranslatef(0.0, 0.0, 2*FWaveAmplitude * sin(pi*TmpAngle/180));
        end;

        // если есть флаг волны увеличения
        if (atZoomWave in FAnimationSet) then
        // определяю, не входит ли буква в диапазон
        if (i >= (FTmpCounter div ROTATION_FRAMES)+1 - ROTATED_LITERAS) and
          (i <= (FTmpCounter div ROTATION_FRAMES)+1 + ROTATED_LITERAS) then
        begin
          // заумный угол поворота
          TmpAngle :=((FTmpCounter div ROTATION_FRAMES)-i+ROTATED_LITERAS+1)*180/(ROTATED_LITERAS*2+1)+
            (FTmpCounter - (FTmpCounter div ROTATION_FRAMES)*ROTATION_FRAMES)*180/ROTATION_FRAMES/(ROTATED_LITERAS*2+1);
          glScale(1+FWaveAmplitude * sin(pi*TmpAngle/180), 1+FWaveAmplitude * sin(pi*TmpAngle/180), 1);
        end;

        // если есть флаг побуквенного вращения
        if (atRotation in FAnimationSet) then
        // определяю, не входит ли буква в диапазон
        if (i >= (FTmpCounter div ROTATION_FRAMES)+1 - ROTATED_LITERAS) and
          (i <= (FTmpCounter div ROTATION_FRAMES)+1 + ROTATED_LITERAS) then
        begin
          glTranslatef(Self.Canvas.TextWidth(TmpStr[i])*FONT_WEIGHT_SCALER/2, 0.0, 0.0);
          // заумный угол поворота
          TmpAngle :=((FTmpCounter div ROTATION_FRAMES)-i+ROTATED_LITERAS+1)*360/(ROTATED_LITERAS*2+1)+
            (FTmpCounter - (FTmpCounter div ROTATION_FRAMES)*ROTATION_FRAMES)*360/ROTATION_FRAMES/(ROTATED_LITERAS*2+1);
          // поворот буковки
          glRotatef(TmpAngle, 0.0, 1.0, 0.0);
          glTranslatef(-Self.Canvas.TextWidth(TmpStr[i])*FONT_WEIGHT_SCALER/2, 0.0, 0.0);
        end;

        // если есть флаг единичной волны
        if (atSingleWave in FAnimationSet) then
        // определяю, не входит ли буква в диапазон
        if (i >= (FTmpCounter div ROTATION_FRAMES)+1 - ROTATED_LITERAS) and
          (i <= (FTmpCounter div ROTATION_FRAMES)+1 + ROTATED_LITERAS) then
        begin
          // заумный угол поворота
          TmpAngle :=((FTmpCounter div ROTATION_FRAMES)-i+ROTATED_LITERAS+1)*180/(ROTATED_LITERAS*2+1)+
            (FTmpCounter - (FTmpCounter div ROTATION_FRAMES)*ROTATION_FRAMES)*180/ROTATION_FRAMES/(ROTATED_LITERAS*2+1);
          glTranslatef(0.0, 2*FWaveAmplitude * sin(pi*TmpAngle/180), 0.0);
        end;

        // если есть флаг волны на всю строку
        if (atWave in FAnimationSet) then
        // сплаваю на немного вверх/низ
        glTranslatef(0.0, FWaveAmplitude*sin(Self.FCounter/10+i), 0.0);

        // зарисую буковку
        OutText(TmpStr[i]);
        // восстановление позиции буковки
        glPopMatrix;
        // сдвиг вправо на длину этой буквы
        glTranslatef(Self.Canvas.TextWidth(TmpStr[i])*FONT_WEIGHT_SCALER +
          FFontSize/DEFAULT_FONT_SIZE*FLiterasGap, 0.0, 0.0);
      end;
      // восстановим вид спереди
      glPopMatrix;
    end;
  end;

  // А теперь проверим, не переходный ли идет процесс
  if FTextCondition = tcInit then
  // то вводим текст
  InitNewText else
  // если же уходит строка
  if FTextCondition = tcGetOut then
  // то пусть уходит :-)
  GetTextOut;

  // восстановление матрицы фронтального взгляда
  glPopMatrix;

  // конец рисования
  SwapBuffers(FGuidDC);
end;

constructor TText3D.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  // установка параметров по умолчанию
  FAngleY := 0;
  FAngleX := 0;
  Self.Height := 120;
  Self.Width := 300;
  FRefreshDelay := DEFAULT_PAUSE;
  FActive := false;
  FCounter := 0;
  FRowIndex := 0;
  FFontColor := clBlue;
  FBackColor := RGB(0, 0, 0);
  FNewRowDelay := 3000;
  FScale := 1;
  FRedraw := true;
  FLiteraDepth := 1.5;
  FLinesCount := 2;
  FLiterasGap := 0;
  FLeftOffset := 0;
  FTopOffset := 0;
  FVisionAngle := 30;
  FTextCondition := tcInit;
  FChangeStyle := csDiffusion;
  FAnimationSet := [atSingleWave, atRotation];
  FRowsGap := DEFAULT_DELTA_ROW;
  FWaveAmplitude := WAVE_AMPLITUDE;
  FLightIntensity := 127;
  FDefaultRotationPeriod := DEFAULT_ROTATION_PERIOD;
  FQualityType := qtFastest;

  // создание и настройка таймера
  FTimer := TTimer.Create(Self);
  FTimer.Enabled := false;
  FTimer.Interval := 10;
  FTimer.OnTimer := OnFTimer;

  // создание листа с надписями
  FItems := TStringList.Create;
  FItems.Add('Дегтярев Константин');
  FItems.Add('Oe-5ye@yandex.ru');
  FItems.Add('Пишите :-)');

  // установка шрифтов канвы
  Self.Canvas.Font.Height := FONT_HEIGHT;
  FontName := 'Arial Cyr';
  FontSize := DEFAULT_FONT_SIZE;
  FontCharset := Self.Font.Charset;
  FontStyle := FFontStyle;
end;

destructor TText3D.Destroy;
begin
  // отключаю перерисовку при уничтожении (а то все глючит)
  FRedraw := false;
  // отключаю активность ОпенГЛ
  SetActive(false);
  // освобожу таймер
  FTimer.Free;
  // освобожу списки
  FItems.Free;
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Standard', [TText3D]);
end;

end.
