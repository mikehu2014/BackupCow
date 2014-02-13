unit UMobileBoxXml;

interface

uses UChangeInfo, xmldom, XMLIntf, msxmldom, XMLDoc, UXmlUtil;

type

    // 父类
  TMobileBoxChangeXml = class( TXmlChangeInfo )
  protected
    MyMobileBox : IXMLNode;
    MobileBoxNodeList : IXMLNode;
  protected
    procedure Update;override;
  end;

    // 修改
  TMobileBoxWriteXml = class( TMobileBoxChangeXml )
  public
    Path : string;
  protected
    MobileBoxIndex : Integer;
    MobileBoxNode : IXMLNode;
  public
    constructor Create( _Path : string );
  protected
    function FindMobileBoxNode: Boolean;
  end;

      // 添加
  TMobileBoxAddXml = class( TMobileBoxWriteXml )
  public
    IsFile : boolean;
  public
    procedure SetIsFile( _IsFile : boolean );
  protected
    procedure Update;override;
  end;

    // 删除
  TMobileBoxRemoveXml = class( TMobileBoxWriteXml )
  protected
    procedure Update;override;
  end;

    // 读取
  TMobileBoxReadXml = class
  public
    MobileBoxNode : IXMLNode;
  public
    constructor Create( _MobileBoxNode : IXMLNode );
    procedure Update;
  end;

    // 启动读取器
  TMoblieBoxXmlReader = class
  public
    procedure Update;
  end;

const
    Xml_MyMobileBox = 'mmb';
    Xml_MobileBoxList = 'mbl';
    Xml_Path = 'p';
    Xml_IsFile = 'if';

implementation

uses UMobileBoxApi;

{ TMobileBoxChangeXml }

procedure TMobileBoxChangeXml.Update;
begin
  MyMobileBox := MyXmlUtil.AddChild( MyXmlDoc.DocumentElement, Xml_MyMobileBox );
  MobileBoxNodeList := MyXmlUtil.AddChild( MyMobileBox, Xml_MobileBoxList );
end;

{ TMobileBoxWriteXml }

constructor TMobileBoxWriteXml.Create( _Path : string );
begin
  Path := _Path;
end;


function TMobileBoxWriteXml.FindMobileBoxNode: Boolean;
var
  i : Integer;
  SelectNode : IXMLNode;
begin
  Result := False;
  for i := 0 to MobileBoxNodeList.ChildNodes.Count - 1 do
  begin
    SelectNode := MobileBoxNodeList.ChildNodes[i];
    if ( MyXmlUtil.GetChildValue( SelectNode, Xml_Path ) = Path ) then
    begin
      Result := True;
      MobileBoxIndex := i;
      MobileBoxNode := MobileBoxNodeList.ChildNodes[i];
      break;
    end;
  end;
end;

{ TMobileBoxAddXml }

procedure TMobileBoxAddXml.SetIsFile( _IsFile : boolean );
begin
  IsFile := _IsFile;
end;

procedure TMobileBoxAddXml.Update;
begin
  inherited;

  if FindMobileBoxNode then
    Exit;

  MobileBoxNode := MyXmlUtil.AddListChild( MobileBoxNodeList );
  MyXmlUtil.AddChild( MobileBoxNode, Xml_Path, Path );
  MyXmlUtil.AddChild( MobileBoxNode, Xml_IsFile, IsFile );
end;

{ TMobileBoxRemoveXml }

procedure TMobileBoxRemoveXml.Update;
begin
  inherited;

  if not FindMobileBoxNode then
    Exit;

  MyXmlUtil.DeleteListChild( MobileBoxNodeList, MobileBoxIndex );
end;

{ MobileBoxNode }

constructor TMobileBoxReadXml.Create( _MobileBoxNode : IXMLNode );
begin
  MobileBoxNode := _MobileBoxNode;
end;

procedure TMobileBoxReadXml.Update;
var
  Path : string;
  IsFile : boolean;
  MobileBoxReadHandle : TMobileBoxReadHandle;
begin
  Path := MyXmlUtil.GetChildValue( MobileBoxNode, Xml_Path );
  IsFile := MyXmlUtil.GetChildBoolValue( MobileBoxNode, Xml_IsFile );

  MobileBoxReadHandle := TMobileBoxReadHandle.Create( Path );
  MobileBoxReadHandle.SetIsFile( IsFile );
  MobileBoxReadHandle.Update;
  MobileBoxReadHandle.Free;
end;



{ TMoblieBoxXmlReader }

procedure TMoblieBoxXmlReader.Update;
var
  MyMobileBox, MobileBoxNodeList : IXMLNode;
  i : Integer;
  MobileBoxNode : IXMLNode;
  MobileBoxReadXml : TMobileBoxReadXml;
begin
  MyMobileBox := MyXmlUtil.AddChild( MyXmlDoc.DocumentElement, Xml_MyMobileBox );
  MobileBoxNodeList := MyXmlUtil.AddChild( MyMobileBox, Xml_MobileBoxList );
  for i := 0 to MobileBoxNodeList.ChildNodes.Count - 1 do
  begin
    MobileBoxNode := MobileBoxNodeList.ChildNodes[i];
    MobileBoxReadXml := TMobileBoxReadXml.Create( MobileBoxNode );
    MobileBoxReadXml.Update;
    MobileBoxReadXml.Free;
  end;
end;



end.
