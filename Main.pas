unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, JvVersionControlActions, StdCtrls, JvExStdCtrls,
  JvMemo, JvExControls, JvLabel;

type
  TfrmMain = class(TForm)
    lblInputString: TJvLabel;
    memInputString: TJvMemo;
    lblOutputString: TJvLabel;
    memOutputString: TJvMemo;
    btnConvert: TButton;
    JvVersionControlActionList1: TJvVersionControlActionList;
    aConvert: TAction;
    procedure aConvertUpdate(Sender: TObject);
    procedure aConvertExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  memInputString.Clear;
  memOutputString.Clear;
end;

procedure TfrmMain.aConvertUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := memInputString.Lines.Count > 0;
end;

procedure TfrmMain.aConvertExecute(Sender: TObject);
var
  lInputStr : String;
  lCurrCP : Cardinal;
  lLastErr : Cardinal;
begin
  lInputStr := memInputString.Lines.Text;
  lCurrCP := GetConsoleCP;
  if lCurrCP=0 then
    begin
      lLastErr := GetLastError;
      memOutputString.Lines.Add('Ошибка '+IntToStr(lLastErr)+': '+SysErrorMessage(lLastErr));
    end
  else
    memOutputString.Lines.Add('Кодовая страница: '+IntToStr(lCurrCP))
end;

end.
