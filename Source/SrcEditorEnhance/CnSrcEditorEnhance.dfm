inherited CnSrcEditorEnhanceForm: TCnSrcEditorEnhanceForm
  Left = 304
  Top = 98
  BorderStyle = bsDialog
  Caption = 'Editor Enhancements Wizard Settings'
  ClientHeight = 515
  ClientWidth = 401
  KeyPreview = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 158
    Top = 484
    Width = 75
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 238
    Top = 484
    Width = 75
    Height = 21
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 318
    Top = 484
    Width = 75
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnHelpClick
  end
  object pgc1: TPageControl
    Left = 8
    Top = 8
    Width = 385
    Height = 468
    ActivePage = ts1
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'Code &Editor'
      object grpEditorEnh: TGroupBox
        Left = 8
        Top = 8
        Width = 361
        Height = 169
        Caption = 'General and &Menu Enhancements'
        TabOrder = 0
        object lbl4: TLabel
          Left = 26
          Top = 60
          Width = 73
          Height = 13
          Caption = 'Command Line:'
        end
        object chkAddMenuCloseOtherPages: TCheckBox
          Left = 8
          Top = 16
          Width = 350
          Height = 17
          Caption = 'Add "Close Other Pages" in Editor'#39's Popupmenu.'
          TabOrder = 0
        end
        object chkAddMenuSelAll: TCheckBox
          Left = 8
          Top = 100
          Width = 350
          Height = 17
          Caption = 'Add "Select All" in Editor'#39's Popupmenu.'
          TabOrder = 4
        end
        object chkAddMenuExplore: TCheckBox
          Left = 8
          Top = 36
          Width = 350
          Height = 17
          Caption = 'Add "Open in Explorer" in Editor'#39's Popupmenu.'
          TabOrder = 1
          OnClick = UpdateContent
        end
        object chkCodeCompletion: TCheckBox
          Left = 8
          Top = 140
          Width = 193
          Height = 17
          Caption = 'Add a CodeCompletion HotKey:'
          TabOrder = 6
          OnClick = UpdateContent
        end
        object hkCodeCompletion: THotKey
          Left = 208
          Top = 140
          Width = 137
          Height = 19
          HotKey = 32833
          InvalidKeys = [hcNone]
          Modifiers = [hkAlt]
          TabOrder = 7
        end
        object chkAddMenuShellMenu: TCheckBox
          Left = 8
          Top = 120
          Width = 350
          Height = 17
          Caption = 'Add "Shell Context Menu" in Editor'#39's Popupmenu.'
          TabOrder = 5
        end
        object chkAddMenuCopyFileName: TCheckBox
          Left = 8
          Top = 80
          Width = 350
          Height = 17
          Caption = 'Add "Copy Full Path/FileName" in Editor'#39's Popupmenu.'
          TabOrder = 3
        end
        object edtExploreCmdLine: TEdit
          Left = 104
          Top = 56
          Width = 241
          Height = 21
          TabOrder = 2
        end
      end
      object grpAutoReadOnly: TGroupBox
        Left = 8
        Top = 180
        Width = 361
        Height = 248
        Caption = '&Read Only Protection'
        TabOrder = 1
        object lblDir: TLabel
          Left = 8
          Top = 189
          Width = 17
          Height = 13
          Caption = 'Dir:'
        end
        object chkAutoReadOnly: TCheckBox
          Left = 8
          Top = 17
          Width = 345
          Height = 17
          Caption = 'Auto Set Editor to ReadOnly when Opening Files in Directories:'
          TabOrder = 0
          OnClick = UpdateContent
        end
        object lbReadOnlyDirs: TListBox
          Left = 8
          Top = 40
          Width = 337
          Height = 137
          ItemHeight = 13
          TabOrder = 1
          OnClick = lbReadOnlyDirsClick
        end
        object edtDir: TEdit
          Left = 48
          Top = 185
          Width = 273
          Height = 21
          TabOrder = 2
        end
        object btnSelectDir: TButton
          Left = 325
          Top = 185
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = btnSelectDirClick
        end
        object btnReplace: TButton
          Left = 47
          Top = 213
          Width = 75
          Height = 21
          Action = actReplace
          TabOrder = 4
        end
        object btnAdd: TButton
          Left = 127
          Top = 213
          Width = 75
          Height = 21
          Action = actAdd
          TabOrder = 5
        end
        object btnDel: TButton
          Left = 207
          Top = 213
          Width = 75
          Height = 21
          Action = actDelete
          Cancel = True
          TabOrder = 6
        end
      end
    end
    object ts2: TTabSheet
      Caption = 'Line &Number / Toolbar'
      ImageIndex = 1
      object grpLineNumber: TGroupBox
        Left = 8
        Top = 98
        Width = 361
        Height = 230
        Caption = '&Line Number'
        TabOrder = 1
        object lbl1: TLabel
          Left = 42
          Top = 151
          Width = 59
          Height = 13
          Caption = 'Show Fixed:'
        end
        object lbl2: TLabel
          Left = 42
          Top = 115
          Width = 72
          Height = 13
          Caption = 'Show at Least:'
        end
        object rbLinePanelFixedWidth: TRadioButton
          Left = 24
          Top = 132
          Width = 321
          Height = 17
          Caption = 'Fixed Width of Line Number.'
          TabOrder = 8
          OnClick = UpdateContent
        end
        object rbLinePanelAutoWidth: TRadioButton
          Left = 24
          Top = 96
          Width = 321
          Height = 17
          Caption = 'Auto Adjust Width of Line Number.'
          Checked = True
          TabOrder = 6
          TabStop = True
          OnClick = UpdateContent
        end
        object chkShowLineNumber: TCheckBox
          Left = 8
          Top = 16
          Width = 350
          Height = 17
          Caption = 'Show Line Number in Editor.'
          TabOrder = 0
          OnClick = UpdateContent
        end
        object seLinePanelFixWidth: TCnSpinEdit
          Left = 184
          Top = 146
          Width = 49
          Height = 22
          MaxValue = 10
          MinValue = 1
          TabOrder = 9
          Value = 3
        end
        object chkShowLineCount: TCheckBox
          Left = 24
          Top = 36
          Width = 321
          Height = 17
          Caption = 'Show Total Line Count.'
          TabOrder = 2
        end
        object seLinePanelMinWidth: TCnSpinEdit
          Left = 184
          Top = 110
          Width = 49
          Height = 22
          MaxValue = 10
          MinValue = 1
          TabOrder = 7
          Value = 3
        end
        object btnLineFont: TButton
          Left = 228
          Top = 16
          Width = 125
          Height = 21
          Caption = 'Line Number &Font...'
          TabOrder = 1
          OnClick = btnLineFontClick
        end
        object chkGutterClickSelectLine: TCheckBox
          Left = 8
          Top = 170
          Width = 321
          Height = 17
          Caption = 'Single Click to Select One Line in Editor.'
          TabOrder = 10
        end
        object chkGutterDblClickToggleBookmark: TCheckBox
          Left = 8
          Top = 190
          Width = 321
          Height = 17
          Caption = 'Double Click to Toggle Bookmark in Editor.'
          TabOrder = 11
        end
        object chkGutterDragSelectLines: TCheckBox
          Left = 8
          Top = 208
          Width = 321
          Height = 17
          Caption = 'Drag to Select Multi-Lines in Editor.'
          TabOrder = 12
        end
        object chkTenMode: TCheckBox
          Left = 24
          Top = 76
          Width = 201
          Height = 17
          Caption = 'Only Show 10th Numbers.'
          TabOrder = 5
        end
        object chkRelativeNumber: TCheckBox
          Left = 24
          Top = 56
          Width = 321
          Height = 17
          Caption = 'Relative Line Number.'
          TabOrder = 4
        end
        object btnCurrLineFont: TButton
          Left = 228
          Top = 40
          Width = 125
          Height = 21
          Caption = 'C&ur. Line Number Font...'
          TabOrder = 3
          OnClick = btnCurrLineFontClick
        end
      end
      object grpToolBar: TGroupBox
        Left = 8
        Top = 8
        Width = 361
        Height = 81
        Caption = 'Editor &Toolbar'
        TabOrder = 0
        object chkShowToolBar: TCheckBox
          Left = 8
          Top = 16
          Width = 225
          Height = 17
          Caption = 'Show Toolbar in Editor.'
          TabOrder = 0
          OnClick = UpdateContent
        end
        object chkToolBarWrap: TCheckBox
          Left = 24
          Top = 56
          Width = 201
          Height = 17
          Caption = 'Wrap Buttons'
          TabOrder = 4
        end
        object chkShowInDesign: TCheckBox
          Left = 8
          Top = 36
          Width = 257
          Height = 17
          Caption = 'Show Toolbar in BDS Embedded Designer.'
          TabOrder = 2
          OnClick = UpdateContent
        end
        object btnDesignToolBar: TButton
          Left = 228
          Top = 40
          Width = 125
          Height = 21
          Caption = 'Customize B&uttons...'
          TabOrder = 3
          OnClick = btnDesignToolBarClick
        end
        object btnToolBar: TButton
          Left = 228
          Top = 16
          Width = 125
          Height = 21
          Caption = 'Customize &Buttons...'
          TabOrder = 1
          OnClick = btnToolBarClick
        end
      end
      object grpEditorNav: TGroupBox
        Left = 8
        Top = 336
        Width = 361
        Height = 92
        Caption = '&Jumping Enhancement'
        TabOrder = 2
        object Label1: TLabel
          Left = 26
          Top = 40
          Width = 139
          Height = 13
          Caption = 'Lines to Make a New Record:'
        end
        object Label2: TLabel
          Left = 26
          Top = 64
          Width = 80
          Height = 13
          Caption = 'Maximum Count:'
        end
        object chkExtendForwardBack: TCheckBox
          Left = 8
          Top = 16
          Width = 345
          Height = 17
          Caption = 'Improve the Jumping Features in IDE Editor.'
          TabOrder = 0
          OnClick = UpdateContent
        end
        object seNavMinLineDiff: TCnSpinEdit
          Left = 184
          Top = 35
          Width = 49
          Height = 22
          MaxValue = 99
          MinValue = 1
          TabOrder = 1
          Value = 5
        end
        object seNavMaxItems: TCnSpinEdit
          Left = 184
          Top = 59
          Width = 49
          Height = 22
          MaxLength = 2
          MaxValue = 99
          MinValue = 1
          TabOrder = 2
          Value = 20
        end
      end
    end
    object ts3: TTabSheet
      Caption = '&Tabset / Button'
      ImageIndex = 2
      object gbTab: TGroupBox
        Left = 8
        Top = 8
        Width = 361
        Height = 123
        Caption = 'Ta&bset Enhancement'
        TabOrder = 0
        object chkDispModifiedInTab: TCheckBox
          Left = 8
          Top = 16
          Width = 350
          Height = 17
          Caption = 'Add "*" to Modified File'#39's Name in Tabset.'
          TabOrder = 0
        end
        object chkDblClkClosePage: TCheckBox
          Left = 8
          Top = 36
          Width = 350
          Height = 17
          Caption = 'Close Page by Double-click.'
          TabOrder = 1
        end
        object chkRClickShellMenu: TCheckBox
          Left = 8
          Top = 56
          Width = 350
          Height = 17
          Caption = 'Show Shell Menu by Right-click Tabset with Shift or Ctrl.'
          TabOrder = 2
        end
        object chkEditorMultiLine: TCheckBox
          Left = 8
          Top = 76
          Width = 350
          Height = 17
          Caption = 'Set Editor Tab to Multi-line(N.A. for BDS).'
          TabOrder = 3
        end
        object chkEditorFlatButtons: TCheckBox
          Left = 8
          Top = 96
          Width = 350
          Height = 17
          Caption = 'Set Editor Tab'#39's Style to Flat Button(N.A. for BDS).'
          TabOrder = 4
        end
      end
      object gbFlatButton: TGroupBox
        Left = 8
        Top = 139
        Width = 361
        Height = 84
        Caption = '&Selection Button'
        TabOrder = 1
        object chkShowFlatButton: TCheckBox
          Left = 8
          Top = 16
          Width = 350
          Height = 17
          Caption = 'Show Selection Button when A Block Selected.'
          TabOrder = 0
          OnClick = UpdateContent
        end
        object chkAddMenuBlockTools: TCheckBox
          Left = 8
          Top = 56
          Width = 326
          Height = 17
          Caption = 'Show Selection Button Menu Items in Editor Context Menu.'
          TabOrder = 2
        end
        object chkShowColor: TCheckBox
          Left = 24
          Top = 36
          Width = 321
          Height = 17
          Caption = 'Show Color Preview when Color String Selected.'
          TabOrder = 1
        end
      end
      object grpAutoSave: TGroupBox
        Left = 8
        Top = 321
        Width = 361
        Height = 64
        Caption = 'Auto &Save'
        TabOrder = 3
        object lblSaveInterval: TLabel
          Left = 26
          Top = 36
          Width = 69
          Height = 13
          Caption = 'Save All Every'
        end
        object lblMinutes: TLabel
          Left = 200
          Top = 36
          Width = 41
          Height = 13
          Caption = 'Minutes.'
        end
        object chkAutoSave: TCheckBox
          Left = 8
          Top = 16
          Width = 350
          Height = 17
          Caption = 'Auto Save All'
          TabOrder = 0
          OnClick = UpdateContent
        end
        object seSaveInterval: TCnSpinEdit
          Left = 136
          Top = 34
          Width = 49
          Height = 22
          MaxValue = 30
          MinValue = 1
          TabOrder = 1
          Value = 3
        end
      end
      object grpSmart: TGroupBox
        Left = 8
        Top = 231
        Width = 361
        Height = 82
        Caption = 'Cli&pboard Operations'
        TabOrder = 2
        object chkSmartCopy: TCheckBox
          Left = 8
          Top = 16
          Width = 350
          Height = 17
          Caption = 'Cut / Copy Token under Cursor when No Selection.'
          TabOrder = 0
        end
        object chkSmartPaste: TCheckBox
          Left = 8
          Top = 36
          Width = 350
          Height = 17
          Caption = 'Smart Paste.'
          TabOrder = 1
          OnClick = UpdateContent
        end
        object chkPasteReplace: TCheckBox
          Left = 24
          Top = 56
          Width = 321
          Height = 17
          Caption = 'Replace Token under Cursor when Pasting.'
          TabOrder = 2
        end
      end
      object chkShowThumbnail: TCheckBox
        Left = 16
        Top = 392
        Width = 350
        Height = 17
        Caption = 'Show Preview Hint Window when Cursor on Vertical ScrollBar.'
        TabOrder = 4
      end
    end
    object ts4: TTabSheet
      Caption = 'Oth&ers'
      ImageIndex = 3
      object grpKeyExtend: TGroupBox
        Left = 8
        Top = 8
        Width = 361
        Height = 264
        Caption = '&Keyboard Extend'
        TabOrder = 0
        object chkShiftEnter: TCheckBox
          Left = 8
          Top = 38
          Width = 350
          Height = 17
          Caption = 'Use Shift+Enter to Move to Line End and Enter.'
          TabOrder = 1
        end
        object chkHomeExtend: TCheckBox
          Left = 8
          Top = 128
          Width = 350
          Height = 17
          Caption = 'Extend Home to Move Between Line Head and First No-Whitespace.'
          TabOrder = 7
          OnClick = UpdateContent
        end
        object chkHomeFirstChar: TCheckBox
          Left = 24
          Top = 146
          Width = 329
          Height = 17
          Caption = 'Move to First No-Whitespace if not in Line Head.'
          TabOrder = 8
        end
        object chkSearchAgain: TCheckBox
          Left = 8
          Top = 74
          Width = 350
          Height = 17
          Caption = 'F3/Shift+F3 to Search Selected Text.'
          TabOrder = 4
          OnClick = UpdateContent
        end
        object chkTabIndent: TCheckBox
          Left = 8
          Top = 20
          Width = 350
          Height = 17
          Caption = 'Tab/Shift+Tab to Indent/Unindent Selected Block.'
          TabOrder = 0
        end
        object chkAutoBracket: TCheckBox
          Left = 8
          Top = 110
          Width = 350
          Height = 17
          Caption = 'Auto Input Matched Bracket and Quote (), [], {} '#39#39', "".'
          TabOrder = 6
        end
        object chkKeepSearch: TCheckBox
          Left = 24
          Top = 92
          Width = 330
          Height = 17
          Caption = 'Let IDE Remember F3/Shift+F3 Search Text. '
          TabOrder = 5
        end
        object chkF2Rename: TCheckBox
          Left = 8
          Top = 56
          Width = 350
          Height = 17
          Caption = 'Rename and Replace Identifier under Cursor with:'
          TabOrder = 2
          OnClick = UpdateContent
        end
        object hkRename: THotKey
          Left = 272
          Top = 54
          Width = 73
          Height = 19
          HotKey = 32833
          InvalidKeys = [hcNone]
          Modifiers = [hkAlt]
          TabOrder = 3
        end
        object chkSemicolon: TCheckBox
          Left = 8
          Top = 218
          Width = 350
          Height = 17
          Caption = 'Put to Line End when Enter ";" in Source Code.'
          TabOrder = 12
          OnClick = UpdateContent
        end
        object chkAutoEnterEnd: TCheckBox
          Left = 8
          Top = 236
          Width = 350
          Height = 17
          Caption = 'Auto Add "end" when Pressing Enter after "begin".'
          TabOrder = 13
          OnClick = UpdateContent
        end
        object chkLeftWrapLine: TCheckBox
          Left = 8
          Top = 182
          Width = 350
          Height = 17
          Caption = 'Wrap Cursor when Press Left at Line Head.'
          TabOrder = 10
          OnClick = UpdateContent
        end
        object chkCursorBeforeEOL: TCheckBox
          Left = 8
          Top = 164
          Width = 350
          Height = 17
          Caption = 'Keep Cursor Before End of Line.'
          TabOrder = 9
          OnClick = UpdateContent
        end
        object chkRightWrapLine: TCheckBox
          Left = 8
          Top = 200
          Width = 350
          Height = 17
          Caption = 'Wrap Cursor when Press Right at Line End.'
          TabOrder = 11
          OnClick = UpdateContent
        end
      end
      object grpAutoIndent: TGroupBox
        Left = 8
        Top = 278
        Width = 361
        Height = 150
        Caption = 'Auto &Indent'
        TabOrder = 1
        object lbl3: TLabel
          Left = 24
          Top = 37
          Width = 175
          Height = 13
          Caption = 'Delphi Keyword List for Auto Indent:'
        end
        object chkAutoIndent: TCheckBox
          Left = 8
          Top = 16
          Width = 345
          Height = 17
          Caption = 'Auto &Indent for Special Keywords in Delphi or '#39'{'#39' in C File.'
          TabOrder = 0
          OnClick = UpdateContent
        end
        object mmoAutoIndent: TMemo
          Left = 24
          Top = 56
          Width = 325
          Height = 78
          ScrollBars = ssVertical
          TabOrder = 1
          WordWrap = False
        end
      end
    end
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 8
    Top = 416
    object actReplace: TAction
      Caption = '&Replace'
      OnExecute = actReplaceExecute
    end
    object actAdd: TAction
      Caption = '&Add'
      OnExecute = actAddExecute
    end
    object actDelete: TAction
      Caption = '&Delete'
      OnExecute = actDeleteExecute
    end
  end
  object dlgFontCurrLine: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 72
    Top = 416
  end
  object dlgFontLine: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 40
    Top = 416
  end
end
