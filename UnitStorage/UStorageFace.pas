unit UStorageFace;

interface

uses UChangeInfo, VirtualTrees;

type

{$Region ' 添加父节点 ' }

  TVstStorageData = record
  public
    ItemID : WideString;
    ItemSize : Int64;
    ItemPath : WideString;
  public
    ShowName : WideString;
    ShowIcon : Integer;
  end;
  PVstStorageData = ^TVstStorageData;

  TVstStorageChangeFace = class( TFaceChangeInfo )
  protected
    vstStorage : TVirtualStringTree;
  protected
    procedure Update;override;
  end;

  TVstStorageWriteFace = class( TVstStorageChangeFace )
  protected
    ItemID : string;
  protected
    StorageNode : PVirtualNode;
    StorageData : PVstStorageData;
  public
    constructor Create( _ItemID : string );
  protected
    function FindStorageNode : Boolean;
  end;

  TVstStorageAddFace = class( TVstStorageWriteFace )
  private
    ShowName : string;
  public
    procedure SetShowName( _ShowName : string );
  protected
    procedure Update;override;
  end;

  TVstStorageRemoveFace = class( TVstStorageWriteFace )
  protected
    procedure Update;override;
  end;

{$EndRegion}

{$Region ' 添加子节点 ' }

  TVstStorageChildWriteFace = class( TVstStorageWriteFace )
  protected
    ChildItemID : string;
    ChildStorageNode : PVirtualNode;
    ChildStorageData : PVstStorageData;
  public
    procedure SetChildItemID( _ChildItemID : string );
  protected
    function FindChildStorageNode : Boolean;
  end;

  TVstStorageChildAddFace = class( TVstStorageChildWriteFace )
  private
    ShowName : string;
    ItemSize : Int64;
  public
    procedure SetShowName( _ShowName : string );
    procedure SetItemSize( _ItemSize : Int64 );
  protected
    procedure Update;override;
  end;

  TVstStorageChildRemoveFace = class( TVstStorageChildWriteFace )
  protected
    procedure Update;override;
  end;

{$EndRegion}

const
  RootItemID_MyComputer = 'MyComputer';
  RootItemID_NetworkComputer = 'NetworkComputer';

  StorageIcon_MyComputer = 9;
  StorageIcon_NetworkComputer = 5;

implementation

uses UMainForm, UIconUtil;

{ TVstStorageChangeFace }

procedure TVstStorageChangeFace.Update;
begin
  vstStorage := frmMainForm.vstStorage;
end;

{ TVstStorageWriteFace }

constructor TVstStorageWriteFace.Create(_ItemID: string);
begin
  ItemID := _ItemID;
end;

function TVstStorageWriteFace.FindStorageNode: Boolean;
var
  SelectNode : PVirtualNode;
  SelectData : PVstStorageData;
begin
  Result := False;
  SelectNode := vstStorage.RootNode.FirstChild;
  while Assigned( SelectNode ) do
  begin
    SelectData := vstStorage.GetNodeData( SelectNode );
    if SelectData.ItemID = ItemID then
    begin
      Result := True;
      StorageNode := SelectNode;
      StorageData := SelectData;
      Break;
    end;
    SelectNode := SelectNode.NextSibling;
  end;
end;

{ TVstStorageAddFace }

procedure TVstStorageAddFace.SetShowName(_ShowName: string);
begin
  ShowName := _ShowName;
end;

procedure TVstStorageAddFace.Update;
begin
  inherited;
  if FindStorageNode then
    Exit;
  StorageNode := vstStorage.AddChild( vstStorage.RootNode );
  StorageNode.NodeHeight := 30;
  StorageData := vstStorage.GetNodeData( StorageNode );
  StorageData.ItemID := ItemID;
  StorageData.ItemSize := -1;
  StorageData.ShowName := ShowName;
  if ItemID = RootItemID_MyComputer then
    StorageData.ShowIcon := StorageIcon_MyComputer
  else
    StorageData.ShowIcon := StorageIcon_NetworkComputer;
end;

{ TVstStorageRemoveFace }

procedure TVstStorageRemoveFace.Update;
begin
  inherited;
  if not FindStorageNode then
    Exit;
  vstStorage.DeleteNode( StorageNode );
end;

{ TVstStorageChildWriteFace }

function TVstStorageChildWriteFace.FindChildStorageNode: Boolean;
var
  SelectNode : PVirtualNode;
  SelectData : PVstStorageData;
begin
  Result := False;
  if not FindStorageNode then
    Exit;
  SelectNode := StorageNode.FirstChild;
  while Assigned( SelectNode ) do
  begin
    SelectData := vstStorage.GetNodeData( SelectNode );
    if SelectData.ItemID = ChildItemID then
    begin
      Result := True;
      ChildStorageNode := SelectNode;
      ChildStorageData := SelectData;
      Break;
    end;
    SelectNode := SelectNode.NextSibling;
  end;
end;

procedure TVstStorageChildWriteFace.SetChildItemID(_ChildItemID: string);
begin
  ChildItemID := _ChildItemID;
end;

{ TVstStorageChildAddFace }

procedure TVstStorageChildAddFace.SetItemSize(_ItemSize: Int64);
begin
  ItemSize := _ItemSize;
end;

procedure TVstStorageChildAddFace.SetShowName(_ShowName: string);
begin
  ShowName := _ShowName;
end;

procedure TVstStorageChildAddFace.Update;
begin
  inherited;
  if FindChildStorageNode then
    Exit;
  ChildStorageNode := vstStorage.AddChild( StorageNode );
  ChildStorageNode.NodeHeight := 20;
  ChildStorageData := vstStorage.GetNodeData( ChildStorageNode );
  ChildStorageData.ItemID := ChildItemID;
  ChildStorageData.ItemSize := ItemSize;
  ChildStorageData.ItemPath := ChildItemID;
  ChildStorageData.ShowName := ShowName;
  if ItemID = RootItemID_MyComputer then
    ChildStorageData.ShowIcon := MyIcon.getIconByFilePath( ChildItemID )
  else
    ChildStorageData.ShowIcon := MyShellTransActionIconUtil.getNetworkPc;
  vstStorage.Expanded[ StorageNode ] := True;
end;


{ TVstStorageChildRemoveFace }

procedure TVstStorageChildRemoveFace.Update;
begin
  inherited;
  if not FindChildStorageNode then
    Exit;
  vstStorage.DeleteNode( ChildStorageNode );
end;

end.
