unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, VCLTee.TeePenDlg, VCLTee.TeCanvas,
  VCLTee.TeeEdiGrad, Vcl.Samples.Spin, Vcl.Buttons;

type
  TMainForm = class(TForm)

    procedure ChildFormsSize(Sender: TObject);

    procedure FormPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  FirstFormPaint: boolean = true;
  FirstPaint: boolean = true;

implementation

{$R *.dfm}

uses frmModel, frmSetting1, frmSetting2, frmControlBar;

  //ReleaseCapture;
  //MainForm.perform(WM_SysCommand,$F012,0);

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Width := Screen.Width - 400;
  Height := Screen.Height - 450;
end;

procedure TMainForm.ChildFormsSize(Sender: TObject);
begin

  // LEFT
  Setting1Form := TSetting1Form.Create(nil);
  Setting1Form.Top := 5;
  Setting1Form.Left := 5;
  Setting1Form.Width := 170;
  Setting1Form.Height := MainForm.Height - 36;
  Setting1Form.Show;

  // RIGHT
  Setting2Form := TSetting2Form.Create(nil);
  Setting2Form.Top := 5;
  Setting2Form.Left := MainForm.Width - 185;
  Setting2Form.Width := 170;
  Setting2Form.Height := MainForm.Height - 36;
  Setting2Form.Show;

  // MEDDLE - CENTER
  ControlBarForm := TControlBarForm.Create(nil);
  ControlBarForm.Top := 5;
  ControlBarForm.Left := 175;
  ControlBarForm.Width := MainForm.Width - 361;
  ControlBarForm.Height := 36;
  ControlBarForm.Show;

  // MIDDLE
  ModelForm := TModelForm.Create(nil);
  ModelForm.Top := 45;
  ModelForm.Left := 180;
  ModelForm.Width := MainForm.Width - 371;
  ModelForm.Height := MainForm.Height - 76;
  ModelForm.Show;

end;

// построить модель
procedure TMainForm.Button1Click(Sender: TObject);
begin
  FirstPaint := False;
  ModelForm.FormPaint(Sender);
end;

// исходная модель
procedure TMainForm.Button2Click(Sender: TObject);
begin
  ModelForm.FormResize(Sender);
end;

// рисование формы
procedure TMainForm.FormPaint(Sender: TObject);
begin
  if FirstFormPaint then
  begin
    ChildFormsSize(Self);
    FirstFormPaint := false;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ModelForm.Free;
  Setting1Form.Free;
  Setting2Form.Free;
end;


end.
