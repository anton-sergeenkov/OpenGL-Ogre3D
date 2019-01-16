unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frameModel, OpenGL, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TMainForm = class(TForm)
    ModelFrame1: TModelFrame;
    Timer1: TTimer;
    Timer2: TTimer;
    Panel1: TPanel;
    Button4: TButton;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Timer3: TTimer;
    Panel5: TPanel;
    Panel6: TPanel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Panel7: TPanel;
    Panel8: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;

    // ����������� ���������
    procedure FormPaint(Sender: TObject);                                       // ��������� ��������
    procedure FormCreate(Sender: TObject);                                      // �������� �����
    procedure FormDestroy(Sender: TObject);                                     // ����������� �����
    procedure FormResize(Sender: TObject);                                      // ��������� ������� �����
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);                                       // ������� ������ ����
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;                // ������� ������ ����
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);// ������������ ����

    // ������ ��������: �������, �����������, ��������
    procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    // �������
    procedure Timer1Timer(Sender: TObject);          // ������ ��� ����������� ����������
    procedure Timer2Timer(Sender: TObject);          // ������ ��� ����������� ����������
    procedure Timer3Timer(Sender: TObject);          // ������ ��� �������� ��������

    // �������� ����� � ������� (unitParserObj.pas)
    procedure CreateObjLoader(ObjFile: string);      // ������ ������ ���������
    procedure CreateObjLoaderDown(ObjFile: string);  // ������ ������ (���������)
    procedure CreateObjLoaderUp(ObjFile: string);    // ������ ������ (����������)

    // ���������� ������
    procedure DrawPolygon;                           // ���������� ������ (���������)
    procedure DrawPolygonDown;                       // ���������� ������ (���������)
    procedure DrawPolygonUp;                         // ���������� ������ (����������)
    procedure RePaint;                               // ����������� ��������

    // �������� ������
    procedure RotateModel(AxisX: boolean);           // ������� ������
    procedure TranslateModel(AxisX: boolean);        // ����������� ������
    procedure RotateCountLabel(AxisX: boolean);      // ������� ������ (��������� label)
    procedure TranslateCountLabel(AxisX: boolean);   // ����������� ������ (��������� label)

  private
    // ���������� ��� OpenGL
    DC : HDC;   // ������ �� �������� ����������
    hrc: HGLRC; // ������ �� �������� ���������������
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

  wrkX, wrkY : Integer; // �������� ������ �� ��� X � �� ��� Y
  down : Boolean = False; // �������� ������, ������� ������ ����

  // ���� ��������

  // ���������������
  ScaleX: real = 2;
  ScaleY: real = 2;
  ScaleZ: real = 2;
  // �������
  RotateX: integer = 0;
  RotateY: integer = 0;
  OriginalRotateX: integer = 0;
  OriginalRotateY: integer = 0;
  // �������
  TranslateX: integer = 0;
  TranslateY: integer = 0;
  OriginalTranslateX: integer = 0;
  OriginalTranslateY: integer = 0;

  // ��������� ����� ����������
  DownLine: array[0..51] of integer = (
    0,2,3,23,25,41,43,
    71,72,74,79,93,95,175,176,
    224,225,231,240,242,258,271,
    272,279,68,69,351,352,
    353,354,355,359,372,98,278,
    139,300,424,230,268,370,371,429,
    246,267,266,265,438,439,275,
    440,426);

  // ��������� ����� ����������
  UpLine: array[0..128] of integer = (
    1,47,51,54,86,98,103,109,114,177,180,181,220,222,226,
    233,46,246,260,261,248,270,275,251,252,282,287,254,
    293,257,302,303,304,69,307,333,339,340,347,352,354,
    358,372,373,374,376,378,379,381,338,391,395,243,431,
    433,434,435,436,438,50,440,443,249,250,446,449,253,
    255,453,256,456,461,112,117,328,104,105,494,111,498,
    363,116,521,522,219,42,43,44,537,538,228,227,539,45,
    231,542,236,241,176,242,546,245,244,547,224,259,459,
    258,548,263,299,565,460,70,371,329,337,478,495,488,
    380,369,368,106,497,107,545,362,370);

const
  OBJ_HEART = 'heart.obj';     // ���� � ������� ������ ���������
  OBJ_HEART_DOWN = 'down.obj'; // ���� � ������� ������ (���������)
  OBJ_HEART_UP = 'up.obj';     // ���� � ������� ������ (����������)


implementation

{$R *.dfm}

uses unitParserObj;

var
  // ����� ����� TModelType �� �������� ������ � ����������� ���������� ������� (�������, �������, �������� � �.�.)
  ModelType: TModelType;      // ������ ������ ���������
  ModelTypeDown: TModelType;  // ������ ������ (���������)
  ModelTypeDown_: TModelType; // ������ ������ (���������)
  ModelTypeUp: TModelType;    // ������ ������ (����������)
  ModelTypeUp_: TModelType;   // ������ ������ (����������)


//------------------------------------------------------------------------------
// �������� ������ ������� � ������� � ��������� ������ (unitParserObj.pas)
//------------------------------------------------------------------------------

// ������ ������ ���������
procedure TMainForm.CreateObjLoader(ObjFile: string);
begin
  ModelType := TModelType.Create;
  try
    ModelType.objLoaderCount(ObjFile);
    ModelType.objLoader(ObjFile);
  finally
    //ModelType.Free;
  end;
end;

// ������ ������ (���������)
procedure TMainForm.CreateObjLoaderDown(ObjFile: string);
begin
  ModelTypeDown := TModelType.Create;
  try
    ModelTypeDown.objLoaderCount(ObjFile);
    ModelTypeDown.objLoader(ObjFile);
  finally
    //ModelTypeDown.Free;
  end;

  ModelTypeDown_ := TModelType.Create;
  try
    ModelTypeDown_.objLoaderCount(ObjFile);
    ModelTypeDown_.objLoader(ObjFile);
  finally
    //ModelTypeDown_.Free;
  end;

end;

// ������ ������ (����������)
procedure TMainForm.CreateObjLoaderUp(ObjFile: string);
begin

  ModelTypeUp := TModelType.Create;
  try
    ModelTypeUp.objLoaderCount(ObjFile);
    ModelTypeUp.objLoader(ObjFile);
  finally
    //ModelTypeUp.Free;
  end;

  ModelTypeUp_ := TModelType.Create;
  try
    ModelTypeUp_.objLoaderCount(ObjFile);
    ModelTypeUp_.objLoader(ObjFile);
  finally
    //ModelTypeUp_.Free;
  end;

end;


//------------------------------------------------------------------------------
// ����������� ������
//------------------------------------------------------------------------------
procedure TMainForm.RePaint;
begin
  InvalidateRect(Handle, nil, False);
end;


//------------------------------------------------------------------------------
// �������� ������, ��������� ��������� ������
//------------------------------------------------------------------------------
var maxCountAnimation: integer = 8; // ���������� ������ ��������

var stepDown: real = 1.01;        // ���������� ��������� �������
var countDown: integer = 0;       // ���-�� �����
var positiveDown: boolean = true; // true - ����������� �����������, false - ���������

// �������� ����������
procedure TMainForm.Timer1Timer(Sender: TObject);
var
  i,j: integer;  // �������� �����
  x,y,z: real;   // ����������
  flag: boolean; // ���� ���������� � ����������� ������
begin

  // ���� �������� ������������� ����� ��������, ������������ �������
  if (countDown=maxCountAnimation) then
  begin
    countDown := 0;

    if (positiveDown) then begin
      positiveDown := false;
    end else begin
      positiveDown := true;
    end;

  end else begin
    countDown := countDown + 1;
  end;

  // ���� ���������� �����������
  if (positiveDown) then begin
    stepDown := stepDown + 0.01;
  end else begin
    stepDown := stepDown - 0.01;
  end;

  // ������� ���� ������ �������
  for i := 0 to ModelTypeDown.VertexCount-1 do
  begin

    flag := true;

    // ��������� �� ���������� � ����������� ������
    for j := 0 to Length(DownLine) - 1 do
    begin
      if i = DownLine[j] then
      begin
         flag := false;
         break;
      end;
    end;

    // ���� ��� ����������, �� �������� �������
    if (flag) then
    begin
      ModelTypeDown.Vertex[0,i] := ModelTypeDown_.Vertex[0,i]*stepDown;
      ModelTypeDown.Vertex[1,i] := ModelTypeDown_.Vertex[1,i]*stepDown;
      ModelTypeDown.Vertex[2,i] := ModelTypeDown_.Vertex[2,i]*stepDown;
    end;

  end;

    // �������������� �����
    MainForm.RePaint;

end;


var stepUp: real = 1.01;        // ���������� ��������� �������
var countUp: integer = 0;       // ���-�� �����
var positiveUp: boolean = true; // true - ����������� �����������, false - ���������

// �������� ����������
procedure TMainForm.Timer2Timer(Sender: TObject);
var
  i,j: integer;  // �������� �����
  x,y,z: real;   // ����������
  flag: boolean; // ���� ���������� � ����������� ������
begin

  // ���� �������� ������������� ����� ��������, ��������� �������� ���������� � ������������ �������
  if (countUp=maxCountAnimation) then
  begin
    Timer1.Enabled := True; // ��������� �������� ����������

    countUp := 0;

    if (positiveUp) then begin
      positiveUp := false;
    end else begin
      positiveUp := true;
    end;

  end else begin
    countUp := countUp + 1;
  end;

  // ���� ���������� �����������
  if (positiveUp) then begin
    stepUp := stepUp + 0.01;
  end else begin
    stepUp := stepUp - 0.01;
  end;

  // ������� ���� ������ �������
  for i := 0 to ModelTypeUp.VertexCount-1 do
  begin

    flag := true;

    // ��������� �� ���������� � ����������� ������
    for j := 0 to Length(UpLine) - 1 do
    begin
      if i = UpLine[j] then
      begin
         flag := false;
         break;
      end;
    end;

    // ���� ��� ����������, �� �������� �������
    if (flag) then
    begin
      ModelTypeUp.Vertex[0,i] := ModelTypeUp_.Vertex[0,i]*stepUp;
      ModelTypeUp.Vertex[1,i] := ModelTypeUp_.Vertex[1,i]*stepUp;
      ModelTypeUp.Vertex[2,i] := ModelTypeUp_.Vertex[2,i]*stepUp;
    end;

  end;

  // �������������� �����
  MainForm.RePaint;

end;


//------------------------------------------------------------------------------
// ���������� ������ �� ��������
//------------------------------------------------------------------------------

// ���������� ������ (���������)
procedure TMainForm.DrawPolygonDown;
var
  i, z: integer;
begin

  for i := 0 to ModelTypeDown.FacesCount-1 do
  begin

    glBegin(GL_TRIANGLES);

      // 1� �������
      glNormal3f(
        ModelTypeDown.Normals[0,ModelTypeDown.FacesNormals[0,i]-1],
        ModelTypeDown.Normals[1,ModelTypeDown.FacesNormals[0,i]-1],
        ModelTypeDown.Normals[2,ModelTypeDown.FacesNormals[0,i]-1]
      );
      glVertex3f(
        ModelTypeDown.Vertex[0,ModelTypeDown.FacesVertex[0,i]-1],
        ModelTypeDown.Vertex[1,ModelTypeDown.FacesVertex[0,i]-1],
        ModelTypeDown.Vertex[2,ModelTypeDown.FacesVertex[0,i]-1]
      );

      // 2� �������
      glNormal3f(
        ModelTypeDown.Normals[0,ModelTypeDown.FacesNormals[1,i]-1],
        ModelTypeDown.Normals[1,ModelTypeDown.FacesNormals[1,i]-1],
        ModelTypeDown.Normals[2,ModelTypeDown.FacesNormals[1,i]-1]
      );
      glVertex3f(
        ModelTypeDown.Vertex[0,ModelTypeDown.FacesVertex[1,i]-1],
        ModelTypeDown.Vertex[1,ModelTypeDown.FacesVertex[1,i]-1],
        ModelTypeDown.Vertex[2,ModelTypeDown.FacesVertex[1,i]-1]
      );

      // 3� �������
      glNormal3f(
        ModelTypeDown.Normals[0,ModelTypeDown.FacesNormals[2,i]-1],
        ModelTypeDown.Normals[1,ModelTypeDown.FacesNormals[2,i]-1],
        ModelTypeDown.Normals[2,ModelTypeDown.FacesNormals[2,i]-1]
      );
      glVertex3f(
        ModelTypeDown.Vertex[0,ModelTypeDown.FacesVertex[2,i]-1],
        ModelTypeDown.Vertex[1,ModelTypeDown.FacesVertex[2,i]-1],
        ModelTypeDown.Vertex[2,ModelTypeDown.FacesVertex[2,i]-1]
      );

    glEnd();

  end;
end;

// ���������� ������ (����������)
procedure TMainForm.DrawPolygonUp;
var
  i, z: integer;
begin

  for i := 0 to ModelTypeUp.FacesCount-1 do
  begin

    glBegin(GL_TRIANGLES);

      // 1� �������
      glNormal3f(
        ModelTypeUp.Normals[0,ModelTypeUp.FacesNormals[0,i]-1],
        ModelTypeUp.Normals[1,ModelTypeUp.FacesNormals[0,i]-1],
        ModelTypeUp.Normals[2,ModelTypeUp.FacesNormals[0,i]-1]
      );
      glVertex3f(
        ModelTypeUp.Vertex[0,ModelTypeUp.FacesVertex[0,i]-1],
        ModelTypeUp.Vertex[1,ModelTypeUp.FacesVertex[0,i]-1],
        ModelTypeUp.Vertex[2,ModelTypeUp.FacesVertex[0,i]-1]
      );

      // 2� �������
      glNormal3f(
        ModelTypeUp.Normals[0,ModelTypeUp.FacesNormals[1,i]-1],
        ModelTypeUp.Normals[1,ModelTypeUp.FacesNormals[1,i]-1],
        ModelTypeUp.Normals[2,ModelTypeUp.FacesNormals[1,i]-1]
      );
      glVertex3f(
        ModelTypeUp.Vertex[0,ModelTypeUp.FacesVertex[1,i]-1],
        ModelTypeUp.Vertex[1,ModelTypeUp.FacesVertex[1,i]-1],
        ModelTypeUp.Vertex[2,ModelTypeUp.FacesVertex[1,i]-1]
      );

      // 3� �������
      glNormal3f(
        ModelTypeUp.Normals[0,ModelTypeUp.FacesNormals[2,i]-1],
        ModelTypeUp.Normals[1,ModelTypeUp.FacesNormals[2,i]-1],
        ModelTypeUp.Normals[2,ModelTypeUp.FacesNormals[2,i]-1]
      );
      glVertex3f(
        ModelTypeUp.Vertex[0,ModelTypeUp.FacesVertex[2,i]-1],
        ModelTypeUp.Vertex[1,ModelTypeUp.FacesVertex[2,i]-1],
        ModelTypeUp.Vertex[2,ModelTypeUp.FacesVertex[2,i]-1]
      );

    glEnd();

  end;
end;


// ���������� ������ (���������)
procedure TMainForm.DrawPolygon;
var
  i, z: integer;
begin

  for i := 0 to ModelType.FacesCount-1 do
  begin

    glBegin(GL_TRIANGLES);

      // 1� �������
      glNormal3f(
        ModelType.Normals[0,ModelType.FacesNormals[0,i]-1],
        ModelType.Normals[1,ModelType.FacesNormals[0,i]-1],
        ModelType.Normals[2,ModelType.FacesNormals[0,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[0,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[0,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[0,i]-1]
      );

      // 2� �������
      glNormal3f(
        ModelType.Normals[0,ModelType.FacesNormals[1,i]-1],
        ModelType.Normals[1,ModelType.FacesNormals[1,i]-1],
        ModelType.Normals[2,ModelType.FacesNormals[1,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[1,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[1,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[1,i]-1]
      );

      // 3� �������
      glNormal3f(
        ModelType.Normals[0,ModelType.FacesNormals[2,i]-1],
        ModelType.Normals[1,ModelType.FacesNormals[2,i]-1],
        ModelType.Normals[2,ModelType.FacesNormals[2,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[2,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[2,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[2,i]-1]
      );

    glEnd();

  end;
end;


//------------------------------------------------------------------------------
// ����������� ���� � ��������� ���������� OpenGL
//------------------------------------------------------------------------------
procedure TMainForm.FormPaint(Sender: TObject);
begin
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // ������� ������ �����
  glClearColor (0.25, 0.25, 0.25, 1.0);   // ���� ����
  glColor3f(0.796863, 0.385882, 0.395294); // ���� �������

  glEnable(GL_POINT_SMOOTH); // ����� ����������� �����
  glPointSize(3.0); // ������������� ������ �����
  glEnable(GL_LINE_SMOOTH); // ����� ����������� �����
  glLineWidth(1); // ������������� ������ �����
  glEnable(GL_BLEND); // �������� ����� ��������
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // ������� ��������
  glHint(GL_POINT_SMOOTH_HINT, GL_DONT_CARE); // ������ ���������� ������������ ����������
  glPolygonMode(GL_FRONT_AND_BACK, GL_FILL); // ����� ������ ����������� ���������

  glPushMatrix; // ��������� ������� ������� � ����, � ��� �� �������� �� �������� �����
      glScalef (ScaleX, ScaleY, ScaleZ); // ���������������

      DrawPolygonDown; // ������ ���������
      DrawPolygonUp; // ������ �����������

      glEnable(GL_ALPHA_TEST); // ������������
      glEnable(GL_BLEND);       // �������� ��������
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // ������� ��������
      glEnable(GL_CULL_FACE);   // �������� ��������� ������ ���������
      glCullFace(GL_BACK);      // �� �������������� ������ ����������� ������

      DrawPolygon; // ������ ��� ������

      glDisable(GL_CULL_FACE);  // ��������� ���������� ������������
      glDisable(GL_BLEND);      // ��������� ����� ��������
      glDisable(GL_ALPHA_TEST);
  glPopMatrix; // ��������� ������� - ���������� � �������� ���������

  glDisable(GL_BLEND);
  SwapBuffers(DC); // ����� �� �����
end;


//------------------------------------------------------------------------------
// ������ ������� (��� OpenGL)
//------------------------------------------------------------------------------
procedure SetDCPixelFormat (hdc : HDC);
var
  pfd : TPixelFormatDescriptor;
  nPixelFormat : Integer;
begin
  FillChar (pfd, SizeOf (pfd), 0);
  pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat (hdc, @pfd);
  SetPixelFormat (hdc, nPixelFormat, @pfd);
end;


//------------------------------------------------------------------------------
// �������� �����
//------------------------------------------------------------------------------
procedure TMainForm.FormCreate(Sender: TObject);
begin
  DC := GetDC (Handle); // ������ �������� ������
  SetDCPixelFormat(DC); //������ ������ �������
  hrc := wglCreateContext(DC); // ������� �������� ���������������
  wglMakeCurrent(DC, hrc); // ���������� �������� ��������������� ������� (������ ��� ������������ ������)

  glClearColor (0.25, 0.25, 0.25, 1.0); // ���� ����

  // ���������
  glEnable (GL_LIGHTING);
  glEnable (GL_LIGHT0);

  glEnable (GL_DEPTH_TEST);

  // ������� �������� ��������� ������ �� ���� ����������� �������
  glEnable(GL_COLOR_MATERIAL);

  FormResize(Sender); // ����� ��� �������� ����� ����������� ������������

  // ��������� ��� ������
  MainForm.CreateObjLoader(OBJ_HEART);
  MainForm.CreateObjLoaderDown(OBJ_HEART_DOWN);
  MainForm.CreateObjLoaderUp(OBJ_HEART_UP);

  MainForm.FormPaint(Sender);
  MainForm.FormResize(Sender);

end;


//------------------------------------------------------------------------------
// ����� ������ ����������
//------------------------------------------------------------------------------
procedure TMainForm.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0); // ���������� ��������
  wglDeleteContext(hrc); // ������� �������� ���������������, ���������� ������
  ReleaseDC (Handle, DC);
  DeleteDC(DC);
end;


//------------------------------------------------------------------------------
// ��������� ������� ������ ��� ��������� ������� ����
//------------------------------------------------------------------------------
procedure TMainForm.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight); // ������� ������
  glMatrixMode(GL_PROJECTION);

  // ���� ����� ��������� � �������� �������, ������� ������� ���������� ��������
  // � ��������� �� ��������� � ������� ���� ����� ���������� ����������, ��������� ��������
  glLoadIdentity;

  if ClientWidth <= ClientHeight
     then glOrtho(-4.0, 4.0, -4.0 * ClientHeight / ClientWidth,
                   4.0 * ClientHeight / ClientWidth, -4.0, 4.0)
     else glOrtho(-4.0 * ClientWidth / ClientHeight,
                   4.0 * ClientWidth / ClientHeight, -4.0, 4.0, -4.0, 4.0);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;

  InvalidateRect(Handle, nil, False);
end;


//------------------------------------------------------------------------------
// �������� ������
//------------------------------------------------------------------------------
procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Down := True;
  wrkX := X;
  wrkY := Y;
end;

procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Down := False;
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Down then
  begin
    glRotatef (X - wrkX, 0.0, 1.0, 0.0);
    glRotatef (Y - wrkY, 1.0, 0.0, 0.0);
    InvalidateRect(Handle, nil, False);

    RotateX := X - wrkX;
    RotateY := Y - wrkY;
    MainForm.RotateCountLabel(true);
    MainForm.RotateCountLabel(false);

    wrkX := X;
    wrkY := Y;
  end;
end;


// -----------------------------------------------------------------------------
// ���� ���������: �������
// -----------------------------------------------------------------------------
// ��� X +1
procedure TMainForm.Button2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton1.Checked then
  begin
    RotateX := 1;
    MainForm.RotateModel(true);
    MainForm.RotateCountLabel(true);
  end;
end;

// ��� X -1
procedure TMainForm.Button1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton1.Checked then
  begin
    RotateX := - 1;
    MainForm.RotateModel(true);
    MainForm.RotateCountLabel(true);
  end;
end;

// ��� Y -1
procedure TMainForm.Button3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton2.Checked then
  begin
    RotateY := - 1;
    MainForm.RotateModel(false);
    MainForm.RotateCountLabel(false);
  end;
end;

// ��� Y +1
procedure TMainForm.Button4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton2.Checked then
  begin
    RotateY := 1;
    MainForm.RotateModel(false);
    MainForm.RotateCountLabel(false);
  end;
end;

// ������� ������
procedure TMainForm.RotateModel(AxisX: boolean);
begin
  if AxisX then
    glRotatef(RotateX, 0.0, 1.0, 0.0)
  else
    glRotatef(RotateY, 1.0, 0.0, 0.0);
  InvalidateRect(Handle, nil, False);
end;

// ����������� �� ����� �������� �������� ������
procedure TMainForm.RotateCountLabel(AxisX: boolean);
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

// �����������
procedure TMainForm.SpeedButton1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Label3.Caption = '����������� ��������' then
  begin
    Label3.Caption := '����������� �������';
    SpeedButton1.Flat := False;
    Timer3.Enabled := True;
    Exit;
  end;
  if Label3.Caption = '����������� �������' then
  begin
    Label3.Caption := '����������� ��������';
    SpeedButton1.Flat := True;
    Timer3.Enabled := False;
    Exit;
  end;
end;

// ������ �����������
procedure TMainForm.Timer3Timer(Sender: TObject);
begin
  if RadioButton1.Checked then
  begin
    RotateX := 1;
    MainForm.RotateModel(true);
    MainForm.RotateCountLabel(true);
  end;

  if RadioButton2.Checked then
  begin
    RotateY := 1;
    MainForm.RotateModel(false);
    MainForm.RotateCountLabel(false);
  end;
end;


//------------------------------------------------------------------------------
// ���� ���������: �����������
// -----------------------------------------------------------------------------

// ��� X
procedure TMainForm.Button6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton3.Checked then
  begin
    TranslateX := 1;
    MainForm.TranslateModel(true);
    TranslateCountLabel(true);
  end;
end;

procedure TMainForm.Button5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton3.Checked then
  begin
    TranslateX := -1;
    MainForm.TranslateModel(true);
    TranslateCountLabel(true);
  end;
end;

// ��� Y
procedure TMainForm.Button8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton4.Checked then
  begin
    TranslateY := 1;
    MainForm.TranslateModel(false);
    TranslateCountLabel(false);
  end;
end;

procedure TMainForm.Button7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if RadioButton4.Checked then
  begin
    TranslateY := -1;
    MainForm.TranslateModel(false);
    TranslateCountLabel(false);
  end;
end;

// ����������� ������
procedure TMainForm.TranslateModel(AxisX: boolean);
begin
  if AxisX then
    glTranslatef(TranslateX, 0.0, 0.0)
  else
    glTranslatef(0.0, TranslateY, 0.0);
  InvalidateRect(Handle, nil, False);
end;

// ����������� �� ����� �������� ����������� ������
procedure TMainForm.TranslateCountLabel(AxisX: boolean);
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


//------------------------------------------------------------------------------
// ���� ���������: ��������
// -----------------------------------------------------------------------------

 procedure TMainForm.SpeedButton2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if Label4.Caption = '�������� ��������' then
  begin
    Label4.Caption := '�������� ���������';
    SpeedButton2.Flat := True;
    Timer1.Enabled := False;
	Timer2.Enabled := False;
    Exit;
  end;
  if Label4.Caption = '�������� ���������' then
  begin
    Label4.Caption := '�������� ��������';
    SpeedButton2.Flat := False;
    Timer1.Enabled := True;
    Timer2.Enabled := True;
    Exit;
  end;

end;

end.


