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
glClearColor (0.25, 0.25, 0.75, 0.5);
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
{var pos: array[0..3]of PGLfloat;
    dir: array[0..2]of PGLfloat;
    mat_sp:array[0..3]of PGLfloat;  }
begin
{pos[0]:=3;  pos[1]:=3; pos[2]:=3; pos[3]:=1;
dir[0]:=-1; dir[1]:=-1; dir[2]:=-1;
mat_sp[0]:=1; mat_sp[1]:=1;  mat_sp[2]:=1; mat_sp[3]:=1;    }
glEnable (GL_LIGHTING);
glEnable (GL_LIGHT0);
glEnable (GL_DEPTH_TEST);
{glLightfv(GL_LIGHT0,GL_POSITION,pos);
glLightfv(GL_LIGHT0,GL_SPOT_DIRECTION,dir);
glMaterialfv(GL_FRONT,GL_SPECULAR,mat_sp);
glMaterialf(GL_FRONT,GL_SHININESS,128.0);
glLightModeli(GL_LIGHT_MODEL_TWO_SIDE,gl_true);   }
timer1.enabled:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
glRotatef(15, 1.0, -1.0, 1.0);
glRotatef(15, -1.0, 1.0, 1.0);
glRotatef(15, 1.0, 1.0, -1.0);
SwapBuffers(DC);
InvalidateRect(Handle, nil, False);
end;

procedure TForm1.FormPaint(Sender: TObject);
//var  front_color,back_color: array [1..4] of PGLfloat;

begin
glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
{glMaterialfv(GL_FRONT, GL_DIFFUSE, front_color);
glMaterialfv(GL_BACK, GL_DIFFUSE, back_color);       }

glBegin(GL_QUADS);
glNormal3f(0.0, 0.0, 1.0);
glVertex3f(1.0, 1.0, 1.0);
glVertex3f(-1.0, 1.0, 1.0);
glVertex3f(-1.0, -1.0, 1.0);
glVertex3f(1.0, -1.0, 1.0);
glEnd;

glBegin(GL_QUADS);
glNormal3f(-1.0, 0.0, 0.0);
glVertex3f(-1.0, 1.0, 1.0);
glVertex3f(-1.0, 1.0, -1.0);
glVertex3f(-1.0, -1.0, -1.0);
glVertex3f(-1.0, -1.0, 1.0);
glEnd;

glBegin(GL_QUADS);
glNormal3f(0.0, 1.0, 0.0);
glVertex3f(-1.0, 1.0, -1.0);
glVertex3f(-1.0, 1.0, 1.0);
glVertex3f(1.0, 1.0, 1.0);
glVertex3f(1.0, 1.0, -1.0);
glEnd;

glBegin(GL_QUADS);
glNormal3f(1.0, 0.0, -1.0);
glVertex3f(1.0, -1.0, -1.0);
glVertex3f(1.0, -1.0, 1.0);
glVertex3f(1.0, 1.0, 1.0);
glVertex3f(1.0, 1.0, -1.0);
glEnd;

glBegin(GL_QUADS);
glNormal3f(0.0, 0.0, -1.0);
glVertex3f(1.0, -1.0, 1.0);
glVertex3f(1.0, -1.0, -1.0);
glVertex3f(-1.0, -1.0, -1.0);
glVertex3f(-1.0, -1.0, 1.0);
glEnd;

glBegin(GL_QUADS);
glNormal3f(0.0, 0.0, -1.0);
glVertex3f(-1.0, -1.0, -1.0);
glVertex3f(-1.0, 1.0, -1.0);
glVertex3f(1.0, 1.0, -1.0);
glVertex3f(1.0, -1.0, -1.0);
glEnd;

end;


end.
