unit UMobileBoxInfo;

interface

uses Generics.Collections, UDataSetInfo, classes;

type

{$Region ' ���ݽṹ ' }

    // ���ݽṹ
  TMobileBoxInfo = class
  public
    Path : string;
  public
    IsFile : boolean;
  public
    constructor Create( _Path : string );
    procedure SetIsFile( _IsFile : boolean );
  end;
  TMobileBoxList = class( TObjectList<TMobileBoxInfo> )end;

  TMyMobileBox = class( TMyDataInfo )
  public
    MobileBoxList : TMobileBoxList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{$EndRegion}

{$Region ' ���ݷ��� ' }

    // ���� ���� List �ӿ�
  TMobileBoxListAccessInfo = class
  protected
    MobileBoxList : TMobileBoxList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // ���� ���ݽӿ�
  TMobileBoxAccessInfo = class( TMobileBoxListAccessInfo )
  public
    Path : string;
  protected
    MobileBoxIndex : Integer;
    MobileBoxInfo : TMobileBoxInfo;
  public
    constructor Create( _Path : string );
  protected
    function FindMobileBoxInfo: Boolean;
  end;

    // �޸ĸ���
  TMobileBoxWriteInfo = class( TMobileBoxAccessInfo )
  end;

    // ��ȡ����
  TMobileBoxReadInfo = class( TMobileBoxAccessInfo )
  end;

{$EndRegion}

{$Region ' �����޸� ' }

    // ���
  TMobileBoxAddInfo = class( TMobileBoxWriteInfo )
  public
    IsFile : boolean;
  public
    procedure SetIsFile( _IsFile : boolean );
    procedure Update;
  end;

    // ɾ��
  TMobileBoxRemoveInfo = class( TMobileBoxWriteInfo )
  public
    procedure Update;
  end;

{$EndRegion}

{$Region ' ���ݶ�ȡ ' }

  TMobileBoxReadPathList = class( TMobileBoxListAccessInfo )
  public
    function get : TStringList;
  end;

  MobileBoxReadUtil = class
  public
    class function ReadPathList : TStringList;
  end;

{$EndRegion}

var
  MyMobileBox : TMyMobileBox;


implementation

{ TMobileBoxInfo }

constructor TMobileBoxInfo.Create( _Path : string );
begin
  Path := _Path;
end;

procedure TMobileBoxInfo.SetIsFile( _IsFile : boolean );
begin
  IsFile := _IsFile;
end;

{ TMyMobileBox }

constructor TMyMobileBox.Create;
begin
  inherited;
  MobileBoxList := TMobileBoxList.Create;
end;

destructor TMyMobileBox.Destroy;
begin
  MobileBoxList.free;
  inherited;
end;

{ TMobileBoxListAccessInfo }

constructor TMobileBoxListAccessInfo.Create;
begin
  MyMobileBox.EnterData;
  MobileBoxList := MyMobileBox.MobileBoxList;
end;

destructor TMobileBoxListAccessInfo.Destroy;
begin
  MyMobileBox.LeaveData;
  inherited;
end;

{ TMobileBoxAccessInfo }

constructor TMobileBoxAccessInfo.Create( _Path : string );
begin
  inherited Create;
  Path := _Path;
end;

function TMobileBoxAccessInfo.FindMobileBoxInfo: Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to MobileBoxList.Count - 1 do
    if ( MobileBoxList[i].Path = Path ) then
    begin
      Result := True;
      MobileBoxIndex := i;
      MobileBoxInfo := MobileBoxList[i];
      break;
    end;
end;

{ TMobileBoxAddInfo }

procedure TMobileBoxAddInfo.SetIsFile( _IsFile : boolean );
begin
  IsFile := _IsFile;
end;

procedure TMobileBoxAddInfo.Update;
begin
  if FindMobileBoxInfo then
    Exit;

  MobileBoxInfo := TMobileBoxInfo.Create( Path );
  MobileBoxInfo.SetIsFile( IsFile );
  MobileBoxList.Add( MobileBoxInfo );
end;

{ TMobileBoxRemoveInfo }

procedure TMobileBoxRemoveInfo.Update;
begin
  if not FindMobileBoxInfo then
    Exit;

  MobileBoxList.Delete( MobileBoxIndex );
end;





{ MobileBoxReadUtil }

class function MobileBoxReadUtil.ReadPathList: TStringList;
var
  MobileBoxReadPathList : TMobileBoxReadPathList;
begin
  MobileBoxReadPathList := TMobileBoxReadPathList.Create;
  Result := MobileBoxReadPathList.get;
  MobileBoxReadPathList.Free;
end;

{ TMobileBoxReadPathList }

function TMobileBoxReadPathList.get: TStringList;
var
  i : Integer;
begin
  Result := TStringList.Create;
  for i := 0 to MobileBoxList.Count - 1 do
    Result.Add( MobileBoxList[i].Path );
end;

end.
