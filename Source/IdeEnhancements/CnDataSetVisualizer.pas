{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     中国人自己的开放源码第三方开发包                         }
{                   (C)Copyright 2001-2024 CnPack 开发组                       }
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
{            网站地址：http://www.cnpack.org                                   }
{            电子邮件：master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnDataSetVisualizer;
{* |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家包
* 单元名称：针对 TDataSet 及其子类的调试期查看器
* 单元作者：CnPack开发组
* 备    注：结构参考了 VCL 中自带的各类 Visualizer
* 开发平台：PWin11 + Delphi 12
* 兼容测试：
* 本 地 化：该单元中的字符串均符合本地化处理方式
* 修改记录：2024.03.07 V1.0
*               创建单元
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

uses
  SysUtils, Classes, Graphics, Controls, Forms, Messages, Dialogs, ComCtrls,
  StdCtrls, Grids, ExtCtrls, ToolsAPI, CnWizConsts, CnWizDebuggerNotifier;

type
  TCnDataSetViewerFrame = class(TFrame, IOTADebuggerVisualizerExternalViewerUpdater)
    pcViews: TPageControl;
    tsProp: TTabSheet;
    mmoProp: TMemo;
    tsData: TTabSheet;
    Panel1: TPanel;
    grdData: TStringGrid;
    tsField: TTabSheet;
    grdField: TStringGrid;
    procedure pcViewsChange(Sender: TObject);
  private
    FExpression: string;
    FOwningForm: TCustomForm;
    FClosedProc: TOTAVisualizerClosedProcedure;
    FItems: TStrings;
    FAvailableState: TCnAvailableState;
    FEvaluator: TCnInProcessEvaluator;
    procedure SetForm(AForm: TCustomForm);
    procedure AddDataSetContent(const Expression, TypeName, EvalResult: string);
    procedure SetAvailableState(const AState: TCnAvailableState);
    procedure Clear;

    procedure WMDPIChangedAfterParent(var Message: TMessage); message WM_DPICHANGED_AFTERPARENT;
  protected
    procedure SetParent(AParent: TWinControl); override;

    procedure LanguageChanged(Sender: TObject);
    procedure Translate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { IOTADebuggerVisualizerExternalViewerUpdater }
    procedure CloseVisualizer;
    procedure MarkUnavailable(Reason: TOTAVisualizerUnavailableReason);
    procedure RefreshVisualizer(const Expression, TypeName, EvalResult: string);
    procedure SetClosedCallback(ClosedProc: TOTAVisualizerClosedProcedure);
  end;

  TCnDebuggerDataSetVisualizer = class(TInterfacedObject, IOTADebuggerVisualizer,
    IOTADebuggerVisualizer250, IOTADebuggerVisualizerExternalViewer)
  public
    { IOTADebuggerVisualizer }
    function GetSupportedTypeCount: Integer;
    procedure GetSupportedType(Index: Integer; var TypeName: string;
      var AllDescendants: Boolean); overload;
    function GetVisualizerIdentifier: string;
    function GetVisualizerName: string;
    function GetVisualizerDescription: string;
    { IOTADebuggerVisualizer250 }
    procedure GetSupportedType(Index: Integer; var TypeName: string;
      var AllDescendants: Boolean; var IsGeneric: Boolean); overload;
    { IOTADebuggerVisualizerExternalViewer }
    function GetMenuText: string;
    function Show(const Expression, TypeName, EvalResult: string;
      SuggestedLeft, SuggestedTop: Integer): IOTADebuggerVisualizerExternalViewerUpdater;
  end;

implementation

uses
  DesignIntf, Actnlist, ImgList, Menus, IniFiles, GraphUtil, BrandingAPI,
  CnLangMgr {$IFDEF DEBUG}, CnDebug {$ENDIF};

{$R *.dfm}

resourcestring
  sProcessNotAccessible = 'process not accessible';
  sValueNotAccessible = 'value not accessible';
  sOutOfScope = 'out of scope';

type
  ICnFrameFormHelper = interface
    ['{0FD4A98F-CE6B-422A-BF13-14E59707D3B2}']
    function GetForm: TCustomForm;
    function GetFrame: TCustomFrame;
    procedure SetForm(Form: TCustomForm);
    procedure SetFrame(Form: TCustomFrame);
  end;

  TCnDataSetVisualizerForm = class(TInterfacedObject, INTACustomDockableForm, ICnFrameFormHelper)
  private
    FMyFrame: TCnDataSetViewerFrame;
    FMyForm: TCustomForm;
    FExpression: string;
  public
    constructor Create(const Expression: string);
    { INTACustomDockableForm }
    function GetCaption: string;
    function GetFrameClass: TCustomFrameClass;
    procedure FrameCreated(AFrame: TCustomFrame);
    function GetIdentifier: string;
    function GetMenuActionList: TCustomActionList;
    function GetMenuImageList: TCustomImageList;
    procedure CustomizePopupMenu(PopupMenu: TPopupMenu);
    function GetToolbarActionList: TCustomActionList;
    function GetToolbarImageList: TCustomImageList;
    procedure CustomizeToolBar(ToolBar: TToolBar);
    procedure LoadWindowState(Desktop: TCustomIniFile; const Section: string);
    procedure SaveWindowState(Desktop: TCustomIniFile; const Section: string; IsProject: Boolean);
    function GetEditState: TEditState;
    function EditAction(Action: TEditAction): Boolean;
    { IFrameFormHelper }
    function GetForm: TCustomForm;
    function GetFrame: TCustomFrame;
    procedure SetForm(Form: TCustomForm);
    procedure SetFrame(Frame: TCustomFrame);
  end;

{ TCnDebuggerDataSetVisualizer }

function TCnDebuggerDataSetVisualizer.GetMenuText: string;
begin
  Result := SCnDebugDataSetViewerMenuText;
end;

function TCnDebuggerDataSetVisualizer.GetSupportedTypeCount: Integer;
begin
  Result := 1;
end;

procedure TCnDebuggerDataSetVisualizer.GetSupportedType(Index: Integer; var TypeName: string;
  var AllDescendants: Boolean);
begin
  TypeName := 'TDataSet';
  AllDescendants := True;
end;

procedure TCnDebuggerDataSetVisualizer.GetSupportedType(Index: Integer;
  var TypeName: string; var AllDescendants, IsGeneric: Boolean);
begin
  TypeName := 'TDataSet';
  AllDescendants := True;
  IsGeneric := False;
end;

function TCnDebuggerDataSetVisualizer.GetVisualizerDescription: string;
begin
  Result := SCnDebugDataSetViewerDescription;
end;

function TCnDebuggerDataSetVisualizer.GetVisualizerIdentifier: string;
begin
  Result := ClassName;
end;

function TCnDebuggerDataSetVisualizer.GetVisualizerName: string;
begin
  Result := SCnDebugDataSetViewerName;
end;

function TCnDebuggerDataSetVisualizer.Show(const Expression, TypeName, EvalResult: string;
  SuggestedLeft, SuggestedTop: Integer): IOTADebuggerVisualizerExternalViewerUpdater;
var
  AForm: TCustomForm;
  AFrame: TCnDataSetViewerFrame;
  VisDockForm: INTACustomDockableForm;
  LThemingServices: IOTAIDEThemingServices;
begin
  VisDockForm := TCnDataSetVisualizerForm.Create(Expression) as INTACustomDockableForm;
  AForm := (BorlandIDEServices as INTAServices).CreateDockableForm(VisDockForm);
  AForm.LockDrawing;
  try
    AForm.Left := SuggestedLeft;
    AForm.Top := SuggestedTop;
    (VisDockForm as ICnFrameFormHelper).SetForm(AForm);
    AFrame := (VisDockForm as ICnFrameFormHelper).GetFrame as TCnDataSetViewerFrame;
    AFrame.AddDataSetContent(Expression, TypeName, EvalResult);
    AFrame.pcViewsChange(nil);
    Result := AFrame as IOTADebuggerVisualizerExternalViewerUpdater;
    if Supports(BorlandIDEServices, IOTAIDEThemingServices, LThemingServices) and
      LThemingServices.IDEThemingEnabled then
    begin
      AFrame.Panel1.StyleElements := AFrame.Panel1.StyleElements - [seClient];
      AFrame.Panel1.ParentBackground := False;
      LThemingServices.ApplyTheme(AForm);
      AFrame.Panel1.Color := ColorBlendRGB(LThemingServices.StyleServices.GetSystemColor(clWindowText),
      LThemingServices.StyleServices.GetSystemColor(clWindow), 0.5);

      if TIDEThemeMetrics.Font.Enabled then
        AFrame.Font.Assign(TIDEThemeMetrics.Font.GetFont());
    end;
  finally
    AForm.UnlockDrawing;
  end;
end;

{ TCnDataSetViewerFrame }

procedure TCnDataSetViewerFrame.SetAvailableState(const AState: TCnAvailableState);
var
  S: string;
begin
  FAvailableState := AState;
  case FAvailableState of
    asAvailable:
      ;
    asProcRunning:
      S := sProcessNotAccessible;
    asOutOfScope:
      S := sOutOfScope;
    asNotAvailable:
      S := sValueNotAccessible;
  end;
  if S <> '' then
    mmoProp.Lines.Text := '';
end;

procedure TCnDataSetViewerFrame.AddDataSetContent(const Expression, TypeName,
  EvalResult: string);
var
  DebugSvcs: IOTADebuggerServices;
  CurProcess: IOTAProcess;
  CurThread: IOTAThread;
  S: string;
  I, C: Integer;
begin
  if Supports(BorlandIDEServices, IOTADebuggerServices, DebugSvcs) then
    CurProcess := DebugSvcs.CurrentProcess;
  if CurProcess = nil then
    Exit;
  CurThread := CurProcess.CurrentThread;
  if CurThread = nil then
    Exit;

  FExpression := Expression;
  SetAvailableState(asAvailable);

  Clear;

  S := FEvaluator.EvaluateExpression(FExpression + '.Active');
  mmoProp.Lines.Add('Active: ' + S);

  if LowerCase(S) = 'true' then
  begin
    S := FEvaluator.EvaluateExpression(FExpression + '.FieldCount');
    mmoProp.Lines.Add('FieldCount: ' + S);
    S := FEvaluator.EvaluateExpression(FExpression + '.RecordCount');
    mmoProp.Lines.Add('RecordCount: ' + S);
    S := FEvaluator.EvaluateExpression(FExpression + '.RecNo');
    mmoProp.Lines.Add('RecNo: ' + S);

    // Fields Defs
    S := FEvaluator.EvaluateExpression(FExpression+ '.FieldDefs.Count');
    C := StrToIntDef(S, 0);
    grdField.RowCount := C + 1;
    grdField.FixedRows := 1;
    grdField.ColCount := 5;
    grdfield.FixedCols := 0;

    for I := 0 to grdField.ColCount - 1 do
      grdField.ColWidths[I] := 90;

    grdField.Cells[0, 0] := 'Name';
    grdField.Cells[1, 0] := 'DataType';
    grdField.Cells[2, 0] := 'Size';
    grdField.Cells[3, 0] := 'Precision';
    grdField.Cells[4, 0] := 'Attribute';

    for I := 0 to C - 1 do // 行循环
    begin
      grdField.Cells[0, I + 1] := FEvaluator.EvaluateExpression(FExpression + Format('.FieldDefs.Items[%d].Name', [I]));
      grdField.Cells[1, I + 1] := FEvaluator.EvaluateExpression(FExpression + Format('.FieldDefs.Items[%d].DataType', [I]));
      grdField.Cells[2, I + 1] := FEvaluator.EvaluateExpression(FExpression + Format('.FieldDefs.Items[%d].Size', [I]));
      grdField.Cells[3, I + 1] := FEvaluator.EvaluateExpression(FExpression + Format('.FieldDefs.Items[%d].Precision', [I]));
      grdField.Cells[4, I + 1] := FEvaluator.EvaluateExpression(FExpression + Format('.FieldDefs.Items[%d].Attribute', [I]));
    end;

    // Data
    grdData.ColCount := C;
    grdData.RowCount := 2;
    grdData.FixedRows := 1;
    for I := 0 to grdData.ColCount - 1 do
      grdData.ColWidths[I] := 90;

    for I := 0 to C - 1 do // 列循环，打印当前记录的各字段值
    begin
      grdData.Cells[I, 0] := FEvaluator.EvaluateExpression(FExpression + Format('.FieldDefs.Items[%d].Name', [I]));
      grdData.Cells[I, 1] := FEvaluator.EvaluateExpression(FExpression + Format('.Fields[%d].AsString', [I]));
    end;
  end;
end;

procedure TCnDataSetViewerFrame.Clear;
begin
  mmoProp.Lines.Clear;
  grdField.RowCount := 1;
  grdField.ColCount := 1;
  grdField.Cells[0, 0] := '';
  grdData.RowCount := 1;
  grdData.ColCount := 1;
  grdData.Cells[0, 0] := '';
end;

procedure TCnDataSetViewerFrame.CloseVisualizer;
begin
  if FOwningForm <> nil then
    FOwningForm.Close;
end;

constructor TCnDataSetViewerFrame.Create(AOwner: TComponent);
begin
  inherited;
  DisableAlign;
  try
    Translate;
  finally
    EnableAlign;
  end;
  CnLanguageManager.AddChangeNotifier(LanguageChanged);
  FEvaluator := TCnInProcessEvaluator.Create(nil);
end;

destructor TCnDataSetViewerFrame.Destroy;
begin
  FEvaluator.Free;
  CnLanguageManager.RemoveChangeNotifier(LanguageChanged);
  inherited;
end;

procedure TCnDataSetViewerFrame.LanguageChanged(Sender: TObject);
begin
{$IFDEF DEBUG}
  CnDebugger.LogMsg('TCnDataSetViewerFrame.LanguageChanged');
{$ENDIF}
  DisableAlign;
  try
    CnLanguageManager.TranslateFrame(Self);
  finally
    EnableAlign;
  end;
end;

procedure TCnDataSetViewerFrame.MarkUnavailable(
  Reason: TOTAVisualizerUnavailableReason);
begin
  if Reason = ovurProcessRunning then
    SetAvailableState(asProcRunning)
  else if Reason = ovurOutOfScope then
    SetAvailableState(asOutOfScope);
end;

procedure TCnDataSetViewerFrame.RefreshVisualizer(const Expression, TypeName,
  EvalResult: string);
begin
  AddDataSetContent(Expression, TypeName, EvalResult);
end;

procedure TCnDataSetViewerFrame.SetClosedCallback(
  ClosedProc: TOTAVisualizerClosedProcedure);
begin
  FClosedProc := ClosedProc;
end;

procedure TCnDataSetViewerFrame.SetForm(AForm: TCustomForm);
begin
  FOwningForm := AForm;
end;

procedure TCnDataSetViewerFrame.SetParent(AParent: TWinControl);
begin
  if AParent = nil then
  begin
    FreeAndNil(FItems);
    if Assigned(FClosedProc) then
      FClosedProc;
  end;
  inherited;
end;

procedure TCnDataSetViewerFrame.WMDPIChangedAfterParent(var Message: TMessage);
begin
  inherited;
  if TIDEThemeMetrics.Font.Enabled then
    TIDEThemeMetrics.Font.AdjustDPISize(Font, TIDEThemeMetrics.Font.Size, PixelsPerInch);
end;

procedure TCnDataSetViewerFrame.pcViewsChange(Sender: TObject);
begin
  if pcViews.ActivePage = tsProp then
    mmoProp.SetFocus
  else if pcViews.ActivePage = tsField then
    grdField.SetFocus
  else if pcViews.ActivePage = tsData then
    grdData.SetFocus;
end;

procedure TCnDataSetViewerFrame.Translate;
begin
  if (CnLanguageManager <> nil) and (CnLanguageManager.LanguageStorage <> nil)
    and (CnLanguageManager.LanguageStorage.LanguageCount > 0) then
  begin
    Screen.Cursor := crHourGlass;
    try
      CnLanguageManager.TranslateFrame(Self);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

{ TCnDataSetVisualizerForm }

constructor TCnDataSetVisualizerForm.Create(const Expression: string);
begin
  inherited Create;
  FExpression := Expression;
end;

procedure TCnDataSetVisualizerForm.CustomizePopupMenu(PopupMenu: TPopupMenu);
begin
  // no toolbar
end;

procedure TCnDataSetVisualizerForm.CustomizeToolBar(ToolBar: TToolBar);
begin
 // no toolbar
end;

function TCnDataSetVisualizerForm.EditAction(Action: TEditAction): Boolean;
begin
  Result := False;
end;

procedure TCnDataSetVisualizerForm.FrameCreated(AFrame: TCustomFrame);
begin
  FMyFrame := TCnDataSetViewerFrame(AFrame);
end;

function TCnDataSetVisualizerForm.GetCaption: string;
begin
  Result := Format(SCnDataSetViewerFormCaption, [FExpression]);
end;

function TCnDataSetVisualizerForm.GetEditState: TEditState;
begin
  Result := [];
end;

function TCnDataSetVisualizerForm.GetForm: TCustomForm;
begin
  Result := FMyForm;
end;

function TCnDataSetVisualizerForm.GetFrame: TCustomFrame;
begin
  Result := FMyFrame;
end;

function TCnDataSetVisualizerForm.GetFrameClass: TCustomFrameClass;
begin
  Result := TCnDataSetViewerFrame;
end;

function TCnDataSetVisualizerForm.GetIdentifier: string;
begin
  Result := 'DataSetDebugVisualizer';
end;

function TCnDataSetVisualizerForm.GetMenuActionList: TCustomActionList;
begin
  Result := nil;
end;

function TCnDataSetVisualizerForm.GetMenuImageList: TCustomImageList;
begin
  Result := nil;
end;

function TCnDataSetVisualizerForm.GetToolbarActionList: TCustomActionList;
begin
  Result := nil;
end;

function TCnDataSetVisualizerForm.GetToolbarImageList: TCustomImageList;
begin
  Result := nil;
end;

procedure TCnDataSetVisualizerForm.LoadWindowState(Desktop: TCustomIniFile;
  const Section: string);
begin
  //no desktop saving
end;

procedure TCnDataSetVisualizerForm.SaveWindowState(Desktop: TCustomIniFile;
  const Section: string; IsProject: Boolean);
begin
  //no desktop saving
end;

procedure TCnDataSetVisualizerForm.SetForm(Form: TCustomForm);
begin
  FMyForm := Form;
  if Assigned(FMyFrame) then
    FMyFrame.SetForm(FMyForm);
end;

procedure TCnDataSetVisualizerForm.SetFrame(Frame: TCustomFrame);
begin
   FMyFrame := TCnDataSetViewerFrame(Frame);
end;

end.

