unit UStorageApi;

interface

type

  StorageApi = class
  public
    class procedure Add( ItemID, ShowName : string );
  public
    class procedure AddMyComputer( ItemID, ShowName : string; ItemSize : Int64 );
    class procedure AddNetworkComputer( ItemID, ShowName : string; ItemSize : Int64 );
  end;

const
  ShowName_MyLocalBackups = 'My Local Backups';
  ShowName_NetworkBackups = '%s''s Backups';
  ShowName_NetworkComputers = 'on %s''s Computer';

implementation

uses UStorageFace, UMainApi;

{ StorageApi }

class procedure StorageApi.Add(ItemID, ShowName: string);
var
  VstStorageAddFace : TVstStorageAddFace;
begin
  VstStorageAddFace := TVstStorageAddFace.Create( ItemID );
  VstStorageAddFace.SetShowName( ShowName );
  VstStorageAddFace.AddChange;
end;

class procedure StorageApi.AddMyComputer(ItemID, ShowName: string; ItemSize : Int64);
var
  VstStorageChildAddFace : TVstStorageChildAddFace;
begin
  VstStorageChildAddFace := TVstStorageChildAddFace.Create( RootItemID_MyComputer );
  VstStorageChildAddFace.SetChildItemID( ItemID );
  VstStorageChildAddFace.SetShowName( ShowName );
  VstStorageChildAddFace.SetItemSize( ItemSize );
  VstStorageChildAddFace.AddChange;

  MyHintAppApi.ShowStorageBtn;
end;

class procedure StorageApi.AddNetworkComputer(ItemID, ShowName: string; ItemSize : Int64);
var
  VstStorageChildAddFace : TVstStorageChildAddFace;
begin
  VstStorageChildAddFace := TVstStorageChildAddFace.Create( RootItemID_NetworkComputer );
  VstStorageChildAddFace.SetChildItemID( ItemID );
  VstStorageChildAddFace.SetShowName( ShowName );
  VstStorageChildAddFace.SetItemSize( ItemSize );
  VstStorageChildAddFace.AddChange;

  MyHintAppApi.ShowStorageBtn;
end;

end.
