unit UFormAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, GIFImg, Vcl.Imaging.pngimage;

type
  TfrmAbout = class(TForm)
    plBackupCow: TPanel;
    CodingBest: TLabel;
    ilApp: TImage;
    lbApp: TLabel;
    lbEdition: TLabel;
    llbApp: TLinkLabel;
    procedure llbAppLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure ilAppDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  public
    { Public declarations }
  end;

const
  PageIndex_BackupCow = 0;
  PageIndex_FolderTransfer = 1;

var
  frmAbout: TfrmAbout;
  AppEdition_IsReset : Boolean = False;

implementation

uses UMyUtil, UAppEditionInfo, UMainForm, UMyUrl, UFormUtil;

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  lbEdition.Caption := MyEditionUtil.get;
  FormUtil.BindEseClose( Self );
end;

procedure TfrmAbout.ilAppDblClick(Sender: TObject);
begin
  AppEdition_IsReset := True;
end;

procedure TfrmAbout.llbAppLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  MyInternetExplorer.OpenWeb( MyProductUrl.Home );
end;

end.
