unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);

    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    DC : HDC;
    hrc: HGLRC;
    NObj : GLUnurbsObj;
    QObj: gluQuadricObj;
  public
    { Public declarations }
  end;

var
    Black: array[0..3] of GLFloat=(0,0,0,1);
    LightPos: array[0..3] of GLFloat=(0,20,20,-5);
      White: array[0..3] of GLFloat=(1,1,1,1);
       Shiness: integer = 20;
  TM: real;
    fColor: array[0..3] of GLFloat=(0.5,0.5,0.5,1);
  Form1: TForm1;
  wrkX, wrkY: Integer;
  mode : Boolean = False;
  down : Boolean = False;
  solid : Boolean = False;
  Sc: single = 1;
  Sc_p: single = 1;
  NObj: GLUnurbsObj;
  QObj: GLUquadricObj;
  uknot: array [1..8] of glfloat = (0.0,0.0,1.0,1.0,2.0,2.0,3.0,3.0);
  uknot_count, vknot_count, u_stride, v_stride, uorder, vorder: integer;
  a:array[1..4,1..4,1..3] of glFloat=(((-0.4,0.1,0), (0.1, 0.4, 1), (0.25,1.1,  0), (2, 1.0,  1)),
                                          ((-0.6, 0.5,0), (0.0, 0.1, 1), (0.7, 0.5,  0), (2, 0.3,  1)),
                                          ((-0.6, 0.0,0), (0.0, 0.2, 1), (0.1, 0.2,  0), (2, 0.2,  1)),
                                          ((-0.35,-1.2,0), (-0.1,-1.8,1), (0.2,-0.9,  0), (2,-1.8 , 1)));

implementation
{$R *.dfm}

procedure SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat (hdc, nPixelFormat, @pfd);
end;



procedure TForm1.FormCreate(Sender: TObject);

begin
 wrkX:=0;
 wrkY:=0;
 DC := GetDC (Handle);
 SetDCPixelFormat(DC);
 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
   glEnable(GL_LIGHTING);
glEnable(GL_LIGHT0);
 glPointSize (5.0);
 NObj := gluNewNurbsRenderer;
 QObj:= gluNewQuadric;
 gluNurbsProperty (NObj, GLU_SAMPLING_TOLERANCE, 50.0);
 glTranslatef(0,0,-5);
 glClearColor(0,0,0,0);
 glEnable (GL_COLOR_MATERIAL);
 glEnable (GL_DEPTH_TEST);
 glEnable (GL_AUTO_NORMAL);
 glEnable (GL_NORMALIZE);

{ glEnable(GL_LIGHTING);
 glEnable(GL_LIGHT0);     }
 glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, 0);
 glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @Black);
 glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @White);
 glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @White);
 glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, Shiness);
 glLightfv(GL_LIGHT0, GL_DIFFUSE, @White);
 glLightfv(GL_LIGHT0, GL_SPECULAR, @White);

 glEnable(GL_FOG);
 glFogi(GL_FOG_MODE,GL_LINEAR);
end;

procedure TForm1.FormPaint(Sender: TObject);
 var
  i, j: integer;
begin
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
   glColor3f (0.7, 0.2, 0);
   If not solid
    then gluNurbsProperty(NObj, GLU_DISPLAY_MODE, GLU_FILL)
    else gluNurbsProperty(NObj, GLU_DISPLAY_MODE, GLU_OUTLINE_POLYGON);
 glenable(gl_depth_test);

 glpushmatrix;
   glFogf(gl_fog_mode,gl_exp);
   glfogf(gl_fog_density,tm);
   glfogfv(gl_fog_color,@FColor);
  glpopmatrix;

 glLightfv(GL_LIGHT0, GL_POSITION, @LightPos);
  glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, Shiness);
  glPushMatrix;
  glTranslatef(0.28,0.2,0);
  gluNurbsSurface(NObj,8,@uknot,8,@uknot,12,3,@a,4,4,GL_MAP2_VERTEX_3);
  gluEndSurface (NObj);
  glPopMatrix;
  glPushMatrix;
  gltranslatef(0., 0.4, 0.5);
  glRotate(90,0.5,0, 0);
  glColor3f (0, 0, 0);
  gluCylinder(QObj,0.02,0.02,2,100,100);
  glPopMatrix;
    SwapBuffers(DC);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 glViewport(0, 0, ClientWidth, ClientHeight);
 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;
 gluPerspective (30.0, ClientWidth / ClientHeight, 3.0, 8.0);
 glMatrixMode(GL_MODELVIEW);
 glLoadIdentity;
 glTranslatef (0.0, 0.0, -5.0);
 InvalidateRect(Handle, nil, False);
end;



procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Down := False;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  wrkX := X;
  wrkY := Y;
  Down := True;
end;


procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If Down then begin
     glRotatef (X - wrkX, 0.0, 1.0, 0.0);
     glRotatef (Y - wrkY, 1.0, 0.0, 0.0);
     wrkX := X;
     wrkY := Y;
     InvalidateRect(Handle, nil, False);
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
     // VK_UP:   LightPos[1]:=LightPos[1]-1;
     // VK_DOWN: LightPos[1]:=LightPos[1]+1;
      VK_Left: LightPos[0]:=LightPos[0]+1;
      VK_Right: LightPos[0]:=LightPos[0]-1;
       VK_UP: TM:=TM+0.05;
  VK_DOWN:  TM:=TM-0.05;
 end;
  InvalidateRect(Handle, nil, False);
end;

end.
