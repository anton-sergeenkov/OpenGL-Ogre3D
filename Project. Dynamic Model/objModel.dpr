program objModel;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {MainForm},
  frameModel in 'frameModel.pas' {ModelFrame: TFrame},
  unitParserObj in 'unitParserObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
