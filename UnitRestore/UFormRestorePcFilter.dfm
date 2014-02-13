object frmRestorePcFilter: TfrmRestorePcFilter
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderWidth = 3
  Caption = 'Select computers you want to show'
  ClientHeight = 295
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001000800680500001600000028000000100000002000
    0000010008000000000000010000000000000000000000010000000100000000
    00005E45450062494900664C4C00684E4E006A5151006C5252006E5555007157
    57007259590072727200767676007C7C7C00BA720D0084777100867973008A7D
    74008A8076008D8076008F83780092857900D1995C000033FF00103DF9002046
    F2005063DF00405BE800AF9FBE00BFACBF00D9A69300DAA89D00CFAFAC00DCAB
    A000DDACA200DEAEA400DFB0A800DDB5B100DFBFB200E0B2AA00E1B3AC00E2B6
    AF00FFCC9900DFC0B500EFC8AA00FFD0A100FFD2A500FFD4AA00FFD6AD00FFC4
    B300FFCEB600FFD8B100FFDBB600FFD0BA00FFD1BC00FFDEBD009F95C5008082
    D1008083D400AFA5CA00BFADC100BFB5D200DFC8C400FFCFC300FFD3C000FFD4
    C200FFD5C500FFD7C900FFE1C300FFE4C900FFE7CE00F3E3D200F5E2D000F6E5
    D500FBE7D300FFEAD500F4E6D900F7E8DA00F8EBDD00FAEDE200FDEEE000F0EE
    EC00FAF0E700FFF2E700FFF6ED00F2F2F200F6F6F600FFF9F100F9F9F900FFFC
    F900FEFEFE000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0A0A0A0A0A0A0A0A0A0A0A0A0C0000000A2428282822222220201D010C000000
    0A464544363633322E2D31020C0000000A4B4A45453C3D33332E34020C000000
    0A462E2A19161A2D2D2E34020C0000000A4637171617161B2D2C40040C000000
    0A4C3B183A2A17182B2D40050C0000000A4C2E2E2E2E3916392D40050C000000
    0A4E332E322E2E18162A40050C0000000A51332E2E2E2E3B163742090C000000
    0A4E2929292929291F2940090B0000000A595959595653514E4A30090A000000
    0A595959595956531515150D000000000A5959595959595615150D0000000000
    0A59595955555050150D0000000000001114111010100F0E0D0000000000C001
    0000C0010000C0010000C0010000C0010000C0010000C0010000C0010000C001
    0000C0010000C0010000C0010000C0030000C0070000C00F0000C01F0000}
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 259
    Width = 393
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOK: TButton
      Left = 95
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 223
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object vstGroupPc: TVirtualStringTree
    Left = 0
    Top = 30
    Width = 393
    Height = 229
    Align = alClient
    BorderWidth = 1
    CheckImageKind = ckXP
    Header.AutoSizeIndex = -1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    Images = ilNw16
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
    OnGetText = vstGroupPcGetText
    OnGetImageIndex = vstGroupPcGetImageIndex
    Columns = <
      item
        Position = 0
        Width = 393
        WideText = 'Computer Name'
      end>
  end
  object tbMain: TToolBar
    Left = 0
    Top = 0
    Width = 393
    Height = 30
    AutoSize = True
    ButtonHeight = 30
    ButtonWidth = 78
    Caption = 'tbMain'
    Images = frmMainForm.ilTb24
    List = True
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 2
    object tbtnSelectAll: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = 'Select All'
      ImageIndex = 14
      OnClick = tbtnSelectAllClick
    end
    object tbtnRemoveAll: TToolButton
      Left = 82
      Top = 0
      Hint = 'Unselect All'
      AutoSize = True
      ImageIndex = 4
      OnClick = tbtnRemoveAllClick
    end
  end
  object ilNw16: TImageList
    Left = 272
    Top = 88
    Bitmap = {
      494C010102000400440010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000000000000000000000000000CACA
      CA00C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C8C8C800C9C9C900C9C9
      C900CCCCCC00000000000000000000000000000000000000000000000000CBC8
      C800CAC7C700CAC7C700CAC7C700CAC8C700CAC7C700CAC7C700CAC8C800CAC8
      C800CDCBCB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BBBB
      BB00DADADA00DBDBDB00D1D1D100D2D2D200D2D2D200D2D2D200D8D8D800E0E0
      E000BBBBBB00000000000000000000000000000000000000000000000000BFBB
      BB00DBD9D900DBDBDB00D1D1D100D2D2D200D2D2D200D2D2D200D8D8D800E1E0
      E000BFBBBB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B9B9B9008D8D8D008D8D8D008D8D8D008D8D8D00BBBBBB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BAB9B9008D8D8D008D8D8D008D8D8D008D8D8D00BCBBBB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8B8B800B8B8B800B8B8
      B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8
      B800B8B8B800B8B8B800B8B8B8000000000000000000B9B7B700B9B7B700B9B7
      B700B9B7B700B9B7B700B9B7B700B9B7B700B9B7B700B9B7B700B9B7B700B9B7
      B700B9B7B700B9B7B700B9B7B700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E5E5E500E3E3E300E3E3
      E300E3E3E300E2E2E200E2E2E200EEEEEE00EEEEEE00E0E0E000E0E0E000E0E0
      E000E0E0E000E0E0E000E1E1E100B8B8B800B9B7B700E9E4E300E7E1E100E7E1
      E100E6E0E000E5DFDF00E5DFDF00F0EDED00F0EDED00E3DDDD00E3DDDD00E3DD
      DD00E3DDDD00E3DDDD00E4DFDF00B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E300E1E1E100E1E1
      E100E0E0E000DFDFDF00DEDEDE00E6E6E600E5E5E500DDDDDD00DCDCDC00DCDC
      DC00DCDCDC00DCDCDC00E3E3E300B8B8B800B9B7B700E7E1E100E5DFDE00E5DE
      DE00E4DDDD00E3DCDC00E2DBDB00E9E5E400E8E4E400E0DADA00E0D9D900E0D9
      D900E0D9D900E0D9D900E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E3008E8E8E008F8F
      8F009090900092929200949494009595950092929200919191008E8E8E008B8B
      8B008989890089898900E3E3E300B8B8B800B9B7B700E7E1E100C7715600C774
      5800C77A5B00C5815F00C5886300C58B6500C4886300C3815F00C1795B00C071
      5700BF6D5400BF6C5400E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E300929292009696
      96009B9B9B00A2A2A200A9A9A900ACACAC00A9A9A900A4A4A4009D9D9D009696
      96009292920092929200E3E3E300B8B8B800B9B7B700E7E1E100E8624000E96B
      4400EA7E4E00EC945A00EEA86500EFB46B00EEAB6600ED985C00EB825000E96E
      4500E8613E00E8603E00E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E300929292009595
      95009A9A9A00A1A1A100A6A6A600A9A9A900A7A7A700A2A2A2009B9B9B009696
      96009292920092929200E3E3E300B8B8B800B9B7B700E7E1E100E8613F00E969
      4200EA7A4C00EC8E5700EEA06000EEA86500EEA26100EC925900EA7E4E00E96C
      4400E8603E00E8603E00E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E3009A9A9A009292
      9200979797009D9D9D00A1A1A100A2A2A200A1A1A1009D9D9D00999999009292
      92009292920092929200E3E3E300B8B8B800B9B7B700E7E1E100E96C4D00E864
      4000E9714700EB815000EC8E5700EC945A00EC905800EB845100EA744900E866
      4100E8603E00E8603E00E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E300ABABAB00ABAB
      AB009E9E9E00989898009A9A9A009B9B9B009B9B9B0098989800959595009292
      92009292920092929200E3E3E300B8B8B800B9B7B700E7E1E100ED846A00ED84
      6A00EA755300EA724800EA7A4C00EA7E4E00EA7B4D00EA734800E9694200E861
      3E00E8603E00E8603E00E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E300ADADAD00B5B5
      B500B4B4B400B1B1B100AAAAAA00A4A4A4009F9F9F009B9B9B00989898009898
      98009A9A9A009C9C9C00E3E3E300B8B8B800B9B7B700E7E1E100ED886F00EF93
      7C00EF927A00EE907600ED886900EC805D00EB775400EA6F4D00E9694800E969
      4900E96C4D00EA6E5000E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E300B0B0B000B8B8
      B800B8B8B800B7B7B700B6B6B600B5B5B500B5B5B500B4B4B400B2B2B200B2B2
      B200B2B2B200ACACAC00E3E3E300B8B8B800B9B7B700E7E1E100EE8C7400F098
      8200F0978100F0968000EF957E00EF947D00EF937C00EF927B00EF917900EF8F
      7800EE8E7700ED856C00E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E300ACACAC00B2B2
      B200B2B2B200B1B1B100B1B1B100B0B0B000B0B0B000B0B0B000AFAFAF00AFAF
      AF00AEAEAE00A9A9A900E3E3E300B8B8B800B9B7B700E7E1E100ED866C00EF90
      7800EF8F7700EE8E7600EE8D7500EE8D7400EE8C7400EE8B7300EE8A7200EE8A
      7100EE897000EC816700E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800E3E3E300E3E3E300E3E3
      E300E3E3E300E3E3E300E3E3E300E3E3E300E3E3E300E3E3E300E3E3E300E3E3
      E300E3E3E300E3E3E300E3E3E300B8B8B800B9B7B700E7E1E100E7E1E100E7E1
      E100E7E1E100E7E1E100E7E1E100E7E1E100E7E1E100E7E1E100E7E1E100E7E1
      E100E7E1E100E7E1E100E7E1E100B9B7B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8B8B800B8B8B800B8B8
      B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8
      B800B8B8B800B8B8B800B8B8B8000000000000000000B9B7B700B9B7B700B9B7
      B700B9B7B700B9B7B700B9B7B700B9B7B700B9B7B700B9B7B700B9B7B700B9B7
      B700B9B7B700B9B7B700B9B7B700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E007E00700000000E007E00700000000
      F81FF81F00000000800180010000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800180010000000000000000000000000000000000000000
      000000000000}
  end
end
