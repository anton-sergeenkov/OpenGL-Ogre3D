unit frmModel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  OpenGL, Vcl.StdCtrls, Vcl.ExtCtrls;

type

  TModelForm = class(TForm)

    // изменение стиля формы на bsNone
    procedure CreateParams(var Params: TCreateParams); override;
    // перерисовка модели
    procedure RePaint;
    // поворот модели
    procedure RotateModel(AxisX: boolean);
    // перемещение модели
    procedure TranslateModel(AxisX: boolean);
    // подготовка текстуры
    procedure LoadTexture(path: string);

    procedure CreateObjLoader(ObjFile: string);
    procedure CreateObjLoaderInside(ObjFile: string);

    procedure DrawPolygon;        // стандартное построение
    procedure DrawPolygonInMinus; // 2я модель нормали с минусом
    procedure DrawPolygonIn;      // 2я модель
    procedure DrawPolygonTexture; // текстурные координаты

    procedure DrawFigure1;        // Пустой холст
    procedure DrawFigure2;        // Модель торса
    procedure DrawFigure3;        // Модель сердца
    procedure DrawFigure4;        // Модель сердца (текстура)
    procedure DrawFigure5;        // Модель сердца (сечение)

    procedure FormPaint(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

  private
    DC : HDC;
    hrc: HGLRC;
  public

  end;

var
  ModelForm: TModelForm;
  wrkX, wrkY : Integer;
  down : Boolean = False;

  NumberModel: integer = 1;
  PolygonMode: integer = 3;

implementation

{$R *.dfm}

uses unitParserObj, frmMain, frmSetting1, unitConsts, frmSetting2;

var
  ModelType: TModelType;
  ModelTypeInside: TModelType;


procedure TModelForm.CreateObjLoader(ObjFile: string);
begin
  ModelType := TModelType.Create;
  try
    ModelType.objLoaderCount(ObjFile);
    ModelType.objLoader(ObjFile);
  finally
    //ModelType.Free;
  end;
end;

procedure TModelForm.CreateObjLoaderInside(ObjFile: string);
begin
  ModelTypeInside := TModelType.Create;
  try
    ModelTypeInside.objLoaderCount(ObjFile);
    ModelTypeInside.objLoader(ObjFile);
  finally
    //ModelTypeInside.Free;
  end;
end;



procedure TModelForm.DrawPolygon;
var
  i: integer;
begin

  for i := 0 to ModelType.FacesCount-1 do
  begin

    if ModelType.FacesVertex[3,i] = 0 then
    begin
      // рисуется треугольник
      glBegin(GL_TRIANGLES);

        // 1я вершина
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

        // 2я вершина
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

        // 3я вершина
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
    end else
    begin
      // рисуется четырехугольник
      glBegin(GL_QUADS);

        // 1я вершина
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

        // 2я вершина
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

        // 3я вершина
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

        // 3я вершина
        glNormal3f(
          ModelType.Normals[0,ModelType.FacesNormals[3,i]-1],
          ModelType.Normals[1,ModelType.FacesNormals[3,i]-1],
          ModelType.Normals[2,ModelType.FacesNormals[3,i]-1]
        );
        glVertex3f(
          ModelType.Vertex[0,ModelType.FacesVertex[3,i]-1],
          ModelType.Vertex[1,ModelType.FacesVertex[3,i]-1],
          ModelType.Vertex[2,ModelType.FacesVertex[3,i]-1]
        );

      glEnd();
    end;
  end;
end;

procedure TModelForm.DrawPolygonInMinus;
var
  i: integer;
begin

  for i := 0 to ModelTypeInside.FacesCount-1 do
  begin

    if ModelTypeInside.FacesVertex[3,i] = 0 then
    begin
      // рисуется треугольник
      glBegin(GL_TRIANGLES);

        // 1я вершина
        glNormal3f(
          -ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[0,i]-1],
          -ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[0,i]-1],
          -ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[0,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[0,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[0,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[0,i]-1]
        );

        // 2я вершина
        glNormal3f(
          -ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[1,i]-1],
          -ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[1,i]-1],
          -ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[1,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[1,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[1,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[1,i]-1]
        );

        // 3я вершина
        glNormal3f(
          -ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[2,i]-1],
          -ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[2,i]-1],
          -ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[2,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[2,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[2,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[2,i]-1]
        );

      glEnd();
    end else
    begin
      // рисуется четырехугольник
      glBegin(GL_QUADS);

        // 1я вершина
        glNormal3f(
          -ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[0,i]-1],
          -ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[0,i]-1],
          -ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[0,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[0,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[0,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[0,i]-1]
        );

        // 2я вершина
        glNormal3f(
          -ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[1,i]-1],
          -ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[1,i]-1],
          -ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[1,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[1,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[1,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[1,i]-1]
        );

        // 3я вершина
        glNormal3f(
          -ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[2,i]-1],
          -ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[2,i]-1],
          -ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[2,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[2,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[2,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[2,i]-1]
        );

        // 4я вершина
        glNormal3f(
          -ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[3,i]-1],
          -ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[3,i]-1],
          -ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[3,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[3,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[3,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[3,i]-1]
        );

      glEnd();
    end;
  end;
end;

procedure TModelForm.DrawPolygonIn;
var
  i: integer;
begin

  for i := 0 to ModelTypeInside.FacesCount-1 do
  begin

    if ModelTypeInside.FacesVertex[3,i] = 0 then
    begin
      // рисуется треугольник
      glBegin(GL_TRIANGLES);

        // 1я вершина
        glNormal3f(
          ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[0,i]-1],
          ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[0,i]-1],
          ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[0,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[0,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[0,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[0,i]-1]
        );

        // 2я вершина
        glNormal3f(
          ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[1,i]-1],
          ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[1,i]-1],
          ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[1,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[1,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[1,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[1,i]-1]
        );

        // 3я вершина
        glNormal3f(
          ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[2,i]-1],
          ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[2,i]-1],
          ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[2,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[2,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[2,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[2,i]-1]
        );

      glEnd();
    end else
    begin
      // рисуется четырехугольник
      glBegin(GL_QUADS);

        // 1я вершина
        glNormal3f(
          ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[0,i]-1],
          ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[0,i]-1],
          ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[0,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[0,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[0,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[0,i]-1]
        );

        // 2я вершина
        glNormal3f(
          ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[1,i]-1],
          ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[1,i]-1],
          ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[1,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[1,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[1,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[1,i]-1]
        );

        // 3я вершина
        glNormal3f(
          ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[2,i]-1],
          ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[2,i]-1],
          ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[2,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[2,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[2,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[2,i]-1]
        );

        // 4я вершина
        glNormal3f(
          ModelTypeInside.Normals[0,ModelTypeInside.FacesNormals[3,i]-1],
          ModelTypeInside.Normals[1,ModelTypeInside.FacesNormals[3,i]-1],
          ModelTypeInside.Normals[2,ModelTypeInside.FacesNormals[3,i]-1]
        );
        glVertex3f(
          ModelTypeInside.Vertex[0,ModelTypeInside.FacesVertex[3,i]-1],
          ModelTypeInside.Vertex[1,ModelTypeInside.FacesVertex[3,i]-1],
          ModelTypeInside.Vertex[2,ModelTypeInside.FacesVertex[3,i]-1]
        );

      glEnd();
    end;
  end;
end;

procedure TModelForm.DrawPolygonTexture;
var
  i: integer;
begin

  for i := 0 to ModelType.FacesCount-1 do
  begin

    if ModelType.FacesVertex[3,i] = 0 then
    begin

    glBegin(GL_TRIANGLES);
      if ModelType.FacesNormals[0,i] <> 0 then
        glNormal3f(
          ModelType.Normals[0,ModelType.FacesNormals[0,i]-1],
          ModelType.Normals[1,ModelType.FacesNormals[0,i]-1],
          ModelType.Normals[2,ModelType.FacesNormals[0,i]-1]
        );

      // 1 вершина
      glTexCoord2d(
        ModelType.Texture[0,ModelType.FacesTexture[0,i]-1],
        ModelType.Texture[1,ModelType.FacesTexture[0,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[0,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[0,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[0,i]-1]
      );

      // 2 вершина
      glTexCoord2d(
        ModelType.Texture[0,ModelType.FacesTexture[1,i]-1],
        ModelType.Texture[1,ModelType.FacesTexture[1,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[1,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[1,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[1,i]-1]
      );

      // 3 вершина
      glTexCoord2d(
        ModelType.Texture[0,ModelType.FacesTexture[2,i]-1],
        ModelType.Texture[1,ModelType.FacesTexture[2,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[2,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[2,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[2,i]-1]
      );

    glEnd();

    end
    else
    begin
    glBegin(GL_QUADS);
      if ModelType.FacesNormals[0,i] <> 0 then
        glNormal3f(
          ModelType.Normals[0,ModelType.FacesNormals[0,i]-1],
          ModelType.Normals[1,ModelType.FacesNormals[0,i]-1],
          ModelType.Normals[2,ModelType.FacesNormals[0,i]-1]
        );

      // 1 вершина
      glTexCoord2d(
        ModelType.Texture[0,ModelType.FacesTexture[0,i]-1],
        ModelType.Texture[1,ModelType.FacesTexture[0,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[0,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[0,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[0,i]-1]
      );

      // 2 вершина
      glTexCoord2d(
        ModelType.Texture[0,ModelType.FacesTexture[1,i]-1],
        ModelType.Texture[1,ModelType.FacesTexture[1,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[1,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[1,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[1,i]-1]
      );

      // 3 вершина
      glTexCoord2d(
        ModelType.Texture[0,ModelType.FacesTexture[2,i]-1],
        ModelType.Texture[1,ModelType.FacesTexture[2,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[2,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[2,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[2,i]-1]
      );

      // 4 вершина
      glTexCoord2d(
        ModelType.Texture[0,ModelType.FacesTexture[3,i]-1],
        ModelType.Texture[1,ModelType.FacesTexture[3,i]-1]
      );
      glVertex3f(
        ModelType.Vertex[0,ModelType.FacesVertex[3,i]-1],
        ModelType.Vertex[1,ModelType.FacesVertex[3,i]-1],
        ModelType.Vertex[2,ModelType.FacesVertex[3,i]-1]
      );

    glEnd();
    end;
  end;
end;



// Пустой холст
procedure TModelForm.DrawFigure1;
begin
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glClearColor (0.25, 0.25, 0.25, 1.0);
  SwapBuffers(DC);
end;

// Модель торса
procedure TModelForm.DrawFigure2;
begin

  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glClearColor (0.25, 0.25, 0.25, 1.0);

  glEnable(GL_POINT_SMOOTH);
  glPointSize(3.0);
  glEnable(GL_LINE_SMOOTH);
  glLineWidth(1);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glHint(GL_POINT_SMOOTH_HINT, GL_DONT_CARE);

  case PolygonMode of
    1: glPolygonMode(GL_FRONT_AND_BACK, GL_POINT);
    2: glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    3: glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
  end;

  glPushMatrix;
  glScalef (ScaleX, ScaleY, ScaleZ);

  // сердце
  glColor3f (0.796863, 0.385882, 0.395294);
  DrawPolygonIn;

  // прозрачность
  glEnable(GL_ALPHA_TEST);
  glEnable(GL_BLEND);       // включаем смешение
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  // glColor4f(0.800000, 0.589304, 0.364622, BlendCount);
  glColor4f(1, 1, 0, BlendCount);
  glEnable(GL_CULL_FACE);   // включаем отсечение сторон полигонов
  glCullFace(GL_FRONT);     // не воспроизводить лицевую поверхность фигуры
  DrawPolygon;              // вывести заднюю поверхность фигуры
  glCullFace(GL_BACK);      // не воспроизводить заднюю поверхность фигуры
  DrawPolygon;              // вывести переднюю поверхность фигуры
  glDisable(GL_CULL_FACE);  // отключить сортировку поверхностей
  glDisable(GL_BLEND);      // отключить режим смешения
  glDisable(GL_ALPHA_TEST);

  glPopMatrix;

  glDisable(GL_BLEND);
  SwapBuffers(DC);
end;

// Модель сердца
procedure TModelForm.DrawFigure3;
begin

  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glClearColor (0.25, 0.25, 0.25, 1.0);
  glColor3f (1.0, 0.0, 0.0);

  glEnable(GL_POINT_SMOOTH);
  glPointSize(3.0);
  glEnable(GL_LINE_SMOOTH);
  glLineWidth(1);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glHint(GL_POINT_SMOOTH_HINT, GL_DONT_CARE);

  case PolygonMode of
    1: glPolygonMode(GL_FRONT_AND_BACK, GL_POINT);
    2: glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    3: glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
  end;

  glPushMatrix;
  glScalef (ScaleX, ScaleY, ScaleZ);

  // прозрачность
  glEnable(GL_ALPHA_TEST);
  glEnable(GL_BLEND);       // включаем смешение
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glColor4f(0.796863, 0.385882, 0.395294, BlendCount);
  glEnable(GL_CULL_FACE);   // включаем отсечение сторон полигонов
  glCullFace(GL_FRONT);     // не воспроизводить лицевую поверхность фигуры
  DrawPolygon;              // вывести заднюю поверхность фигуры
  glCullFace(GL_BACK);      // не воспроизводить заднюю поверхность фигуры
  DrawPolygon;              // вывести переднюю поверхность фигуры
  glDisable(GL_CULL_FACE);  // отключить сортировку поверхностей
  glDisable(GL_BLEND);      // отключить режим смешения
  glDisable(GL_ALPHA_TEST);

  glPopMatrix;

  glDisable(GL_BLEND);
  SwapBuffers(DC);
end;

// Модель сердца (текстура)
procedure TModelForm.DrawFigure4;
var
  i: integer;
begin

  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glClearColor (0.25, 0.25, 0.25, 1.0);
  glColor3f (1.0, 0.0, 0.0);

//------------------------------------------------------------------------------
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
  glEnable(GL_TEXTURE_2D);
  LoadTexture(TEXTURE_HEART);
  //не учитывать цвет примитивов
  glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
//------------------------------------------------------------------------------

  glPushMatrix;
  glScalef (ScaleX, ScaleY, ScaleZ);

  ////////////////////////////////////
  DrawPolygonTexture;

  glPopMatrix;
  SwapBuffers(DC);
  glDisable(GL_TEXTURE_2D);
end;

// Модель сердца (сечение)
procedure TModelForm.DrawFigure5;
var
  i: integer;
  eqn : Array [0..3] of GLdouble;
begin

  eqn[0] := ClipPlane1;
  eqn[1] := ClipPlane2;
  eqn[2] := ClipPlane3;

  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glClearColor (0.25, 0.25, 0.25, 1.0);

  case PolygonMode of
    1: glPolygonMode(GL_FRONT_AND_BACK, GL_POINT);
    2: glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    3: glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
  end;

  glPushMatrix;
  glScalef (ScaleX, ScaleY, ScaleZ);

  // отсечение
  glClipPlane (GL_CLIP_PLANE0, @eqn);
  glEnable (GL_CLIP_PLANE0);

  // полости сердца
  glColor3f (0.796863, 0.385882, 0.395294);
  DrawPolygonInMinus;
  // сердце
  glColor3f (0.796863, 0.385882, 0.395294);
  DrawPolygon;

  glDisable (GL_CLIP_PLANE0);
  glPopMatrix;
  SwapBuffers(DC);
end;



procedure TModelForm.FormPaint(Sender: TObject);
begin
  case NumberModel of
    1: DrawFigure1;
    2: DrawFigure2; // tors.obj
    3: DrawFigure3; // heart.obj
    4: DrawFigure4; // heart.obj
    5: DrawFigure5;
  end;
end;




// Формат пикселя
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

procedure TModelForm.FormCreate(Sender: TObject);
begin
  DC := GetDC (Handle);
  SetDCPixelFormat(DC);
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);

  glClearColor (0.25, 0.25, 0.25, 1.0);

  // освещение
  glEnable (GL_LIGHTING);
  glEnable (GL_LIGHT0);

  glEnable (GL_DEPTH_TEST);

  // текущие цветовые установки влияют на цвет поверхности объекта
  glEnable(GL_COLOR_MATERIAL);

  FormResize(Sender); // иначе при создании формы некорректно отрисовывает
end;

procedure TModelForm.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC (Handle, DC);
  DeleteDC(DC);
end;

// изменение размеров формы
procedure TModelForm.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
  glMatrixMode(GL_PROJECTION);
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
// Вращение фигуры
//------------------------------------------------------------------------------

procedure TModelForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Down := True;
  wrkX := X;
  wrkY := Y;
end;

procedure TModelForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Down := False;
end;

procedure TModelForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Down then
  begin
    glRotatef (X - wrkX, 0.0, 1.0, 0.0);
    glRotatef (Y - wrkY, 1.0, 0.0, 0.0);
    InvalidateRect(Handle, nil, False);

    // форма Setting1Form
    RotateX := X - wrkX;
    RotateY := Y - wrkY;
    Setting1Form.RotateCountLabel(true);
    Setting1Form.RotateCountLabel(false);

    wrkX := X;
    wrkY := Y;
  end;
end;

//------------------------------------------------------------------------------
// Подготовка текстуры
//------------------------------------------------------------------------------

procedure TModelForm.LoadTexture(path: string);
type
  PPixelArray = ^TPixelArray;
  TPixelArray = array [0..0] of Byte;
var
  Bitmap : TBitmap;
  Data : PPixelArray;                      // образ текстуры, размер заранее не оговариваем
  BMInfo : TBitmapInfo;                    // заголовок файла
  I, ImageSize : Integer;                  // вспомогательные переменные
  Temp : Byte;                             // для перестановки цветов
  MemDC : HDC;                             // вспомогательный идентификатор
begin
  Bitmap := TBitmap.Create;
  Bitmap.LoadFromFile (path);              // считываем образ из файла
  with BMinfo.bmiHeader do begin
    FillChar (BMInfo, SizeOf(BMInfo), 0);  // считываем заголовок
    biSize := sizeof (TBitmapInfoHeader);
    biBitCount := 24;
    biWidth := Bitmap.Width;
    biHeight := Bitmap.Height;
    ImageSize := biWidth * biHeight;
    biPlanes := 1;
    biCompression := BI_RGB;
    MemDC := CreateCompatibleDC (0);
    GetMem (Data, ImageSize * 3);          // создаем динамический массив
    try
      // считываем в DIB-формат растр битового массива
      GetDIBits (MemDC, Bitmap.Handle, 0, biHeight, Data,
                 BMInfo, DIB_RGB_COLORS);
      For I := 0 to ImageSize - 1 do begin // переставляем цвета
          Temp := Data [I * 3];
          Data [I * 3] := Data [I * 3 + 2];
          Data [I * 3 + 2] := Temp;
      end;
      // создаем образ
      glTexImage2d(GL_TEXTURE_2D, 0, 3, biWidth,
                   biHeight, 0, GL_RGB, GL_UNSIGNED_BYTE, Data);
    finally
      FreeMem (Data);                      // освобождаем память
      DeleteDC (MemDC);
      Bitmap.Free;
    end;
  end;
end;

//------------------------------------------------------------------------------
// Вспомогательные процедуры
// -----------------------------------------------------------------------------

procedure TModelForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not WS_OVERLAPPEDWINDOW or WS_BORDER
end;

procedure TModelForm.RePaint;
begin
  InvalidateRect(Handle, nil, False);
end;

procedure TModelForm.RotateModel(AxisX: boolean);
begin
  if AxisX then
    glRotatef(RotateX, 0.0, 1.0, 0.0)
  else
    glRotatef(RotateY, 1.0, 0.0, 0.0);
  InvalidateRect(Handle, nil, False);
end;

procedure TModelForm.TranslateModel(AxisX: boolean);
begin
  if AxisX then
    glTranslatef(TranslateX, 0.0, 0.0)
  else
    glTranslatef(0.0, TranslateY, 0.0);
  InvalidateRect(Handle, nil, False);
end;

end.
