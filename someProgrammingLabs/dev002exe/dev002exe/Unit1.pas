//******************************************************************************
// Author : Georgy Moshkin
// -----------------------------------------------
// email  : tmtlib@narod.ru
// WWW    : http://www.tmtlib.narod.ru/
//
// License:
// --------
// This unit is freely distributable without licensing fees and is
// provided without guarantee or warrantee expressed or implied. This unit
// is Public Domain. Feel free to use or enhance this code. You can use the
// program for any purpose you see fit.
//
//******************************************************************************
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,OpenGL, rtsmain, ComCtrls;


type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;

    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerDraw(Sender: TObject);
    procedure MyMouseCursor(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure MyMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    rc : HGLRC;    // RC
    dc  : HDC;     // DC

    procedure InitGL;
    procedure glDraw;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

var MyMouse:TPOINT; // Координаты мыши
var MyMouseLeft:boolean=false; // Нажата левая кнопка мыши
var MyMouseRight:boolean=false; // Нажата правая кнопка мыши
var MouseCount:integer; // Длительность скролла
var firsttime:boolean=true; // Первый проход главной процедуры ДА/НЕТ
var movex,movey:single; // смещение обзора по x и по y (для движения по карте)

const screenDX=25; // отступ от края экрана для СКРОЛЛИНГА карты


procedure TForm1.glDraw(); // главная процедура рисования в OPENGL окне
var i,j:integer;
var a,b,fff,ppp:single;
var n,m:integer;
r1,r2:single;
s1,s2:integer;
foundStroyka:integer;
begin

 ListBox1.Clear;
 if firsttime then
  begin

   randomize;

   glEnable(GL_TEXTURE_2D);
   glEnable(GL_BLEND);

   glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

   glEnable(GL_ALPHA_TEST);
   glAlphaFunc(GL_GREATER, 0.1);

   glColor3f(1,1,1);
   firsttime:=false;
  
  end;




 glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // очищаем экран
 glLoadIdentity(); // заполняем матрицу единичной диагональной

   glDisable(GL_DEPTH_TEST);

 // здесь добавим команды для вывода на экран



glTranslatef(movex,movey,0);

if Button2.Enabled=false then
begin

if CheckBox2.Checked then  RenderKarta;

  RenderObjects;

  ShowEnerg:=CheckBox1.checked;


  for i:=0 to length(obyekti)-1 do   // проверяем все пары игроков
   for j:=i+1 to length(obyekti)-1 do
    if (obyekti[i].energia[0]>0) and (obyekti[j].energia[0]>0) then
     begin
      r1:=Rassa[Obyekti[i].nomRas].Opisan[Obyekti[i].nomTip].radius;
      r2:=Rassa[Obyekti[j].nomRas].Opisan[Obyekti[j].nomTip].radius;
      s1:=length(Rassa[Obyekti[i].nomRas].Opisan[Obyekti[i].nomTip].skorost);
      s2:=length(Rassa[Obyekti[j].nomRas].Opisan[Obyekti[j].nomTip].skorost);
      if not Centurus(obyekti[i].pos,obyekti[j].pos,r1,r2,s1,s2) then
       begin
         NujnoDogonyat(i,j);
         NujnoDogonyat(j,i);
       end
        else
       begin
        Stolknulsa(i,j);
        Stolknulsa(j,i);
       end;
       
     end;


  InterpretirovatMisli;
  Intellekt(0);     
  Intellekt(1);


  if mouseCount>0 then
  begin
   if MyMouse.x<screenDX*2 then movex:=movex+1;
   if MyMouse.y<screenDX*2 then movey:=movey+1;
   if MyMouse.x>Panel3.Width-screenDX*2 then movex:=movex-1;
   if MyMouse.y>Panel3.Height-screenDX*2 then movey:=movey-1;
   mouseCount:=mouseCount-1;
  end;


  if ComboBox1.ItemIndex<>-1 then komanda:=1; // atakovat

//                                         2  // idtiza

  if ComboBox2.ItemIndex<>-1 then komanda:=3; // stroyka

  if ComboBox3.ItemIndex<>-1 then komanda:=4; // upgrade


  if MyMouseLeft then
    for i:=0 to length(Obyekti)-1 do
     Obyekti[i].vibran:=false;

  ktoNibudPodKursorom:=-1;

  for i:=0 to length(Obyekti)-1 do
   if Obyekti[i].energia[0]>0 then
   begin

    m:=Obyekti[i].nomRas;
    n:=Obyekti[i].nomTip;

            if PodKursorom(i,MyMouse.X-movex,MyMouse.Y-movey) then
             begin
             ktoNibudPodKursorom:=i;
             ppp:=Rassa[m].Opisan[n].radius;
             glPushAttrib(GL_ALL_ATTRIB_BITS);
             glPushMatrix;
              glTranslatef(Obyekti[i].pos.x,Obyekti[i].pos.y-ppp/2,0);
              if komanda=1 then Kursor(1,ppp) else Kursor(0,ppp);
             glPopMatrix;
             glPopAttrib;

             if myMouseLeft then
              begin
                Obyekti[i].vibran:=true;

                ComboBox1.Clear;
                 for j:=0 to length(Rassa[m].Opisan[n].udar)-1 do
                  ComboBox1.Items.Add(Rassa[m].Opisan[n].udar[j].nazv+' (сила '+FloatToStr(Rassa[m].Opisan[n].udar[j].sila)+')');
                   ComboBox1.Text:='Тип атаки';

                ComboBox2.Clear;
                 for j:=0 to length(Rassa[m].Opisan[n].stroyka)-1 do
                  ComboBox2.Items.Add(Rassa[m].Opisan[n].stroyka[j]);
                   ComboBox2.Text:='Тип объекта';

                ComboBox3.Clear;
                 for j:=0 to length(Rassa[m].Opisan[n].upgrade)-1 do
                  ComboBox3.Items.Add(Rassa[m].Opisan[n].upgrade[j].nazv);
                   ComboBox3.Text:='Тип апгрейда';



              end;
     
             end;
   end;


if myMouseRight then
if (komanda=0) and (KtoNibudPodKursorom>-1) then
 komanda:=2; // idtiza;


///

 for i:=0 to length(Obyekti)-1 do
   begin

    m:=Obyekti[i].nomRas;
    n:=Obyekti[i].nomTip;

       if myMouseRight then
          if obyekti[i].vibran=true then
               case komanda of
               0: begin
                     Obyekti[i].MISL1:='idti '+intToStr(round(MyMouse.X-movex))
                                                   +','
                                                   +intToStr(round(MyMouse.Y-movey));
                     Obyekti[i].MISL2:='';
                   end;

              1: begin
                  if (KtoNibudPodKursorom>-1) and (KtoNibudPodKursorom<>i) then
                  Obyekti[i].MISL1:='atakovat '+intToStr(KtoNibudPodKursorom);
                  Obyekti[i].tipAtaki:=ComboBox1.ItemIndex;
                  komanda:=0;
                  ComboBox1.ItemIndex:=-1;
                  Obyekti[i].MISL2:='';
                 end;

              2: begin
                  if (KtoNibudPodKursorom<>i) then
                   Obyekti[i].MISL1:='idtiza '+intToStr(KtoNibudPodKursorom);
                  komanda:=0;
                   Obyekti[i].MISL2:='';                  
                 end;

              3: begin
                   FoundStroyka:=-1;

                   for j:=0 to length(Rassa[Obyekti[i].nomRas].Opisan)-1 do
                    begin
//                     ShowMessage(Rassa[m].Opisan[j].nazv+' , '+Rassa[m].Opisan[n].stroyka[ComboBox2.ItemIndex]);
                     if Rassa[m].Opisan[j].nazv=Rassa[m].Opisan[n].stroyka[ComboBox2.ItemIndex] then
                      FoundStroyka:=j
                    end;

                    if FoundStroyka>-1 then
                     begin
                     Obyekti[i].MISL1:='idti '+intToStr(round(MyMouse.X-movex))
                                                   +','
                                                   +intToStr(round(MyMouse.Y-movey));
                     
                      Obyekti[i].MISL2:='stroyka '+intToStr(FoundStroyka)
                                        +','+intToStr(round(MyMouse.X-movex))
                                        +','+intToStr(round(MyMouse.Y-movey));

                      Obyekti[i].MISLPROGRESS:=0;

                      if length(Rassa[m].Opisan[n].skorost)=0 then
                      begin
                       Obyekti[i].MISL1:='';
                        Obyekti[i].MISL2:='stroyka '+intToStr(FoundStroyka)
                                        +','+intToStr(round(Obyekti[i].pos.x+random(25)-random(50)))
                                        +','+intToStr(round(Obyekti[i].pos.y+random(25)-random(50)));
                      end;


                     end;
                    ComboBox2.ItemIndex:=-1;
                    komanda:=0;
                 end;

               end;
 end;

///





end;





   ListBox1.Items.Add('Первая расса: $'+IntToStr(round(Igroki[0].resurs[0])));
   ListBox1.Items.Add('Вторая расса: $'+IntToStr(round(Igroki[1].resurs[0])));
   ListBox1.Items.Add('Третья расса: $'+IntToStr(round(Igroki[2].resurs[0])));

   ListBox1.Items.Add('Команда при клике: '+intToStr(komanda));
   ListBox1.Items.Add('Под курсором: '+intToStr(KtoNibudPodKursorom));
   ListBox1.Items.Add(' '); 

 if KtoNibudPodKursorom>-1 then
  begin
   ListBox1.Items.Add('Это '+Rassa[Obyekti[KtoNibudPodKursorom].nomRas].Opisan[Obyekti[KtoNibudPodKursorom].nomTip].nazv);
   ListBox1.Items.Add('Мысль 1: '+Obyekti[KtoNibudPodKursorom].MISL1);
   ListBox1.Items.Add('Мысль 2: '+Obyekti[KtoNibudPodKursorom].MISL2);
   if length(Obyekti[KtoNibudPodKursorom].resurs)>0 then
   ListBox1.Items.Add('Ресурс: '+ IntToStr(round(Obyekti[KtoNibudPodKursorom].resurs[0])));
  end
   else
  begin
   ListBox1.Items.Add('Наведите курсор на юнит,');
   ListBox1.Items.Add('чтобы узнать его мысли');
  end;




 myMouseLeft:=false;
 myMouseRight:=false;
 SwapBuffers(DC);
end;


//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
procedure TForm1.InitGL;
begin
  glClearColor(0.0, 0.0, 0.0, 1.0); 	   // White Background
  glShadeModel(GL_SMOOTH);                 // Enables Smooth Color Shading
  glClearDepth(1.0);                       // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST);                 // Enable Depth Buffer
  glDepthFunc(GL_LESS);		           // The Type Of Depth Test To Do

  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations


end;

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

procedure TForm1.FormCreate(Sender: TObject);
var pfd : TPIXELFORMATDESCRIPTOR;
    pf  : Integer;
begin

  DecimalSeparator:='.';
  dc:=GetDC(Panel3.Handle);

  pfd.nSize:=sizeof(pfd);
  pfd.nVersion:=1;
  pfd.dwFlags:=PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER or 0;
  pfd.iPixelType:=PFD_TYPE_RGBA;
  pfd.cColorBits:=32;

  pf :=ChoosePixelFormat(dc, @pfd);
  SetPixelFormat(dc, pf, @pfd);

  rc :=wglCreateContext(dc);    // RC
  wglMakeCurrent(dc,rc);        // DC

  InitGL;

  randomize;

end;

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

procedure TForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, Panel3.Width, Panel3.Height);



  // 3D режим

(*
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  gluPerspective(45.0, Panel3.Width/Panel3.Height, 0.1, 500.0);

  glMatrixMode(GL_MODELVIEW);
*)


  // 2D режим

  glMatrixMode(GL_PROJECTION);  // Switch to the projection matrix
  glPushMatrix();               // Save current projection matrix
  glLoadIdentity();

  glOrtho(0, Panel3.Width, 0, Panel3.Height , -100, 100);

  glMatrixMode(GL_MODELVIEW);  // Return to the modelview matrix
  glPushMatrix();              // Save the current modelview matrix
  glLoadIdentity();


  glDraw();
end;

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

procedure TForm1.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(rc);
end;

procedure TForm1.TimerDraw(Sender: TObject);
begin
glDraw();
end;

procedure TForm1.MyMouseCursor(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
MyMouse.X:=X;
MyMouse.Y:=Panel3.Height-Y;
MouseCount:=30;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
ZagruzRassa('ludi.txt','.\ludi\');
ZagruzRassa('orki.txt','.\orki\');
LoadMapTexture;
Button1.Enabled:=false;
Button1.Caption:='ДАННЫЕ ЗАГРУЖЕНЫ';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

if Button1.Enabled then ShowMessage('Сначала загрузите данные!')
 else
  begin

  Igroki[0].resurs[0]:=570;
  Igroki[1].resurs[0]:=570;

  Igroki[0].AI:=true;
  Igroki[1].AI:=true;  

//NewObyekt(nomRas, nomTip, nomDru:integer;x,y,phi:single);  
 NewObyekt(0,
           0,
           0,
           0,
           0,
           0);

 NewObyekt(1,
           0,
           1,
           0,
           0,
           0);

 NewObyekt(0,
           2,
           555,
           0,
           0,
           0);

 NewObyekt(0,
           2,
           555,
           0,
           -200,
           0);

Button2.Enabled:=false;
Button2.Caption:='ЮНИТЫ РАЗМЕЩЕНЫ';

   Obyekti[0].pos.x:=200;
   Obyekti[0].pos.y:=200;

   Obyekti[1].pos.x:=-200;
   Obyekti[1].pos.y:=-200;
   end;
end;

procedure TForm1.MyMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbLeft then MyMouseLeft:=true;
 if Button=mbRight then MyMouseRight:=true;
end;

end.

