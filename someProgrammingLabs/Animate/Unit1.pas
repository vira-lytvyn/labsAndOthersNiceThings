unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  TForm1 = class(TForm)
    Animate1: TAnimate;
    Button1: TButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
Var AviKindList: array[0..5] of TCommonAvi;
begin
  AviKindList[0]:=aviCopyFile;
  AviKindList[1]:=aviCopyFiles;
  AviKindList[2]:=aviEmptyReCycle;
  AviKindList[3]:=aviDeleteFile;
  AviKindList[4]:=aviFindFile;
  AviKindList[5]:=aviFindFolder;

  Animate1.CommonAVI:=AVIKindList[RadioGroup1.ItemIndex];
  Animate1.Play(0,Animate1.FrameCount,0);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Animate1.Stop;
end;

end.
