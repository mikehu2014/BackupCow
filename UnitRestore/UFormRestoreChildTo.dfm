object frmRestoreChildTo: TfrmRestoreChildTo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'D:\Backup Folder'
  ClientHeight = 175
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010200000000000680400001600000028000000100000002000
    0000010020000000000000040000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000018799C0018799C0018799C0018799C0018799C0018799C001879
    9C0018799C0018799C0018799C00000000000000000000000000000000000000
    00001896C0001896C0001896C0001896C0001896C0001896C0001896C0001896
    C0001896C0001896C0001896C00018799C00000000000000000000000000189A
    C600189AC6009CFFFF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7
    FF006BD7FF006BD7FF006BD7FF002899BF000C72A5000000000000000000189A
    C600189AC60079E4F0009CFFFF007BE3FF007BE3FF007BE3FF007BE3FF007BE3
    FF007BE3FF007BE3FF007BDFFF0042B2DE000C72A5000000000000000000189A
    C60025A2CF003FB8D7009CFFFF0084EBFF0084EBFF0084EBFF0084EBFF0084EB
    FF0084EBFF0084EBFF0084E7FF0042BAEF000C72A5000000000000000000189A
    C60042B3E20025A2CF00A5FFFF0094F7FF0094F7FF0094F7FF0094F7FF0094F7
    FF0094F7FF0094F7FF0094F7FF0052BEE7005BBCCE000C72A50000000000189A
    C6006BD7FF001896C00089F0F7009CFFFF009CFFFF009CFFFF009CFFFF009CFF
    FF009CFFFF009CFFFF009CFFFF005AC7FF0096F9FB000C72A50000000000189A
    C60084D7FF00189AC6006BBFDA000000000000000000F7FBFF00000000000000
    000000000000000000000000000084E7FF00000000000C72A50000000000189A
    C60084EBFF004FC1E200189AC600189AC600189AC600189AC600189AC600189A
    C600189AC600189AC600189AC600189AC600189AC6000C72A50000000000189A
    C6009CF3FF008CF3FF008CF3FF008CF3FF008CF3FF008CF3FF00000000000000
    0000000000000000000000000000189AC60018799C000000000000000000189A
    C600000000009CFFFF009CFFFF009CFFFF009CFFFF0000000000189AC600189A
    C600189AC600189AC600189AC600189AC6000000000000000000000000000000
    000025A2CF0000000000000000000000000000000000189AC600000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000025A2CF0021A2CE0025A2CF0021A2CE0000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FFFF0000C00F000080070000000300000003000000030000000100000001
    00000DF500000001000001F3000042070000BDFF0000C3FF0000FFFF0000}
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvFiles: TListView
    Left = 0
    Top = 0
    Width = 217
    Height = 175
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'File Name'
      end>
    ShowColumnHeaders = False
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitWidth = 227
    ExplicitHeight = 185
  end
end
