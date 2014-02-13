unit ULanguageConst;

interface

uses RTTI, IniFiles;

type

    // 父类
  TLanguageHandle = class
  protected
    Obj : TObject;
    FilePath : string;
  protected
    IniFile : TIniFile;
  public
    constructor Create( _Obj : TObject; _FilePath : string );
    destructor Destroy; override;
  end;

    // 保存
  TLanguangeSaveHandle = class( TLanguageHandle )
  public
    procedure Update;
  private
    procedure Save( ProName, ProValue : string );
  end;

    // 读取
  TLanguageLoadHandle = class( TLanguageHandle )
  public
    procedure Update;
  private
    function Load( ProName : string ): string;
  end;

    // 语言属性
  TLanguageInfo = class
  public
    frmLogin_Title_Login : string;
    frmLogin_Title_Signup : string;
  public
    constructor Create;
  public
    procedure Save( FilePath : string );
    procedure Load( FilePath : string );
  end;

var
  LanguageInfo : TLanguageInfo;

implementation

{ TLanguageInfo }

constructor TLanguageInfo.Create;
begin
  frmLogin_Title_Login := 'Login';
  frmLogin_Title_Signup := 'Signup';
end;

procedure TLanguageInfo.Load(FilePath: string);
var
  LanguageLoadHandle : TLanguageLoadHandle;
begin
  LanguageLoadHandle := TLanguageLoadHandle.Create( Self, FilePath );
  LanguageLoadHandle.Update;
  LanguageLoadHandle.Free;
end;

procedure TLanguageInfo.Save(FilePath: string);
var
  LanguangeSaveHandle : TLanguangeSaveHandle;
begin
  LanguangeSaveHandle := TLanguangeSaveHandle.Create( Self, FilePath );
  LanguangeSaveHandle.Update;
  LanguangeSaveHandle.Free;
end;

{ TLanguageHandle }

constructor TLanguageHandle.Create(_Obj: TObject; _FilePath: string);
begin
  Obj := _Obj;
  FilePath := _FilePath;
  IniFile := TIniFile.Create( FilePath );
end;

destructor TLanguageHandle.Destroy;
begin
  IniFile.Free;
  inherited;
end;

{ TLanguangeSaveHandle }

procedure TLanguangeSaveHandle.Save(ProName, ProValue: string);
begin
  IniFile.WriteString( Obj.ClassName, ProName, ProValue );
end;

procedure TLanguangeSaveHandle.Update;
var
  ctx: TRttiContext;
  t: TRttiType;
  f : TRttiField;
  value : TValue;
  ProValue : Variant;
begin
  t := ctx.GetType( Obj.ClassType );
  for f in t.GetFields do
  begin
    value := f.GetValue( Obj );
    if value.IsOrdinal then
      ProValue := value.AsOrdinal
    else
      ProValue := value.AsVariant;
    Save( f.Name, ProValue );
  end;
end;

{ TLanguageLoadHandle }

function TLanguageLoadHandle.Load(ProName: string): string;
begin
  Result := IniFile.ReadString( Obj.ClassName, ProName, '' );
end;

procedure TLanguageLoadHandle.Update;
var
  ctx: TRttiContext;
  t: TRttiType;
  f : TRttiField;
  ProName : string;
  ProValue : string;
begin
  t := ctx.GetType( Obj.ClassType );
  for f in t.GetFields do
  begin
    ProValue := Load( f.Name );
    f.SetValue( Obj, ProValue );
  end;
end;

initialization
  LanguageInfo := TLanguageInfo.Create;
finalization
  LanguageInfo.Free;

end.
