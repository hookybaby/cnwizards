object CnAICoderChatForm: TCnAICoderChatForm
  Left = 511
  Top = 90
  Width = 484
  Height = 611
  Caption = 'AI Coder Chat'
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
  object spl1: TSplitter
    Left = 0
    Top = 113
    Width = 476
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Visible = False
  end
  object mmoSelf: TMemo
    Left = 0
    Top = 0
    Width = 476
    Height = 113
    Align = alTop
    TabOrder = 0
    Visible = False
  end
  object pnlChat: TPanel
    Left = 0
    Top = 116
    Width = 476
    Height = 468
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 1
  end
end
