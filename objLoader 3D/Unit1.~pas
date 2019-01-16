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

  {-----------------------------------------------------------------------------
  Vertex  - 'v ' - список вершин
  Texture - 'vt' - текстурные координаты
  Normals - 'vn' - нормали
  Faces   - 'f ' - определения поверхности(сторон)
          - 'vp' - параметры вершин в пространстве
  -----------------------------------------------------------------------------}

  VertexCount: integer = 0;
  NormalsCount: integer = 0;
  FacesCount : integer = 0;

  Vertex : array of array of real;
  Normals : array of array of real;

  FacesVertex : array of array of integer;
  FacesNormals: array of integer;
  FacesTexture: array of array of integer;

  iVertex: integer = 0;
  iNormals: integer = 0;
  iFaces: integer = 0;

implementation

{$R *.DFM}

// разбор строки
function parseString(var temp: string): string;
var
  i: integer;
  s: string;
begin
  for i:=1 to Length(temp) do
  begin
    if (temp[i] = ' ') then
    begin
      s := Copy(temp, 1, i-1);
      Delete(temp, 1, i);
      break;
    end;
    if (i = Length(temp)) then
    begin
      s := Copy(temp, 1, i);
      Delete(temp, 1, i);
      break;
    end;
  end;
  Result := s;
end;

// разбор строки полигонов
function parseFaces(var Fase: string): string;
var
  i: integer;
  s: string;
begin
  for i:=1 to Length(Fase) do
  begin
    if (Fase[i] = '/') then
    begin
      s := Copy(Fase, 1, i-1);
      Delete(Fase, 1, i);
      break;
    end;
    if (i = Length(Fase)) then
    begin
      s := Copy(Fase, 1, i);
      Delete(Fase, 1, i);
      break;
    end;
  end;
  Result := s;
end;

// выделение памяти для массивов
// загрузка количества элементов из файла
procedure objLoaderCount(FileName: string);
var
  f : TextFile;
  key: string;
  temp: string;
  code: integer;
begin

  AssignFile(f,FileName);
  Reset(f);

  while not eof(f) do
  begin
    ReadLn(f, temp);
    key := Copy(temp, 1, 2);

    // v - вершины
    if key = 'v ' then
    begin
      VertexCount := VertexCount + 1;
      Continue;
    end;

    // n - нормали
    if key = 'vn' then
    begin
      NormalsCount := NormalsCount + 1;
      Continue;
    end;

    // faces - полигоны
    if key = 'f ' then
    begin
      FacesCount := FacesCount + 1;
      Continue;
    end;

  end;

  CloseFile(f);

  SetLength(Vertex, 3);
  SetLength(Vertex[0], VertexCount);
  SetLength(Vertex[1], VertexCount);
  SetLength(Vertex[2], VertexCount);

  SetLength(Normals, 3);
  SetLength(Normals[0], NormalsCount);
  SetLength(Normals[1], NormalsCount);
  SetLength(Normals[2], NormalsCount);

  SetLength(FacesVertex, 4);
  SetLength(FacesVertex[0], FacesCount);
  SetLength(FacesVertex[1], FacesCount);
  SetLength(FacesVertex[2], FacesCount);
  SetLength(FacesVertex[3], FacesCount);

  SetLength(FacesNormals, FacesCount);

  SetLength(FacesTexture, 4);
  SetLength(FacesTexture[0], FacesCount);
  SetLength(FacesTexture[1], FacesCount);
  SetLength(FacesTexture[2], FacesCount);
  SetLength(FacesTexture[3], FacesCount);
         
end;

// заполнение массивов
// загрузка значений из файла
procedure objLoader(FileName: string);
var
  f : TextFile;
  key: string;
  temp: string;
  code: integer;
  i: integer;
  c: char;
  slash: boolean;
  Fase, FaseTemp: string;
begin

  slash := false;

  AssignFile(f,FileName);
  Reset(f);

  while not eof(f) do
  begin
    ReadLn(f, temp);
    key := Copy(temp, 1, 2);

    //--------------------------------------------------------------------------
    //v - вершины
    //--------------------------------------------------------------------------
    if key = 'v ' then
    begin
      Delete(temp, 1, 2); // удаление 'v '
      Val(parseString(temp), Vertex[0,iVertex], code);
      Val(parseString(temp), Vertex[1,iVertex], code);
      Val(parseString(temp), Vertex[2,iVertex], code);
      iVertex := iVertex+1;

      Continue;
    end;

    //--------------------------------------------------------------------------
    //vn - нормали
    //--------------------------------------------------------------------------
    if key = 'vn' then
    begin
      Delete(temp, 1, 3); // удаление 'vn'
      Val(parseString(temp), Normals[0,iNormals], code);
      Val(parseString(temp), Normals[1,iNormals], code);
      Val(parseString(temp), Normals[2,iNormals], code);
      iNormals := iNormals+1;

      Continue;
    end;

    //--------------------------------------------------------------------------
    // f - полигоны
    //--------------------------------------------------------------------------
    if key = 'f ' then
    begin
      Delete(temp, 1, 2); // удаление 'f '

      // проверяем на наличие '/' в строке
      for i := 1 to Length(temp) do
      begin
        c := temp[i];
        if c = '/' then
        begin
          slash := true;
          break;
        end;
      end;

      if slash then // если "/" есть
      begin

        // 1 face
        Fase := parseString(temp);
        FacesVertex[0,iFaces] := StrToInt(parseFaces(Fase));

        if Fase <> '' then
        begin
          FaseTemp := parseFaces(Fase);
          if FaseTemp <> '' then
            FacesTexture[0,iFaces] := StrToInt(FaseTemp);
        end
        else
          FacesTexture[0,iFaces] := 0;

        if Fase <> '' then
          FacesNormals[iFaces] := StrToInt(parseFaces(Fase))
        else
          FacesNormals[iFaces] := 0;

        // 2 face
        Fase := parseString(temp);
        FacesVertex[1,iFaces] := StrToInt(parseFaces(Fase));

        if Fase <> '' then
        begin
          FaseTemp := parseFaces(Fase);
          if FaseTemp <> '' then
            FacesTexture[1,iFaces] := StrToInt(FaseTemp);
        end
        else
          FacesTexture[1,iFaces] := 0;

        if Fase <> '' then
          FacesNormals[iFaces] := StrToInt(parseFaces(Fase))
        else
          FacesNormals[iFaces] := 0;

        // 3 face
        Fase := parseString(temp);
        FacesVertex[2,iFaces] := StrToInt(parseFaces(Fase));

        if Fase <> '' then
        begin
          FaseTemp := parseFaces(Fase);
          if FaseTemp <> '' then
            FacesTexture[2,iFaces] := StrToInt(FaseTemp);
        end
        else
          FacesTexture[2,iFaces] := 0;

        if Fase <> '' then
          FacesNormals[iFaces] := StrToInt(parseFaces(Fase))
        else
          FacesNormals[iFaces] := 0;

        // 4 face
        if temp <> '' then
        begin
          Fase := parseString(temp);
          FacesVertex[3,iFaces] := StrToInt(parseFaces(Fase));

          if Fase <> '' then
          begin
            FaseTemp := parseFaces(Fase);
            if FaseTemp <> '' then
              FacesTexture[3,iFaces] := StrToInt(FaseTemp);
          end
          else
            FacesTexture[3,iFaces] := 0;

          if Fase <> '' then
            FacesNormals[iFaces] := StrToInt(parseFaces(Fase))
          else
            FacesNormals[iFaces] := 0;
        end
        else
        begin
          FacesVertex[3,iFaces] := 0;
          FacesTexture[3,iFaces] := 0;
          FacesNormals[iFaces] := 0;
        end;
      end

      // если "/" нет
      else
      begin
        FacesVertex[0,iFaces] := StrToInt(parseString(temp));
        FacesVertex[1,iFaces] := StrToInt(parseString(temp));
        FacesVertex[2,iFaces] := StrToInt(parseString(temp));
        if temp <> '' then
          FacesVertex[3,iFaces] := StrToInt(parseString(temp))
        else
          FacesVertex[3,iFaces] := 0;
        FacesNormals[iFaces] := 0;
        FacesTexture[0,iFaces] := 0;
      end;

      iFaces := iFaces+1;
      Continue;
    end;
    //--------------------------------------------------------------------------

  end;

  CloseFile(f);
end;

{=======================================================================
Перерисовка окна}
procedure TfrmGL.FormPaint(Sender: TObject);
//const
  // положение источника света в системе координат
  //position : Array [0..3] of GLFloat = (0.0, 0.0, 1.5, 1.0);
var
  i: integer;
begin
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);      // очистка буфера цвета

  glPushMatrix;
  glScalef (2, 2, 2);

  // задание параметров источника света
  //glLightfv (GL_LIGHT0, GL_POSITION, @position);

  //glPointSize(7);
  //GL_POINTS

  for i := 0 to FacesCount-1 do
  begin

    if FacesVertex[3,i] = 0 then
    begin
    glBegin(GL_TRIANGLES);
      if FacesNormals[i] <> 0 then
        glNormal3f(
          Normals[0,FacesNormals[i]-1],
          Normals[1,FacesNormals[i]-1],
          Normals[2,FacesNormals[i]-1]
        );

      glVertex3f(
        Vertex[0,FacesVertex[0,i]-1],
        Vertex[1,FacesVertex[0,i]-1],
        Vertex[2,FacesVertex[0,i]-1]
      );
      glVertex3f(
        Vertex[0,FacesVertex[1,i]-1],
        Vertex[1,FacesVertex[1,i]-1],
        Vertex[2,FacesVertex[1,i]-1]
      );
      glVertex3f(
        Vertex[0,FacesVertex[2,i]-1],
        Vertex[1,FacesVertex[2,i]-1],
        Vertex[2,FacesVertex[2,i]-1]
      );
    glEnd();
    end
    else
    begin
    glBegin(GL_QUADS);
      if FacesNormals[i] <> 0 then
        glNormal3f(
          Normals[0,FacesNormals[i]-1],
          Normals[1,FacesNormals[i]-1],
          Normals[2,FacesNormals[i]-1]
        );

      glVertex3f(
        Vertex[0,FacesVertex[0,i]-1],
        Vertex[1,FacesVertex[0,i]-1],
        Vertex[2,FacesVertex[0,i]-1]
      );
      glVertex3f(
        Vertex[0,FacesVertex[1,i]-1],
        Vertex[1,FacesVertex[1,i]-1],
        Vertex[2,FacesVertex[1,i]-1]
      );
      glVertex3f(
        Vertex[0,FacesVertex[2,i]-1],
        Vertex[1,FacesVertex[2,i]-1],
        Vertex[2,FacesVertex[2,i]-1]
      );
      glVertex3f(
        Vertex[0,FacesVertex[3,i]-1],
        Vertex[1,FacesVertex[3,i]-1],
        Vertex[2,FacesVertex[3,i]-1]
      );

    glEnd();
    end;

  end;

  glPopMatrix;
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
  //glClearColor (0.5, 0.5, 0.75, 1.0);
  glClearColor (0, 0, 0, 1.0); // цвет фона
           
  // освещение
  glEnable (GL_LIGHTING);
  //glDisable (GL_LIGHTING); // отключение
  glEnable (GL_LIGHT0);
  glEnable (GL_DEPTH_TEST);

  // текущие цветовые установки влияют на цвет поверхности объекта
  glEnable(GL_COLOR_MATERIAL);
  glColor3f (0.0, 1.0, 0.0); // цвет объекта

  objLoaderCount('untitled.obj');
  objLoader('untitled.obj');

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

  frmGL.Caption := 'VertexCount = ' + IntToStr(VertexCount) + ' ' +
    'FacesCount = ' + IntToStr(FacesCount);

end;

end.

