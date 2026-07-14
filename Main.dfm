object frmMain: TfrmMain
  Left = 200
  Top = 113
  Width = 924
  Height = 497
  Caption = #1048#1085#1090#1077#1088#1085#1072#1083#1080#1079#1072#1094#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblInputString: TJvLabel
    Left = 28
    Top = 28
    Width = 85
    Height = 13
    Caption = #1042#1093#1086#1076#1085#1072#1103' '#1089#1090#1088#1086#1082#1072':'
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
  end
  object lblOutputString: TJvLabel
    Left = 28
    Top = 234
    Width = 93
    Height = 13
    Caption = #1042#1099#1093#1086#1076#1085#1072#1103' '#1089#1090#1088#1086#1082#1072':'
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
  end
  object memInputString: TJvMemo
    Left = 28
    Top = 46
    Width = 685
    Height = 165
    Lines.Strings = (
      'memInputString')
    TabOrder = 0
  end
  object memOutputString: TJvMemo
    Left = 28
    Top = 252
    Width = 685
    Height = 165
    Lines.Strings = (
      'memOutputString')
    TabOrder = 1
  end
  object btnConvert: TButton
    Left = 752
    Top = 46
    Width = 129
    Height = 25
    Action = aConvert
    TabOrder = 2
  end
  object JvVersionControlActionList1: TJvVersionControlActionList
    Left = 754
    Top = 122
    object aConvert: TAction
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100
      OnExecute = aConvertExecute
      OnUpdate = aConvertUpdate
    end
  end
end
