unit frmControlBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TControlBarForm = class(TForm)
    ControlBar1: TControlBar;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;

    // изменение стиля формы на bsNone
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Image11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image12MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ControlBarForm: TControlBarForm;
  VisibleImage: boolean = True;

implementation

{$R *.dfm}

uses frmMain, frmModel;

// изменение стиля формы на bsNone
procedure TControlBarForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not WS_OVERLAPPEDWINDOW;
end;


procedure TControlBarForm.Image11MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MainForm.Close;
end;

procedure TControlBarForm.Image12MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  pseconds = 100;
begin

  if VisibleImage then
  begin
    Application.ProcessMessages;
    Sleep(pseconds);
    Image11.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image10.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image9.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image8.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image7.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image6.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image5.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image4.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image3.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image2.Visible := False;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image1.Visible := False;

    VisibleImage := False;

    ModelForm.Close;
    ModelForm.Free;

    // MIDDLE
    ModelForm := TModelForm.Create(nil);
    ModelForm.Top := 5;
    ModelForm.Left := 180;
    ModelForm.Width := MainForm.Width - 371;
    ModelForm.Height := MainForm.Height - 36;
    ModelForm.Show;

  end else
  begin
    Application.ProcessMessages;
    Sleep(pseconds);
    Image1.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image2.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image3.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image4.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image5.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image6.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image7.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image8.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image9.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image10.Visible := True;

    Application.ProcessMessages;
    Sleep(pseconds);
    Image11.Visible := True;

    VisibleImage := True;

    ModelForm.Close;
    ModelForm.Free;

    // MIDDLE
    ModelForm := TModelForm.Create(nil);
    ModelForm.Top := 45;
    ModelForm.Left := 180;
    ModelForm.Width := MainForm.Width - 371;
    ModelForm.Height := MainForm.Height - 76;
    ModelForm.Show;

  end;

end;

end.
