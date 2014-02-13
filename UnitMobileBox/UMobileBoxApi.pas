unit UMobileBoxApi;

interface

type

    // 修改
  TMobileBoxWriteHandle = class
  public
    Path : string;
  public
    constructor Create( _Path : string );
  end;

    // 读取
  TMobileBoxReadHandle = class( TMobileBoxWriteHandle )
  public
    IsFile : boolean;
  public
    procedure SetIsFile( _IsFile : boolean );
    procedure Update;virtual;
  private
    procedure AddToInfo;
    procedure AddToFace;
  end;

    // 添加
  TMobileBoxAddHandle = class( TMobileBoxReadHandle )
  public
    procedure Update;override;
  private
    procedure AddToXml;
  end;

    // 删除
  TMobileBoxRemoveHandle = class( TMobileBoxWriteHandle )
  protected
    procedure Update;
  private
    procedure RemoveFromInfo;
    procedure RemoveFromFace;
    procedure RemoveFromXml;
  end;

    // 调用接口
  MobileBoxApi = class
  public
    class procedure AddItem( Path : string; IsFile : Boolean );
    class procedure RemoveItem( Path : string );
  end;

implementation

uses UMobileBoxInfo, UMobileBoxXml, UMobileBoxFace, UMyCloudApiInfo;

constructor TMobileBoxWriteHandle.Create( _Path : string );
begin
  Path := _Path;
end;

{ TMobileBoxReadHandle }

procedure TMobileBoxReadHandle.SetIsFile( _IsFile : boolean );
begin
  IsFile := _IsFile;
end;

procedure TMobileBoxReadHandle.AddToInfo;
var
  MobileBoxAddInfo : TMobileBoxAddInfo;
begin
  MobileBoxAddInfo := TMobileBoxAddInfo.Create( Path );
  MobileBoxAddInfo.SetIsFile( IsFile );
  MobileBoxAddInfo.Update;
  MobileBoxAddInfo.Free;
end;

procedure TMobileBoxReadHandle.AddToFace;
var
  MobileBoxAddFace : TMobileBoxAddFace;
begin
  MobileBoxAddFace := TMobileBoxAddFace.Create( Path );
  MobileBoxAddFace.SetIsFile( IsFile );
  MobileBoxAddFace.AddChange;
end;

procedure TMobileBoxReadHandle.Update;
begin
  AddToInfo;
  AddToFace;

  MoblieBox_IsExist := True;
end;

{ TMobileBoxAddHandle }

procedure TMobileBoxAddHandle.AddToXml;
var
  MobileBoxAddXml : TMobileBoxAddXml;
begin
  MobileBoxAddXml := TMobileBoxAddXml.Create( Path );
  MobileBoxAddXml.SetIsFile( IsFile );
  MobileBoxAddXml.AddChange;
end;

procedure TMobileBoxAddHandle.Update;
begin
  inherited;
  AddToXml;
end;

{ TMobileBoxRemoveHandle }

procedure TMobileBoxRemoveHandle.RemoveFromInfo;
var
  MobileBoxRemoveInfo : TMobileBoxRemoveInfo;
begin
  MobileBoxRemoveInfo := TMobileBoxRemoveInfo.Create( Path );
  MobileBoxRemoveInfo.Update;
  MobileBoxRemoveInfo.Free;
end;

procedure TMobileBoxRemoveHandle.RemoveFromFace;
var
  MobileBoxRemoveFace : TMobileBoxRemoveFace;
begin
  MobileBoxRemoveFace := TMobileBoxRemoveFace.Create( Path );
  MobileBoxRemoveFace.AddChange;
end;

procedure TMobileBoxRemoveHandle.RemoveFromXml;
var
  MobileBoxRemoveXml : TMobileBoxRemoveXml;
begin
  MobileBoxRemoveXml := TMobileBoxRemoveXml.Create( Path );
  MobileBoxRemoveXml.AddChange;
end;

procedure TMobileBoxRemoveHandle.Update;
begin
  RemoveFromInfo;
  RemoveFromFace;
  RemoveFromXml;
end;

{ MobileBoxApi }

class procedure MobileBoxApi.AddItem(Path: string; IsFile: Boolean);
var
  MobileBoxAddHandle : TMobileBoxAddHandle;
begin
  MobileBoxAddHandle := TMobileBoxAddHandle.Create( Path );
  MobileBoxAddHandle.SetIsFile( IsFile );
  MobileBoxAddHandle.Update;
  MobileBoxAddHandle.Free;
end;

class procedure MobileBoxApi.RemoveItem(Path: string);
var
  MobileBoxRemoveHandle : TMobileBoxRemoveHandle;
begin
  MobileBoxRemoveHandle := TMobileBoxRemoveHandle.Create( Path );
  MobileBoxRemoveHandle.Update;
  MobileBoxRemoveHandle.Free;
end;



end.
