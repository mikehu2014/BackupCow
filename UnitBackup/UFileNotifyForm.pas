unit UFileNotifyForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShlObj, StrUtils, ExtCtrls, ShellAPI, StdCtrls;

const
  WM_SHNOTIFY = WM_USER + 10;

type

  TFileChangeEvent = procedure( s : string ) of object;

  TfrmFileNotify = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    IsSetNotify : Boolean;
    FileChangeEvent : TFileChangeEvent;
    procedure WMSHNOTIFY(var Msg: TMessage); message WM_SHNOTIFY;
    function getRewriteFile(path: string; time: Int64): string;
  public
    function ReadIsSetNotify : Boolean;
    property OnFileChange : TFileChangeEvent read FileChangeEvent write FileChangeEvent;
  end;

var
  Notify_Path : string = '';
  frmFileNotify: TfrmFileNotify;

implementation

uses UMyUtil;

type
  NOTIFYREGISTER = packed record
    pidlPath: PItemIDList;
    bWatchSubtree: BOOL;
  end;
   PNotifyRegister = ^NOTIFYREGISTER;
var
   FNotifyHandle: THandle;
   lastChange:string;

{$R *.dfm}

function SHILCreateFromPath(pszPath: PChar; ppidl: PItemIDList;
  rgflnOut: PDWORD): HResult; stdcall; external Shell32 index 28;
function SHChangeNotifyRegister(hWnd: hWnd; dwFlags: Integer;
  wEventMask: Cardinal; uMsg: UINT; cItems: Integer;
  lpItems: PNotifyRegister): hWnd; stdcall; external Shell32 index 2;
function SHChangeNotifyDeregister(hWnd: hWnd): Boolean; stdcall;
external Shell32 index 4;


procedure TfrmFileNotify.FormCreate(Sender: TObject);
var
  vNotifyRegister: NOTIFYREGISTER;
  vAttributes: Word;

  Dir: string;
  i: Integer;
   vItemIDList:PItemIDList;
begin
  IsSetNotify := False;
//  Dir := '::{20D04FE0-3AEA-1069-A2D8-08002B30309D}';
  Dir := Notify_Path;
  SHILCreateFromPath(PChar((Dir)),
  @vItemIDList,
  @vAttributes);
  vNotifyRegister.pidlPath := vItemIDList;
  vNotifyRegister.bWatchSubtree := True;
  FNotifyHandle := SHChangeNotifyRegister(Handle, SHCNF_TYPE or SHCNF_IDLIST,
    SHCNE_ALLEVENTS or SHCNE_INTERRUPT, WM_SHNOTIFY, 1, @vNotifyRegister);
end;



function TfrmFileNotify.getRewriteFile(path: string; time: Int64): string;
var
  FindFile: TSearchRec;
begin

  path := IncludeTrailingBackslash(path);

  if FindFirst(path + '*.*', faAnyFile, FindFile) = 0 then
  begin
    repeat
      if ((FindFile.Attr and faDirectory) = faDirectory)=False then
      begin
        if (time - FindFile.time < 10) then
        begin
          Result := FindFile.Name;
          Break;
        end;
      end;
    until FindNext(FindFile) <> 0;
  end;
end;

function TfrmFileNotify.ReadIsSetNotify: Boolean;
begin
  Result := IsSetNotify;
end;

procedure TfrmFileNotify.WMSHNOTIFY(var Msg: TMessage);
type
  PSHNOTIFYSTRUCT = ^SHNOTIFYSTRUCT;

  SHNOTIFYSTRUCT = packed record
    dwItem1: PItemIDList;
    dwItem2: PItemIDList;
  end;
var
  vBuffer: array [0 .. MAX_PATH] of Char;
  pidlItem: PSHNOTIFYSTRUCT;
  S: AnsiString;
  modiFileName: string;
  FileSize : Int64;
  FileTime : TDateTime;
begin
  pidlItem := PSHNOTIFYSTRUCT(Msg.WParam);
  SHGetPathFromIDList(pidlItem.dwItem1, vBuffer);
  S := vBuffer;
  SHGetPathFromIDList(pidlItem.dwItem2, vBuffer);

  if(lastChange=IntToStr(Msg.LParam)+s)then
  begin
    exit;
  end
  else
  begin
     lastChange:=IntToStr(Msg.LParam)+s;
  end;

  case Msg.LParam of
    SHCNE_RENAMEITEM: // 文件名改变
      begin
        S := 'RENAMEITEM: ' + S + ' <to> ' + vBuffer + '|' + IntToStr( MyFileInfo.getFileSize( vBuffer ) ) +
             '|' + DateTimeToStr( MyFileInfo.getFileLastWriteTime( vBuffer ) );
      end;
    SHCNE_CREATE: // 新增文件
      begin
        S := 'CREATE: '+ S + '|' + IntToStr( MyFileInfo.getFileSize( S ) ) +
             '|' + DateTimeToStr( MyFileInfo.getFileLastWriteTime( S ) );
      end;
    SHCNE_DELETE: // 删除文件
      begin
        S := 'DELETE: ' + S;
      end;
    SHCNE_UPDATEITEM: // 更新文件win7
      begin
        S:= 'UPDATEITEM: '+ S + '|' + IntToStr( MyFileInfo.getFileSize( S ) ) +
            '|' + DateTimeToStr( MyFileInfo.getFileLastWriteTime( S ) );
      end;
    SHCNE_UPDATEDIR: // 更新文件  非win7
      begin
        modiFileName := getRewriteFile(S, DateTimeToFileDate(Now));
        if RightStr(S, 1) <> '\' then
        begin
          S := S + '\';
        end;
         s:=s+modiFileName;
        S:='UPDATEDIR: '+S;
      end;
    SHCNE_MKDIR: // 新建目录
      begin
      S := 'MKDIR: ' + S;
      end;
    SHCNE_RMDIR:
      S := 'RMDIR: ' + S;
    SHCNE_MEDIAINSERTED:
      S := 'MEDIAINSERTED: ' + S;
    SHCNE_MEDIAREMOVED:
      S := 'MEDIAREMOVED: ' + S;
    SHCNE_DRIVEREMOVED:
      S := 'DRIVEREMOVED: ' + S;
    SHCNE_DRIVEADD:
      S := 'DRIVEADD: ' + S;
    SHCNE_NETSHARE:
      S := 'NETSHARE: ' + S;
    SHCNE_ATTRIBUTES:
      S := 'ATTRIBUTES: ' + S;
    SHCNE_SERVERDISCONNECT:
      S := 'SERVERDISCONNECT: ' + S + '   ' + vBuffer;
    SHCNE_UPDATEIMAGE:
      S := 'SHCNE_UPDATEIMAGE';
    SHCNE_DRIVEADDGUI:
      S := 'SHCNE_DRIVEADDGUI';
    SHCNE_RENAMEFOLDER:
      begin
        S := 'RENAMEFOLDER: ' + S + ' <to> ' + vBuffer;
      end;
    SHCNE_FREESPACE:
      S := 'FREESPACE';
    SHCNE_ASSOCCHANGED:
      S := 'ASSOCCHANGED';
  else
    S := 'unknown: ' + IntToStr(Msg.LParam);
  end;

    // 是否存在过滤信息
  if Pos( NotifyFilter_Name, s ) > 0 then
    Exit;

  if Assigned( FileChangeEvent ) then
    FileChangeEvent( s );
end;
end.
