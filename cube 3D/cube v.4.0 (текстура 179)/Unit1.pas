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
    procedure PrepareImage(bmap: string);
  end;


var
  frmGL: TfrmGL;
  wrkX, wrkY : Integer;
  down : Boolean = False;

implementation

{$R *.DFM}


//------------------------------------------------------------------------------
// ���������� ��������
procedure TfrmGL.PrepareImage(bmap: string);
// ��� ��� ������������� �������, ��� �������� ��� ���� ������ Delphi
type
  PPixelArray = ^TPixelArray;
  TPixelArray = array [0..0] of Byte;
var
  Bitmap : TBitmap;
  Data : PPixelArray;                      // ����� ��������, ������ ������� �� �����������
  BMInfo : TBitmapInfo;                    // ��������� �����
  I, ImageSize : Integer;                  // ��������������� ����������
  Temp : Byte;                             // ��� ������������ ������
  MemDC : HDC;                             // ��������������� �������������
begin
  Bitmap := TBitmap.Create;
  Bitmap.LoadFromFile (bmap);              // ��������� ����� �� �����
  with BMinfo.bmiHeader do begin
    FillChar (BMInfo, SizeOf(BMInfo), 0);  // ��������� ���������
    biSize := sizeof (TBitmapInfoHeader);
    biBitCount := 24;
    biWidth := Bitmap.Width;
    biHeight := Bitmap.Height;
    ImageSize := biWidth * biHeight;
    biPlanes := 1;
    biCompression := BI_RGB;
    MemDC := CreateCompatibleDC (0);
    GetMem (Data, ImageSize * 3);          // ������� ������������ ������
    try
      // ��������� � DIB-������ ����� �������� �������
      GetDIBits (MemDC, Bitmap.Handle, 0, biHeight, Data,
                 BMInfo, DIB_RGB_COLORS);
      For I := 0 to ImageSize - 1 do begin // ������������ �����
          Temp := Data [I * 3];
          Data [I * 3] := Data [I * 3 + 2];
          Data [I * 3 + 2] := Temp;
      end;
      // ������� �����
      glTexImage2d(GL_TEXTURE_2D, 0, 3, biWidth,
                   biHeight, 0, GL_RGB, GL_UNSIGNED_BYTE, Data);
    finally
      FreeMem (Data);                      // ����������� ������
      DeleteDC (MemDC);
      Bitmap.Free;
    end;
  end;
end;
//------------------------------------------------------------------------------


{=======================================================================
����������� ����}
procedure TfrmGL.FormPaint(Sender: TObject);
var
  i: integer;
begin
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);      // ������� ������ �����

  glPushMatrix;
  glScalef (2, 2, 2);

  glBegin (GL_QUADS);
    glNormal3f(0.0, 0.0, 1.0);
    glTexCoord2d (1.0, 0.0);
    glVertex3f (1.0, 1.0, 1.0);
    glTexCoord2d (1.0, 1.0);
    glVertex3f (-1.0, 1.0, 1.0);
    glTexCoord2d (0.0, 1.0);
    glVertex3f (-1.0, -1.0, 1.0);
    glTexCoord2d (0.0, 0.0);
    glVertex3f (1.0, -1.0, 1.0);
  glEnd();

  glBegin (GL_QUADS);
    glNormal3f(0.0, 0.0, -1.0);
    glTexCoord2d (1.0, 0.0);
    glVertex3f (1.0, 1.0, -1.0);
    glTexCoord2d (1.0, 1.0);
    glVertex3f (1.0, -1.0, -1.0);
    glTexCoord2d (0.0, 1.0);
    glVertex3f (-1.0, -1.0, -1.0);
    glTexCoord2d (0.0, 0.0);
    glVertex3f (-1.0, 1.0, -1.0);
  glEnd();

  glBegin (GL_QUADS);
    glNormal3f(-1.0, 0.0, 0.0);
    glTexCoord2d (1.0, 0.0);
    glVertex3f (-1.0, 1.0, 1.0);
    glTexCoord2d (1.0, 1.0);
    glVertex3f (-1.0, 1.0, -1.0);
    glTexCoord2d (0.0, 1.0);
    glVertex3f (-1.0, -1.0, -1.0);
    glTexCoord2d (0.0, 0.0);
    glVertex3f (-1.0, -1.0, 1.0);
  glEnd();

  glBegin (GL_QUADS);
    glNormal3f(1.0, 0.0, 0.0);
    glTexCoord2d (1.0, 0.0);
    glVertex3f (1.0, 1.0, 1.0);
    glTexCoord2d (1.0, 1.0);
    glVertex3f (1.0, -1.0, 1.0);
    glTexCoord2d (0.0, 1.0);
    glVertex3f (1.0, -1.0, -1.0);
    glTexCoord2d (0.0, 0.0);
    glVertex3f (1.0, 1.0, -1.0);
  glEnd();

  glBegin (GL_QUADS);
    glNormal3f(0.0, 1.0, 0.0);
    glTexCoord2d (1.0, 0.0);
    glVertex3f (-1.0, 1.0, -1.0);
    glTexCoord2d (1.0, 1.0);
    glVertex3f (-1.0, 1.0, 1.0);
    glTexCoord2d (0.0, 1.0);
    glVertex3f (1.0, 1.0, 1.0);
    glTexCoord2d (0.0, 0.0);
    glVertex3f (1.0, 1.0, -1.0);
  glEnd();

  glBegin(GL_QUADS);
    glNormal3f(0.0, -1.0, 0.0);
    glTexCoord2d (1.0, 0.0);
    glVertex3f (-1.0, -1.0, -1.0);
    glTexCoord2d (1.0, 1.0);
    glVertex3f (1.0, -1.0, -1.0);
    glTexCoord2d (0.0, 1.0);
    glVertex3f (1.0, -1.0, 1.0);
    glTexCoord2d (0.0, 0.0);
    glVertex3f (-1.0, -1.0, 1.0);
  glEnd();

  glPopMatrix;
  SwapBuffers(DC);
end;

{=======================================================================
������ �������}
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
�������� �����}
procedure TfrmGL.FormCreate(Sender: TObject);
begin
  DC := GetDC (Handle);
  SetDCPixelFormat(DC);
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);

  // ���������
  glEnable (GL_LIGHTING);
  glEnable (GL_LIGHT0);

  glEnable (GL_DEPTH_TEST);

  // ������� �������� ��������� ������ �� ���� ����������� �������
  glEnable(GL_COLOR_MATERIAL);
  glColor3f (0.0, 1.0, 0.0); // ���� �������
  glClearColor (0, 0, 0, 1.0); // ���� ����

//------------------------------------------------------------------------------
 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
 glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
 glEnable(GL_TEXTURE_2D);
 PrepareImage ('GOLD.bmp');
 //�� ��������� ���� ����������
 glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
//------------------------------------------------------------------------------

end;

{=======================================================================
����� ������ ����������}
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

// ��������� ������� ������ ��� ��������� ������� ����
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

