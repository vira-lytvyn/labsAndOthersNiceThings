unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,OpenGL, Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    BitBtn1: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    DC:HDC;
    hrc:HGLRC;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure SetDCPixelFormat (hdc : HDC);
var
pfd : TPixelFormatDescriptor;
nPixelFormat : Integer;
begin
FillChar (pfd, SizeOf (pfd), 0);
pfd.dwFlags :=PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
nPixelFormat :=ChoosePixelFormat (hdc, @pfd);
SetPixelFormat(hdc, nPixelFormat, @pfd);
end;

procedure Tform1.FormCreate(Sender: TObject);
begin
DC := GetDC (Handle);
SetDCPixelFormat(DC);
hrc := wglCreateContext(DC);
wglMakeCurrent(DC, hrc);
glClearColor (1.0, 1.0, 0.0, 0.5);
glMatrixMode (GL_PROJECTION);
glLoadIdentity;
glFrustum (-1, 1, -1, 1, 2, 20);
glMatrixMode (GL_MODELVIEW);
glLoadIdentity;
glTranslatef(-2.0, 2.0, -8.0);
end;

procedure Tform1.FormDestroy(Sender: TObject);
begin
wglMakeCurrent(0, 0);
wglDeleteContext(hrc);
ReleaseDC (Handle, DC);
DeleteDC (DC);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
glEnable (GL_LIGHTING);
glEnable (GL_LIGHT0);
glEnable(GL_COLOR_MATERIAL);
glEnable (GL_DEPTH_TEST);
timer1.enabled:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
glRotatef(15, 10.0, -8.0, 5.0);
glRotatef(15, -5.0, 9.0, -4.0);
glRotatef(15, 1.0, -1.0, -1.0);
SwapBuffers(DC);
InvalidateRect(Handle, nil, False);
end;

procedure TForm1.FormPaint(Sender: TObject);

begin
glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

glBegin(GL_TRIANGLE_STRIP);
glColor3d(0.2, 0.6, 0.2);
glVertex3f(0.0, 0.0, 0.0);
glVertex3f(2.0, 0.0, 0.0);
glVertex3f(0.0, 2.0, 0.0);
glVertex3f(0.0, 0.0, 2.0);
glVertex3f(0.0, 0.0, 0.0);
glVertex3f(2.0, 0.0, 0.0);
glEnd;

glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
glColor3d(1.0,0.2,0.4);
glBegin(GL_POLYGON);
glVertex3f(5.0, -1.0, 0.0);
glVertex3f(5.0, 4.0, 0.0);
glVertex3f(6.0, 5.0, 0.0);
glVertex3f(7.0, 5.0, 0.0);
glVertex3f(8.0, 4.0, 0.0);
glVertex3f(8.0, 2.0, 0.0);
glVertex3f(10.0, 2.0, 0.0);
glVertex3f(11.0, 1.0, 0.0);
glVertex3f(11.0, 0.0, 0.0);
glVertex3f(10.0, -1.0, 0.0);
glEnd;

end;

end.
