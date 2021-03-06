unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,
  OpenGL;

type
  TfrmGL = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    DC : HDC;
    hrc: HGLRC;
  end;

const
  GLF_START_LIST = 1000;  // text

var
  frmGL: TfrmGL;
  wrkX, wrkY : Integer;
  down : Boolean = False;

  lf : TLOGFONT;              // text
  hFontNew, hOldFont : HFONT; // text

implementation

{$R *.DFM}


procedure TfrmGL.FormPaint(Sender: TObject);
var
  i: integer;
  Litera : PChar;  // text
begin
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  // ����� ������---------------------------------------------------------------
  glRasterPos2f (0,0); // ������� ����� ��� ������ ������
  Litera := '�����'; // text
  glListBase(GLF_START_LIST);  // �������� ��� ���� �������
  glCallLists(Length (Litera), GL_UNSIGNED_BYTE, Litera); // ����� ������ ��� ������� �������
  //----------------------------------------------------------------------------

  SwapBuffers(DC);
end;

procedure SetDCPixelFormat (hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat(hdc, @pfd);
  SetPixelFormat(hdc, nPixelFormat, @pfd);
end;

procedure TfrmGL.FormCreate(Sender: TObject);
begin
  DC := GetDC (Handle);
  SetDCPixelFormat(DC);
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  glClearColor (0.3, 0.4, 0.6, 1.0);
  glEnable(GL_DEPTH_TEST);// ��������� ���� �������
  glEnable(GL_LIGHTING);  // ��������� ������ � �������������
  glEnable(GL_LIGHT0);    // �������� �������� ����� 0

  // ����� ������---------------------------------------------------------------
  wglUseFontBitmaps (Canvas.Handle, 0, 255, GLF_START_LIST);
  //----------------------------------------------------------------------------
end;

procedure TfrmGL.FormDestroy(Sender: TObject);
begin
 glDeleteLists (GLF_START_LIST, 256); // text
 wglMakeCurrent(0, 0);
 wglDeleteContext(hrc);
 ReleaseDC (Handle, DC);
 DeleteDC (DC);
end;

procedure TfrmGL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 If Key = VK_ESCAPE then Close;          
end;

procedure TfrmGL.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  If ClientWidth <= ClientHeight
      then glOrtho(-4.0, 4.0, -4.0 * ClientHeight / ClientWidth,
                   4.0 * ClientHeight / ClientWidth, -4.0, 4.0)
      else glOrtho(-4.0 * ClientWidth / ClientHeight,
                   4.0 * ClientWidth / ClientHeight, -4.0, 4.0, -4.0, 4.0);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;

  InvalidateRect(Handle, nil, False);
end;

// �������� ������
procedure TfrmGL.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Down := True;
  wrkX := X;
  wrkY := Y;
end;

procedure TfrmGL.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Down := False;
end;

procedure TfrmGL.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If Down then begin
     glRotatef (X - wrkX, 0.0, 1.0, 0.0);
     glRotatef (Y - wrkY, 1.0, 0.0, 0.0);
     InvalidateRect(Handle, nil, False);
     wrkX := X;
     wrkY := Y;
  end;
end;

end.

