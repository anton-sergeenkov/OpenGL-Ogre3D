program objModel;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {MainForm},
  frmModel in 'frmModel.pas' {ModelForm},
  unitParserObj in 'unitParserObj.pas',
  frmSetting1 in 'frmSetting1.pas' {Setting1Form},
  frmSetting2 in 'frmSetting2.pas' {Setting2Form},
  unitConsts in 'unitConsts.pas',
  frmSettingTors in 'frmSettingTors.pas' {SettingTorsForm},
  frmControlBar in 'frmControlBar.pas' {ControlBarForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TMainForm, MainForm);
  //Application.CreateForm(TControlBarForm, ControlBarForm);
  //Application.CreateForm(TSettingTorsForm, SettingTorsForm);
  //Application.CreateForm(TCaseModel, CaseModel);
  //Application.CreateForm(TSetting1Form, Setting1Form);
  //Application.CreateForm(TModel1Form, Model1Form);
  Application.Run;
end.
