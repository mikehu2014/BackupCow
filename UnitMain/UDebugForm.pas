unit UDebugForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UPortMap, ExtCtrls, UChangeInfo, uDebugLock, Vcl.ComCtrls,
  RzTabs;

type
  TfrmDebug = class(TForm)
    plControl: TPanel;
    btnRefresh: TButton;
    btnClose: TButton;
    pcMain: TRzPageControl;
    tsDetails: TRzTabSheet;
    tsList: TRzTabSheet;
    mmoResult: TMemo;
    lvDebug: TListView;
    tsReceive: TRzTabSheet;
    mmoReceive: TMemo;
    plReceive: TPanel;
    chkMarkReceive: TCheckBox;
    btnClear: TButton;
    tsSend: TRzTabSheet;
    plSend: TPanel;
    mmoSend: TMemo;
    chkSend: TCheckBox;
    btnClearSend: TButton;
    Label1: TLabel;
    lbEditionNumber: TLabel;
    procedure StartClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure chkMarkReceiveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnClearSendClick(Sender: TObject);
    procedure chkSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function getNewItem( tid : Integer ): Integer;
  end;

  TWriteLog = class( TChangeInfo )
  public
    s : string;
  public
    constructor Create(_s : string);
    procedure Update;override;
  end;

var
  frmDebug: TfrmDebug;

implementation

uses UMyTcp;

{$R *.dfm}

procedure TfrmDebug.btnClearClick(Sender: TObject);
begin
  frmDebug.mmoReceive.Clear;
end;

procedure TfrmDebug.btnClearSendClick(Sender: TObject);
begin
  mmoSend.Clear;
end;

procedure TfrmDebug.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDebug.btnRefreshClick(Sender: TObject);
var
  I: Integer;
  DebugLockItem: PDebugLockItem;
  s : string;
  NewItemIndex : Integer;
  NewItem : TListItem;
begin
  mmoResult.Text := DebugLock.TrackDebug;

  lvDebug.Clear;
  DebugLock.Lock;
  try
    for I := 0 to DebugLock.FList.Count - 1 do
    begin
      DebugLockItem := DebugLock.FList.Items[I];
      NewItemIndex := getNewItem( DebugLockItem^.ThreadId );
      if NewItemIndex >= 0 then
        NewItem := lvDebug.Items.Insert( NewItemIndex )
      else
        NewItem := lvDebug.Items.Add;
      NewItem.Caption := IntToStr( DebugLockItem^.ThreadId );
      NewItem.SubItems.Add( DebugLockItem^.ThreadName );
   end;
  except
  end;
  DebugLock.Unlock;
end;

procedure TfrmDebug.chkMarkReceiveClick(Sender: TObject);
begin
  IsMark_Receive := chkMarkReceive.Checked;
end;

procedure TfrmDebug.chkSendClick(Sender: TObject);
begin
  IsMark_Send := chkSend.Checked;
end;

procedure TfrmDebug.FormCreate(Sender: TObject);
begin
  lbEditionNumber.Caption := IntToStr( ConnEdition_Now );
end;

function TfrmDebug.getNewItem(tid: Integer): Integer;
var
  i: Integer;
  SelectID : Integer;
begin
  Result := -1;
  for i := 0 to lvDebug.Items.Count - 1 do
  begin
    SelectID := StrToIntDef( lvDebug.Items[i].Caption, 0 );
    if SelectID > tid then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TfrmDebug.StartClick(Sender: TObject);
begin
end;

{ TWriteLog }

constructor TWriteLog.Create(_s: string);
begin
  s := _s;
end;

procedure TWriteLog.Update;
begin
end;

end.
