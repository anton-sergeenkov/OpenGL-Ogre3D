unit frmSettingTors;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TSettingTorsForm = class(TForm)
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    Panel1: TPanel;
    Label9: TLabel;
    Edit1: TEdit;
    Label11: TLabel;
    Panel2: TPanel;
    Label13: TLabel;
    Edit3: TEdit;
    Label14: TLabel;
    Panel3: TPanel;
    Label15: TLabel;
    Edit4: TEdit;
    Label16: TLabel;
    Panel4: TPanel;
    Label10: TLabel;
    Edit2: TEdit;
    Label12: TLabel;
    Panel5: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;

    procedure MoveForm(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingTorsForm: TSettingTorsForm;

implementation

{$R *.dfm}

procedure TSettingTorsForm.BitBtn1Click(Sender: TObject);
const
  pi = 3.14;
var
  a: real; // полуобхват грудной клетки (трансверсальный диаметр)
  b: real; // сагиттальный диаметр
  L: real; // обхват грудной клетки (длина эллипса)
begin
  L := StrToFloat(Edit1.Text);
  a := StrToFloat(Edit3.Text);

  b := (2*L - pi*a) / pi;

  Edit4.Text := FloatToStr(Round(b));
  BitBtn2.Caption := 'Выход';
end;

procedure TSettingTorsForm.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TSettingTorsForm.MoveForm(Sender: TObject);
begin
  ReleaseCapture;
  SettingTorsForm.perform(WM_SysCommand,$F012,0);
end;



procedure TSettingTorsForm.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveForm(Sender);
end;

procedure TSettingTorsForm.Panel2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveForm(Sender);
end;

procedure TSettingTorsForm.Panel3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveForm(Sender);
end;

procedure TSettingTorsForm.Panel4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveForm(Sender);
end;

end.
