program Internalization;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Интернализация';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
