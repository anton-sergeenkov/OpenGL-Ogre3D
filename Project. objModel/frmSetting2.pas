unit frmSetting2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CategoryButtons, Vcl.ExtCtrls,
  Vcl.StdCtrls, VCLTee.TeCanvas, VCLTee.TeeEdiGrad, VCLTee.TeePenDlg,
  Vcl.Buttons, Vcl.ComCtrls;

type
  TSetting2Form = class(TForm)
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CategoryPanel2: TCategoryPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    TrackBar1: TTrackBar;
    Label5: TLabel;
    CategoryPanel3: TCategoryPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox5: TGroupBox;
    Label6: TLabel;

    // изменение стиля формы на bsNone
    procedure CreateParams(var Params: TCreateParams); override;

    procedure DrawFigure1(Sender: TObject);
    procedure DrawFigure2(Sender: TObject);
    procedure DrawFigure3(Sender: TObject);
    procedure DrawFigure5(Sender: TObject);
    procedure DrawFigureClipPlane(Sender: TObject);


    procedure Label3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox1MouseLeave(Sender: TObject);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox2MouseLeave(Sender: TObject);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox3MouseLeave(Sender: TObject);
    procedure Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox4MouseLeave(Sender: TObject);
    procedure Label4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure Edit3Click(Sender: TObject);
    procedure GroupBox5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupBox5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox5MouseLeave(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label6MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Setting2Form: TSetting2Form;
  BlendCount: real = 10;
  ClipPlane1: real = 0;
  ClipPlane2: real = 0;
  ClipPlane3: real = 1;

implementation

{$R *.dfm}

uses frmSetting1, frmModel, frmMain, unitParserObj, unitConsts;

// изменение стиля формы на bsNone
procedure TSetting2Form.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not WS_OVERLAPPEDWINDOW;
end;



// пустой холст-----------------------------------------------------------------
procedure TSetting2Form.DrawFigure1(Sender: TObject);
begin
  CategoryPanel3.Visible := False;

  NumberModel := 1;
  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);
end;

procedure TSetting2Form.GroupBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawFigure1(Sender);
end;

procedure TSetting2Form.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawFigure1(Sender);
end;
// -----------------------------------------------------------------------------

// модель Торса-----------------------------------------------------------------
procedure TSetting2Form.DrawFigure2(Sender: TObject);
begin
  Setting1Form.TrackBar1.Position := 6;
  Setting1Form.TrackBar2.Position := 6;
  Setting1Form.TrackBar3.Position := 6;
  RadioButton4.Enabled := False;
  CategoryPanel3.Visible := False;

  ModelForm.CreateObjLoader(OBJ_TORS);
  ModelForm.CreateObjLoaderInside(OBJ_HEART_IN_TORS);

  NumberModel := 2;
  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);
end;

procedure TSetting2Form.GroupBox2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawFigure2(Sender);
end;

procedure TSetting2Form.Label2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawFigure2(Sender);
end;
// -----------------------------------------------------------------------------

// модель Сердца----------------------------------------------------------------
procedure TSetting2Form.DrawFigure3(Sender: TObject);
begin
  Setting1Form.TrackBar1.Position := 2;
  Setting1Form.TrackBar2.Position := 2;
  Setting1Form.TrackBar3.Position := 2;
  RadioButton4.Enabled := True;
  CategoryPanel3.Visible := False;

  ModelForm.CreateObjLoader(OBJ_HEART);

  if RadioButton4.Checked then
    NumberModel := 4
  else
    NumberModel := 3;

  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);
end;

procedure TSetting2Form.GroupBox3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawFigure3(Sender);
end;

procedure TSetting2Form.Label3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawFigure3(Sender);
end;

// -----------------------------------------------------------------------------

// модель Сердца (сечение)------------------------------------------------------
procedure TSetting2Form.DrawFigure5(Sender: TObject);
begin
  Setting1Form.TrackBar1.Position := 2;
  Setting1Form.TrackBar2.Position := 2;
  Setting1Form.TrackBar3.Position := 2;
  CategoryPanel3.Visible := True;

  ModelForm.CreateObjLoader(OBJ_HEART);
  ModelForm.CreateObjLoaderInside(OBJ_HEART_INSIDE);

  NumberModel := 5;
  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);
end;

procedure TSetting2Form.GroupBox4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DrawFigure5(Sender);
end;

procedure TSetting2Form.Label4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawFigure5(Sender);
end;

// -----------------------------------------------------------------------------












// 1----------------------------------------------------------------------------
procedure TSetting2Form.GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox1.Color := COLOR_2;
end;

procedure TSetting2Form.GroupBox1MouseLeave(Sender: TObject);
begin
  GroupBox1.Color := COLOR_1;
end;

procedure TSetting2Form.Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox1.Color := COLOR_2;
end;

procedure TSetting2Form.Label1MouseLeave(Sender: TObject);
begin
  GroupBox1.Color := COLOR_1;
end;

// 2----------------------------------------------------------------------------
procedure TSetting2Form.GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox2.Color := COLOR_2;
end;

procedure TSetting2Form.GroupBox2MouseLeave(Sender: TObject);
begin
  GroupBox2.Color := COLOR_1;
end;

procedure TSetting2Form.Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox2.Color := COLOR_2;
end;

procedure TSetting2Form.Label2MouseLeave(Sender: TObject);
begin
  GroupBox2.Color := COLOR_1;
end;

// 3----------------------------------------------------------------------------
procedure TSetting2Form.GroupBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox3.Color := COLOR_2;
end;

procedure TSetting2Form.GroupBox3MouseLeave(Sender: TObject);
begin
  GroupBox3.Color := COLOR_1;
end;

procedure TSetting2Form.Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox3.Color := COLOR_2;
end;

procedure TSetting2Form.Label3MouseLeave(Sender: TObject);
begin
  GroupBox3.Color := COLOR_1;
end;

// 4----------------------------------------------------------------------------
procedure TSetting2Form.GroupBox4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  GroupBox4.Color := COLOR_2;
end;

procedure TSetting2Form.GroupBox4MouseLeave(Sender: TObject);
begin
  GroupBox4.Color := COLOR_1;
end;

procedure TSetting2Form.Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox4.Color := COLOR_2;
end;

procedure TSetting2Form.Label4MouseLeave(Sender: TObject);
begin
  GroupBox4.Color := COLOR_1;
end;
//------------------------------------------------------------------------------

// 5----------------------------------------------------------------------------
procedure TSetting2Form.GroupBox5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  GroupBox5.Color := COLOR_2;
end;

procedure TSetting2Form.GroupBox5MouseLeave(Sender: TObject);
begin
  GroupBox5.Color := COLOR_1;
end;

procedure TSetting2Form.Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GroupBox5.Color := COLOR_2;
end;

procedure TSetting2Form.Label6MouseLeave(Sender: TObject);
begin
  GroupBox5.Color := COLOR_1;
end;
//------------------------------------------------------------------------------













// vertex
procedure TSetting2Form.RadioButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //NumberModel := 3;
  if NumberModel = 4 then NumberModel := 3;

  PolygonMode := 1;
  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);
end;

// line
procedure TSetting2Form.RadioButton2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //NumberModel := 3;
  if NumberModel = 4 then NumberModel := 3;

  PolygonMode := 2;
  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);
end;

// fill
procedure TSetting2Form.RadioButton3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //NumberModel := 3;
  if NumberModel = 4 then NumberModel := 3;

  PolygonMode := 3;
  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);
end;

// texture
procedure TSetting2Form.RadioButton4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RadioButton3MouseDown(Sender, Button, Shift, X, Y);
  NumberModel := 4;
  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);
  //objLoaderCount(OBJ_HEART);
  //objLoader(OBJ_HEART);
end;


//------------------------------------------------------------------------------


procedure TSetting2Form.TrackBar1Change(Sender: TObject);
begin
  BlendCount := TrackBar1.Position;
  Label5.Caption := 'Прозрачность ' + FloatToStr(BlendCount * 10) + ' %';

  BlendCount := 1-BlendCount/10;
  if (BlendCount = 0) and (TrackBar1.Position <> 10) then
    BlendCount := 10;

  ModelForm.RePaint;
end;


//------------------------------------------------------------------------------


procedure TSetting2Form.DrawFigureClipPlane(Sender: TObject);
var
  f: double;
begin

  if (TryStrToFloat(Edit1.Text, f)) and
   (TryStrToFloat(Edit2.Text, f)) and
   (TryStrToFloat(Edit3.Text, f)) then
  begin
    ClipPlane1 := StrToFloat(Edit1.Text);
    ClipPlane2 := StrToFloat(Edit2.Text);
    ClipPlane3 := StrToFloat(Edit3.Text);
  end
  else
    Application.MessageBox('Введены неверные значения', 'Ошибка');

  ModelForm.FormPaint(Sender);
  ModelForm.FormResize(Sender);

end;

procedure TSetting2Form.Edit1Click(Sender: TObject);
begin
  Edit1.Text := '';
end;

procedure TSetting2Form.Edit2Click(Sender: TObject);
begin
  Edit2.Text := '';
end;

procedure TSetting2Form.Edit3Click(Sender: TObject);
begin
  Edit3.Text := '';
end;



procedure TSetting2Form.GroupBox5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  DrawFigureClipPlane(Sender);
end;

procedure TSetting2Form.Label6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawFigureClipPlane(Sender);
end;

end.
