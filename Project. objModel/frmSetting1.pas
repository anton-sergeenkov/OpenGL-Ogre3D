unit frmSetting1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TSetting1Form = class(TForm)
    Timer1: TTimer;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel2: TCategoryPanel;
    CategoryPanel3: TCategoryPanel;
    CategoryPanel4: TCategoryPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    SpeedButton5: TSpeedButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Panel4: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Panel6: TPanel;
    Panel7: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    CategoryPanel1: TCategoryPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;

    // изменение стиля формы на bsNone
    procedure CreateParams(var Params: TCreateParams); override;
    // отображение на метке значения поворота модели
    procedure RotateCountLabel(AxisX: boolean);
    // отображение на метке значения перемещения модели
    procedure TranslateCountLabel(AxisX: boolean);
    // настройка модели торса
    procedure SettingTors(Sender: TObject);

    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure SpeedButton5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Button7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox1MouseLeave(Sender: TObject);
    procedure Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label9MouseLeave(Sender: TObject);
    procedure Label9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Setting1Form: TSetting1Form;
  // масштабирование
  ScaleX: real = 1;
  ScaleY: real = 1;
  ScaleZ: real = 1;
  // поворот
  RotateX: integer = 0;
  RotateY: integer = 0;
  OriginalRotateX: integer = 0;
  OriginalRotateY: integer = 0;
  // перенос
  TranslateX: integer = 0;
  TranslateY: integer = 0;
  OriginalTranslateX: integer = 0;
  OriginalTranslateY: integer = 0;

implementation

{$R *.dfm}

uses frmModel, frmMain, frmSettingTors, unitConsts;

// изменение стиля формы на bsNone
procedure TSetting1Form.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not WS_OVERLAPPEDWINDOW
end;

// -----------------------------------------------------------------------------
// Масштабирование
// -----------------------------------------------------------------------------

// CheckBox 1
procedure TSetting1Form.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    TrackBar1.Enabled := True
  else
    TrackBar1.Enabled := False;
end;

// CheckBox 2
procedure TSetting1Form.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
    TrackBar2.Enabled := True
  else
    TrackBar2.Enabled := False;
end;

// CheckBox 3
procedure TSetting1Form.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
    TrackBar3.Enabled := True
  else
    TrackBar3.Enabled := False;
end;

// TrackBar1
procedure TSetting1Form.TrackBar1Change(Sender: TObject);
begin
  if CheckBox4.Checked then
  begin
    TrackBar2.Position := TrackBar1.Position;
    TrackBar3.Position := TrackBar1.Position;
    if TrackBar1.Position <> 0 then
    begin
      ScaleX := TrackBar1.Position;
      ScaleY := TrackBar2.Position;
      ScaleZ := TrackBar3.Position;
    end
    else
    begin
      ScaleX := 0.2;
      ScaleY := 0.2;
      ScaleZ := 0.2;
    end;
    Label4.Caption := 'x' + FloatToStr(ScaleX);
    Label5.Caption := 'x' + FloatToStr(ScaleY);
    Label6.Caption := 'x' + FloatToStr(ScaleZ);
  end
  else
  begin
    if TrackBar1.Position <> 0 then
      ScaleX := TrackBar1.Position
    else
      ScaleX := 0.2;
    Label4.Caption := 'x' + FloatToStr(ScaleX);
  end;
  ModelForm.RePaint;
end;

// TrackBar2
procedure TSetting1Form.TrackBar2Change(Sender: TObject);
begin
  if CheckBox4.Checked then
  begin
    TrackBar1.Position := TrackBar2.Position;
    TrackBar3.Position := TrackBar2.Position;
    if TrackBar2.Position <> 0 then
    begin
      ScaleX := TrackBar1.Position;
      ScaleY := TrackBar2.Position;
      ScaleZ := TrackBar3.Position;
    end
    else
    begin
      ScaleX := 0.2;
      ScaleY := 0.2;
      ScaleZ := 0.2;
    end;
    Label4.Caption := 'x' + FloatToStr(ScaleX);
    Label5.Caption := 'x' + FloatToStr(ScaleY);
    Label6.Caption := 'x' + FloatToStr(ScaleZ);
  end
  else
  begin
    if TrackBar2.Position <> 0 then
      ScaleX := TrackBar2.Position
    else
      ScaleX := 0.2;
    Label5.Caption := 'x' + FloatToStr(ScaleX);
  end;
  ModelForm.RePaint;
end;

// TrackBar3
procedure TSetting1Form.TrackBar3Change(Sender: TObject);
begin

  if CheckBox4.Checked then
  begin
    TrackBar1.Position := TrackBar3.Position;
    TrackBar2.Position := TrackBar3.Position;
    if TrackBar3.Position <> 0 then
    begin
      ScaleX := TrackBar1.Position;
      ScaleY := TrackBar2.Position;
      ScaleZ := TrackBar3.Position;
    end
    else
    begin
      ScaleX := 0.2;
      ScaleY := 0.2;
      ScaleZ := 0.2;
    end;
    Label4.Caption := 'x' + FloatToStr(ScaleX);
    Label5.Caption := 'x' + FloatToStr(ScaleY);
    Label6.Caption := 'x' + FloatToStr(ScaleZ);
  end
  else
  begin
    if TrackBar3.Position <> 0 then
      ScaleX := TrackBar3.Position
    else
      ScaleX := 0.2;
    Label6.Caption := 'x' + FloatToStr(ScaleX);
  end;
  ModelForm.RePaint;
end;

// -----------------------------------------------------------------------------
// Поворот
// -----------------------------------------------------------------------------

// ось X +1
procedure TSetting1Form.Button3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton1.Checked then
  begin
    RotateX := 1;
    ModelForm.RotateModel(true);
    Setting1Form.RotateCountLabel(true);
  end;
end;

// ось X -1
procedure TSetting1Form.Button4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton1.Checked then
  begin
    RotateX := - 1;
    ModelForm.RotateModel(true);
    Setting1Form.RotateCountLabel(true);
  end;
end;

// ось Y +1
procedure TSetting1Form.Button5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton2.Checked then
  begin
    RotateY := 1;
    ModelForm.RotateModel(false);
    Setting1Form.RotateCountLabel(false);
  end;
end;

// ось Y -1
procedure TSetting1Form.Button6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton2.Checked then
  begin
    RotateY := - 1;
    ModelForm.RotateModel(false);
    Setting1Form.RotateCountLabel(false);
  end;
end;

// таймер автоповорот
procedure TSetting1Form.Timer1Timer(Sender: TObject);
begin
  if RadioButton1.Checked then
  begin
    RotateX := 1;
    ModelForm.RotateModel(true);
    Setting1Form.RotateCountLabel(true);
  end;

  if RadioButton2.Checked then
  begin
    RotateY := 1;
    ModelForm.RotateModel(false);
    Setting1Form.RotateCountLabel(false);
  end;
end;

// автоповорот
procedure TSetting1Form.SpeedButton5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Label3.Caption = 'Автоповорот отключен' then
  begin
    Label3.Caption := 'Автоповорот включен';
    SpeedButton5.Flat := False;
    Timer1.Enabled := True;
    Exit;
  end;
  if Label3.Caption = 'Автоповорот включен' then
  begin
    Label3.Caption := 'Автоповорот отключен';
    SpeedButton5.Flat := True;
    Timer1.Enabled := False;
    Exit;
  end;
end;

// отображение на метке значения поворота модели
procedure TSetting1Form.RotateCountLabel(AxisX: boolean);
begin
  if AxisX then
  begin
    OriginalRotateX := OriginalRotateX + RotateX;
    Label1.Caption := IntToStr(OriginalRotateX);
  end
  else
  begin
    OriginalRotateY := OriginalRotateY + RotateY;
    Label2.Caption := IntToStr(OriginalRotateY);
  end;
end;

// -----------------------------------------------------------------------------
// Перемещение
// -----------------------------------------------------------------------------

// ось X
procedure TSetting1Form.Button7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton3.Checked then
  begin
    TranslateX := 1;
    ModelForm.TranslateModel(true);
    TranslateCountLabel(true);
  end;
end;

procedure TSetting1Form.Button8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton3.Checked then
  begin
    TranslateX := -1;
    ModelForm.TranslateModel(true);
    TranslateCountLabel(true);
  end;
end;

// ось Y
procedure TSetting1Form.Button9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton4.Checked then
  begin
    TranslateY := 1;
    ModelForm.TranslateModel(false);
    TranslateCountLabel(false);
  end;
end;

procedure TSetting1Form.Button10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton4.Checked then
  begin
    TranslateY := -1;
    ModelForm.TranslateModel(false);
    TranslateCountLabel(false);
  end;
end;

// отображение на метке значения перемещения модели
procedure TSetting1Form.TranslateCountLabel(AxisX: boolean);
begin
  if AxisX then
  begin
    OriginalTranslateX := OriginalTranslateX + TranslateX;
    Label7.Caption := IntToStr(OriginalTranslateX);
  end
  else
  begin
    OriginalTranslateY := OriginalTranslateY + TranslateY;
    Label8.Caption := IntToStr(OriginalTranslateY);
  end;
end;










// настройка модели торса
procedure TSetting1Form.SettingTors(Sender: TObject);
begin
  SettingTorsForm := TSettingTorsForm.Create(nil);
  SettingTorsForm.Show;
end;

procedure TSetting1Form.GroupBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  GroupBox1.Color := COLOR_2;
end;

procedure TSetting1Form.GroupBox1MouseLeave(Sender: TObject);
begin
  GroupBox1.Color := COLOR_1;
end;

procedure TSetting1Form.Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox1.Color := COLOR_2;
end;

procedure TSetting1Form.Label9MouseLeave(Sender: TObject);
begin
  GroupBox1.Color := COLOR_1;
end;

procedure TSetting1Form.Label9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SettingTors(Sender);
end;

procedure TSetting1Form.GroupBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SettingTors(Sender);
end;




end.
