unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, JvVersionControlActions, StdCtrls, JvExStdCtrls,
  JvMemo, JvExControls, JvLabel, ExtCtrls, JvExExtCtrls, JvRadioGroup;

type
  TfrmMain = class(TForm)
    lblInputString: TJvLabel;
    memInputString: TJvMemo;
    lblOutputString: TJvLabel;
    memOutputString: TJvMemo;
    btnConvert: TButton;
    vcalMain: TJvVersionControlActionList;
    aConvert: TAction;
    rgConversionMethods: TJvRadioGroup;
    btnClear: TButton;
    aClear: TAction;
    procedure aConvertUpdate(Sender: TObject);
    procedure aConvertExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aClearUpdate(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
  private
    { Private declarations }
    FCurrCP : Cardinal;
    FLastErr : Cardinal;
    procedure AnsiToUnicode;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  aClearExecute(aClear);
end;

procedure TfrmMain.aConvertUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (rgConversionMethods.ItemIndex<>-1) and (memInputString.Lines.Count>0);
end;

procedure TfrmMain.aConvertExecute(Sender: TObject);
begin
  FCurrCP := GetACP;
  if FCurrCP=0 then
    begin
      FLastErr := GetLastError;
      memOutputString.Lines.Add('Ошибка '+IntToStr(FLastErr)+': '+SysErrorMessage(FLastErr));
    end
  else
    begin
      memOutputString.Lines.Add('Кодовая страница: '+IntToStr(FCurrCP));
      memOutputString.Lines.Add('Текст после преобразования:');
      case rgConversionMethods.ItemIndex of
        0 : AnsiToUnicode;
        1 : ;
      end;  { End of case }
    end;
end;

procedure TfrmMain.aClearUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (memInputString.Lines.Count>0) or (memOutputString.Lines.Count>0)
end;

procedure TfrmMain.aClearExecute(Sender: TObject);
begin
  memInputString.Clear;
  memOutputString.Clear;
  rgConversionMethods.ItemIndex := -1;
end;

procedure TfrmMain.AnsiToUnicode;
var
  lInputStr : String;
  lLenInputStr : Integer;
  lpWideCharStr : WideString;
  lRequiredSz : Integer;
begin
  lInputStr := memInputString.Lines.Text;
  lLenInputStr := Length(lInputStr);
  lRequiredSz := MultiByteToWideChar(FCurrCP, 0, PAnsiChar(lInputStr), lLenInputStr, nil, 0);
  if lRequiredSz=0 then
    begin
      FLastErr := GetLastError;
      memOutputString.Lines.Add('Ошибка '+IntToStr(FLastErr)+': '+SysErrorMessage(FLastErr));
    end
  else
    try
      SetLength(lpWideCharStr, lRequiredSz);
      lRequiredSz := MultiByteToWideChar(FCurrCP, 0, PAnsiChar(lInputStr), lLenInputStr, PWideChar(lpWideCharStr), lRequiredSz);
      if lRequiredSz=0 then
        begin
          FLastErr := GetLastError;
          memOutputString.Lines.Add('Ошибка '+IntToStr(FLastErr)+': '+SysErrorMessage(FLastErr));
        end
      else
        memOutputString.Lines.Add(lpWideCharStr);
    except on E: Exception do
      memOutputString.Lines.Add('Исключение '+E.ClassName+': '+E.Message)
    end;
end;

end.
