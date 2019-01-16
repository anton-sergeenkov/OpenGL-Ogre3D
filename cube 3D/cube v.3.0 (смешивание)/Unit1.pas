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


var
  frmGL: TfrmGL;
  wrkX, wrkY : Integer;
  down : Boolean = False;

implementation

uses DGLUT;

{$R *.DFM}


{=======================================================================
Перерисовка окна}
procedure TfrmGL.FormPaint(Sender: TObject);
begin
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);


  glColor3f(1.0, 0.0, 0.0);
  //glutSolidSphere(1, 16, 16);
  glutSolidCube(2);

  glEnable(GL_BLEND);
  glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glColor4f(0.0, 1.0, 0.0, 0.4);
  glutSolidCube(4);
  glDisable(GL_BLEND);


  SwapBuffers(DC);
end;

{=======================================================================
Формат пикселя}
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

{=======================================================================
Создание формы}
procedure TfrmGL.FormCreate(Sender: TObject);
begin
  DC := GetDC (Handle);
  SetDCPixelFormat(DC);
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  glClearColor (0, 0, 0, 1.0); // цвет фона

  // освещение
  glEnable (GL_LIGHTING);
  //glDisable (GL_LIGHTING); // отключение
  glEnable (GL_LIGHT0);
  glEnable (GL_DEPTH_TEST);

  // текущие цветовые установки влияют на цвет поверхности объекта
  glEnable(GL_COLOR_MATERIAL);
end;

{=======================================================================
Конец работы приложения}
procedure TfrmGL.FormDestroy(Sender: TObject);
begin
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

// изменение размера фигуры при изменении размера окна
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

// вращение фигуры
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

