unit UMobileBoxFace;

interface

uses UChangeInfo, VirtualTrees;

type

    // 数据结构
  TMobileBoxData = record
  public
    Path : WideString;
    IsFile : boolean;
    MainIcon : Integer;
  end;
  PMobileBoxData = ^TMobileBoxData;

    // 父类
  TMobileBoxChangeFace = class( TFaceChangeInfo )
  public
    VstMobileBox : TVirtualStringTree;
  protected
    procedure Update;override;
  end;

    // 修改
  TMobileBoxWriteFace = class( TMobileBoxChangeFace )
  public
    Path : string;
  protected
    MobileBoxNode : PVirtualNode;
    MobileBoxData : PMobileBoxData;
  public
    constructor Create( _Path : string );
  protected
    function FindMobileBoxNode : Boolean;
  end;

      // 添加
  TMobileBoxAddFace = class( TMobileBoxWriteFace )
  public
    IsFile : boolean;
  public
    procedure SetIsFile( _IsFile : boolean );
  protected
    procedure Update;override;
  end;

    // 删除
  TMobileBoxRemoveFace = class( TMobileBoxWriteFace )
  protected
    procedure Update;override;
  end;

implementation

uses UMainForm, UMyUtil, UIconUtil;

{ TMobileBoxChangeFace }

procedure TMobileBoxChangeFace.Update;
begin
  VstMobileBox := frmMainForm.VstMobileBox;
end;

{ TMobileBoxWriteFace }

constructor TMobileBoxWriteFace.Create( _Path : string );
begin
  Path := _Path;
end;


function TMobileBoxWriteFace.FindMobileBoxNode : Boolean;
var
  SelectNode : PVirtualNode;
  SelectData : PMobileBoxData;
begin
  Result := False;
  SelectNode := VstMobileBox.RootNode.FirstChild;
  while Assigned( SelectNode ) do
  begin
    SelectData := VstMobileBox.GetNodeData( SelectNode );
    if ( SelectData.Path = Path ) then
    begin
      Result := True;
      MobileBoxNode := SelectNode;
      MobileBoxData := SelectData;
      Break;
    end;
    SelectNode := SelectNode.NextSibling;
  end;
end;

{ TMobileBoxAddFace }

procedure TMobileBoxAddFace.SetIsFile( _IsFile : boolean );
begin
  IsFile := _IsFile;
end;

procedure TMobileBoxAddFace.Update;
begin
  inherited;

  if FindMobileBoxNode then
    Exit;

  MobileBoxNode := VstMobileBox.AddChild( VstMobileBox.RootNode );
  MobileBoxData := VstMobileBox.GetNodeData( MobileBoxNode );
  MobileBoxData.Path := Path;
  MobileBoxData.IsFile := IsFile;
  MobileBoxData.MainIcon := MyIcon.getIconByFilePath( Path );
end;

{ TMobileBoxRemoveFace }

procedure TMobileBoxRemoveFace.Update;
begin
  inherited;

  if not FindMobileBoxNode then
    Exit;

  VstMobileBox.DeleteNode( MobileBoxNode );
end;




end.
