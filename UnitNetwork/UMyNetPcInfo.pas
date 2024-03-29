unit UMyNetPcInfo;

interface

uses UChangeInfo, Generics.Collections, SyncObjs, SysUtils, UModelUtil, UMyUtil, Math,
     uDebug, DateUtils, UDataSetInfo, classes;

type

{$Region ' Master信息, 数据结构 ' }

  TMasterInfoAddParams = record
  public
    PcID : string;
    ClientCount : Integer; // 客户端数
    StartTime : TDateTime;  // 程序运行开始时间
    RanNum : Integer;   // 随机数
  end;

  TMasterInfo = class
  public
    MaxLock : TCriticalSection;
    MaxPcID : string;
    MaxClientCount : Integer;
    MaxStartTime : TDateTime;
    MaxRanNum : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ResetMasterPc;
    procedure AddItem( Params : TMasterInfoAddParams );
  end;

{$EndRegion}


{$Region ' 网络模式 数据结构 ' }

    // Group 网络信息
  TNetworkGroupInfo = class
  public
    GroupName : string;
    Password : string;
  public
    constructor Create( _GroupName : string );
    procedure SetPassword( _Password : string );
  end;
  TNetworkGroupList = class( TObjectList< TNetworkGroupInfo > )end;

    // ConnPc 网络信息
  TNetworkPcConnInfo = class
  public
    Domain : string;
    Port : string;
  public
    constructor Create( _Domain, _Port : string );
  end;
  TNetworkPcConnList = class( TObjectList< TNetworkPcConnInfo > )end;

    // 网络连接信息
  TMyNetworkConnInfo = class( TMyDataInfo )
  public  // 远程网络连接
    NetworkGroupList : TNetworkGroupList;
    NetworkPcConnList : TNetworkPcConnList;
  public  // 选择的网络类型与值
    SelectType : string;
    SelectValue1, SelectValue2 : string;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{$EndRegion}

{$Region ' 网络模式 数据接口 ' }

    // 访问 数据 List 接口
  TNetworkGroupListAccessInfo = class
  protected
    NetworkGroupList : TNetworkGroupList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // 访问 数据接口
  TNetworkGroupAccessInfo = class( TNetworkGroupListAccessInfo )
  public
    GroupName : string;
  protected
    NetworkGroupIndex : Integer;
    NetworkGroupInfo : TNetworkGroupInfo;
  public
    constructor Create( _GroupName : string );
  protected
    function FindNetworkGroupInfo: Boolean;
  end;

    // 访问 数据 List 接口
  TNetworkPcConnListAccessInfo = class
  protected
    NetworkPcConnList : TNetworkPcConnList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // 访问 数据接口
  TNetworkPcConnAccessInfo = class( TNetworkPcConnListAccessInfo )
  public
    Domain, Port : string;
  protected
    NetworkPcConnIndex : Integer;
    NetworkPcConnInfo : TNetworkPcConnInfo;
  public
    constructor Create( _Domain, _Port : string );
  protected
    function FindNetworkPcConnInfo: Boolean;
  end;

{$EndRegion }

{$Region ' 网络模式 Group 数据修改 ' }

    // 修改父类
  TNetworkGroupWriteInfo = class( TNetworkGroupAccessInfo )
  end;

    // 添加
  TNetworkGroupAddInfo = class( TNetworkGroupWriteInfo )
  public
    Password : string;
  public
    procedure SetPassword( _Password : string );
    procedure Update;
  end;

    // 修改
  TNetworkGroupSetPasswordInfo = class( TNetworkGroupWriteInfo )
  public
    Password : string;
  public
    procedure SetPassword( _Password : string );
    procedure Update;
  end;


    // 删除
  TNetworkGroupRemoveInfo = class( TNetworkGroupWriteInfo )
  public
    procedure Update;
  end;



{$EndRegion}

{$Region ' 网络模式 ConnPc 数据修改 ' }

    // 修改父类
  TNetworkPcConnWriteInfo = class( TNetworkPcConnAccessInfo )
  end;


    // 添加
  TNetworkPcConnAddInfo = class( TNetworkPcConnWriteInfo )
  public
    procedure Update;
  end;

    // 删除
  TNetworkPcConnRemoveInfo = class( TNetworkPcConnWriteInfo )
  public
    procedure Update;
  end;

{$EndRegion}

{$Region ' 网络模式 Group 数据读取 ' }

    // 读取父类
  TNetworkGroupReadInfo = class( TNetworkGroupAccessInfo )
  end;

    // 读取 组是否存在
  TNetworkGroupReadIsExist = class( TNetworkGroupReadInfo )
  public
    function get : Boolean;
  end;

    // 读取 密码
  TNetworkGroupReadPassword = class( TNetworkGroupReadInfo )
  public
    function get : string;
  end;

    // 网络 组信息 读取
  NetworkGroupInfoReadUtil = class
  public
    class function ReadIsExist( Group : string ): Boolean;
    class function ReadPassword( Group : string ): string;
  end;

{$EndRegion}

{$Region ' 网络模式 ConnToPc 数据读取 ' }

    // 读取父类
  TNetworkPcConnReadInfo = class( TNetworkPcConnAccessInfo )
  end;


    // 读取 组是否存在
  TNetworkPcConnReadIsExist = class( TNetworkPcConnReadInfo )
  public
    function get : Boolean;
  end;

    // 网络 组信息 读取
  NetworkConnToPcInfoReadUtil = class
  public
    class function ReadIsExist( Ip, Port : string ): Boolean;
  end;

{$EndRegion}


{$Region ' 本机信息 数据结构 ' }

    // 本机的 Pc 信息
  TPcInfo = class
  public
    PcID, PcName : string;
    PcHardCode : string;
  public
    LanIp, LanPort : string;
    InternetIp, InternetPort : string;
    RealLanIp : string;
  public
    StartTime : TDateTime;
    RanNum : Integer;
  public
    procedure SetPcInfo( _PcID, _PcName : string );
    procedure SetPcHardCode( _PcHardCode : string );
    procedure SetLanInfo( _LanIp, _LanPort : string );
    procedure SetInternetInfo( _InternetIp, _InternetPort : string );
    procedure SetSortInfo( _StartTime : TDateTime; _RanNum : Integer );
  end;


{$EndRegion}


{$Region ' 网络Pc 数据结构 ' }

    // 网络 Pc 信息
  TNetPcInfo = class
  public
    PcID, PcName : string;
    Ip, Port : string;
    DeviceType : string;
    IsLanConn, IsConnect : Boolean; // 是否局域网连接， 是否连接过，未连接需连接确认
    CanConnectTo, CanConnectFrom : Boolean; // 是否可以连接
  public
    IsActivate, IsOnline, IsServer : Boolean;
  public
    constructor Create( _PcID : string );
    procedure SetPcName( _PcName : string );
    procedure SetSocketInfo( _Ip, _Port : string );
    destructor Destroy; override;
  end;
  TNetPcInfoPair = TPair< string , TNetPcInfo >;
  TNetPcInfoHash = class( TStringDictionary< TNetPcInfo > );

{$EndRegion}

{$Region ' 网络Pc 数据接口 ' }

    // 访问 集合
  TNetPcAccessInfo = class
  protected
    NetPcInfoHash : TNetPcInfoHash;
  public
    constructor Create;
    destructor Destroy; override;
  end;

    // 访问 Item
  TNetPcItemAccessInfo = class( TNetPcAccessInfo )
  public
    PcID : string;
  protected
    NetPcInfo : TNetPcInfo;
  public
    constructor Create( _PcID : string );
  protected
    function FindNetPcInfo: Boolean;
  end;

{$EndRegion}

{$Region ' 网络Pc 数据修改 ' }

    // 修改
  TNetPcWriteInfo = class( TNetPcItemAccessInfo )
  end;

  {$Region ' 增删信息 ' }

      // 增加 Pc
  TNetPcAddInfo = class( TNetPcWriteInfo )
  public
    PcName : string;
  public
    procedure SetPcName( _PcName : string );
    procedure Update;
  end;

    // 删除 Pc
  TNetPcRemoveInfo = class( TNetPcWriteInfo )
  public
    procedure Update;
  end;

  {$EndRegion}

  {$Region ' 位置信息 ' }

    // 修改 Socket
  TNetPcSocketInfo = class( TNetPcWriteInfo )
  private
    Ip, Port : string;
    IsLanConn : Boolean;
  public
    procedure SetSocket( _Ip, _Port : string );
    procedure SetIsLanConn( _IsLanConn : Boolean );
    procedure Update;
  end;

      // 是否可连接该 Pc
  TNetPcSetCanConnectToInfo = class( TNetPcWriteInfo )
  private
    CanConnectTo : Boolean;
  public
    procedure SetCanConnectTo( _CanConnectTo : Boolean );
    procedure Update;
  end;

    // 是否可被该 Pc 连接
  TNetPcSetCanConnectFromInfo = class( TNetPcWriteInfo )
  private
    CanConnectFrom : Boolean;
  public
    procedure SetCanConnectFrom( _CanConnectFrom : Boolean );
    procedure Update;
  end;

  {$EndRegion}

  {$Region ' 状态信息 ' }

    // 修改 Online
  TNetPcOnlineInfo = class( TNetPcWriteInfo )
  public
    procedure Update;
  end;

    // 修改 Offline
  TNetPcOfflineInfo = class( TNetPcWriteInfo )
  public
    procedure Update;
  end;

    // 修改 Server
  TNetPcServerInfo = class( TNetPcWriteInfo )
  public
    procedure Update;
  end;


    // 设置Pc的设备类型
  TNetPcSetDeviceTypeInfo = class( TNetPcWriteInfo )
  private
    DeviceType : string;
  public
    procedure SetDeviceType( _DeviceType : string );
    procedure Update;
  end;

  {$EndRegion}

{$EndRegion}

{$Region ' 网络Pc 数据读取 ' }

    // 读取信息 父类
  TNetPcReadInfo = class( TNetPcAccessInfo )
  end;

    // 在线的 Pc 数目
  TNetPcReadOnlineCount = class( TNetPcReadInfo )
  public
    function get : Integer;
  end;

    // Ip 读 是否 Ios
  TNetPcReadIsIosByIp = class( TNetPcReadInfo )
  private
    Ip : string;
  public
    procedure SetIp( _Ip : string );
    function get : Boolean;
  end;

    // 读取
  TNetPcReadPcNameByIp = class( TNetPcReadInfo )
  private
    Ip : string;
  public
    procedure SetIp( _Ip : string );
    function get : string;
  end;

    // 读取 Item 父类
  TNetPcItemReadInfo = class( TNetPcItemAccessInfo )
  end;

    // 读取 Pc 名
  TNetPcItemReadName = class( TNetPcItemAccessInfo )
  public
    function get : string;
  end;

    // 读取 Ip
  TNetPcItemReadIp = class( TNetPcItemAccessInfo )
  public
    function get : string;
  end;

    // 读取 Port
  TNetPcItemReadPort = class( TNetPcItemAccessInfo )
  public
    function get : string;
  end;

    // 读取 是否上线
  TNetPcItemReadIsOnline = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

      // 读取 是否已经连接过
  TNetPcReadIsConnect = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

    // 读取 是否 可以连接
  TNetPcReadIsCanConnectTo = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;


      // 读取 是否 可以被连接
  TNetPcReadIsCanConnectFrom = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

      // 读取 是否 局域网连接
  TNetPcReadIsLanPc = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

    // 读取 Pc 可用空间
  TNetPcItemReadAvailableSpace = class( TNetPcItemAccessInfo )
  public
    function get : Int64;
  end;

      // 读取正在活动的 Pc 列表
  TNetPcReadActivateList = class( TNetPcAccessInfo )
  public
    function get : TStringList;
  end;

        // 读取正在活动的 Pc 列表
  TNetPcReadIosList = class( TNetPcAccessInfo )
  public
    function get : TStringList;
  end;

    // 读取 Pc 总数
  TNetPcReadCount = class( TNetPcAccessInfo )
  public
    function get : Integer;
  end;

    // 读取 是否移动
  TNetPcReadIsIos = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

    // 读取 是否移动
  TNetPcReadIsMac = class( TNetPcItemAccessInfo )
  public
    function get : Boolean;
  end;

    // 读取 辅助类
  MyNetPcInfoReadUtil = class
  public
    class function ReadName( PcID : string ): string;
    class function ReadIp( PcID : string ): string;
    class function ReadPort( PcID : string ): string;
    class function ReadIsOnline( PcID : string ): Boolean;
    class function ReadIsConnect( PcID : string ): Boolean;
    class function ReadIsCanConnectTo( PcID : string ): Boolean;
    class function ReadIsCanConnectFrom( PcID : string ): Boolean;
    class function ReadPcNameByIp( Ip : string ): string;
    class function ReadIsLanPc( PcID : string ): Boolean;
    class function ReadIsIos( PcID : string ): Boolean;
    class function ReadIsIosByIp( Ip : string ): Boolean;
    class function ReadIsMac( PcID : string ): Boolean;
  public
    class function ReadDesItemShow( DesItemID : string ): string;
    class function ReadDesIsOnline( DesItemID : string ): Boolean;
    class function ReadActivatePcList : TStringList;
    class function ReadPcCount : Integer;
    class function ReadIosList : TStringList;
  end;

{$EndREgion}


    // 网络 Pc 信息 集合
  TMyNetPcInfo = class( TMyDataInfo )
  public
    NetPcInfoHash : TNetPcInfoHash; // 网络 Pc 信息
  public
    constructor Create;
    destructor Destroy; override;
  end;

const
  NetworkMode_LAN : string = 'LAN';  // 局域网
  NetworkMode_Standard : string = 'Standard';  // 公司网
  NetworkMode_Advance : string = 'Advance';  // Internet

  BackupPriority_Alway = 'Alway';
  BackupPriority_Never = 'Nerver';
  BackupPriority_High = 'High';
  BackupPriority_Normal = 'Normal';
  BackupPriority_Low = 'Low';

var   // 初始化 信息
  Time_LastOnlineBackup : TDateTime = 0;

var
  PcInfo : TPcInfo;
  MasterInfo : TMasterInfo;
  MyNetPcInfo : TMyNetPcInfo;
  MyNetworkConnInfo : TMyNetworkConnInfo;

implementation

uses UNetworkFace, USearchServer, USettingInfo, UNetworkControl;

{ TNetPcInfo }

constructor TNetPcInfo.Create( _PcID : string );
begin
  IsOnline := False;
  IsServer := False;
  IsActivate := False;
  IsConnect := False;
  CanConnectTo := True;
  CanConnectFrom := True;
  PcID := _PcID;
end;

destructor TNetPcInfo.Destroy;
begin
  inherited;
end;

procedure TNetPcInfo.SetPcName(_PcName: string);
begin
  PcName := _PcName;
end;

procedure TNetPcInfo.SetSocketInfo(_Ip, _Port: string);
begin
  Ip := _Ip;
  Port := _Port;
end;


{ TMySearchServerInfo }

constructor TMyNetPcInfo.Create;
begin
  inherited;
  NetPcInfoHash := TNetPcInfoHash.Create;
end;

destructor TMyNetPcInfo.Destroy;
begin
  NetPcInfoHash.Free;
  inherited;
end;


{ TSearchPcAddInfo }

procedure TNetPcAddInfo.SetPcName(_PcName: string);
begin
  PcName := _PcName;
end;

{ TNetPcOnlineInfo }

procedure TNetPcOnlineInfo.Update;
begin
    // 不存在
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.IsOnline := True;
end;

{ TNetPcServerInfo }

procedure TNetPcServerInfo.Update;
begin
    // 不存在
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.IsServer := True;
end;

{ TNetPcSocketInfo }

procedure TNetPcSocketInfo.SetIsLanConn(_IsLanConn: Boolean);
begin
  IsLanConn := _IsLanConn;
end;

procedure TNetPcSocketInfo.SetSocket(_Ip, _Port: string);
begin
  Ip := _Ip;
  Port := _Port;
end;

procedure TNetPcSocketInfo.Update;
begin
      // 不存在
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.SetSocketInfo( Ip, Port );
  NetPcInfo.IsLanConn := IsLanConn;
  NetPcInfo.IsConnect := True; // 已连接过
end;

{ TNetPcRemoveInfo }

procedure TNetPcRemoveInfo.Update;
begin
    // 不存在
  if not FindNetPcInfo then
    Exit;

  NetPcInfoHash.Remove( PcID );
end;

procedure TNetPcAddInfo.Update;
begin
    // 不存在则创建
  if not FindNetPcInfo then
  begin
    NetPcInfo := TNetPcInfo.Create( PcID );
    NetPcInfoHash.AddOrSetValue( PcID, NetPcInfo );
  end;
  NetPcInfo.PcName := PcName;  // 改名
  NetPcInfo.IsActivate := True; // 激活Pc
end;



{ TNetPcOfflineInfo }

procedure TNetPcOfflineInfo.Update;
begin
    // 不存在
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.IsOnline := False;
  NetPcInfo.IsServer := False;
  NetPcInfo.IsActivate := False;
  NetPcInfo.IsConnect := False;
  NetPcInfo.CanConnectTo := True;
  NetPcInfo.CanConnectFrom := True;
end;

{ TNetPcAccessInfo }

constructor TNetPcAccessInfo.Create;
begin
  MyNetPcInfo.EnterData;
  NetPcInfoHash := MyNetPcInfo.NetPcInfoHash;
end;

destructor TNetPcAccessInfo.Destroy;
begin
  MyNetPcInfo.LeaveData;
  inherited;
end;

{ TNetPcItemAccessInfo }

constructor TNetPcItemAccessInfo.Create(_PcID: string);
begin
  inherited Create;
  PcID := _PcID;
end;

function TNetPcItemAccessInfo.FindNetPcInfo: Boolean;
begin
  Result := NetPcInfoHash.ContainsKey( PcID );
  if Result then
    NetPcInfo := NetPcInfoHash[ PcID ];
end;

{ MyNetPcInfoReadUtil }



class function MyNetPcInfoReadUtil.ReadActivatePcList: TStringList;
var
  NetPcReadActivateList : TNetPcReadActivateList;
begin
  NetPcReadActivateList := TNetPcReadActivateList.Create;
  Result := NetPcReadActivateList.get;
  NetPcReadActivateList.Free;
end;

class function MyNetPcInfoReadUtil.ReadDesIsOnline(DesItemID: string): Boolean;
var
  PcID : string;
begin
  PcID := NetworkDesItemUtil.getPcID( DesItemID );
  Result := ReadIsOnline( PcID );
end;

class function MyNetPcInfoReadUtil.ReadDesItemShow(DesItemID: string): string;
var
  DesPcID, DesPcName : string;
begin
  DesPcID := NetworkDesItemUtil.getPcID( DesItemID );
  DesPcName := ReadName( DesPcID );
  Result := NetworkDesItemUtil.getDesItemShowName( DesItemID, DesPcName );
end;

class function MyNetPcInfoReadUtil.ReadIosList: TStringList;
var
  NetPcReadIosList : TNetPcReadIosList;
begin
  NetPcReadIosList := TNetPcReadIosList.Create;
  Result := NetPcReadIosList.get;
  NetPcReadIosList.Free;
end;

class function MyNetPcInfoReadUtil.ReadIp(PcID: string): string;
var
  NetPcItemReadIp : TNetPcItemReadIp;
begin
  NetPcItemReadIp := TNetPcItemReadIp.Create( PcID );
  Result := NetPcItemReadIp.get;
  NetPcItemReadIp.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsCanConnectFrom(PcID: string): Boolean;
var
  NetPcReadIsCanConnectFrom : TNetPcReadIsCanConnectFrom;
begin
  NetPcReadIsCanConnectFrom := TNetPcReadIsCanConnectFrom.Create( PcID );
  Result := NetPcReadIsCanConnectFrom.get;
  NetPcReadIsCanConnectFrom.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsCanConnectTo(PcID: string): Boolean;
var
  NetPcReadIsCanConnectTo : TNetPcReadIsCanConnectTo;
begin
  NetPcReadIsCanConnectTo := TNetPcReadIsCanConnectTo.Create( PcID );
  Result := NetPcReadIsCanConnectTo.get;
  NetPcReadIsCanConnectTo.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsConnect(PcID: string): Boolean;
var
  NetPcReadIsConnect : TNetPcReadIsConnect;
begin
  NetPcReadIsConnect := TNetPcReadIsConnect.Create( PcID );
  Result := NetPcReadIsConnect.get;
  NetPcReadIsConnect.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsIos(PcID: string): Boolean;
var
  NetPcReadIsIos : TNetPcReadIsIos;
begin
  NetPcReadIsIos := TNetPcReadIsIos.Create( PcID );
  Result := NetPcReadIsIos.get;
  NetPcReadIsIos.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsIosByIp(Ip: string): Boolean;
var
  NetPcReadIsIosByIp : TNetPcReadIsIosByIp;
begin
  NetPcReadIsIosByIp := TNetPcReadIsIosByIp.Create;
  NetPcReadIsIosByIp.SetIp( Ip );
  Result := NetPcReadIsIosByIp.get;
  NetPcReadIsIosByIp.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsLanPc(PcID: string): Boolean;
var
  NetPcReadIsLanPc : TNetPcReadIsLanPc;
begin
  NetPcReadIsLanPc := TNetPcReadIsLanPc.Create( PcID );
  Result := NetPcReadIsLanPc.get;
  NetPcReadIsLanPc.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsMac(PcID: string): Boolean;
var
  NetPcReadIsMac : TNetPcReadIsMac;
begin
  NetPcReadIsMac := TNetPcReadIsMac.Create( PcID );
  Result := NetPcReadIsMac.get;
  NetPcReadIsMac.Free;
end;

class function MyNetPcInfoReadUtil.ReadIsOnline(PcID: string): Boolean;
var
  NetPcItemReadIsOnline : TNetPcItemReadIsOnline;
begin
  NetPcItemReadIsOnline := TNetPcItemReadIsOnline.Create( PcID );
  Result := NetPcItemReadIsOnline.get;
  NetPcItemReadIsOnline.Free;
end;

class function MyNetPcInfoReadUtil.ReadName(PcID: string): string;
var
  NetPcItemReadName : TNetPcItemReadName;
begin
  NetPcItemReadName := TNetPcItemReadName.Create( PcID );
  Result := NetPcItemReadName.get;
  NetPcItemReadName.Free;
end;

class function MyNetPcInfoReadUtil.ReadPcCount: Integer;
var
  NetPcReadCount : TNetPcReadCount;
begin
  NetPcReadCount := TNetPcReadCount.Create;
  Result := NetPcReadCount.get;
  NetPcReadCount.Free;
end;

class function MyNetPcInfoReadUtil.ReadPort(PcID: string): string;
var
  NetPcItemReadPort : TNetPcItemReadPort;
begin
  NetPcItemReadPort := TNetPcItemReadPort.Create( PcID );
  Result := NetPcItemReadPort.get;
  NetPcItemReadPort.Free;
end;

{ TNetPcItemReadPcName }

function TNetPcItemReadName.get: string;
begin
  if not FindNetPcInfo then
    Result := PcID
  else
    Result := NetPcInfo.PcName;
end;

{ TNetPcItemReadSocket }

function TNetPcItemReadIp.get: string;
begin
  Result := '';
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.Ip;
end;

{ TNetPcItemReadIsOnline }

function TNetPcItemReadIsOnline.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.IsOnline;
end;

{ TNetPcItemReadPort }

function TNetPcItemReadPort.get: string;
begin
  Result := '';
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.Port;
end;

{ TNetPcReadActivateCount }

function TNetPcReadOnlineCount.get: Integer;
var
  p : TNetPcInfoPair;
begin
  Result := 0;
  for p in NetPcInfoHash do
    if p.Value.IsOnline then
      Inc( Result );
end;

{ TNetPcItemReadAvailableSpace }

function TNetPcItemReadAvailableSpace.get: Int64;
begin
  Result := 10000000000;
end;

{ TNetworkGroupInfo }

constructor TNetworkGroupInfo.Create(_GroupName: string);
begin
  GroupName := _GroupName;
end;

procedure TNetworkGroupInfo.SetPassword(_Password: string);
begin
  Password := _Password;
end;

{ TMyNetworkConnInfo }

constructor TMyNetworkConnInfo.Create;
begin
  inherited;
  NetworkGroupList := TNetworkGroupList.Create;
  NetworkPcConnList := TNetworkPcConnList.Create;
  SelectType := SelectConnType_Local;
end;

destructor TMyNetworkConnInfo.Destroy;
begin
  NetworkGroupList.Free;
  NetworkPcConnList.Free;
  inherited;
end;

{ TNetworkPcConnInfo }

constructor TNetworkPcConnInfo.Create(_Domain, _Port: string);
begin
  Domain := _Domain;
  Port := _Port;
end;

{ TNetworkGroupListAccessInfo }

constructor TNetworkGroupListAccessInfo.Create;
begin
  MyNetworkConnInfo.EnterData;
  NetworkGroupList := MyNetworkConnInfo.NetworkGroupList;
end;

destructor TNetworkGroupListAccessInfo.Destroy;
begin
  MyNetworkConnInfo.LeaveData;
  inherited;
end;

{ TNetworkGroupAccessInfo }

constructor TNetworkGroupAccessInfo.Create( _GroupName : string );
begin
  inherited Create;
  GroupName := _GroupName;
end;

function TNetworkGroupAccessInfo.FindNetworkGroupInfo: Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to NetworkGroupList.Count - 1 do
    if ( NetworkGroupList[i].GroupName = GroupName ) then
    begin
      Result := True;
      NetworkGroupIndex := i;
      NetworkGroupInfo := NetworkGroupList[i];
      break;
    end;
end;

{ TNetworkGroupAddInfo }

procedure TNetworkGroupAddInfo.SetPassword( _Password : string );
begin
  Password := _Password;
end;

procedure TNetworkGroupAddInfo.Update;
begin
  if FindNetworkGroupInfo then
    Exit;

  NetworkGroupInfo := TNetworkGroupInfo.Create( GroupName );
  NetworkGroupInfo.SetPassword( Password );
  NetworkGroupList.Add( NetworkGroupInfo );
end;

{ TNetworkGroupRemoveInfo }

procedure TNetworkGroupRemoveInfo.Update;
begin
  if not FindNetworkGroupInfo then
    Exit;

  NetworkGroupList.Delete( NetworkGroupIndex );
end;


{ TNetworkGroupSetPasswordInfo }

procedure TNetworkGroupSetPasswordInfo.SetPassword( _Password : string );
begin
  Password := _Password;
end;

procedure TNetworkGroupSetPasswordInfo.Update;
begin
  if not FindNetworkGroupInfo then
    Exit;
  NetworkGroupInfo.Password := Password;
end;

{ TNetworkPcConnListAccessInfo }

constructor TNetworkPcConnListAccessInfo.Create;
begin
  MyNetworkConnInfo.EnterData;
  NetworkPcConnList := MyNetworkConnInfo.NetworkPcConnList;
end;

destructor TNetworkPcConnListAccessInfo.Destroy;
begin
  MyNetworkConnInfo.LeaveData;
  inherited;
end;

{ TNetworkPcConnAccessInfo }

constructor TNetworkPcConnAccessInfo.Create( _Domain, _Port : string );
begin
  inherited Create;
  Domain := _Domain;
  Port := _Port;
end;

function TNetworkPcConnAccessInfo.FindNetworkPcConnInfo: Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to NetworkPcConnList.Count - 1 do
    if ( NetworkPcConnList[i].Domain = Domain ) and ( NetworkPcConnList[i].Port = Port ) then
    begin
      Result := True;
      NetworkPcConnIndex := i;
      NetworkPcConnInfo := NetworkPcConnList[i];
      break;
    end;
end;

{ TNetworkPcConnAddInfo }

procedure TNetworkPcConnAddInfo.Update;
begin
  if FindNetworkPcConnInfo then
    Exit;

  NetworkPcConnInfo := TNetworkPcConnInfo.Create( Domain, Port );
  NetworkPcConnList.Add( NetworkPcConnInfo );
end;

{ TNetworkPcConnRemoveInfo }

procedure TNetworkPcConnRemoveInfo.Update;
begin
  if not FindNetworkPcConnInfo then
    Exit;

  NetworkPcConnList.Delete( NetworkPcConnIndex );
end;




{ NetworkGroupInfoReadUtil }

class function NetworkGroupInfoReadUtil.ReadIsExist(Group: string): Boolean;
var
  NetworkGroupReadIsExist : TNetworkGroupReadIsExist;
begin
  NetworkGroupReadIsExist := TNetworkGroupReadIsExist.Create( Group );
  Result := NetworkGroupReadIsExist.get;
  NetworkGroupReadIsExist.Free;
end;

class function NetworkGroupInfoReadUtil.ReadPassword(Group: string): string;
var
  NetworkGroupReadPassword : TNetworkGroupReadPassword;
begin
  NetworkGroupReadPassword := TNetworkGroupReadPassword.Create( Group );
  Result := NetworkGroupReadPassword.get;
  NetworkGroupReadPassword.Free;
end;

{ TNetworkGroupReadIsExist }

function TNetworkGroupReadIsExist.get: Boolean;
begin
  Result := FindNetworkGroupInfo;
end;

{ TNetworkGroupReadPassword }

function TNetworkGroupReadPassword.get: string;
begin
  Result := '';
  if not FindNetworkGroupInfo then
    Exit;
  Result := NetworkGroupInfo.Password;
end;

{ TNetworkPcConnReadIsExist }

function TNetworkPcConnReadIsExist.get: Boolean;
begin
  Result := FindNetworkPcConnInfo;
end;

{ NetworkConnToPcInfoReadUtil }

class function NetworkConnToPcInfoReadUtil.ReadIsExist(Ip,
  Port: string): Boolean;
var
  NetworkPcConnReadIsExist : TNetworkPcConnReadIsExist;
begin
  NetworkPcConnReadIsExist := TNetworkPcConnReadIsExist.Create( Ip, Port );
  Result := NetworkPcConnReadIsExist.get;
  NetworkPcConnReadIsExist.Free;
end;

{ TPcInfo }

procedure TPcInfo.SetInternetInfo(_InternetIp, _InternetPort: string);
begin
  InternetIp := _InternetIp;
  InternetPort := _InternetPort;
end;

procedure TPcInfo.SetLanInfo(_LanIp, _LanPort: string);
begin
  LanIp := _LanIp;
  LanPort := _LanPort;

  RealLanIp := LanIp;
end;

procedure TPcInfo.SetPcHardCode(_PcHardCode: string);
begin
  PcHardCode := _PcHardCode;
end;

procedure TPcInfo.SetPcInfo(_PcID, _PcName: string);
begin
  PcID := _PcID;
  PcName := _PcName;
end;

procedure TPcInfo.SetSortInfo(_StartTime: TDateTime; _RanNum: Integer);
begin
  StartTime := _StartTime;
  RanNum := _RanNum;
end;

{ TMasterInfo }

procedure TMasterInfo.AddItem(Params: TMasterInfoAddParams);
var
  IsBigger : Boolean;
begin
    // 本机
  if Params.PcID = PcInfo.PcID then
    Exit;

    // 检查是否最大的 Pc
  MaxLock.Enter;
  IsBigger := False;
  if Params.ClientCount > MaxClientCount then
    IsBigger := True
  else
  if Params.ClientCount = MaxClientCount then
  begin
    if Params.StartTime < MaxStartTime then
      IsBigger := True
    else
    if MaxStartTime = Params.StartTime then
      IsBigger := Params.RanNum > MaxRanNum;
  end;
  if IsBigger then
  begin
    MaxPcID := Params.PcID;
    MaxClientCount := Params.ClientCount;
    MaxStartTime := Params.StartTime;
    MaxRanNum := Params.RanNum;
  end;
  MaxLock.Leave;
end;

constructor TMasterInfo.Create;
begin
  MaxLock := TCriticalSection.Create;
end;

destructor TMasterInfo.Destroy;
begin
  MaxLock.Free;
  inherited;
end;

procedure TMasterInfo.ResetMasterPc;
begin
  MaxLock.Enter;
  MaxPcID := PcInfo.PcID;
  MaxClientCount := 0;
  MaxStartTime := PcInfo.StartTime;
  MaxRanNum := PcInfo.RanNum;
  MaxLock.Leave;
end;



{ TNetPcReadActivateList }

function TNetPcReadActivateList.get: TStringList;
var
  p : TNetPcInfoPair;
begin
  Result := TStringList.Create;
  for p in NetPcInfoHash do
    if p.Value.IsActivate then
      Result.Add( p.Value.PcID );
end;

{ TNetPcSetCanConnectToInfo }

procedure TNetPcSetCanConnectToInfo.SetCanConnectTo(_CanConnectTo: Boolean);
begin
  CanConnectTo := _CanConnectTo;
end;

procedure TNetPcSetCanConnectToInfo.Update;
begin
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.CanConnectTo := CanConnectTo;
end;

{ TNetPcSetCanConnectFromInfo }

procedure TNetPcSetCanConnectFromInfo.SetCanConnectFrom(_CanConnectFrom: Boolean);
begin
  CanConnectFrom := _CanConnectFrom;
end;

procedure TNetPcSetCanConnectFromInfo.Update;
begin
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.CanConnectFrom := CanConnectFrom;
end;

{ TNetPcReadIsConnect }

function TNetPcReadIsConnect.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.IsConnect;
end;

{ TNetPcReadIsCanConnectTo }

function TNetPcReadIsCanConnectTo.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.CanConnectTo;
end;

{ TNetPcReadIsCanConnectFrom }

function TNetPcReadIsCanConnectFrom.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.CanConnectFrom;
end;

{ TNetPcReadCount }

function TNetPcReadCount.get: Integer;
begin
  Result := NetPcInfoHash.Count;
end;

{ TNetPcReadPcIDByIp }

function TNetPcReadPcNameByIp.get: string;
var
  p : TNetPcInfoPair;
begin
  Result := '';
  for p in NetPcInfoHash do
    if p.Value.Ip = Ip then
      Result := p.Value.PcName;
end;

procedure TNetPcReadPcNameByIp.SetIp(_Ip: string);
begin
  Ip := _Ip;
end;

class function MyNetPcInfoReadUtil.ReadPcNameByIp(Ip: string): string;
var
  NetPcReadPcNameByIp : TNetPcReadPcNameByIp;
begin
  NetPcReadPcNameByIp := TNetPcReadPcNameByIp.Create;
  NetPcReadPcNameByIp.SetIp( Ip );
  Result := NetPcReadPcNameByIp.get;
  NetPcReadPcNameByIp.Free;
end;

{ TNetPcReadIsLanPc }

function TNetPcReadIsLanPc.get: Boolean;
begin
  Result := True;
  if not FindNetPcInfo then
    Exit;
  Result := MyNetworkConnUtil.getIsLanIp( NetPcInfo.Ip );
end;

{ TNetPcSetDeviceTypeInfo }

procedure TNetPcSetDeviceTypeInfo.SetDeviceType(_DeviceType: string);
begin
  DeviceType := _DeviceType;
end;

procedure TNetPcSetDeviceTypeInfo.Update;
begin
    // 不存在
  if not FindNetPcInfo then
    Exit;

  NetPcInfo.DeviceType := DeviceType;
end;

{ TNetPcReadIsIos }

function TNetPcReadIsIos.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.DeviceType = DeviceType_IOS;
end;

{ TNetPcReadIosList }

function TNetPcReadIosList.get: TStringList;
var
  p : TNetPcInfoPair;
begin
  Result := TStringList.Create;
  for p in NetPcInfoHash do
    if p.Value.DeviceType = DeviceType_IOS then
      Result.Add( p.Value.PcID );
end;

{ TNetPcReadIsMac }

function TNetPcReadIsMac.get: Boolean;
begin
  Result := False;
  if not FindNetPcInfo then
    Exit;
  Result := NetPcInfo.DeviceType = DeviceType_Mac;
end;

{ TNetPcReadIsIosByIp }

function TNetPcReadIsIosByIp.get: Boolean;
var
  p : TNetPcInfoPair;
begin
  Result := False;
  for p in NetPcInfoHash do
    if ( p.Value.Ip = Ip ) and
       ( ( p.Value.DeviceType = DeviceType_IOS ) or ( p.Value.DeviceType = DeviceType_Mac ) )
    then
    begin
      Result := True;
      Break;
    end;
end;

procedure TNetPcReadIsIosByIp.SetIp(_Ip: string);
begin
  Ip := _Ip;
end;

end.
