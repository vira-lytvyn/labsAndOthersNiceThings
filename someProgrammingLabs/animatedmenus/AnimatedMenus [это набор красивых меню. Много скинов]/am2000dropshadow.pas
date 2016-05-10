{*******************************************************}
{                                                       }
{       Animated Menus                                  }
{       T_AM2000_DropShadow                         }
{                                                       }
{       Copyright (c) 1997-2002 AnimatedMenus.com       }
{       All rights reserved.                            }
{                                                       }
{*******************************************************}


unit am2000dropshadow;

{$I am2000.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls,
  Forms, am2000utils;

type
  T_AM2000_Opacity255 = 0..255;
  TCustomVerticalShadow = class;
  TCustomHorizontalShadow = class;

  T_AM2000_DropShadow = class
  private
    VerticalShadow: TCustomVerticalShadow;
    HorizontalShadow: TCustomHorizontalShadow;

    function GetOpacity: T_AM2000_Opacity255;
    procedure SetOpacity(const Value: T_AM2000_Opacity255);
    procedure SetColor(const Value: TColor);

  public
    property Opacity: T_AM2000_Opacity255
      read GetOpacity write SetOpacity default 100;
    property Color: TColor
      write SetColor default clBlack;

    constructor Create(AOwner: TForm);
    destructor Destroy; override;

    procedure Update;
    procedure Show(const AHandle: THandle);
    procedure Hide;

  end;


  TCustomShadow = class(TForm)
  private
    Old: Integer;
    bi: TBitmapInfo;
    bmp: TBitmap;

  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure wmEraseBkgnd(var Msg: TWMEraseBkgnd); message wm_EraseBkgnd;
    procedure SetColor(const Value: TColor); virtual; abstract;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Repaint; override;

  end;

  TCustomVerticalShadow = class(TCustomShadow)
  public
    constructor Create(AOwner: TComponent); override;
    procedure Update; override;
  end;

  TCustomHorizontalShadow = class(TCustomShadow)
  public
    constructor Create(AOwner: TComponent); override;
    procedure Update; override;
  end;

  TVerticalShadow98 = class(TCustomVerticalShadow)
  protected
    procedure Paint; override;
    procedure SetColor(const Value: TColor); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  THorizontalShadow98 = class(TCustomHorizontalShadow)
  protected
    procedure Paint; override;
    procedure SetColor(const Value: TColor); override;
  end;

  TVerticalShadow2000 = class(TCustomVerticalShadow)
  private
    V, V1, V2: PByteArray;
    Blend: TBlendFunction;
    
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetColor(const Value: TColor); override;
    
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;

  end;

  THorizontalShadow2000 = class(TCustomHorizontalShadow)
  private
    V, V1: PByteArray;
    Blend: TBlendFunction;
    
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetColor(const Value: TColor); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;
    
  end;


implementation

uses
  am2000desktop;

const
  // drop shadow
  iDropShadowSize: Integer = 4;
  iDropShadowOpacity: Integer = 75;
  iDropShadowDistance: Integer = 4;
  P: TPoint = (X:0; Y:0);

type
  TRGBA = packed record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
    Alpha: Byte;
  end;
  TRGBAArray = array [Byte] of TRGBA;
  PRGBAArray = ^TRGBAArray;

const
  SizeV = 5*4;
  SizeV1 = 5*5*4;
  SizeV2 = 5*5*4;

{ Routines }

var
  OpacityData: array [Byte, 1..10] of Byte;

procedure CalculateVerticalDropShadow(const bits: PByteArray;
  const Index, d1, d2, d3, d4, bs: Integer);
begin
  if (Index < 0)
  or (Index + iDropShadowSize *3 > bs)
  then Exit;

  bits[Index]:=     OpacityData[bits[Index],     d1];
  bits[Index +1]:=  OpacityData[bits[Index +1],  d1];
  bits[Index +2]:=  OpacityData[bits[Index +2],  d1];

  bits[Index +3]:=  OpacityData[bits[Index +3],  d2];
  bits[Index +4]:=  OpacityData[bits[Index +4],  d2];
  bits[Index +5]:=  OpacityData[bits[Index +5],  d2];

  bits[Index +6]:=  OpacityData[bits[Index +6],  d3];
  bits[Index +7]:=  OpacityData[bits[Index +7],  d3];
  bits[Index +8]:=  OpacityData[bits[Index +8],  d3];
  
  bits[Index +9]:=  OpacityData[bits[Index +9],  d4];
  bits[Index +10]:= OpacityData[bits[Index +10], d4];
  bits[Index +11]:= OpacityData[bits[Index +11], d4];
end;

procedure CalculateHorizontalDropShadow(const bits: PByteArray;
  const Index, d1, W, DI, bs: Integer);
var
  J, J0, J1: Integer;
begin
  if Index < 0
  then Exit;
  J0:= Index * W * SizeOf(TRgbTriple) + DI * Index;
  J1:= (Index + 1) * W * SizeOf(TRgbTriple) + DI * Index -1;
  if J1 >= bs then J1:= bs -1;

  for J:= J0 + iDropShadowSize *3 to J1
  do bits^[J]:= d1 * (bits^[J] div 9);
end;

procedure Convert(const R, G, B: Byte; const H: array of Byte;
  const aV: PByteArray; const Size: Cardinal);
var
  I: Integer;
begin
  for I:= 0 to (Size div 4) -1
  do begin
    aV[I * 4]:=    Round((B * H[I]) / 255);
    aV[I * 4 +1]:= Round((G * H[I]) / 255);
    aV[I * 4 +2]:= Round((R * H[I]) / 255);
    aV[I * 4 +3]:= H[I];
  end;
end;


{ T_AM2000_DropShadow }

constructor T_AM2000_DropShadow.Create(AOwner: TForm);
begin
  inherited Create;

  if Assigned(pSetLayeredWindowAttributes)
  then begin
    VerticalShadow:= TVerticalShadow2000.Create(AOwner);
    HorizontalShadow:= THorizontalShadow2000.Create(AOwner);
  end
  else begin
    VerticalShadow:= TVerticalShadow98.Create(AOwner);
    HorizontalShadow:= THorizontalShadow98.Create(AOwner);
  end;
end;

destructor T_AM2000_DropShadow.Destroy;
begin
  // free bits
  VerticalShadow.Free;
  HorizontalShadow.Free;

  inherited Destroy;
end;

function T_AM2000_DropShadow.GetOpacity: T_AM2000_Opacity255;
begin
  if Assigned(pSetLayeredWindowAttributes)
  then Result:= TVerticalShadow2000(VerticalShadow).Blend.SourceConstantAlpha
  else Result:= 255;
end;

procedure T_AM2000_DropShadow.Hide;
begin
  ShowWindow(VerticalShadow.Handle, sw_Hide);
  ShowWindow(HorizontalShadow.Handle, sw_Hide);
end;

procedure T_AM2000_DropShadow.SetColor(const Value: TColor);
begin
  VerticalShadow.SetColor(Value);
  HorizontalShadow.SetColor(Value);
end;

procedure T_AM2000_DropShadow.SetOpacity(const Value: T_AM2000_Opacity255);
begin
  if Assigned(pSetLayeredWindowAttributes)
  then begin
    TVerticalShadow2000(VerticalShadow).Blend.SourceConstantAlpha:= Value;
    THorizontalShadow2000(HorizontalShadow).Blend.SourceConstantAlpha:= Value;
    Update;
  end;
end;

procedure T_AM2000_DropShadow.Show(const AHandle: THandle);
begin
  ShowWindow(VerticalShadow.Handle, sw_ShowNoActivate);
  ShowWindow(HorizontalShadow.Handle, sw_ShowNoActivate);

  if AHandle <> 0
  then begin
    SetWindowPos(VerticalShadow.Handle, AHandle, 0, 0, 0, 0, FormFlags);
    SetWindowPos(HorizontalShadow.Handle, AHandle, 0, 0, 0, 0, FormFlags);
  end;

  Update;
end;

procedure T_AM2000_DropShadow.Update;
begin
  VerticalShadow.Update;
  HorizontalShadow.Update;
end;



{ TCustomShadow }

constructor TCustomShadow.Create(AOwner: TComponent);
var
  I, J: Integer;
begin
  inherited CreateNew(AOwner {$IFDEF CBuilder1}, 0{$ENDIF});

  ControlStyle:= ControlStyle - [csCaptureMouse];
  BorderStyle:= bsNone;
  FormStyle:= fsStayOnTop;
  Position:= poDesigned;
  inherited SetBounds(0, 0, 0, 0);

  bmp:= TBitmap.Create;

  bi.bmiHeader.biSize:= SizeOf(bi.bmiHeader);
  bi.bmiHeader.biPlanes:= 1;
  bi.bmiHeader.biBitCount:= 24;
  bi.bmiHeader.biCompression:= bi_RGB;
  bi.bmiHeader.biSizeImage:= 0; 
end;

procedure TCustomShadow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle:= Params.ExStyle or WS_EX_TOOLWINDOW;
  Params.WindowClass.style:= Params.WindowClass.style or CS_SAVEBITS;
end;

destructor TCustomShadow.Destroy;
begin
  // free bits
  bmp.Free;

  inherited Destroy;
end;

procedure TCustomShadow.Repaint;
begin
  Paint;
end;

procedure TCustomShadow.wmEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Paint;
  Msg.Result:= 1;
end;


{ TCustomVerticalShadow }

constructor TCustomVerticalShadow.Create(AOwner: TComponent);
begin
  inherited;

  bmp.Width:= iDropShadowSize;
  bi.bmiHeader.biWidth:= iDropShadowSize;
end;

procedure TCustomVerticalShadow.Update;
var
  R: TRect;
begin
  if Owner is TForm
  then begin
    GetWindowRect(TForm(Owner).Handle, R);

    bi.bmiHeader.biHeight:= R.Bottom - R.Top;
    bmp.Height:= bi.bmiHeader.biHeight;

    SetBounds(R.Right, R.Top + iDropShadowSize, iDropShadowSize, bi.bmiHeader.biHeight);
  end;
end;


{ TCustomHorizontalShadow }

constructor TCustomHorizontalShadow.Create(AOwner: TComponent);
begin
  inherited;
  
  bmp.Height:= iDropShadowSize;
  bi.bmiHeader.biHeight:= iDropShadowSize;
end;

procedure TCustomHorizontalShadow.Update;
var
  R: TRect;
begin
  if Owner is TForm
  then begin
    GetWindowRect(TForm(Owner).Handle, R);

    bi.bmiHeader.biWidth:= R.Right - R.Left - iDropShadowSize;
    bmp.Width:= bi.bmiHeader.biWidth;

    SetBounds(R.Left + iDropShadowSize, R.Bottom, bi.bmiHeader.biWidth, iDropShadowSize);
  end;
end;


{ TVerticalShadow98 }

constructor TVerticalShadow98.Create(AOwner: TComponent);
var
  I, J: Integer;
begin
  inherited;

  for I:= 0 to 255
  do begin
    for J:= 1 to 9
    do OpacityData[I, J]:= Round((I * J) / 9);

    OpacityData[I, 10]:= I;
  end;
end;

procedure TVerticalShadow98.Paint;
var
  bs, I, H: Integer;
  bits: PByteArray;
  R: TRect;
begin
  GetWindowRect(Handle, R);
  H:= bi.bmiHeader.biHeight;

  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  or (H = 0)
  then Exit;

  // calc direction
  if (Old <> H)
  then begin
    // vertical shadow
    bmp.Height:= H;
    Desktop.GetBitmapNoLock(bmp.Canvas.Handle, R.Left, R.Top, iDropShadowSize, H);

    // get dib bits
    bs:= (iDropShadowSize +1)* H * SizeOf(TRgbTriple);
    GetMem(bits, bs);

    bi.bmiHeader.biHeight:= H;
    GetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, H, bits, bi, Dib_Rgb_Colors);

    for I:= 3 to H -4
    do CalculateVerticalDropShadow(bits, I *12, 5, 6, 7, 8, bs);

    // calc bottom
    CalculateVerticalDropShadow(bits, 0,  8, 8, 8, 9, bs);
    CalculateVerticalDropShadow(bits, 12, 7, 7, 8, 8, bs);
    CalculateVerticalDropShadow(bits, 24, 6, 6, 7, 8, bs);

    // calc top
    CalculateVerticalDropShadow(bits, (H -1)*12, 8, 8, 8, 9, bs);
    CalculateVerticalDropShadow(bits, (H -2)*12, 7, 7, 8, 8, bs);
    CalculateVerticalDropShadow(bits, (H -3)*12, 6, 6, 7, 8, bs);

    SetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, H, bits, bi, Dib_Rgb_Colors);
    FreeMem(bits);
  end;

  // draw
  BitBlt(Canvas.Handle, 0, 0, iDropShadowSize, H, bmp.Canvas.Handle, 0, 0, SrcCopy);

  Old:= H;
end;


procedure TVerticalShadow98.SetColor(const Value: TColor);
begin
end;


{ THorizontalShadow98 }

procedure THorizontalShadow98.Paint;
var
  bs, I, H, W, W1, {X, Y,} DI: Integer;
  bits: PByteArray;
  R: TRect;
begin
  GetWindowRect(Handle, R);
  W:= R.Right - R.Left;

  if (csLoading in ComponentState)
  or (csDestroying in ComponentState)
  or (W = 0)
  then Exit;

  DI:= W mod 4;

  // calc direction
  if (Old <> W)
  then begin
    // horizontal
    bmp.Width:= W;
    Desktop.GetBitmapNoLock(bmp.Canvas.Handle, R.Left, R.Top + H - iDropShadowSize, W, iDropShadowSize);

    bs:= iDropShadowSize * W * SizeOf(TRgbTriple) + iDropShadowSize + 100;
    GetMem(bits, bs);

    bi.bmiHeader.biWidth:= W;
    GetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, iDropShadowSize, bits, bi, Dib_Rgb_Colors);

    for I:= 0 to iDropShadowSize -1
    do CalculateHorizontalDropShadow(bits, I, 8 - I, W, DI, bs);

    // calc bottom
    I:= W1 * SizeOf(TRgbTriple) + DI;
    CalculateVerticalDropShadow(bits, 0,   9, 8, 8, 8, bs);
    CalculateVerticalDropShadow(bits, I,   8, 8, 7, 7, bs);
    CalculateVerticalDropShadow(bits, 2*I, 8, 7, 6, 6, bs);
    CalculateVerticalDropShadow(bits, 3*I, 8, 7, 6, 5, bs);

    SetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, iDropShadowSize, bits, bi, Dib_Rgb_Colors);

    FreeMem(bits);
  end;

  // draw
  BitBlt(Canvas.Handle, 0, 0, W, iDropShadowSize, bmp.Canvas.Handle, 0, 0, SrcCopy);

  Old:= W;
end;


procedure THorizontalShadow98.SetColor(const Value: TColor);
begin
end;


{ TVerticalShadow2000 }

constructor TVerticalShadow2000.Create(AOwner: TComponent);
  // initialize
var
  X: Integer;
begin
  iDropShadowSize:= 5;
  inherited;

  bi.bmiHeader.biBitCount:= 32;

  Bmp.PixelFormat:= pf32Bit;

  Blend.BlendOp:= 0;
  Blend.BlendFlags:= 0;
  Blend.SourceConstantAlpha:= 255;
  Blend.AlphaFormat:= 1;

  X:= GetWindowLong(Handle, gwl_ExStyle);
  if X and ws_ex_Layered = 0
  then SetWindowLong(Handle, gwl_ExStyle, X or ws_ex_Layered);

  GetMem(V, SizeV);
  GetMem(V1, SizeV1);
  GetMem(V2, SizeV2);
end;

procedure TVerticalShadow2000.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle:= Params.ExStyle or WS_EX_LAYERED;
end;


destructor TVerticalShadow2000.Destroy;
begin
  FreeMem(V);
  FreeMem(V1);
  Freemem(V2);
  
  inherited;
end;

procedure TVerticalShadow2000.SetColor(const Value: TColor);
  // set drop shadow color
const
  oV: array [0..4] of Byte = ($72, $57, $2b, $0d, $04);
  oV1: array [0..24] of Byte = ($03, $01, $00, $00, $00, $0d, $0a, $06, $03, $00,
    $27, $1c, $0d, $05, $01, $4d, $39, $1c, $0a, $02, $64, $4b, $26, $0d, $03);
  oV2: array [0..24] of Byte = ($64, $4b, $26, $0d, $03, $4d, $39, $1c, $0a, $02,
    $27, $1c, $0d, $05, $01, $0d, $0a, $06, $03, $00, $03, $01, $00, $00, $00);
var
  C: TColorRef;
  R, G, B: Byte;
begin
  C:= ColorToRGB(Value);
  R:= GetRValue(C);
  G:= GetGValue(C);
  B:= GetBValue(C);
  Convert(R, G, B, oV, V, SizeV);
  Convert(R, G, B, oV1, V1, SizeV1);
  Convert(R, G, B, oV2, V2, SizeV2);
end;

procedure TVerticalShadow2000.Update;
  // update vertical shadow
var
  DC: HDC;
  P1, P2: TPoint;
  S: TSize;
  P: PRGBAArray;
  InfoHeaderSize, bs, Y: DWord;
begin
  inherited;

  if (bi.bmiHeader.biHeight < 11)
//  or (Old = bi.bmiHeader.biHeight)
  then Exit;


  S.cx:= bi.bmiHeader.biWidth;
  S.cy:= bi.bmiHeader.biHeight;

  // initialize bitmap
  GetDibSizes(Bmp.Handle, InfoHeaderSize, bs);
  GetMem(P, bs);

  DC:= CreateCompatibleDC(0);

  for Y:= iDropShadowSize to Bmp.Height - iDropShadowSize -1
  do Move(V^, P[Y * iDropShadowSize], SizeV);

  Move(V1^, P[0], SizeV1);
  Move(V2^, P[(Bmp.Height -5) * iDropShadowSize], SizeV2);

  SetDiBits(DC, Bmp.Handle, 0, ClientHeight, P, bi, DIB_RGB_COLORS);

  FreeMem(P);
  DeleteDC(DC);

  // update
  P1:= BoundsRect.TopLeft;
  P2:= Point(0, 0);
  DC:= GetDC(0);

  pUpdateLayeredWindow(Handle, DC, @P1, @S, Bmp.Canvas.Handle, @P2, clNone, @Blend, 2);

  DeleteDC(DC);               
  Old:= bi.bmiHeader.biHeight;
end;


{ THorizontalShadow2000 }

constructor THorizontalShadow2000.Create(AOwner: TComponent);
var
  X: Cardinal;
begin
  iDropShadowSize:= 5;
  inherited;

  bi.bmiHeader.biBitCount:= 32;

  Bmp.PixelFormat:= pf32Bit;

  Blend.BlendOp:= 0;
  Blend.BlendFlags:= 0;
  Blend.SourceConstantAlpha:= 255;
  Blend.AlphaFormat:= 1;

  X:= GetWindowLong(Handle, gwl_ExStyle);
  if X and ws_ex_Layered = 0
  then SetWindowLong(Handle, gwl_ExStyle, X or ws_ex_Layered);

  GetMem(V, SizeV);
  GetMem(V1, SizeV1);
end;

procedure THorizontalShadow2000.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle:= Params.ExStyle or WS_EX_LAYERED;
end;

destructor THorizontalShadow2000.Destroy;
begin
  FreeMem(V);
  FreeMem(V1);

  inherited;
end;

procedure THorizontalShadow2000.SetColor(const Value: TColor);
  // udates shadow's color
const
  oV: array [0..4] of Byte = ($04, $0d, $2b, $57, $72);
  oV1: array [0..24] of Byte = ($00, $00, $00, $01, $03, $00, $03, $06, $0a, $0d,
    $01, $05, $0d, $1c, $27, $02, $0a, $1c, $39, $4d, $03, $0d, $26, $4b, $64);
var
  C: TColorRef;
  R, G, B: Byte;
begin
  C:= ColorToRGB(Value);
  R:= GetRValue(C);
  G:= GetGValue(C);
  B:= GetBValue(C);
  Convert(R, G, B, oV, V, SizeV);
  Convert(R, G, B, oV1, V1, SizeV1);
end;

procedure THorizontalShadow2000.Update;
  // update vertical shadow
var
  DC: HDC;
  P1, P2: TPoint;
  S: TSize;
  P: PRGBAArray;
  InfoHeaderSize, bs, X, Y, Y1: DWord;
begin
  inherited;

  if (bi.bmiHeader.biWidth < 6)
//  or (Old = bi.bmiHeader.biWidth)
  then Exit;

  S.cx:= bi.bmiHeader.biWidth;
  S.cy:= bi.bmiHeader.biHeight;

  // initialize bitmap
  GetDibSizes(Bmp.Handle, InfoHeaderSize, bs);
  GetMem(P, bs);

  DC:= CreateCompatibleDC(0);

  for Y:= 0 to Bmp.Height -1
  do begin
    Y1:= Y * Bmp.Width;
    
    Move(V1[Y * 20], P[Y1], 5*SizeOf(TRGBA));

    for X:= 5 to Bmp.Width -1
    do Move(V[Y * 4], P[Y1 + X], SizeOf(TRGBA));
  end;

  SetDiBits(DC, Bmp.Handle, 0, ClientHeight, P, bi, DIB_RGB_COLORS);

  FreeMem(P);
  DeleteDC(DC);

  // update
  P1:= BoundsRect.TopLeft;
  P2:= Point(0, 0);
  DC:= GetDC(0);

  pUpdateLayeredWindow(Handle, DC, @P1, @S, Bmp.Canvas.Handle, @P2, clNone, @Blend, 2);

  DeleteDC(DC);
  Old:= bi.bmiHeader.biWidth;
end;


end.
