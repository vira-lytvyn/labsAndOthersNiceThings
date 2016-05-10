unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
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
             var
               lt : TSYSTEMTIME;
               st : TSYSTEMTIME;
             begin
               GetLocalTime(lt);
               GetSystemTime(st);
               Memo1.Lines.Add('LocalTime = ' +
                               IntToStr(lt.wmonth) + '/' +
                               IntToStr(lt.wDay) +  '/' +
                               IntToStr(lt.wYear) + ' ' +
                               IntToStr(lt.wHour) +  ':' +
                               IntToStr(lt.wMinute) +  ':' +
                               IntToStr(lt.wSecond));
               Memo1.Lines.Add('UTCTime = ' +
                               IntToStr(st.wmonth) + '/' +
                               IntToStr(st.wDay) +  '/' +
                               IntToStr(st.wYear) + ' ' +
                               IntToStr(st.wHour) +  ':' +
                               IntToStr(st.wMinute) +  ':' +
                               IntToStr(st.wSecond));
             end;


end.
