unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,opengl;

type
  Tbitmapheader = array[0..53] of byte;
  TRGB = record b,g,r:byte; end;
  TRGBA = record r,g,b,a:byte;end;
  TRGBArray=array[0..16384] of TRGB;
  TRGBAArray=array[0..16384] of TRGBA;
  PRGBAArray =^TRGBAArray;
  GLArr=array[0..3] of GLFloat;
  TForm1 = class(TForm)
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure okpok(Sender: TObject);
    procedure UP(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Wx,Wy,rx,ry:real;
  rotate:boolean;
    //текстуры
  RGB:TRGBArray;
  textures:array[1..4] of PRGBAArray=(nil,nil,nil,nil);
  tex:PRGBAArray;
  s_coeffs:array[0..3] of glfloat=(0.5,0.5,0.5,0.5);
  t_coeffs:array[0..3] of glfloat=(0.5,0.5,0.5,0.5);
  //свет
  m_ambient:array[0..3] of glFloat=(0.2,0.2,0.2,1);
  m_diffuse:array[0..3] of glFloat=(0.8,0.8,0.8,1);
  m_specular:array[0..3] of glFloat=(0,0,0,1);


implementation

{$R *.dfm}

procedure  svet();
begin
  glmaterialfv(gl_front_and_back,gl_ambient,@m_ambient);
  glmaterialfv(gl_front_and_back,gl_diffuse,@m_diffuse);
  glmaterialfv(gl_front_and_back,gl_specular,@m_specular);
  glmateriali(gl_front_and_back,gl_shininess,70);
end;

function LoadTexture(fname:string;alpha:integer):integer;
var
F:file of byte;
header:TBitmapHeader;
j,i,RGBsize:integer;
begin
  assign(f,fname);
  reset(f);
  RGBSize:=FileSize(f)-54;
  for j:=1 to 4 do
  if textures[j]=nil
  then break;
  new(tex);
  textures[j]:=tex;

  fillchar(header,54,0);
  Blockread(f,Header,54);
  Blockread(f,RGB,RGBsize);
  close(f);

  for i:=0 to rgbsize div 3 -1 do
   begin
    tex[i].r:=RGB[i].r;
    tex[i].g:=RGB[i].g;
    tex[i].b:=RGB[i].b;
    tex[i].a:=alpha;
   end;
   glpixelstorei(gl_unpack_alignment,4);
   result:=j;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
wX:=X;
wY:=Y;
rotate:=true;
end;

procedure SelectTexture(texture:integer;map,genmode,filtermode:GLint;
xmult,zmult:array of GLfloat;logik:boolean);
var
autogenmodex:GLint;
autogenmodez:glint;
wrapsmode:glint;
wraptmode:glint;
magfilter:glint;
minfilter:glint;
environmentmode:glint;
begin
  wrapsmode:=gl_repeat;
  wraptmode:=gl_repeat;

  magfilter:=filtermode;
  minfilter:=filtermode;

  autogenmodex:=map;
  autogenmodez:=map;
  environmentmode:=gl_decal;

  gltexgeni(gl_s,gl_texture_gen_mode,autogenmodex);
  gltexgenfv(gl_s,genmode,addr(xmult));
  gltexgeni(gl_t,gl_texture_gen_mode,autogenmodez);
  gltexgenfv(gl_t,genmode,addr(zmult));

  gltexparameteri(gl_texture_2d,gl_texture_wrap_s,wrapSmode);
  gltexparameteri(gl_texture_2d,gl_texture_wrap_t,wraptmode);
  gltexparameteri(gl_texture_2d,gl_texture_mag_filter,magfilter);
  gltexparameteri(gl_texture_2d,gl_texture_min_filter,minfilter);
  gltexenvi(gl_texture_env,gl_texture_env_mode,environmentmode);
  if logik
  then
  begin
  gltexenvi(gl_texture_env,gl_texture_env_mode,gl_blend);
  gltexenvf(gl_texture_env,gl_texture_env_mode,gl_blend);
  end;
  glteximage2d(gl_texture_2d,0,4,128,128,0,gl_rgba,gl_unsigned_byte,textures[texture]);

end;
///////////////////////////////////
{procedure lampa;
const
  M_amb:array[0..3] of glfloat =(0.1,0.1,0.1,0.0);
  m_dif:array[0..3] of glfloat =(0.5,0.5,0.5,0.2);
  m_spec:array[0..3] of glfloat =(0.5,0.5,0.5,0.2);
  m_pos:array[0..3] of glfloat=(0,0.5,0.9,1.0);
  m_napr:array[0..3] of glfloat=(0,0,-1,1);
  begin
  gl_lightf(4,gl_short_exponent,100);
  gl_lightf(4,gl_short_cutoff,120);
  gl_lightf(4,gl_ambient,@m_amb);
  gl_lightf(4,gl_diffuse,@m_dif);
  gl_lightf(4,gl_specular,@M_spec);
  gl_lightf(4,gl_position,@m_pos);
  gl_lightf(4,gl_shot_direction,@m_napr);

end; }

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState;
X,Y: Integer);
begin
if rotate then
begin
rX:=rX+(X-wX)/2;
rY:=rY+(Y-wY)/2;
wX:=X;
wY:=Y;
InvalidateRect(Handle,nil,false);
end;
end;
procedure TForm1.FormCreate(Sender: TObject);
var
pfd:TPixelFormatDescriptor;
nPixelFormat: Integer;
begin
FillChar(pfd, sizeof(pfd), 0);
nPixelFormat:=ChoosePixelFormat(Canvas.Handle, @pfd);
SetPixelFormat(Canvas.Handle, nPixelFormat, @pfd);
end;



procedure TForm1.okpok(Sender: TObject);
 const
  points1 : Array [0..3, 0..3, 0..2] of GLFloat =
 (
    (
        (-1.7, 1, -0.1),
        (-0.5, -1, 0.1),
        (0.5, -1, 0.1),
        (1.7, 1, -0.1)),
    (
        (-2.2, 2, -0.3),
        (-1, 1.5, 0.3),
        (1, 2.5, 0.3),
        (2.2, 2, -0.3)),
    (
        (-3, 3, -0.4),
        (-2, 3.5, 0.4),
        (2, 3, 0.4),
        (3,3, -0.4)),
    (
        (-1.5, 4, -0.1),
        (-0.6, 4.3, 0),
        (0.6, 4.3, 0),
        (1.5, 4, -0.1))
 );
 knots : Array [0..7] of GLFloat = (0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0);


 points2 : Array [0..3, 0..3, 0..2] of GLFloat =
 (  (
 
        (0.2, -1, 1),
        (0, -0.9, 1),
        (0.3, -1, 1),
        (0.1,-1, 1)),

         (
        (-0.1, -1, 0.2),
        (0, 0, 0.2),
        (0, -1, 0.2),
        (-0.1,-1, 0.2)),



    (
        (-0.2, -1, 0),
        (0, 0, 0),
        (0.2, -1, 00),
        (-0.2,-1, 0)),
    (
        (-0.2, -0.5, 0),
        (0, 0, 0),
        (0.2, -0.5, 0),
        (-0.2, -0.5, 0))
 );


    Black: array[0..3] of GLFloat=(0,0,0,1);
    LightPos: array[0..3] of GLFloat=(0,20,20,-5);
      White: array[0..3] of GLFloat=(1,1,1,1);
       Shiness: integer = 20;



var
hrc:HGLRC;
i,j,k:integer;
x,y:real;
key:boolean;
QuadObj: GLUquadricObj;
Nurb: gluNurbsObj;
textur:integer;

begin

 {//glpushmatrix();
 //glenable(gl_texture_2d);
  glenable(gl_texture_gen_s);
  glenable(gl_texture_gen_t);
 glEnable(GL_TEXTURE_2D);
 glTexImage2D(gl_texture_2d,0,4,8,64,0,GL_Rgba,GL_UNSIGNED_BYTE,textures[2]);
 glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
                                                              }


hrc:=wglCreateContext(Canvas.Handle);
wglMakeCurrent(Canvas.Handle,hrc);
glClearColor(0.9,0.9,0.9,1.0);
glClear(GL_COLOR_BUFFER_BIT) ;



     QuadObj:=gluNewQuadric;
gluQuadricDrawStyle(QuadObj,GLU_Fill);
glRotatef(rX,0,1,0);
glRotatef(rY,1,0,0);
//glEnable(GL_LIGHTING);
glEnable(GL_LIGHT0);
glColor3f(0,0,0);
     glTranslatef(0,0, -0.5);
     GluCylinder(QuadObj,0.3,0.4,0.5,20,20);
//textur:=loadtexture('D:\BLUSTONE.bmp',1);
//selecttexture(Textur, gl_eye_linear,gl_texture_gen_mode,gl_linear,s_coeffs,t_coeffs,true);
 //showmessage(getcurrentdir+ '\textur\Tn_6_gif.bmp');
 glPushMatrix();

   glEnable(GL_TEXTURE_2D); glenable(gl_texture_gen_s);
  glenable(gl_texture_gen_t);{
 glTexImage2D(gl_texture_2d,0,4,8,64,0,GL_rgb,GL_BiTmap,textures[2]);
 glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
     }

 { glEnable (GL_COLOR_MATERIAL);
 glEnable (GL_DEPTH_TEST);
glEnable (GL_AUTO_NORMAL);
glEnable (GL_NORMALIZE);

 glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, 0);     
 glLightModelfv(GL_LIGHT_MODEL_AMBIENT, @Black);
 glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @White);
 glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @White);
glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, Shiness);
 glLightfv(GL_LIGHT0, GL_DIFFUSE, @White);
 glLightfv(GL_LIGHT0, GL_SPECULAR, @White);     }


  glEnable(GL_FOG);
 glFogi(GL_FOG_MODE,GL_LINEAR);    

 glLightfv(GL_LIGHT0, GL_POSITION, @LightPos);
  glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, Shiness);

  glenable(gl_blend);
  glBlendFunc(gl_src_alpha,gl_src_color);
  
      //  textur:=loadtexture('C:\GREEN003.BMP',0);
//selecttexture(Textur, gl_eye_linear,gl_texture_gen_mode,gl_linear,s_coeffs,t_coeffs,true);


      glTranslatef(0,0, 0.4);
      glColor3f(0,1,0);
     GluCylinder(quadobj,0.01,0.005,0.7,20,20);

                     glColor3f(0,0,0);
    // glColor3f(0.5,0.5,0.5);

       GluDisk( quadobj,0,0.38,20,20);

       glTranslatef(0,0, -0.4);
     GluDisk( quadobj,0,0.3,20,20);



     glTranslatef(0,0, 1.1);
     glColor3f(1,1,0);
     GluDisk( quadobj,0,0.3,20,20);
     gluDeleteQuadric(QuadObj);

 //textur:=loadtexture('D:\student\547\лаб6\textur\GREEN0031.BMP',1);
 //selecttexture(Textur, gl_eye_linear,gl_texture_gen_mode,gl_linear,s_coeffs,t_coeffs,true);
   Nurb:=gluNewNurbsRenderer;
 //  gluNurbsProperty(Nurb, GLU_DISPLAY_MODE, GLU_OUTLINE_POLYGON);
//gluBeginSurface(Nurb);
 gluNurbsProperty (Nurb, GLU_SAMPLING_TOLERANCE, 25.0);
{gluNurbsSurface(Nurb, 4*2, @uknot, 4*2, @vknot,
4*3, 3, @ctlarray, 4, 4, GL_MAP2_VERTEX_3); }

glColor3f(1,0,0);
  for k:=1 to 8  do
  begin


 gluBeginSurface (Nurb);
    gluNurbsSurface (Nurb,
	             8, @knots,
	             8, @knots,
	             4 * 3,
	             3,
	             @points2,
	             4, 4,
	             GL_MAP2_VERTEX_3);
 gluEndSurface (Nurb); 
   GLRotatef(45,0,0,1);
   GLTranslatef(0,0,0);
 end;



gluEndSurface(Nurb);

//gluBeginTrim(Nurb)  ;
//gluPwlCurve(Nurb,9,@ctlarray2,3,GLU_MAP1_TRIM_3);
//gluEndTrim(Nurb)        ;



   gluDeleteNurbsRenderer(Nurb);


//glFinish();
wglMakeCurrent (0,0);
wglDeleteContext(hrc);
end;


procedure TForm1.UP(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
rotate:=false;
end;

end.









