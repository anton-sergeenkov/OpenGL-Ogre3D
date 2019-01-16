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

    // стандартные процедуры
    procedure FormPaint(Sender: TObject);                                       // отрисовка объектов
    procedure FormCreate(Sender: TObject);                                      // создание формы
    procedure FormDestroy(Sender: TObject);                                     // уничтожение формы
    procedure FormResize(Sender: TObject);                                      // изменение размера формы
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);                                       // нажатие кнопки мыши
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;                // отжатие кнопки мыши
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);// передвижение мыши

    // кнопки настроек: поворот, перемещение, анимация
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

    // таймеры
    procedure Timer1Timer(Sender: TObject);          // таймер для визулизации желудочков
    procedure Timer2Timer(Sender: TObject);          // таймер для визулизации предсердий
    procedure Timer3Timer(Sender: TObject);          // таймер для настройи анимации

    // загрузка файла в массивы (unitParserObj.pas)
    procedure CreateObjLoader(ObjFile: string);      // модель сердца полностью
    procedure CreateObjLoaderDown(ObjFile: string);  // модель сердца (желудочки)
    procedure CreateObjLoaderUp(ObjFile: string);    // модель сердца (предсердия)

    // построение модели
    procedure DrawPolygon;                           // построение модели (полностью)
    procedure DrawPolygonDown;                       // построение модели (желудочки)
    procedure DrawPolygonUp;                         // построение модели (предсердия)
    procedure RePaint;                               // перерисовка объектов

    // настроки модели
    procedure RotateModel(AxisX: boolean);           // поворот модели
    procedure TranslateModel(AxisX: boolean);        // перемещение модели
    procedure RotateCountLabel(AxisX: boolean);      // поворот модели (изменение label)
    procedure TranslateCountLabel(AxisX: boolean);   // перемещение модели (изменение label)

  private
    // переменные для OpenGL
    DC : HDC;   // ссылка на контекст устройства
    hrc: HGLRC; // ссылка на контекст воспроизведения
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

  wrkX, wrkY : Integer; // вращение фигуры по оси X и по оси Y
  down : Boolean = False; // вращение фигуры, нажатие кнопки мыши

  // окно настроек

  // масштабирование
  ScaleX: real = 2;
  ScaleY: real = 2;
  ScaleZ: real = 2;
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

  // граничная линия желудочков
  DownLine: array[0..51] of integer = (
    0,2,3,23,25,41,43,
    71,72,74,79,93,95,175,176,
    224,225,231,240,242,258,271,
    272,279,68,69,351,352,
    353,354,355,359,372,98,278,
    139,300,424,230,268,370,371,429,
    246,267,266,265,438,439,275,
    440,426);

  // граничная линия предсердий
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
  OBJ_HEART = 'heart.obj';     // файл с моделью сердца полностью
  OBJ_HEART_DOWN = 'down.obj'; // файл с моделью сердца (желудочки)
  OBJ_HEART_UP = 'up.obj';     // файл с моделью сердца (предсердия)


implementation

{$R *.dfm}

uses unitParserObj;

var
  // через класс TModelType мы получаем доступ к загруженным параметрам объекта (вершины, нормали, полигоны и т.д.)
  ModelType: TModelType;      // модель сердца полностью
  ModelTypeDown: TModelType;  // модель сердца (желудочки)
  ModelTypeDown_: TModelType; // модель сердца (желудочки)
  ModelTypeUp: TModelType;    // модель сердца (предсердия)
  ModelTypeUp_: TModelType;   // модель сердца (предсердия)


//------------------------------------------------------------------------------
// загрузка файлов моделей в массивы и получение данных (unitParserObj.pas)
//------------------------------------------------------------------------------

// модель сердца полностью
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

// модель сердца (желудочки)
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

// модель сердца (предсердия)
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
// перерисовка модели
//------------------------------------------------------------------------------
procedure TMainForm.RePaint;
begin
  InvalidateRect(Handle, nil, False);
end;


//------------------------------------------------------------------------------
// анимация модели, изменение координат вершин
//------------------------------------------------------------------------------
var maxCountAnimation: integer = 8; // количество кадров анимации

var stepDown: real = 1.01;        // коэффициен изменения вершины
var countDown: integer = 0;       // кол-во шагов
var positiveDown: boolean = true; // true - увеличиваем коэффициент, false - уменьшаем

// анимация желудочков
procedure TMainForm.Timer1Timer(Sender: TObject);
var
  i,j: integer;  // счетчики цикла
  x,y,z: real;   // координаты
  flag: boolean; // флаг совпадения с пограничной линией
begin

  // если достигли максимального кадра анимации, возвращается обратно
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

  // если увеличивем коэффициент
  if (positiveDown) then begin
    stepDown := stepDown + 0.01;
  end else begin
    stepDown := stepDown - 0.01;
  end;

  // перебор всех вершин объекта
  for i := 0 to ModelTypeDown.VertexCount-1 do
  begin

    flag := true;

    // проверяем на совпадение с пограничной линией
    for j := 0 to Length(DownLine) - 1 do
    begin
      if i = DownLine[j] then
      begin
         flag := false;
         break;
      end;
    end;

    // если нет совпадений, то изменяем вершину
    if (flag) then
    begin
      ModelTypeDown.Vertex[0,i] := ModelTypeDown_.Vertex[0,i]*stepDown;
      ModelTypeDown.Vertex[1,i] := ModelTypeDown_.Vertex[1,i]*stepDown;
      ModelTypeDown.Vertex[2,i] := ModelTypeDown_.Vertex[2,i]*stepDown;
    end;

  end;

    // перерисовываем форму
    MainForm.RePaint;

end;


var stepUp: real = 1.01;        // коэффициен изменения вершины
var countUp: integer = 0;       // кол-во шагов
var positiveUp: boolean = true; // true - увеличиваем коэффициент, false - уменьшаем

// анимация предсердий
procedure TMainForm.Timer2Timer(Sender: TObject);
var
  i,j: integer;  // счетчики цикла
  x,y,z: real;   // координаты
  flag: boolean; // флаг совпадения с пограничной линией
begin

  // если достигли максимального кадра анимации, запускаем анимацию желудочков и возвращается обратно
  if (countUp=maxCountAnimation) then
  begin
    Timer1.Enabled := True; // запускаем анимацию желудочков

    countUp := 0;

    if (positiveUp) then begin
      positiveUp := false;
    end else begin
      positiveUp := true;
    end;

  end else begin
    countUp := countUp + 1;
  end;

  // если увеличивем коэффициент
  if (positiveUp) then begin
    stepUp := stepUp + 0.01;
  end else begin
    stepUp := stepUp - 0.01;
  end;

  // перебор всех вершин объекта
  for i := 0 to ModelTypeUp.VertexCount-1 do
  begin

    flag := true;

    // проверяем на совпадение с пограничной линией
    for j := 0 to Length(UpLine) - 1 do
    begin
      if i = UpLine[j] then
      begin
         flag := false;
         break;
      end;
    end;

    // если нет совпадений, то изменяем вершину
    if (flag) then
    begin
      ModelTypeUp.Vertex[0,i] := ModelTypeUp_.Vertex[0,i]*stepUp;
      ModelTypeUp.Vertex[1,i] := ModelTypeUp_.Vertex[1,i]*stepUp;
      ModelTypeUp.Vertex[2,i] := ModelTypeUp_.Vertex[2,i]*stepUp;
    end;

  end;

  // перерисовываем форму
  MainForm.RePaint;

end;


//------------------------------------------------------------------------------
// построение модели по массивам
//------------------------------------------------------------------------------

// построение модели (желудочки)
procedure TMainForm.DrawPolygonDown;
var
  i, z: integer;
begin

  for i := 0 to ModelTypeDown.FacesCount-1 do
  begin

    glBegin(GL_TRIANGLES);

      // 1я вершина
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

      // 2я вершина
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

      // 3я вершина
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

// построение модели (предсердия)
procedure TMainForm.DrawPolygonUp;
var
  i, z: integer;
begin

  for i := 0 to ModelTypeUp.FacesCount-1 do
  begin

    glBegin(GL_TRIANGLES);

      // 1я вершина
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

      // 2я вершина
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

      // 3я вершина
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


// построение модели (полностью)
procedure TMainForm.DrawPolygon;
var
  i, z: integer;
begin

  for i := 0 to ModelType.FacesCount-1 do
  begin

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

  end;
end;


//------------------------------------------------------------------------------
// перерисовка окна и настройка параметров OpenGL
//------------------------------------------------------------------------------
procedure TMainForm.FormPaint(Sender: TObject);
begin
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // очистка буфера цвета
  glClearColor (0.25, 0.25, 0.25, 1.0);   // цвет фона
  glColor3f(0.796863, 0.385882, 0.395294); // цвет объекта

  glEnable(GL_POINT_SMOOTH); // режим сглаживания точек
  glPointSize(3.0); // устанавливаем размер точки
  glEnable(GL_LINE_SMOOTH); // режим сглаживания линий
  glLineWidth(1); // устанавливаем ширину линии
  glEnable(GL_BLEND); // включаем режим смешения
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // правила смешения
  glHint(GL_POINT_SMOOTH_HINT, GL_DONT_CARE); // способ выполнения растеризации примитивов
  glPolygonMode(GL_FRONT_AND_BACK, GL_FILL); // выбор режима отображения полигонов

  glPushMatrix; // загружает текущую матрицу в стек, и она же остается на верхушке стека
      glScalef (ScaleX, ScaleY, ScaleZ); // масштабирование

      DrawPolygonDown; // рисуем желудочки
      DrawPolygonUp; // рисуем предсвердия

      glEnable(GL_ALPHA_TEST); // прозрачность
      glEnable(GL_BLEND);       // включаем смешение
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); // правила смешения
      glEnable(GL_CULL_FACE);   // включаем отсечение сторон полигонов
      glCullFace(GL_BACK);      // не воспроизводить заднюю поверхность фигуры

      DrawPolygon; // рисуем все сердце

      glDisable(GL_CULL_FACE);  // отключить сортировку поверхностей
      glDisable(GL_BLEND);      // отключить режим смешения
      glDisable(GL_ALPHA_TEST);
  glPopMatrix; // выгружает матрицу - возвращает в исходное состояние

  glDisable(GL_BLEND);
  SwapBuffers(DC); // вывод на экран
end;


//------------------------------------------------------------------------------
// формат пикселя (для OpenGL)
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
// создание формы
//------------------------------------------------------------------------------
procedure TMainForm.FormCreate(Sender: TObject);
begin
  DC := GetDC (Handle); // задаем значение ссылки
  SetDCPixelFormat(DC); //задаем формат пиксела
  hrc := wglCreateContext(DC); // создаем контекст воспроизведения
  wglMakeCurrent(DC, hrc); // установить контекст воспроизведения текущим (занять для последующего вывода)

  glClearColor (0.25, 0.25, 0.25, 1.0); // цвет фона

  // освещение
  glEnable (GL_LIGHTING);
  glEnable (GL_LIGHT0);

  glEnable (GL_DEPTH_TEST);

  // текущие цветовые установки влияют на цвет поверхности объекта
  glEnable(GL_COLOR_MATERIAL);

  FormResize(Sender); // иначе при создании формы некорректно отрисовывает

  // загружаем все модели
  MainForm.CreateObjLoader(OBJ_HEART);
  MainForm.CreateObjLoaderDown(OBJ_HEART_DOWN);
  MainForm.CreateObjLoaderUp(OBJ_HEART_UP);

  MainForm.FormPaint(Sender);
  MainForm.FormResize(Sender);

end;


//------------------------------------------------------------------------------
// конец работы приложения
//------------------------------------------------------------------------------
procedure TMainForm.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0); // освободить контекст
  wglDeleteContext(hrc); // удаляем контекст воспроизведения, освобождая память
  ReleaseDC (Handle, DC);
  DeleteDC(DC);
end;


//------------------------------------------------------------------------------
// изменение размера фигуры при изменении размера окна
//------------------------------------------------------------------------------
procedure TMainForm.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight); // область вывода
  glMatrixMode(GL_PROJECTION);

  // если нужно вернуться к исходной позиции, текущая матрица заменяется матрицей
  // с единицами по диагонали и равными нулю всеми остальными элементами, единичной матрицей
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
// вращение фигуры
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
// Окно настройки: Поворот
// -----------------------------------------------------------------------------
// ось X +1
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

// ось X -1
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

// ось Y -1
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

// ось Y +1
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

// поворот модели
procedure TMainForm.RotateModel(AxisX: boolean);
begin
  if AxisX then
    glRotatef(RotateX, 0.0, 1.0, 0.0)
  else
    glRotatef(RotateY, 1.0, 0.0, 0.0);
  InvalidateRect(Handle, nil, False);
end;

// отображение на метке значения поворота модели
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

// автоповорот
procedure TMainForm.SpeedButton1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Label3.Caption = 'Автоповорот отключен' then
  begin
    Label3.Caption := 'Автоповорот включен';
    SpeedButton1.Flat := False;
    Timer3.Enabled := True;
    Exit;
  end;
  if Label3.Caption = 'Автоповорот включен' then
  begin
    Label3.Caption := 'Автоповорот отключен';
    SpeedButton1.Flat := True;
    Timer3.Enabled := False;
    Exit;
  end;
end;

// таймер автоповорот
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
// Окно настройки: Перемещение
// -----------------------------------------------------------------------------

// ось X
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

// ось Y
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

// перемещение модели
procedure TMainForm.TranslateModel(AxisX: boolean);
begin
  if AxisX then
    glTranslatef(TranslateX, 0.0, 0.0)
  else
    glTranslatef(0.0, TranslateY, 0.0);
  InvalidateRect(Handle, nil, False);
end;

// отображение на метке значения перемещения модели
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
// Окно настройки: Анимация
// -----------------------------------------------------------------------------

 procedure TMainForm.SpeedButton2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if Label4.Caption = 'Анимация включена' then
  begin
    Label4.Caption := 'Анимация отключена';
    SpeedButton2.Flat := True;
    Timer1.Enabled := False;
	Timer2.Enabled := False;
    Exit;
  end;
  if Label4.Caption = 'Анимация отключена' then
  begin
    Label4.Caption := 'Анимация включена';
    SpeedButton2.Flat := False;
    Timer1.Enabled := True;
    Timer2.Enabled := True;
    Exit;
  end;

end;

end.


