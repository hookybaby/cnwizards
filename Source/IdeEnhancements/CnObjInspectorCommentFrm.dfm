object CnObjInspectorCommentForm: TCnObjInspectorCommentForm
  Left = 427
  Top = 226
  Width = 347
  Height = 498
  Caption = 'Object Inspector Comment'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlComment: TPanel
    Left = 0
    Top = 30
    Width = 339
    Height = 441
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 0
    object mmoComment: TMemo
      Left = 1
      Top = 49
      Width = 337
      Height = 372
      Align = alClient
      TabOrder = 0
    end
    object statHie: TStatusBar
      Left = 1
      Top = 421
      Width = 337
      Height = 19
      Panels = <>
      SimplePanel = True
    end
    object pnl1: TPanel
      Left = 1
      Top = 1
      Width = 337
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object spl1: TSplitter
        Left = 120
        Top = 0
        Width = 3
        Height = 48
        Cursor = crHSplit
        Color = clInfoBk
        ParentColor = False
      end
      object pnlRight: TPanel
        Left = 123
        Top = 0
        Width = 214
        Height = 48
        Align = alClient
        AutoSize = True
        BevelOuter = bvNone
        BorderWidth = 2
        Color = clInfoBk
        TabOrder = 0
        object pnlEdtType: TPanel
          Left = 2
          Top = 2
          Width = 210
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object edtTypeComment: TEdit
            Left = 0
            Top = 0
            Width = 210
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
        end
        object pnlEdtProp: TPanel
          Left = 2
          Top = 23
          Width = 210
          Height = 23
          Align = alClient
          AutoSize = True
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object edtPropComment: TEdit
            Left = 0
            Top = 2
            Width = 210
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
        end
      end
      object pnlLeft: TPanel
        Left = 0
        Top = 0
        Width = 120
        Height = 48
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 2
        Color = clInfoBk
        TabOrder = 1
        object pnlType: TPanel
          Left = 2
          Top = 2
          Width = 116
          Height = 21
          Align = alTop
          AutoSize = True
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object edtType: TEdit
            Left = 4
            Top = 0
            Width = 112
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            BorderStyle = bsNone
            ParentColor = True
            ReadOnly = True
            TabOrder = 0
          end
        end
        object pnlProp: TPanel
          Left = 2
          Top = 23
          Width = 116
          Height = 23
          Align = alClient
          AutoSize = True
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object edtProp: TEdit
            Left = 4
            Top = 1
            Width = 112
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            BorderStyle = bsNone
            ParentColor = True
            ReadOnly = True
            TabOrder = 0
          end
        end
      end
    end
  end
  object tlbObjComment: TToolBar
    Left = 0
    Top = 0
    Width = 339
    Height = 30
    BorderWidth = 1
    EdgeBorders = [ebLeft, ebTop, ebRight]
    Flat = True
    Images = dmCnSharedImages.Images
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object btnClear: TToolButton
      Left = 0
      Top = 0
      Action = actClear
    end
    object btn1: TToolButton
      Left = 23
      Top = 0
      Width = 8
      ImageIndex = 2
      Style = tbsSeparator
    end
    object btnFont: TToolButton
      Left = 31
      Top = 0
      Action = actFont
    end
    object btnHelp: TToolButton
      Left = 54
      Top = 0
      Action = actHelp
    end
    object btn2: TToolButton
      Left = 77
      Top = 0
      Width = 8
      Caption = 'btn2'
      ImageIndex = 2
      Style = tbsSeparator
    end
  end
  object dlgFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 40
    Top = 586
  end
  object actlstComment: TActionList
    Images = dmCnSharedImages.Images
    Left = 24
    Top = 414
    object actClear: TAction
      Caption = 'C&lear'
      Hint = 'Clear Comment'
      ImageIndex = 13
      OnExecute = actClearExecute
    end
    object actFont: TAction
      Caption = '&Font'
      Hint = 'Change Font'
      ImageIndex = 29
      OnExecute = actFontExecute
    end
    object actHelp: TAction
      Caption = '&Help'
      Hint = 'Display Help'
      ImageIndex = 1
      OnExecute = actHelpExecute
    end
  end
end
