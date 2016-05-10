unit WavePanel;

{
WavePanel: component with running colors, like panel at the bottom
           of the startup screen when Windows 9x loading. Freeware.

Status: Freeware with full source.

Installation: Choose 'Install Component...' at the main menu.
              Choose the 'Into new package' tab. Select in
              the 'Unit file name' the wavepanel.pas. And in the
              'Package file name' input any file name
              (not 'wavepanel' - 'wavepanelpack', for example).
              Press 'Ok' button. That's all!

---------- Other products ----------

MaxSpace
~~~~~~~~
MaxSpace just makes Delphi and C++ Builder more comfortable in usage.
It turns the IDE ToolBar and ObjectInspector into emerging state,
giving you unbelievable freedom of program editing and form designing.
For more information visit http://www.zecos.com/maxspc

ElegantMDI
~~~~~~~~~~
This component is a new elegant realiztion of the old MDI interface.
All windows (MDIChild) will be presented as buttons on autohidden panel.
User can toggle between windows without choosing items in main menu.
It looks very effectively. Freeware.

MinModal
~~~~~~~~
Minimizer for modal windows. Why we can't minimize an application when
a modal window is active? Drop this component to the form, open form
by method 'ShowModal' and try minimize this form at run time. All your
application will be minimized!

All this programs you can download from http://www.zecos.com

Zecos Software team
http://www.zecos.com
support@zecos.com
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TDirection = (drLeftToRight, drRightToLeft, drTopToBottom, drBottomToTop);
  TAlignHor = (hrLeft, hrCenter, hrRight);
  TAlignVer = (vrTop, vrCenter, vrBottom);
  TInternet = (asEMail, asWWW, asNone);

  TWavePanel = class(TCustomControl)
  private
    FActive: Boolean;
    FIdTimer: Integer;
    FCurentCoord: Integer;
    FFromColor: TColor;
    FToColor: TColor;
    FStepSize: Integer;
    FDelay: Integer;
    FOfset: Integer;
    FPeriod: Integer;
    FInnerToColor: TColor;
    FStepColor: Integer;
    FDirection: TDirection;
    FMyEmail: String;
    FCaption: TCaption;
    FAlignHorizontal: TAlignHor;
    FAlignVertical: TAlignVer;
    FUseInternet: TInternet;
    FSelectColor: TColor;
    FOldColor: TColor;
    procedure SetActive(const Value: Boolean);
    procedure SetFromColor(const Value: TColor);
    procedure SetToColor(const Value: TColor);
    procedure SetStepSize(const Value: Integer);
    procedure WhatPeriod;
    procedure SetStepColor(const Value: Integer);
    procedure SetDirection(const Value: TDirection);
    procedure SetCaption(const Value: TCaption);
    procedure SetAlignHorizontal(const Value: TAlignHor);
    procedure SetAlignVertical(const Value: TAlignVer);
    procedure SetUseInternet(const Value: TInternet);
  protected
    procedure SetName(const NewName : TComponentName); override;
    procedure WMLButtonDown(var Message: TMessage); message WM_LBUTTONDOWN;
    procedure WMTimer(var Message: TMessage); message WM_TIMER;
    procedure WMPaint(var Message: TMessage); message WM_PAINT;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Active: Boolean read FActive write SetActive default False;
    property Caption: TCaption read FCaption write SetCaption;
    property FromColor: TColor read FFromColor write SetFromColor;
    property ToColor: TColor read FToColor write SetToColor;
    property StepSize: Integer read FStepSize write SetStepSize;
    property StepColor: Integer read FStepColor write SetStepColor;
    property Direction: TDirection read FDirection write SetDirection;
    property AlignHorizontal: TAlignHor read FAlignHorizontal write SetAlignHorizontal default hrCenter;
    property AlignVertical: TAlignVer read FAlignVertical write SetAlignVertical default vrCenter;
    property UseInternet: TInternet read FUseInternet write SetUseInternet default asNone;
    property SelectColor: TColor read FSelectColor write FSelectColor;
    property Font;
    property Align;
    property Visible;
    property DragCursor;
    property DragMode;
    property PopupMenu;
    property ShowHint;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    property DragKind;
    property Anchors;
    property DockSite;
    property UseDockManager;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnUnDock;
  end;

procedure Register;

implementation

uses ShellAPI;

procedure Register;
begin
  RegisterComponents('Samples', [TWavePanel]);
end;

{ TWavePanel }

procedure TWavePanel.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  if (UseInternet<>asNone) and (not (csDesigning in ComponentState)) then begin
    FOldColor := Font.Color;
    Font.Color := SelectColor;
  end;
end;

procedure TWavePanel.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  Font.Color := FOldColor;
end;

constructor TWavePanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 400;
  Height := 15;
  Direction := drLeftToRight;
  FMyEmail := 'support@zecos.com';
  UseInternet := asNone;
  StepColor := 15;
  StepSize := 10;
  FCurentCoord := 0;
  FOfset := Width div 4;
  FromColor := clRed;
  ToColor := clYellow;
  SelectColor := clBlue;
  AlignHorizontal := hrCenter;
  AlignVertical := vrCenter;
  FDelay := 50;
  Canvas.Brush.Color := FromColor;
  Active := False;
end;

procedure TWavePanel.SetActive(const Value: Boolean);
begin
  if FActive<>Value then begin
    if Value then begin
      WhatPeriod;
      FIdTimer := SetTimer(Handle,1,FDelay,nil);
      if FIdTimer=1 then begin
        FActive := Value;
      end
      else
        Application.MessageBox('Can''t activate.','Error',MB_OK+MB_ICONERROR);
    end
    else begin
      if KillTimer(Handle,FIdTimer) then
        FActive := Value
      else
        Application.MessageBox('Can''t deactivate','Error',MB_OK+MB_ICONERROR);
    end;
  end;
end;

procedure TWavePanel.SetAlignHorizontal(const Value: TAlignHor);
begin
  if FAlignHorizontal<>Value then begin
    FAlignHorizontal := Value;
    Invalidate;
  end;
end;

procedure TWavePanel.SetAlignVertical(const Value: TAlignVer);
begin
  if FAlignVertical<>Value then begin
    FAlignVertical := Value;
    Invalidate;
  end;
end;

procedure TWavePanel.SetCaption(const Value: TCaption);
begin
  if FCaption<>Value then begin
    FCaption := Value;
    Invalidate;
  end;
end;

procedure TWavePanel.SetDirection(const Value: TDirection);
begin
  if FDirection<>Value then begin
    case Direction of
      drLeftToRight,
      drRightToLeft: begin
                       case Value of
                         drLeftToRight,
                         drRightToLeft: begin
                                          FCurentCoord := (Width-FCurentCoord);
                                          FOfset := (Width-FCurentCoord);
                                        end;
                         drTopToBottom: begin
                                          FCurentCoord := 0;
                                          FOfset := 0;
                                        end;
                         drBottomToTop: begin
                                          FCurentCoord := Height;
                                          FOfset := Height;
                                        end;
                       end;
                     end;
      drTopToBottom,
      drBottomToTop: begin
                       case Value of
                         drTopToBottom,
                         drBottomToTop: begin
                                          FCurentCoord := (Height-FCurentCoord);
                                          FOfset := (Height-FCurentCoord);
                                        end;
                         drLeftToRight: begin
                                          FCurentCoord := 0;
                                          FOfset := 0;
                                        end;
                         drRightToLeft: begin
                                          FCurentCoord := Width;
                                          FOfset := Width;
                                        end;
                       end;
                     end;
    end;
    FDirection := Value;
  end;
end;

procedure TWavePanel.SetFromColor(const Value: TColor);
begin
  if FFromColor<>Value then begin
    FFromColor := Value;
    Canvas.Brush.Color := FFromColor;
    WhatPeriod;
  end;
end;

procedure TWavePanel.SetName(const NewName: TComponentName);
begin
  if csDesigning in ComponentState then begin
  if Caption=Name then begin
    inherited SetName(NewName);
    Caption := Name;
  end
  else
    inherited SetName(NewName);
  end
  else inherited SetName(NewName);
end;

procedure TWavePanel.SetStepColor(const Value: Integer);
begin
  if FStepColor<>Value then begin
    if Value>0 then begin
      FStepColor := Value;
      WhatPeriod;
    end
    else
      Application.MessageBox('Value must be more than 0.','Error',MB_OK+MB_ICONERROR);
  end;
end;

procedure TWavePanel.SetStepSize(const Value: Integer);
begin
  if FStepSize<>Value then begin
    if Value>0 then
      FStepSize := Value
    else
      Application.MessageBox('Value must be more than 0.','Error',MB_OK+MB_ICONERROR);
  end;
end;

procedure TWavePanel.SetToColor(const Value: TColor);
begin
  if FToColor<>Value then begin
    FToColor := Value;
    FInnerToColor := ToColor;
    WhatPeriod;
  end;
end;

procedure TWavePanel.SetUseInternet(const Value: TInternet);
begin
  if FUseInternet<>Value then begin
    if Value<>asNone then begin
      Font.Style := Font.Style + [fsUnderline];
      Cursor := crHandPoint;
    end
    else begin
      Font.Style := Font.Style - [fsUnderline];
      Cursor := crDefault;
    end;
    FUseInternet := Value;
  end;
end;

procedure TWavePanel.WhatPeriod;
var
  TmpColor: TColor;
begin
  TmpColor := FromColor;
  FPeriod := 0;
  while TmpColor<>ToColor do begin
    if (TmpColor and $FF0000)>(ToColor and $FF0000) then begin
      TmpColor := TmpColor - $010000*StepColor;
    end;
    if (TmpColor and $FF0000)<(ToColor and $FF0000) then begin
      TmpColor := TmpColor + $010000*StepColor;
    end;
    if Abs((TmpColor and $FF0000)-(ToColor and $FF0000))<$010000*StepColor then
      TmpColor := (ToColor and $FF0000) or (TmpColor and $00FFFF);

    if (TmpColor and $00FF00)>(ToColor and $00FF00) then begin
      TmpColor := TmpColor - $000100*StepColor;
    end;
    if (TmpColor and $00FF00)<(ToColor and $00FF00) then begin
      TmpColor := TmpColor + $000100*StepColor;
    end;
    if Abs((TmpColor and $00FF00)-(ToColor and $00FF00))<$000100*StepColor then
      TmpColor := (ToColor and $00FF00) or (TmpColor and $FF00FF);

    if (TmpColor and $0000FF)>(ToColor and $0000FF) then begin
      TmpColor := TmpColor - $000001*StepColor;
    end;
    if (TmpColor and $0000FF)<(ToColor and $0000FF) then begin
      TmpColor := TmpColor + $000001*StepColor;
    end;
    if Abs((TmpColor and $0000FF)-(ToColor and $0000FF))<$000001*StepColor then
      TmpColor := (ToColor and $0000FF) or (TmpColor and $FFFF00);

    FPeriod := FPeriod + 1;
  end;
  FPeriod := FPeriod * 2;
end;

procedure TWavePanel.WMLButtonDown(var Message: TMessage);
begin
  inherited;
  case UseInternet of
    asEMail: ShellExecute(Application.Handle,'open',PChar('mailto:'+Caption),'','',SW_MAXIMIZE);
    asWWW: ShellExecute(Application.Handle,'open',PChar('http://'+Caption),'','',SW_MAXIMIZE);
  end;
end;

procedure TWavePanel.WMPaint(var Message: TMessage);
var
  i: Integer;
  x,y: Integer;
begin
  if Message.LParam=0 then inherited;

  with Canvas do begin
    Brush.Color := FromColor;
    if Message.LParam<>0 then begin
      case Direction of
        drLeftToRight:
          FillRect(Rect(Abs(FOfset-StepSize),0,FOfset,Height));
        drRightToLeft:
          FillRect(Rect(Abs(FOfset+StepSize),0,FOfset,Height));
        drTopToBottom:
          FillRect(Rect(0,Abs(FOfset-StepSize),Width,FOfset));
        drBottomToTop:
          FillRect(Rect(0,Abs(FOfset+StepSize),Width,FOfset));
      end;
    end
    else
      FillRect(Rect(0,0,Width,Height));

    FCurentCoord := FOfset;
    FInnerToColor := ToColor;
    for i:=1 to FPeriod do begin
      if (Brush.Color and $FF0000)>(FInnerToColor and $FF0000) then begin
        Brush.Color := Brush.Color - $010000*StepColor;
      end;
      if (Brush.Color and $FF0000)<(FInnerToColor and $FF0000) then begin
        Brush.Color := Brush.Color + $010000*StepColor;
      end;
      if Abs((Brush.Color and $FF0000)-(FInnerToColor and $FF0000))<$010000*StepColor then
        Brush.Color := (FInnerToColor and $FF0000) or (Brush.Color and $00FFFF);

      if (Brush.Color and $00FF00)>(FInnerToColor and $00FF00) then begin
        Brush.Color := Brush.Color - $000100*StepColor;
      end;
      if (Brush.Color and $00FF00)<(FInnerToColor and $00FF00) then begin
        Brush.Color := Brush.Color + $000100*StepColor;
      end;
      if Abs((Brush.Color and $00FF00)-(FInnerToColor and $00FF00))<$000100*StepColor then
        Brush.Color := (FInnerToColor and $00FF00) or (Brush.Color and $FF00FF);

      if (Brush.Color and $0000FF)>(FInnerToColor and $0000FF) then begin
        Brush.Color := Brush.Color - $000001*StepColor;
      end;
      if (Brush.Color and $0000FF)<(FInnerToColor and $0000FF) then begin
        Brush.Color := Brush.Color + $000001*StepColor;
      end;
      if Abs((Brush.Color and $0000FF)-(FInnerToColor and $0000FF))<$000001*StepColor then
        Brush.Color := (FInnerToColor and $0000FF) or (Brush.Color and $FFFF00);

      if Brush.Color=FInnerToColor then begin
        FInnerToColor := FromColor;
      end;

      case Direction of
        drLeftToRight: begin
                         FillRect(Rect(FCurentCoord,0,FCurentCoord+StepSize,Height));
                         FCurentCoord := FCurentCoord + StepSize;
                         if FCurentCoord>=Width then
                           FCurentCoord := 0;
                       end;
        drRightToLeft: begin
                         FillRect(Rect(FCurentCoord,0,FCurentCoord-StepSize,Height));
                         FCurentCoord := FCurentCoord - StepSize;
                         if FCurentCoord<=0 then
                           FCurentCoord := Width;
                       end;
        drTopToBottom: begin
                         FillRect(Rect(0,FCurentCoord,Width,FCurentCoord+StepSize));
                         FCurentCoord := FCurentCoord + StepSize;
                         if FCurentCoord>=Height then
                           FCurentCoord := 0;
                       end;
        drBottomToTop: begin
                         FillRect(Rect(0,FCurentCoord,Width,FCurentCoord-StepSize));
                         FCurentCoord := FCurentCoord - StepSize;
                         if FCurentCoord<=0 then
                           FCurentCoord := Height;
                       end;
      end;
    end;

    if Message.LParam<>0 then begin
      case Direction of
        drLeftToRight: begin
                         FOfset := FOfset + StepSize;
                         if FOfset>=Width then FOfset:=0;
                       end;
        drRightToLeft: begin
                         FOfset := FOfset - StepSize;
                         if FOfset<=0 then FOfset:=Width;
                       end;
        drTopToBottom: begin
                         FOfset := FOfset + StepSize;
                         if FOfset>=Height then FOfset:=0;
                       end;
        drBottomToTop: begin
                         FOfset := FOfset - StepSize;
                         if FOfset<=0 then FOfset:=Height;
                       end;
      end;
    end;
  end;

  if Caption<>'' then begin
    SetBkMode(Canvas.Handle,TRANSPARENT);
    Canvas.Font.Assign(Font);
    x := 0;
    y := 0;
    case AlignHorizontal of
      hrLeft: x:=0;
      hrCenter: x:=(Width-Canvas.TextWidth(Caption)) div 2;
      hrRight: x:=(Width-Canvas.TextWidth(Caption));
    end;
    case AlignVertical of
      vrTop: y := 0;
      vrCenter: y := (Height-Canvas.TextHeight(Caption)) div 2;
      vrBottom: y := (Height-Canvas.TextHeight(Caption));
    end;
    Canvas.TextOut(x,y,Caption);
  end;
end;

procedure TWavePanel.WMTimer(var Message: TMessage);
begin
  Perform(WM_PAINT,Canvas.Handle,1);
end;

end.
