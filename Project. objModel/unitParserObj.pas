unit unitParserObj;

interface

uses System.SysUtils, frmModel;


type
  {-----------------------------------------------------------------------------
  Vertex  - 'v ' - список вершин
  Texture - 'vt' - текстурные координаты
  Normals - 'vn' - нормали
  Faces   - 'f ' - определения поверхности(сторон)
  нет     - 'vp' - параметры вершин в пространстве
  Object  - 'o ' - название нового объекта
  -----------------------------------------------------------------------------}

  TModelType = class

    function parseString(var temp: string): string;
    function parseFaces(var Fase: string): string;
    procedure objLoaderCount(FileName: string);
    procedure objLoader(FileName: string);

  public

    VertexCount: integer;
    TextureCount: integer;
    NormalsCount: integer;
    FacesCount : integer;

    Vertex : array of array of real;
    Texture : array of array of real;
    Normals : array of array of real;

    FacesVertex : array of array of integer;
    FacesTexture: array of array of integer;
    FacesNormals: array of array of integer;

    iVertex: integer;
    iNormals: integer;
    iFaces: integer;
    iTexture: integer;
  end;

implementation

// разбор строки
function TModelType.parseString(var temp: string): string;
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
function TModelType.parseFaces(var Fase: string): string;
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

// загрузка количества элементов из файла и
// выделение памяти для массивов
procedure TModelType.objLoaderCount(FileName: string);
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

    // vt - текстурные координаты
    if key = 'vt' then
    begin
      TextureCount := TextureCount + 1;
      Continue;
    end;

    // vn - нормали
    if key = 'vn' then
    begin
      NormalsCount := NormalsCount + 1;
      Continue;
    end;

    // f - полигоны
    if key = 'f ' then
    begin
      FacesCount := FacesCount + 1;
      Continue;
    end;

  end;

  CloseFile(f);

  // выделение памяти для массивов
  SetLength(Vertex, 3, VertexCount);
  SetLength(Texture, 2, TextureCount);
  SetLength(Normals, 3, NormalsCount);

  SetLength(FacesVertex, 4, FacesCount);
  SetLength(FacesNormals, 4, FacesCount);
  SetLength(FacesTexture, 4, FacesCount);

end;

// загрузка значений из файла и
// заполнение массивов
procedure TModelType.objLoader(FileName: string);
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
    //vt - текстурные координаты
    //--------------------------------------------------------------------------
    if key = 'vt' then
    begin
      Delete(temp, 1, 3); // удаление 'vt '
      Val(parseString(temp), Texture[0,iTexture], code);
      Val(parseString(temp), Texture[1,iTexture], code);
      iTexture := iTexture+1;
      Continue;
    end;

    //--------------------------------------------------------------------------
    //vn - нормали
    //--------------------------------------------------------------------------
    if key = 'vn' then
    begin
      Delete(temp, 1, 3); // удаление 'vn '
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
          FacesNormals[0,iFaces] := StrToInt(parseFaces(Fase))
        else
          FacesNormals[0,iFaces] := 0;

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
          FacesNormals[1,iFaces] := StrToInt(parseFaces(Fase))
        else
          FacesNormals[1,iFaces] := 0;

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
          FacesNormals[2,iFaces] := StrToInt(parseFaces(Fase))
        else
          FacesNormals[2,iFaces] := 0;

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
            FacesNormals[3,iFaces] := StrToInt(parseFaces(Fase))
          else
            FacesNormals[3,iFaces] := 0;
        end
        else
        begin
          FacesVertex[3,iFaces] := 0;
          FacesTexture[3,iFaces] := 0;
          FacesNormals[3,iFaces] := 0;
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
        FacesNormals[0,iFaces] := 0;
        FacesTexture[0,iFaces] := 0;
      end;

      iFaces := iFaces+1;
      Continue;
    end;
    //--------------------------------------------------------------------------

  end;

  CloseFile(f);
end;

end.


