{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     中国人自己的开放源码第三方开发包                         }
{                   (C)Copyright 2001-2025 CnPack 开发组                       }
{                   ------------------------------------                       }
{                                                                              }
{            本开发包是开源的自由软件，您可以遵照 CnPack 的发布协议来修        }
{        改和重新发布这一程序。                                                }
{                                                                              }
{            发布这一开发包的目的是希望它有用，但没有任何担保。甚至没有        }
{        适合特定目的而隐含的担保。更详细的情况请参阅 CnPack 发布协议。        }
{                                                                              }
{            您应该已经和开发包一起收到一份 CnPack 发布协议的副本。如果        }
{        还没有，可访问我们的网站：                                            }
{                                                                              }
{            网站地址：https://www.cnpack.org                                  }
{            电子邮件：master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnScript_Dialogs;
{ |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家包
* 单元名称：脚本扩展 ComCtrls 注册类
* 单元作者：周劲羽 (zjy@cnpack.org)
* 备    注：该单元由 UnitParser v0.7 自动生成的文件修改而来
* 开发平台：PWinXP SP2 + Delphi 5.01
* 兼容测试：PWin9X/2000/XP + Delphi 5/6/7
* 本 地 化：该窗体中的字符串支持本地化处理方式
* 修改记录：2006.12.11 V1.0
*               创建单元
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

uses
  Windows, SysUtils, Graphics, Classes, Controls, Dialogs, ExtDlgs, Forms,
  uPSComponent, uPSRuntime, uPSCompiler;

type

  TPSImport_Dialogs = class(TPSPlugin)
  public
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;

  { compile-time registration functions }
procedure SIRegister_TReplaceDialog(CL: TPSPascalCompiler);
procedure SIRegister_TFindDialog(CL: TPSPascalCompiler);
procedure SIRegister_TPrintDialog(CL: TPSPascalCompiler);
procedure SIRegister_TPrinterSetupDialog(CL: TPSPascalCompiler);
procedure SIRegister_TFontDialog(CL: TPSPascalCompiler);
procedure SIRegister_TColorDialog(CL: TPSPascalCompiler);
procedure SIRegister_TSaveDialog(CL: TPSPascalCompiler);
procedure SIRegister_TOpenDialog(CL: TPSPascalCompiler);
procedure SIRegister_TCommonDialog(CL: TPSPascalCompiler);
procedure SIRegister_Dialogs(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_Dialogs_Routines(S: TPSExec);
procedure RIRegister_TReplaceDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_TFindDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_TPrintDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_TPrinterSetupDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_TFontDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_TColorDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_TSaveDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_TOpenDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_TCommonDialog(CL: TPSRuntimeClassImporter);
procedure RIRegister_Dialogs(CL: TPSRuntimeClassImporter);

implementation

(* === compile-time registration functions === *)

procedure SIRegister_TReplaceDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TFindDialog', 'TReplaceDialog') do
  with CL.AddClass(CL.FindClass('TFindDialog'), TReplaceDialog) do
  begin
  end;
end;

procedure SIRegister_TFindDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCommonDialog', 'TFindDialog') do
  with CL.AddClass(CL.FindClass('TCommonDialog'), TFindDialog) do
  begin
    RegisterMethod('Procedure CloseDialog');
    RegisterProperty('Left', 'Integer', iptrw);
    RegisterProperty('Position', 'TPoint', iptrw);
    RegisterProperty('Top', 'Integer', iptrw);
    RegisterProperty('FindText', 'string', iptrw);
    RegisterProperty('Options', 'TFindOptions', iptrw);
    RegisterProperty('OnFind', 'TNotifyEvent', iptrw);
  end;
end;

procedure SIRegister_TPrintDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCommonDialog', 'TPrintDialog') do
  with CL.AddClass(CL.FindClass('TCommonDialog'), TPrintDialog) do
  begin
    RegisterProperty('Collate', 'Boolean', iptrw);
    RegisterProperty('Copies', 'Integer', iptrw);
    RegisterProperty('FromPage', 'Integer', iptrw);
    RegisterProperty('MinPage', 'Integer', iptrw);
    RegisterProperty('MaxPage', 'Integer', iptrw);
    RegisterProperty('Options', 'TPrintDialogOptions', iptrw);
    RegisterProperty('PrintToFile', 'Boolean', iptrw);
    RegisterProperty('PrintRange', 'TPrintRange', iptrw);
    RegisterProperty('ToPage', 'Integer', iptrw);
  end;
end;

procedure SIRegister_TPrinterSetupDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCommonDialog', 'TPrinterSetupDialog') do
  with CL.AddClass(CL.FindClass('TCommonDialog'), TPrinterSetupDialog) do
  begin
  end;
end;

procedure SIRegister_TFontDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCommonDialog', 'TFontDialog') do
  with CL.AddClass(CL.FindClass('TCommonDialog'), TFontDialog) do
  begin
    RegisterProperty('Font', 'TFont', iptrw);
    RegisterProperty('Device', 'TFontDialogDevice', iptrw);
    RegisterProperty('MinFontSize', 'Integer', iptrw);
    RegisterProperty('MaxFontSize', 'Integer', iptrw);
    RegisterProperty('Options', 'TFontDialogOptions', iptrw);
    RegisterProperty('OnApply', 'TFDApplyEvent', iptrw);
  end;
end;

procedure SIRegister_TColorDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCommonDialog', 'TColorDialog') do
  with CL.AddClass(CL.FindClass('TCommonDialog'), TColorDialog) do
  begin
    RegisterProperty('Color', 'TColor', iptrw);
    RegisterProperty('CustomColors', 'TStrings', iptrw);
    RegisterProperty('Options', 'TColorDialogOptions', iptrw);
  end;
end;

procedure SIRegister_TSaveDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TOpenDialog', 'TSaveDialog') do
  with CL.AddClass(CL.FindClass('TOpenDialog'), TSaveDialog) do
  begin
  end;
end;

procedure SIRegister_TOpenDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TCommonDialog', 'TOpenDialog') do
  with CL.AddClass(CL.FindClass('TCommonDialog'), TOpenDialog) do
  begin
    RegisterProperty('FileEditStyle', 'TFileEditStyle', iptrw);
    RegisterProperty('Files', 'TStrings', iptr);
    RegisterProperty('HistoryList', 'TStrings', iptrw);
    RegisterProperty('DefaultExt', 'string', iptrw);
    RegisterProperty('FileName', 'TFileName', iptrw);
    RegisterProperty('Filter', 'string', iptrw);
    RegisterProperty('FilterIndex', 'Integer', iptrw);
    RegisterProperty('InitialDir', 'string', iptrw);
    RegisterProperty('Options', 'TOpenOptions', iptrw);
    RegisterProperty('Title', 'string', iptrw);
    RegisterProperty('OnCanClose', 'TCloseQueryEvent', iptrw);
    RegisterProperty('OnFolderChange', 'TNotifyEvent', iptrw);
    RegisterProperty('OnSelectionChange', 'TNotifyEvent', iptrw);
    RegisterProperty('OnTypeChange', 'TNotifyEvent', iptrw);
  end;
end;

procedure SIRegister_TCommonDialog(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TComponent', 'TCommonDialog') do
  with CL.AddClass(CL.FindClass('TComponent'), TCommonDialog) do
  begin
    RegisterMethod('Function Execute : Boolean');
    RegisterProperty('Handle', 'HWnd', iptr);
    RegisterProperty('Ctl3D', 'Boolean', iptrw);
    RegisterProperty('HelpContext', 'THelpContext', iptrw);
    RegisterProperty('OnClose', 'TNotifyEvent', iptrw);
    RegisterProperty('OnShow', 'TNotifyEvent', iptrw);
  end;
end;

procedure SIRegister_Dialogs(CL: TPSPascalCompiler);
begin
  SIRegister_TCommonDialog(CL);
  CL.AddTypeS('TOpenOption', '( ofReadOnly, ofOverwritePrompt, ofHideReadOnly, '
    + 'ofNoChangeDir, ofShowHelp, ofNoValidate, ofAllowMultiSelect, ofExtensionDi'
    + 'fferent, ofPathMustExist, ofFileMustExist, ofCreatePrompt, ofShareAware, o'
    + 'fNoReadOnlyReturn, ofNoTestFileCreate, ofNoNetworkButton, ofNoLongNames, o'
    + 'fOldStyleDialog, ofNoDereferenceLinks, ofEnableIncludeNotify, ofEnableSizi'
    + 'ng )');
  CL.AddTypeS('TOpenOptions', 'set of TOpenOption');
  CL.AddTypeS('TFileEditStyle', '( fsEdit, fsComboBox )');
  SIRegister_TOpenDialog(CL);
  SIRegister_TSaveDialog(CL);
  CL.AddTypeS('TColorDialogOption', '( cdFullOpen, cdPreventFullOpen, cdShowHel'
    + 'p, cdSolidColor, cdAnyColor )');
  CL.AddTypeS('TColorDialogOptions', 'set of TColorDialogOption');
  SIRegister_TColorDialog(CL);
  CL.AddTypeS('TFontDialogOption', '( fdAnsiOnly, fdTrueTypeOnly, fdEffects, fd'
    + 'FixedPitchOnly, fdForceFontExist, fdNoFaceSel, fdNoOEMFonts, fdNoSimulatio'
    + 'ns, fdNoSizeSel, fdNoStyleSel, fdNoVectorFonts, fdShowHelp, fdWysiwyg, fdL'
    + 'imitSize, fdScalableOnly, fdApplyButton )');
  CL.AddTypeS('TFontDialogOptions', 'set of TFontDialogOption');
  CL.AddTypeS('TFontDialogDevice', '( fdScreen, fdPrinter, fdBoth )');
  CL.AddTypeS('TFDApplyEvent', 'Procedure ( Sender : TObject; Wnd : HWND)');
  SIRegister_TFontDialog(CL);
  SIRegister_TPrinterSetupDialog(CL);
  CL.AddTypeS('TPrintRange', '( prAllPages, prSelection, prPageNums )');
  CL.AddTypeS('TPrintDialogOption', '( poPrintToFile, poPageNums, poSelection, '
    + 'poWarning, poHelp, poDisablePrintToFile )');
  CL.AddTypeS('TPrintDialogOptions', 'set of TPrintDialogOption');
  SIRegister_TPrintDialog(CL);
  CL.AddTypeS('TFindOption', '( frDown, frFindNext, frHideMatchCase, frHideWhol'
    + 'eWord, frHideUpDown, frMatchCase, frDisableMatchCase, frDisableUpDown, frD'
    + 'isableWholeWord, frReplace, frReplaceAll, frWholeWord, frShowHelp )');
  CL.AddTypeS('TFindOptions', 'set of TFindOption');
  SIRegister_TFindDialog(CL);
  SIRegister_TReplaceDialog(CL);
  CL.AddTypeS('TMsgDlgType', '( mtWarning, mtError, mtInformation, mtConfirmati'
    + 'on, mtCustom )');
  CL.AddTypeS('TMsgDlgBtn', '( mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, m'
    + 'bIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp )');
  CL.AddTypeS('TMsgDlgButtons', 'set of TMsgDlgBtn');
  CL.AddConstantN('mbYesNoCancel', 'LongInt').Value.ts32 := ord(mbYes) or ord(mbNo) or ord(mbCancel);
  CL.AddConstantN('mbOKCancel', 'LongInt').Value.ts32 := ord(mbOK) or ord(mbCancel);
  CL.AddConstantN('mbAbortRetryIgnore', 'LongInt').Value.ts32 := ord(mbAbort) or ord(mbRetry) or ord(mbIgnore);
  CL.AddDelphiFunction('Function CreateMessageDialog( const Msg : string; DlgType : TMsgDlgType; Buttons : TMsgDlgButtons) : TForm');
  CL.AddDelphiFunction('Function MessageDlg( const Msg : string; DlgType : TMsgDlgType; Buttons : TMsgDlgButtons; HelpCtx : Longint) : Integer');
  CL.AddDelphiFunction('Function MessageDlgPos( const Msg : string; DlgType : TMsgDlgType; Buttons : TMsgDlgButtons; HelpCtx : Longint; X, Y : Integer) : Integer');
  CL.AddDelphiFunction('Function MessageDlgPosHelp( const Msg : string; DlgType : TMsgDlgType; Buttons : TMsgDlgButtons; HelpCtx : Longint; X, Y : Integer; const HelpFileName : string) : Integer');
  CL.AddDelphiFunction('Procedure ShowMessage( const Msg : string)');
  CL.AddDelphiFunction('Procedure ShowMessageFmt( const Msg : string; Params : array of const)');
  CL.AddDelphiFunction('Procedure ShowMessagePos( const Msg : string; X, Y : Integer)');
  CL.AddDelphiFunction('Function InputBox( const ACaption, APrompt, ADefault : string) : string');
  CL.AddDelphiFunction('Function InputQuery( const ACaption, APrompt : string; var Value : string) : Boolean');
end;

(* === run-time registration functions === *)

procedure TFindDialogOnFind_W(Self: TFindDialog; const T: TNotifyEvent);
begin
  Self.OnFind := T;
end;

procedure TFindDialogOnFind_R(Self: TFindDialog; var T: TNotifyEvent);
begin
  T := Self.OnFind;
end;

procedure TFindDialogOptions_W(Self: TFindDialog; const T: TFindOptions);
begin
  Self.Options := T;
end;

procedure TFindDialogOptions_R(Self: TFindDialog; var T: TFindOptions);
begin
  T := Self.Options;
end;

procedure TFindDialogFindText_W(Self: TFindDialog; const T: string);
begin
  Self.FindText := T;
end;

procedure TFindDialogFindText_R(Self: TFindDialog; var T: string);
begin
  T := Self.FindText;
end;

procedure TFindDialogTop_W(Self: TFindDialog; const T: Integer);
begin
  Self.Top := T;
end;

procedure TFindDialogTop_R(Self: TFindDialog; var T: Integer);
begin
  T := Self.Top;
end;

procedure TFindDialogPosition_W(Self: TFindDialog; const T: TPoint);
begin
  Self.Position := T;
end;

procedure TFindDialogPosition_R(Self: TFindDialog; var T: TPoint);
begin
  T := Self.Position;
end;

procedure TFindDialogLeft_W(Self: TFindDialog; const T: Integer);
begin
  Self.Left := T;
end;

procedure TFindDialogLeft_R(Self: TFindDialog; var T: Integer);
begin
  T := Self.Left;
end;

procedure TPrintDialogToPage_W(Self: TPrintDialog; const T: Integer);
begin
  Self.ToPage := T;
end;

procedure TPrintDialogToPage_R(Self: TPrintDialog; var T: Integer);
begin
  T := Self.ToPage;
end;

procedure TPrintDialogPrintRange_W(Self: TPrintDialog; const T: TPrintRange);
begin
  Self.PrintRange := T;
end;

procedure TPrintDialogPrintRange_R(Self: TPrintDialog; var T: TPrintRange);
begin
  T := Self.PrintRange;
end;

procedure TPrintDialogPrintToFile_W(Self: TPrintDialog; const T: Boolean);
begin
  Self.PrintToFile := T;
end;

procedure TPrintDialogPrintToFile_R(Self: TPrintDialog; var T: Boolean);
begin
  T := Self.PrintToFile;
end;

procedure TPrintDialogOptions_W(Self: TPrintDialog; const T: TPrintDialogOptions);
begin
  Self.Options := T;
end;

procedure TPrintDialogOptions_R(Self: TPrintDialog; var T: TPrintDialogOptions);
begin
  T := Self.Options;
end;

procedure TPrintDialogMaxPage_W(Self: TPrintDialog; const T: Integer);
begin
  Self.MaxPage := T;
end;

procedure TPrintDialogMaxPage_R(Self: TPrintDialog; var T: Integer);
begin
  T := Self.MaxPage;
end;

procedure TPrintDialogMinPage_W(Self: TPrintDialog; const T: Integer);
begin
  Self.MinPage := T;
end;

procedure TPrintDialogMinPage_R(Self: TPrintDialog; var T: Integer);
begin
  T := Self.MinPage;
end;

procedure TPrintDialogFromPage_W(Self: TPrintDialog; const T: Integer);
begin
  Self.FromPage := T;
end;

procedure TPrintDialogFromPage_R(Self: TPrintDialog; var T: Integer);
begin
  T := Self.FromPage;
end;

procedure TPrintDialogCopies_W(Self: TPrintDialog; const T: Integer);
begin
  Self.Copies := T;
end;

procedure TPrintDialogCopies_R(Self: TPrintDialog; var T: Integer);
begin
  T := Self.Copies;
end;

procedure TPrintDialogCollate_W(Self: TPrintDialog; const T: Boolean);
begin
  Self.Collate := T;
end;

procedure TPrintDialogCollate_R(Self: TPrintDialog; var T: Boolean);
begin
  T := Self.Collate;
end;

procedure TFontDialogOnApply_W(Self: TFontDialog; const T: TFDApplyEvent);
begin
  Self.OnApply := T;
end;

procedure TFontDialogOnApply_R(Self: TFontDialog; var T: TFDApplyEvent);
begin
  T := Self.OnApply;
end;

procedure TFontDialogOptions_W(Self: TFontDialog; const T: TFontDialogOptions);
begin
  Self.Options := T;
end;

procedure TFontDialogOptions_R(Self: TFontDialog; var T: TFontDialogOptions);
begin
  T := Self.Options;
end;

procedure TFontDialogMaxFontSize_W(Self: TFontDialog; const T: Integer);
begin
  Self.MaxFontSize := T;
end;

procedure TFontDialogMaxFontSize_R(Self: TFontDialog; var T: Integer);
begin
  T := Self.MaxFontSize;
end;

procedure TFontDialogMinFontSize_W(Self: TFontDialog; const T: Integer);
begin
  Self.MinFontSize := T;
end;

procedure TFontDialogMinFontSize_R(Self: TFontDialog; var T: Integer);
begin
  T := Self.MinFontSize;
end;

procedure TFontDialogDevice_W(Self: TFontDialog; const T: TFontDialogDevice);
begin
  Self.Device := T;
end;

procedure TFontDialogDevice_R(Self: TFontDialog; var T: TFontDialogDevice);
begin
  T := Self.Device;
end;

procedure TFontDialogFont_W(Self: TFontDialog; const T: TFont);
begin
  Self.Font := T;
end;

procedure TFontDialogFont_R(Self: TFontDialog; var T: TFont);
begin
  T := Self.Font;
end;

procedure TColorDialogOptions_W(Self: TColorDialog; const T: TColorDialogOptions);
begin
  Self.Options := T;
end;

procedure TColorDialogOptions_R(Self: TColorDialog; var T: TColorDialogOptions);
begin
  T := Self.Options;
end;

procedure TColorDialogCustomColors_W(Self: TColorDialog; const T: TStrings);
begin
  Self.CustomColors := T;
end;

procedure TColorDialogCustomColors_R(Self: TColorDialog; var T: TStrings);
begin
  T := Self.CustomColors;
end;

procedure TColorDialogColor_W(Self: TColorDialog; const T: TColor);
begin
  Self.Color := T;
end;

procedure TColorDialogColor_R(Self: TColorDialog; var T: TColor);
begin
  T := Self.Color;
end;

procedure TOpenDialogOnTypeChange_W(Self: TOpenDialog; const T: TNotifyEvent);
begin
  Self.OnTypeChange := T;
end;

procedure TOpenDialogOnTypeChange_R(Self: TOpenDialog; var T: TNotifyEvent);
begin
  T := Self.OnTypeChange;
end;

procedure TOpenDialogOnSelectionChange_W(Self: TOpenDialog; const T: TNotifyEvent);
begin
  Self.OnSelectionChange := T;
end;

procedure TOpenDialogOnSelectionChange_R(Self: TOpenDialog; var T: TNotifyEvent);
begin
  T := Self.OnSelectionChange;
end;

procedure TOpenDialogOnFolderChange_W(Self: TOpenDialog; const T: TNotifyEvent);
begin
  Self.OnFolderChange := T;
end;

procedure TOpenDialogOnFolderChange_R(Self: TOpenDialog; var T: TNotifyEvent);
begin
  T := Self.OnFolderChange;
end;

procedure TOpenDialogOnCanClose_W(Self: TOpenDialog; const T: TCloseQueryEvent);
begin
  Self.OnCanClose := T;
end;

procedure TOpenDialogOnCanClose_R(Self: TOpenDialog; var T: TCloseQueryEvent);
begin
  T := Self.OnCanClose;
end;

procedure TOpenDialogTitle_W(Self: TOpenDialog; const T: string);
begin
  Self.Title := T;
end;

procedure TOpenDialogTitle_R(Self: TOpenDialog; var T: string);
begin
  T := Self.Title;
end;

procedure TOpenDialogOptions_W(Self: TOpenDialog; const T: TOpenOptions);
begin
  Self.Options := T;
end;

procedure TOpenDialogOptions_R(Self: TOpenDialog; var T: TOpenOptions);
begin
  T := Self.Options;
end;

procedure TOpenDialogInitialDir_W(Self: TOpenDialog; const T: string);
begin
  Self.InitialDir := T;
end;

procedure TOpenDialogInitialDir_R(Self: TOpenDialog; var T: string);
begin
  T := Self.InitialDir;
end;

procedure TOpenDialogFilterIndex_W(Self: TOpenDialog; const T: Integer);
begin
  Self.FilterIndex := T;
end;

procedure TOpenDialogFilterIndex_R(Self: TOpenDialog; var T: Integer);
begin
  T := Self.FilterIndex;
end;

procedure TOpenDialogFilter_W(Self: TOpenDialog; const T: string);
begin
  Self.Filter := T;
end;

procedure TOpenDialogFilter_R(Self: TOpenDialog; var T: string);
begin
  T := Self.Filter;
end;

procedure TOpenDialogFileName_W(Self: TOpenDialog; const T: TFileName);
begin
  Self.FileName := T;
end;

procedure TOpenDialogFileName_R(Self: TOpenDialog; var T: TFileName);
begin
  T := Self.FileName;
end;

procedure TOpenDialogDefaultExt_W(Self: TOpenDialog; const T: string);
begin
  Self.DefaultExt := T;
end;

procedure TOpenDialogDefaultExt_R(Self: TOpenDialog; var T: string);
begin
  T := Self.DefaultExt;
end;

procedure TOpenDialogHistoryList_W(Self: TOpenDialog; const T: TStrings);
begin
  Self.HistoryList := T;
end;

procedure TOpenDialogHistoryList_R(Self: TOpenDialog; var T: TStrings);
begin
  T := Self.HistoryList;
end;

procedure TOpenDialogFiles_R(Self: TOpenDialog; var T: TStrings);
begin
  T := Self.Files;
end;

procedure TOpenDialogFileEditStyle_W(Self: TOpenDialog; const T: TFileEditStyle);
begin
  Self.FileEditStyle := T;
end;

procedure TOpenDialogFileEditStyle_R(Self: TOpenDialog; var T: TFileEditStyle);
begin
  T := Self.FileEditStyle;
end;

procedure TCommonDialogOnShow_W(Self: TCommonDialog; const T: TNotifyEvent);
begin
  Self.OnShow := T;
end;

procedure TCommonDialogOnShow_R(Self: TCommonDialog; var T: TNotifyEvent);
begin
  T := Self.OnShow;
end;

procedure TCommonDialogOnClose_W(Self: TCommonDialog; const T: TNotifyEvent);
begin
  Self.OnClose := T;
end;

procedure TCommonDialogOnClose_R(Self: TCommonDialog; var T: TNotifyEvent);
begin
  T := Self.OnClose;
end;

procedure TCommonDialogHelpContext_W(Self: TCommonDialog; const T: THelpContext);
begin
  Self.HelpContext := T;
end;

procedure TCommonDialogHelpContext_R(Self: TCommonDialog; var T: THelpContext);
begin
  T := Self.HelpContext;
end;

procedure TCommonDialogCtl3D_W(Self: TCommonDialog; const T: Boolean);
begin
  Self.Ctl3D := T;
end;

procedure TCommonDialogCtl3D_R(Self: TCommonDialog; var T: Boolean);
begin
  T := Self.Ctl3D;
end;

procedure TCommonDialogHandle_R(Self: TCommonDialog; var T: HWnd);
begin
  T := Self.Handle;
end;

procedure RIRegister_Dialogs_Routines(S: TPSExec);
begin
  S.RegisterDelphiFunction(@CreateMessageDialog, 'CreateMessageDialog', cdRegister);
  S.RegisterDelphiFunction(@MessageDlg, 'MessageDlg', cdRegister);
  S.RegisterDelphiFunction(@MessageDlgPos, 'MessageDlgPos', cdRegister);
  S.RegisterDelphiFunction(@MessageDlgPosHelp, 'MessageDlgPosHelp', cdRegister);
  S.RegisterDelphiFunction(@ShowMessage, 'ShowMessage', cdRegister);
  S.RegisterDelphiFunction(@ShowMessageFmt, 'ShowMessageFmt', cdRegister);
  S.RegisterDelphiFunction(@ShowMessagePos, 'ShowMessagePos', cdRegister);
  S.RegisterDelphiFunction(@InputBox, 'InputBox', cdRegister);
  S.RegisterDelphiFunction(@InputQuery, 'InputQuery', cdRegister);
end;

procedure RIRegister_TReplaceDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TReplaceDialog) do
  begin
  end;
end;

procedure RIRegister_TFindDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TFindDialog) do
  begin
    RegisterMethod(@TFindDialog.CloseDialog, 'CloseDialog');
    RegisterPropertyHelper(@TFindDialogLeft_R, @TFindDialogLeft_W, 'Left');
    RegisterPropertyHelper(@TFindDialogPosition_R, @TFindDialogPosition_W, 'Position');
    RegisterPropertyHelper(@TFindDialogTop_R, @TFindDialogTop_W, 'Top');
    RegisterPropertyHelper(@TFindDialogFindText_R, @TFindDialogFindText_W, 'FindText');
    RegisterPropertyHelper(@TFindDialogOptions_R, @TFindDialogOptions_W, 'Options');
    RegisterPropertyHelper(@TFindDialogOnFind_R, @TFindDialogOnFind_W, 'OnFind');
  end;
end;

procedure RIRegister_TPrintDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TPrintDialog) do
  begin
    RegisterPropertyHelper(@TPrintDialogCollate_R, @TPrintDialogCollate_W, 'Collate');
    RegisterPropertyHelper(@TPrintDialogCopies_R, @TPrintDialogCopies_W, 'Copies');
    RegisterPropertyHelper(@TPrintDialogFromPage_R, @TPrintDialogFromPage_W, 'FromPage');
    RegisterPropertyHelper(@TPrintDialogMinPage_R, @TPrintDialogMinPage_W, 'MinPage');
    RegisterPropertyHelper(@TPrintDialogMaxPage_R, @TPrintDialogMaxPage_W, 'MaxPage');
    RegisterPropertyHelper(@TPrintDialogOptions_R, @TPrintDialogOptions_W, 'Options');
    RegisterPropertyHelper(@TPrintDialogPrintToFile_R, @TPrintDialogPrintToFile_W, 'PrintToFile');
    RegisterPropertyHelper(@TPrintDialogPrintRange_R, @TPrintDialogPrintRange_W, 'PrintRange');
    RegisterPropertyHelper(@TPrintDialogToPage_R, @TPrintDialogToPage_W, 'ToPage');
  end;
end;

procedure RIRegister_TPrinterSetupDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TPrinterSetupDialog) do
  begin
  end;
end;

procedure RIRegister_TFontDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TFontDialog) do
  begin
    RegisterPropertyHelper(@TFontDialogFont_R, @TFontDialogFont_W, 'Font');
    RegisterPropertyHelper(@TFontDialogDevice_R, @TFontDialogDevice_W, 'Device');
    RegisterPropertyHelper(@TFontDialogMinFontSize_R, @TFontDialogMinFontSize_W, 'MinFontSize');
    RegisterPropertyHelper(@TFontDialogMaxFontSize_R, @TFontDialogMaxFontSize_W, 'MaxFontSize');
    RegisterPropertyHelper(@TFontDialogOptions_R, @TFontDialogOptions_W, 'Options');
    RegisterPropertyHelper(@TFontDialogOnApply_R, @TFontDialogOnApply_W, 'OnApply');
  end;
end;

procedure RIRegister_TColorDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TColorDialog) do
  begin
    RegisterPropertyHelper(@TColorDialogColor_R, @TColorDialogColor_W, 'Color');
    RegisterPropertyHelper(@TColorDialogCustomColors_R, @TColorDialogCustomColors_W, 'CustomColors');
    RegisterPropertyHelper(@TColorDialogOptions_R, @TColorDialogOptions_W, 'Options');
  end;
end;

procedure RIRegister_TSaveDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TSaveDialog) do
  begin
  end;
end;

procedure RIRegister_TOpenDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TOpenDialog) do
  begin
    RegisterPropertyHelper(@TOpenDialogFileEditStyle_R, @TOpenDialogFileEditStyle_W, 'FileEditStyle');
    RegisterPropertyHelper(@TOpenDialogFiles_R, nil, 'Files');
    RegisterPropertyHelper(@TOpenDialogHistoryList_R, @TOpenDialogHistoryList_W, 'HistoryList');
    RegisterPropertyHelper(@TOpenDialogDefaultExt_R, @TOpenDialogDefaultExt_W, 'DefaultExt');
    RegisterPropertyHelper(@TOpenDialogFileName_R, @TOpenDialogFileName_W, 'FileName');
    RegisterPropertyHelper(@TOpenDialogFilter_R, @TOpenDialogFilter_W, 'Filter');
    RegisterPropertyHelper(@TOpenDialogFilterIndex_R, @TOpenDialogFilterIndex_W, 'FilterIndex');
    RegisterPropertyHelper(@TOpenDialogInitialDir_R, @TOpenDialogInitialDir_W, 'InitialDir');
    RegisterPropertyHelper(@TOpenDialogOptions_R, @TOpenDialogOptions_W, 'Options');
    RegisterPropertyHelper(@TOpenDialogTitle_R, @TOpenDialogTitle_W, 'Title');
    RegisterPropertyHelper(@TOpenDialogOnCanClose_R, @TOpenDialogOnCanClose_W, 'OnCanClose');
    RegisterPropertyHelper(@TOpenDialogOnFolderChange_R, @TOpenDialogOnFolderChange_W, 'OnFolderChange');
    RegisterPropertyHelper(@TOpenDialogOnSelectionChange_R, @TOpenDialogOnSelectionChange_W, 'OnSelectionChange');
    RegisterPropertyHelper(@TOpenDialogOnTypeChange_R, @TOpenDialogOnTypeChange_W, 'OnTypeChange');
  end;
end;

procedure RIRegister_TCommonDialog(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(TCommonDialog) do
  begin
    RegisterVirtualAbstractMethod(TOpenDialog, @TOpenDialog.Execute, 'Execute');
    RegisterPropertyHelper(@TCommonDialogHandle_R, nil, 'Handle');
    RegisterPropertyHelper(@TCommonDialogCtl3D_R, @TCommonDialogCtl3D_W, 'Ctl3D');
    RegisterPropertyHelper(@TCommonDialogHelpContext_R, @TCommonDialogHelpContext_W, 'HelpContext');
    RegisterPropertyHelper(@TCommonDialogOnClose_R, @TCommonDialogOnClose_W, 'OnClose');
    RegisterPropertyHelper(@TCommonDialogOnShow_R, @TCommonDialogOnShow_W, 'OnShow');
  end;
end;

procedure RIRegister_Dialogs(CL: TPSRuntimeClassImporter);
begin
  RIRegister_TCommonDialog(CL);
  RIRegister_TOpenDialog(CL);
  RIRegister_TSaveDialog(CL);
  RIRegister_TColorDialog(CL);
  RIRegister_TFontDialog(CL);
  RIRegister_TPrinterSetupDialog(CL);
  RIRegister_TPrintDialog(CL);
  RIRegister_TFindDialog(CL);
  RIRegister_TReplaceDialog(CL);
end;

{ TPSImport_Dialogs }

procedure TPSImport_Dialogs.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_Dialogs(CompExec.Comp);
end;

procedure TPSImport_Dialogs.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_Dialogs(ri);
  RIRegister_Dialogs_Routines(CompExec.Exec); // comment it if no routines
end;

end.




