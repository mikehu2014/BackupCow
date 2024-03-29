object frmDebug: TfrmDebug
  Left = 0
  Top = 0
  Caption = 'frmDebug'
  ClientHeight = 445
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object plControl: TPanel
    Left = 0
    Top = 400
    Width = 441
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 5
      Width = 57
      Height = 13
      Caption = 'ConnEdition'
    end
    object lbEditionNumber: TLabel
      Left = 9
      Top = 25
      Width = 77
      Height = 13
      Caption = 'lbEditionNumber'
    end
    object btnRefresh: TButton
      Left = 108
      Top = 11
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = btnRefreshClick
    end
    object btnClose: TButton
      Left = 246
      Top = 11
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
  object pcMain: TRzPageControl
    Left = 0
    Top = 0
    Width = 441
    Height = 400
    ActivePage = tsDetails
    Align = alClient
    BoldCurrentTab = True
    TabIndex = 0
    TabOrder = 1
    TabStyle = tsRoundCorners
    FixedDimension = 19
    object tsDetails: TRzTabSheet
      Caption = 'tsDetails'
      Padding.Top = 5
      object mmoResult: TMemo
        Left = 0
        Top = 5
        Width = 437
        Height = 369
        Align = alClient
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object tsList: TRzTabSheet
      Caption = 'tsList'
      Padding.Top = 5
      object lvDebug: TListView
        Left = 0
        Top = 5
        Width = 437
        Height = 369
        Align = alClient
        Columns = <
          item
            Caption = 'Thread ID'
            Width = 80
          end
          item
            AutoSize = True
            Caption = 'Thread Name'
          end>
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object tsReceive: TRzTabSheet
      Caption = 'tsReceive'
      object mmoReceive: TMemo
        Left = 0
        Top = 0
        Width = 437
        Height = 344
        Align = alClient
        ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object plReceive: TPanel
        Left = 0
        Top = 344
        Width = 437
        Height = 30
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object chkMarkReceive: TCheckBox
          Left = 16
          Top = 7
          Width = 193
          Height = 17
          Caption = 'Check Here to Mark Receive'
          TabOrder = 0
          OnClick = chkMarkReceiveClick
        end
        object btnClear: TButton
          Left = 189
          Top = 3
          Width = 75
          Height = 25
          Caption = 'Clear'
          TabOrder = 1
          OnClick = btnClearClick
        end
      end
    end
    object tsSend: TRzTabSheet
      Caption = 'tsSend'
      object plSend: TPanel
        Left = 0
        Top = 333
        Width = 437
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object chkSend: TCheckBox
          Left = 17
          Top = 13
          Width = 165
          Height = 17
          Caption = 'check here to mark send'
          TabOrder = 0
          OnClick = chkSendClick
        end
        object btnClearSend: TButton
          Left = 223
          Top = 9
          Width = 75
          Height = 25
          Caption = 'Clear'
          TabOrder = 1
          OnClick = btnClearSendClick
        end
      end
      object mmoSend: TMemo
        Left = 0
        Top = 0
        Width = 437
        Height = 333
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
  end
end
