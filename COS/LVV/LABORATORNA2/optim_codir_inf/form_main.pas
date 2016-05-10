unit form_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ToolWin, ComCtrls, Grids, ExtCtrls, mat_code, XPMan;

type
  TFormMain = class(TForm)
    CoolBar1: TCoolBar;
    Panel6: TPanel;
    Label3: TLabel;
    edText: TEdit;
    memAnalyze: TMemo;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    sgShannonFano: TStringGrid;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    memShannonFano: TMemo;
    sgHuffman: TStringGrid;
    memHuffman: TMemo;
    XPManifest1: TXPManifest;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edTextChange(Sender: TObject);
  private
    FModeler: TMatModeler;
    FCoderShannonFano: TMatCoder;
    FCoderHuffman: TMatCoder;
    procedure CreateCoderInfo(Coder: TMatCoder; StringGrid: TStringGrid; Memo: TMemo);
  end;

var
  FormMain: TFormMain;

implementation
uses math;

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FModeler := TMatModeler.Create;
  FCoderShannonFano := TMatCoderShannonFano.Create(FModeler);
  FCoderHuffman := TMatCoderHuffman.Create(FModeler);
  edText.OnChange(Self);
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FModeler.Free;
end;

procedure TFormMain.edTextChange(Sender: TObject);
begin
  FModeler.Execute(edText.Text);
  FCoderShannonFano.Execute;
  FCoderHuffman.Execute;
  with memAnalyze, Lines, FModeler do
  begin
    Clear;
    Add(Format('Длина сообщения (символов): %d', [Length(FModeler.Text)]));
    Add(Format('Кол-во символов алфавита: %d',[CharsPerTable]));
    Add(Format('Энтропия сообщения: %.5f', [EntropyPerText]));
    Add(Format('Средняя энтропия символа: %.5f',[EntropyPerChar]));
    Add(Format('Длина символа при равномерном кодировании (бит): %d', [BitsPerChar]));
    Add(Format('Длина сообщения при равномерном кодировании (бит): %d', [BitsPerText]));
    Add(Format('Абсолютная избыточность в представлении сообщения: %.5f', [RedundancePerText]));
    Add(Format('Средняя абсолютная избыточность в представлении символа: %.5f',[RedundancePerChar]));
  end;
  CreateCoderInfo(FCoderShannonFano, sgShannonFano, memShannonFano);
  CreateCoderInfo(FCoderHuffman, sgHuffman, memHuffman);
end;

procedure TFormMain.CreateCoderInfo(Coder: TMatCoder; StringGrid: TStringGrid; Memo: TMemo);
var rc, k, i, ci: Integer;
    CharItem: PMatCharTableItem;
    CodeItem: PMatCodeTableItem;
begin
  with StringGrid, Coder do
  begin
    rc := FModeler.CharsPerTable + 1;
    if rc = 1 then
    begin
       Inc(rc);
       Rows[1].Clear;
    end;

    RowCount := rc;
    Cells[0, 0] := 'Символ';
    Cells[1, 0] := 'Вероятность';
    Cells[2, 0] := 'Энтропия';
    Cells[3, 0] := 'Избыток';
    Cells[4, 0] := 'Код';

    for k := 0 to CodesPerTable-1 do
    begin
      ci := CodeIndex[k];
      CodeItem := CodeTable[ci];
      CharItem := FModeler.CharTable[CodeItem.CharItem.Value];

      Cells[0, k+1] := Format('"%s"', [Chr(CodeItem.CharItem.Value)]);
      Cells[1, k+1] := Format('%.5f', [CharItem.Probability]);
      Cells[2, k+1] := Format('%.5f', [CharItem.Entropy]);
      Cells[3, k+1] := Format('%5.2f', [CodeItem.Redundance]);
      Cells[4, k+1] := Format('%s', [CodeItem.Code]);
      for i := 1 to Length(CodeItem.Code) do Cells[4 + i, k+1] := CodeItem.Code[i];
      for i := Length(CodeItem.Code) + 1 to 32 do Cells[4 + i, k+1] := '';
    end;
  end;
  with Memo, Lines, Coder do
  begin
    Clear;
    Add(Format('Средняя длина кода: %.5f',[AvgCodeLength]));
    Add(Format('Коэффициент относительной эффективности: %.5f',[RatioEffective]));
    Add(Format('Коэффициент сжатия кода: %.5f',[RatioCompression]));
    Add(Format('Длина сжатого сообщения (бит): %d', [BitsPerText]));
  end;
end;

end.
