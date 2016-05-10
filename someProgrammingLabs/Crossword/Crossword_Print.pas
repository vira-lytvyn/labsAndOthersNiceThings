unit Crossword_Print;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, ExtCtrls, Buttons;

type
  TfmPrint = class(TForm)
    pnlPrint: TPanel;
    sgPrint: TStringGrid;
    redPrint: TRichEdit;
    bbtnPrint: TBitBtn;
    bbtnClose: TBitBtn;
    procedure bbtnPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgPrintDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrint: TfmPrint;

implementation

{$R *.dfm}

procedure TfmPrint.bbtnPrintClick(Sender: TObject);
begin
  redPrint.Visible := False;
  bbtnPrint.Visible := False;
  bbtnClose.Visible := False;
  Print;
  redPrint.Print('');
  redPrint.Visible := True;
  bbtnPrint.Visible := True;
  bbtnClose.Visible := True;
end;

procedure TfmPrint.FormShow(Sender: TObject);
begin
  with sgPrint do
  begin
    DefaultColWidth := (Width - 10) div ColCount;
    DefaultRowHeight := DefaultColWidth;
  end;
end;

procedure TfmPrint.sgPrintDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var CurNumber: integer;
    CurLetter: Char;
begin
  with sgPrint, Canvas do
  begin
    if Cells[ACol, ARow] = '_'
      then Brush.Color := clGray
      else Brush.Color := clWhite;
    FillRect(Rect);
    if Cells[ACol, ARow] <> '_' then
    begin
      CurNumber := StrToInt(Copy(Cells[ACol, ARow], 1, 3));
      if Length(Cells[ACol, ARow]) < 4
        then CurLetter := ' '
        else CurLetter := Copy(Cells[ACol, ARow], 4, 1)[1];
      Font.Size := DefaultRowHeight div 2;
      TextOut(Rect.Left + (DefaultColWidth*2 div 5),
              Rect.Top + (DefaultColWidth div 5), CurLetter);
      if CurNumber <> 0
      then begin
        Font.Size := DefaultRowHeight div 4;
        TextOut(Rect.Left + 1, Rect.Top + 1, IntToStr(CurNumber));
      end;
    end;
  end;
end;

end.
