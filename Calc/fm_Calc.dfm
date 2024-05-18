object fmCalc: TfmCalc
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
  ClientHeight = 333
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object sbPlus: TSpeedButton
    Left = 176
    Top = 103
    Width = 50
    Height = 106
    Caption = '+'
    OnClick = sbPlusClick
  end
  object sbMinus: TSpeedButton
    Left = 176
    Top = 47
    Width = 50
    Height = 50
    Caption = '-'
    OnClick = sbMinusClick
  end
  object sbMultiply: TSpeedButton
    Left = 120
    Top = 47
    Width = 50
    Height = 50
    Caption = '*'
    OnClick = sbMultiplyClick
  end
  object sbDivide: TSpeedButton
    Left = 64
    Top = 47
    Width = 50
    Height = 50
    Caption = '/'
    OnClick = sbDivideClick
  end
  object sbCancel: TSpeedButton
    Left = 8
    Top = 47
    Width = 50
    Height = 50
    Caption = 'C'
    OnClick = sbCancelClick
  end
  object sbOne: TSpeedButton
    Left = 8
    Top = 103
    Width = 50
    Height = 50
    Caption = '1'
    OnClick = sbOneClick
  end
  object sbTwo: TSpeedButton
    Left = 64
    Top = 103
    Width = 50
    Height = 50
    Caption = '2'
    OnClick = sbTwoClick
  end
  object sbThree: TSpeedButton
    Left = 120
    Top = 103
    Width = 50
    Height = 50
    Caption = '3'
    OnClick = sbThreeClick
  end
  object sbFour: TSpeedButton
    Left = 8
    Top = 159
    Width = 50
    Height = 50
    Caption = '4'
    OnClick = sbFourClick
  end
  object sbFive: TSpeedButton
    Left = 64
    Top = 159
    Width = 50
    Height = 50
    Caption = '5'
    OnClick = sbFiveClick
  end
  object sbSix: TSpeedButton
    Left = 120
    Top = 159
    Width = 50
    Height = 50
    Caption = '6'
    OnClick = sbSixClick
  end
  object sbSeven: TSpeedButton
    Left = 8
    Top = 215
    Width = 50
    Height = 50
    Caption = '7'
    OnClick = sbSevenClick
  end
  object sbEight: TSpeedButton
    Left = 64
    Top = 215
    Width = 50
    Height = 50
    Caption = '8'
    OnClick = sbEightClick
  end
  object sbNine: TSpeedButton
    Left = 120
    Top = 215
    Width = 50
    Height = 50
    Caption = '9'
    OnClick = sbNineClick
  end
  object sbZero: TSpeedButton
    Left = 176
    Top = 215
    Width = 50
    Height = 50
    Caption = '0'
    OnClick = sbZeroClick
  end
  object sbEnter: TSpeedButton
    Left = 120
    Top = 271
    Width = 106
    Height = 50
    Caption = '='
    OnClick = sbEnterClick
  end
  object sbBracket1: TSpeedButton
    Left = 8
    Top = 271
    Width = 50
    Height = 50
    Caption = '('
    OnClick = sbBracket1Click
  end
  object sbBracket2: TSpeedButton
    Left = 64
    Top = 271
    Width = 50
    Height = 50
    Caption = ')'
    OnClick = sbBracket2Click
  end
  object rtResult: TRichEdit
    Left = 8
    Top = 8
    Width = 218
    Height = 33
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    WordWrap = False
    OnKeyDown = rtResultKeyDown
    OnKeyPress = rtResultKeyPress
  end
end
