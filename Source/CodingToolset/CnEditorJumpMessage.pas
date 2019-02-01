{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     �й����Լ��Ŀ���Դ�������������                         }
{                   (C)Copyright 2001-2019 CnPack ������                       }
{                   ------------------------------------                       }
{                                                                              }
{            ���������ǿ�Դ���������������������� CnPack �ķ���Э������        }
{        �ĺ����·�����һ����                                                }
{                                                                              }
{            ������һ��������Ŀ����ϣ�������ã���û���κε���������û��        }
{        �ʺ��ض�Ŀ�Ķ������ĵ���������ϸ���������� CnPack ����Э�顣        }
{                                                                              }
{            ��Ӧ���Ѿ��Ϳ�����һ���յ�һ�� CnPack ����Э��ĸ��������        }
{        ��û�У��ɷ������ǵ���վ��                                            }
{                                                                              }
{            ��վ��ַ��http://www.cnpack.org                                   }
{            �����ʼ���master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnEditorJumpMessage;
{* |<PRE>
================================================================================
* �������ƣ�CnPack IDE ר�Ұ�
* ��Ԫ���ƣ���������һ��Ϣ�������� intf/impl ������ƥ��ؼ���ʵ�ֵ�Ԫ
* ��Ԫ���ߣ���Х (liuxiao@cnpack.org)
* ��    ע����ת�� Index ʹ�� MessageCount - 2 ���������һ����Ϣǿ��Ϊ�գ���Ч��
* ����ƽ̨��PWinXP SP2 + Delphi 5.01
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6/7 + C++Builder 5/6
* �� �� �����ô����е��ַ��������ϱ��ػ�������ʽ
* �޸ļ�¼��2014.12.25
*               ��������ƥ�����������ָ��Ĺ���
*           2012.02.25
*               ��������ǰһ��/��һ����ͬ��ʶ���Ĺ���
*           2009.04.15
*               ����� C/C++ �����ŵ�֧��
*           2008.11.22
*               ��������ƥ��ؼ��ֵĹ���
*           2008.11.14
*               �������� intf/impl �Ĺ���
*           2007.01.23 V1.0
*               ������Ԫ��ʵ�ֹ���
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

{$IFDEF CNWIZARDS_CNEDITORTOOLSETWIZARD}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IniFiles, Menus, ToolsAPI, CnWizUtils, CnConsts, CnCommon, CnWizManager,
  CnWizEditFiler, CnEditorWizard, CnWizConsts, CnEditorCodeTool, CnWizIdeUtils,
  CnSourceHighlight, CnPasCodeParser, CnEditControlWrapper, mPasLex,
  CnCppCodeParser, mwBCBTokenList, CnFastList {$IFDEF BDS}, CnWizMethodHook {$ENDIF};

type

//==============================================================================
// ������/��һ��Ϣ�й�����
//==============================================================================

{ TCnEditorPrevMessage }

  TCnEditorPrevMessage = class(TCnBaseEditorTool)
  private

  protected
    function GetDefShortCut: TShortCut; override;
  public
    constructor Create(AOwner: TCnEditorToolsetWizard); override;
    destructor Destroy; override;
    function GetCaption: string; override;
    function GetHint: string; override;
    procedure GetEditorInfo(var Name, Author, Email: string); override;
    procedure Execute; override;
  end;

{ TCnEditorNextMessage }

  TCnEditorNextMessage = class(TCnBaseEditorTool)
  private

  protected
    function GetDefShortCut: TShortCut; override;
  public
    constructor Create(AOwner: TCnEditorToolsetWizard); override;
    destructor Destroy; override;
    function GetCaption: string; override;
    function GetHint: string; override;
    procedure GetEditorInfo(var Name, Author, Email: string); override;
    procedure Execute; override;
  end;

  TCnEditorJumpIntf = class(TCnBaseEditorTool)
  private

  public
    constructor Create(AOwner: TCnEditorToolsetWizard); override;
    destructor Destroy; override;
    procedure LoadSettings(Ini: TCustomIniFile); override;
    procedure SaveSettings(Ini: TCustomIniFile); override;
    function GetCaption: string; override;
    function GetHint: string; override;
    procedure GetEditorInfo(var Name, Author, Email: string); override;
    function GetState: TWizardState; override;
    function GetDefShortCut: TShortCut; override;
    procedure Execute; override;
  end;

  TCnEditorJumpImpl = class(TCnBaseEditorTool)
  private

  public
    constructor Create(AOwner: TCnEditorToolsetWizard); override;
    destructor Destroy; override;
    procedure LoadSettings(Ini: TCustomIniFile); override;
    procedure SaveSettings(Ini: TCustomIniFile); override;
    function GetCaption: string; override;
    function GetHint: string; override;
    procedure GetEditorInfo(var Name, Author, Email: string); override;
    function GetState: TWizardState; override;
    function GetDefShortCut: TShortCut; override;
    procedure Execute; override;
  end;

{$IFDEF CNWIZARDS_CNSOURCEHIGHLIGHT}

// �������������ڸ���������˴˴���ҪҲ���� IFDEF

  TCnEditorJumpMatchedKeyword = class(TCnBaseEditorTool)
  private

  public
    constructor Create(AOwner: TCnEditorToolsetWizard); override;
    destructor Destroy; override;
    procedure LoadSettings(Ini: TCustomIniFile); override;
    procedure SaveSettings(Ini: TCustomIniFile); override;
    function GetCaption: string; override;
    function GetHint: string; override;
    procedure GetEditorInfo(var Name, Author, Email: string); override;
    function GetState: TWizardState; override;
    function GetDefShortCut: TShortCut; override;
    procedure Execute; override;
  end;

  TCnEditorJumpPrevIdent = class(TCnBaseEditorTool)
  private

  public
    constructor Create(AOwner: TCnEditorToolsetWizard); override;
    destructor Destroy; override;
    procedure LoadSettings(Ini: TCustomIniFile); override;
    procedure SaveSettings(Ini: TCustomIniFile); override;
    function GetCaption: string; override;
    function GetHint: string; override;
    procedure GetEditorInfo(var Name, Author, Email: string); override;
    function GetState: TWizardState; override;
    function GetDefShortCut: TShortCut; override;
    procedure Execute; override;
  end;

  TCnEditorJumpNextIdent = class(TCnBaseEditorTool)
  private

  public
    constructor Create(AOwner: TCnEditorToolsetWizard); override;
    destructor Destroy; override;
    procedure LoadSettings(Ini: TCustomIniFile); override;
    procedure SaveSettings(Ini: TCustomIniFile); override;
    function GetCaption: string; override;
    function GetHint: string; override;
    procedure GetEditorInfo(var Name, Author, Email: string); override;
    function GetState: TWizardState; override;
    function GetDefShortCut: TShortCut; override;
    procedure Execute; override;
  end;

{$ENDIF CNWIZARDS_CNSOURCEHIGHLIGHT}

{$ENDIF CNWIZARDS_CNEDITORTOOLSETWIZARD}

implementation

{$IFDEF CNWIZARDS_CNEDITORTOOLSETWIZARD}

{$IFDEF DEBUG}
uses
  CnDebug;
{$ENDIF}

{$IFDEF BDS}
function EmptyKeyDataToShiftState(KeyData: Longint): TShiftState;
begin
  Result := [];
end;
{$ENDIF}

{ TCnEditorJumpMessage }

constructor TCnEditorNextMessage.Create(AOwner: TCnEditorToolsetWizard);
begin
  inherited;

end;

destructor TCnEditorNextMessage.Destroy;
begin

  inherited;
end;

function TCnEditorNextMessage.GetCaption: string;
begin
  Result := SCnEditorNextMessageMenuCaption;
end;

function TCnEditorNextMessage.GetHint: string;
begin
  Result := SCnEditorNextMessageMenuHint;
end;

function TCnEditorNextMessage.GetDefShortCut: TShortCut;
begin
  Result := TextToShortCut('Alt+.');
end;

procedure TCnEditorNextMessage.GetEditorInfo(var Name, Author, Email: string);
begin
  Name := SCnEditorNextMessageName;
  Author := SCnPack_LiuXiao;
  Email := SCnPack_LiuXiaoEmail;
end;

procedure TCnEditorNextMessage.Execute;
{$IFDEF BDS}
var
  Hook: TCnMethodHook;
{$ENDIF}
begin
  if CnMessageViewWrapper.MessageViewForm = nil then Exit;
  if not CnMessageViewWrapper.MessageViewForm.Visible then
    CnMessageViewWrapper.MessageViewForm.Show;
{$IFDEF BDS}
  Hook := TCnMethodHook.Create(GetBplMethodAddress(@KeyDataToShiftState), @EmptyKeyDataToShiftState);
  CnMessageViewWrapper.TreeView.Perform(WM_KEYDOWN, VK_DOWN, Integer($1500001));
  CnMessageViewWrapper.TreeView.Perform(WM_KEYUP, VK_DOWN, Integer($C1500001));
  Hook.Free;
{$ELSE}
  if CnMessageViewWrapper.SelectedIndex < CnMessageViewWrapper.MessageCount - 2 then
    CnMessageViewWrapper.SelectedIndex := CnMessageViewWrapper.SelectedIndex + 1
  else
    CnMessageViewWrapper.SelectedIndex := 0; // ����������һ��
{$ENDIF}
  CnMessageViewWrapper.EditMessageSource;
end;

{ TCnEditorPrevMessage }

constructor TCnEditorPrevMessage.Create(AOwner: TCnEditorToolsetWizard);
begin
  inherited;

end;

destructor TCnEditorPrevMessage.Destroy;
begin

  inherited;
end;

procedure TCnEditorPrevMessage.Execute;
{$IFDEF BDS}
var
  Hook: TCnMethodHook;
{$ENDIF}
begin
  if CnMessageViewWrapper.MessageViewForm = nil then Exit;
  if not CnMessageViewWrapper.MessageViewForm.Visible then
    CnMessageViewWrapper.MessageViewForm.Show;
{$IFDEF BDS}
  Hook := TCnMethodHook.Create(GetBplMethodAddress(@KeyDataToShiftState), @EmptyKeyDataToShiftState);
  CnMessageViewWrapper.TreeView.Perform(WM_KEYDOWN, VK_UP, Integer($1500001));
  CnMessageViewWrapper.TreeView.Perform(WM_KEYUP, VK_UP, Integer($C1500001));
  Hook.Free;  
{$ELSE}
  if CnMessageViewWrapper.SelectedIndex > 0 then
    CnMessageViewWrapper.SelectedIndex := CnMessageViewWrapper.SelectedIndex - 1
  else
    CnMessageViewWrapper.SelectedIndex := CnMessageViewWrapper.MessageCount - 2 ; // ��������ĩһ��
{$ENDIF}
  CnMessageViewWrapper.EditMessageSource;
end;

function TCnEditorPrevMessage.GetCaption: string;
begin
  Result := SCnEditorPrevMessageMenuCaption;
end;

function TCnEditorPrevMessage.GetDefShortCut: TShortCut;
begin
  Result := TextToShortCut('Alt+,');
end;

procedure TCnEditorPrevMessage.GetEditorInfo(var Name, Author, Email: string);
begin
  Name := SCnEditorPrevMessageName;
  Author := SCnPack_LiuXiao;
  Email := SCnPack_LiuXiaoEmail;
end;

function TCnEditorPrevMessage.GetHint: string;
begin
  Result := SCnEditorPrevMessageMenuHint;
end;

// ���� Pascal ���벢������һ�� Token ���ڵ��С�����ֻ�����У�������� Unicode ����
procedure ParsePasAndGotoLine(TokenKind: TTokenKind; const ErrorMsg: string);
var
  LineNum: Integer;
  View: IOTAEditView;
  Parser: TmwPasLex;
  MemStream: TMemoryStream;
  S: string;
begin
  View := CnOtaGetTopMostEditView;
  if View = nil then
    Exit;

  LineNum := 0;
  S := CnOtaGetCurrentSourceFileName;
  if not (IsDelphiSourceModule(S) or IsInc(S)) then
    Exit;

  Parser := nil;
  MemStream := TMemoryStream.Create;
  try
    with TCnEditFiler.Create(S) do
    try
      SaveToStream(MemStream, True);
    finally
      Free;
    end;

    Parser := TmwPasLex.Create;
    Parser.Origin := MemStream.Memory;
    
    while Parser.TokenID <> tkNull do
    begin
      if Parser.TokenID = TokenKind then
      begin
        if (TokenKind <> tkInterface) or not Parser.IsInterface then
        begin
          if LineNum = 0 then
          begin
            LineNum := Parser.LineNumber + 1;
            Break;
          end;
        end;
      end;
      Parser.NextNoJunk;
    end;

    if LineNum > 0 then
      CnOtaGotoEditPosAndRepaint(View, LineNum)
    else
      ErrorDlg(ErrorMsg);
  finally
    MemStream.Free;
    Parser.Free;
  end;
end;

{ TCnEditorJumpIntf }

function TCnEditorJumpIntf.GetCaption: string;
begin
  Result := SCnEditorJumpIntfMenuCaption;
end;

function TCnEditorJumpIntf.GetHint: string;
begin
  Result := SCnEditorJumpIntfMenuHint;
end;

procedure TCnEditorJumpIntf.GetEditorInfo(var Name, Author, Email: string);
begin
  Name := SCnEditorJumpIntfName;
  Author := SCnPack_LiuXiao;
  Email := SCnPack_LiuXiaoEmail;
end;

constructor TCnEditorJumpIntf.Create(AOwner: TCnEditorToolsetWizard);
begin
  inherited;

end;

destructor TCnEditorJumpIntf.Destroy;
begin

  inherited;
end;

procedure TCnEditorJumpIntf.Execute;
begin
  ParsePasAndGotoLine(tkInterface, SCnProcListErrorNoIntf);
end;

function TCnEditorJumpIntf.GetState: TWizardState;
var
  S: string;
begin
  Result := inherited GetState;
  S := CnOtaGetCurrentSourceFileName;
  if (wsEnabled in Result) and not (IsPas(S) or IsInc(S)) then
    Result := [];
end;

function TCnEditorJumpIntf.GetDefShortCut: TShortCut;
begin
  Result := 0;
end;

procedure TCnEditorJumpIntf.LoadSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

procedure TCnEditorJumpIntf.SaveSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

{ TCnEditorJumpImpl }

function TCnEditorJumpImpl.GetCaption: string;
begin
  Result := SCnEditorJumpImplMenuCaption;
end;

function TCnEditorJumpImpl.GetHint: string;
begin
  Result := SCnEditorJumpImplMenuHint;
end;

procedure TCnEditorJumpImpl.GetEditorInfo(var Name, Author, Email: string);
begin
  Name := SCnEditorJumpImplName;
  Author := SCnPack_LiuXiao;
  Email := SCnPack_LiuXiaoEmail;
end;

constructor TCnEditorJumpImpl.Create(AOwner: TCnEditorToolsetWizard);
begin
  inherited;

end;

destructor TCnEditorJumpImpl.Destroy;
begin

  inherited;
end;

procedure TCnEditorJumpImpl.Execute;
begin
  ParsePasAndGotoLine(tkImplementation, SCnProcListErrorNoImpl);
end;

function TCnEditorJumpImpl.GetState: TWizardState;
var
  S: string;
begin
  Result := inherited GetState;
  S := CnOtaGetCurrentSourceFileName;
  if (wsEnabled in Result) and not (IsPas(S) or IsInc(S)) then
    Result := [];
end;

function TCnEditorJumpImpl.GetDefShortCut: TShortCut;
begin
  Result := 0;
end;

procedure TCnEditorJumpImpl.LoadSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

procedure TCnEditorJumpImpl.SaveSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

{$IFDEF CNWIZARDS_CNSOURCEHIGHLIGHT}

// �˹��������ڸ���������˴˴���ҪҲ���� IFDEF

{ TCnEditorJumpMatchedKeyword }

function TCnEditorJumpMatchedKeyword.GetCaption: string;
begin
  Result := SCnEditorJumpMatchedKeywordMenuCaption;
end;

function TCnEditorJumpMatchedKeyword.GetHint: string;
begin
  Result := SCnEditorJumpMatchedKeywordMenuHint;
end;

procedure TCnEditorJumpMatchedKeyword.GetEditorInfo(var Name, Author, Email: string);
begin
  Name := SCnEditorJumpMatchedKeywordName;
  Author := SCnPack_LiuXiao;
  Email := SCnPack_LiuXiaoEmail;
end;

constructor TCnEditorJumpMatchedKeyword.Create(AOwner: TCnEditorToolsetWizard);
begin
  inherited;

end;

destructor TCnEditorJumpMatchedKeyword.Destroy;
begin

  inherited;
end;

procedure TCnEditorJumpMatchedKeyword.Execute;
var
  BlockMatchInfo: TBlockMatchInfo;
  LineInfo: TBlockLineInfo;
  CompDirectiveInfo: TCompDirectiveInfo;
  EditControl: TControl;
  EditView: IOTAEditView;
  PasParser: TCnGeneralPasStructParser;
  CppParser: TCnGeneralCppStructParser;
  Stream: TMemoryStream;
  CharPos: TOTACharPos;
  I: Integer;
  DestToken: TCnGeneralPasToken;
  TokenIndex: Integer;
  CurIsPas, CurIsCpp: Boolean;
  HighlightWizard: TCnSourceHighlight;
begin
  EditControl := CnOtaGetCurrentEditControl;
  if EditControl = nil then
    Exit;
  try
    EditView := EditControlWrapper.GetEditView(EditControl);
  except
    Exit;
  end;

  if EditView = nil then
    Exit;

  HighlightWizard := TCnSourceHighlight(CnWizardMgr.WizardByClass(TCnSourceHighlight));
  if HighlightWizard = nil then
    Exit;

  CurIsPas := IsDprOrPas(EditView.Buffer.FileName) or IsInc(EditView.Buffer.FileName);
  CurIsCpp := IsCppSourceModule(EditView.Buffer.FileName);
  if (not CurIsCpp) and (not CurIsPas) then
    Exit;

  PasParser := nil;
  CppParser := nil;

  if CurIsPas then
  begin
    PasParser := TCnGeneralPasStructParser.Create;
    {$IFDEF BDS}
    PasParser.UseTabKey := True; // HighlightWizard.UseTabKey;
    PasParser.TabWidth := HighlightWizard.TabWidth;
    {$ENDIF}
  end;
  if CurIsCpp then
  begin
    CppParser := TCnGeneralCppStructParser.Create;
    {$IFDEF BDS}
    CppParser.UseTabKey := True; // HighlightWizard.UseTabKey;
    CppParser.TabWidth := HighlightWizard.TabWidth;
    {$ENDIF}
  end;

  Stream := TMemoryStream.Create;
  try
    CnGeneralSaveEditorToStream(EditView.Buffer, Stream);

    // ������ǰ��ʾ��Դ�ļ�
    if CurIsPas then
      CnPasParserParseSource(PasParser, Stream, IsDpr(EditView.Buffer.FileName)
        or IsInc(EditView.Buffer.FileName), False);
    if CurIsCpp then
      CnCppParserParseSource(CppParser, Stream, EditView.CursorPos.Line, EditView.CursorPos.Col);
  finally
    Stream.Free;
  end;

  if CurIsPas then
  begin
    // �������ٲ��ҵ�ǰ������ڵĿ飬��ֱ��ʹ�� CursorPos����Ϊ Parser ����ƫ�ƿ��ܲ�ͬ
    CnOtaGetCurrentCharPosFromCursorPosForParser(CharPos);
    PasParser.FindCurrentBlock(CharPos.Line, CharPos.CharIndex);
  end;

  try
    BlockMatchInfo := TBlockMatchInfo.Create(EditControl);
    LineInfo := TBlockLineInfo.Create(EditControl);
    CompDirectiveInfo := TCompDirectiveInfo.Create(EditControl);
    BlockMatchInfo.LineInfo := LineInfo;
    BlockMatchInfo.CompDirectiveInfo := CompDirectiveInfo;

    if CurIsPas then
    begin
      if Assigned(PasParser.InnerBlockStartToken) and Assigned(PasParser.InnerBlockCloseToken) then
      begin
        for I := PasParser.InnerBlockStartToken.ItemIndex to
          PasParser.InnerBlockCloseToken.ItemIndex do
          if PasParser.Tokens[I].TokenID in csKeyTokens then
            BlockMatchInfo.AddToKeyList(PasParser.Tokens[I]);
      end;

      for I := 0 to PasParser.Count - 1 do
        if CheckIsCompDirectiveToken(PasParser.Tokens[I], False) then
          BlockMatchInfo.AddToCompDirectiveList(PasParser.Tokens[I]);
    end;

    if CurIsCpp then
    begin
      if Assigned(CppParser.InnerBlockStartToken) and Assigned(CppParser.InnerBlockCloseToken) then
      begin
        for I := CppParser.InnerBlockStartToken.ItemIndex to
          CppParser.InnerBlockCloseToken.ItemIndex do
          if CppParser.Tokens[I].CppTokenKind in [ctkbraceopen, ctkbraceclose] then
            BlockMatchInfo.AddToKeyList(CppParser.Tokens[I]);
      end
      else if Assigned(CppParser.BlockStartToken) and Assigned(CppParser.BlockCloseToken) then
      begin
        for I := CppParser.BlockStartToken.ItemIndex to
          CppParser.BlockCloseToken.ItemIndex do
          if CppParser.Tokens[I].CppTokenKind in [ctkbraceopen, ctkbraceclose] then
            BlockMatchInfo.AddToKeyList(CppParser.Tokens[I]);
      end
      else
      begin
        for I := 0 to CppParser.Count - 1 do
          if CppParser.Tokens[I].CppTokenKind in [ctkbraceopen, ctkbraceclose] then
            BlockMatchInfo.AddToKeyList(CppParser.Tokens[I]);
      end;

      for I := 0 to CppParser.Count - 1 do
        if CheckIsCompDirectiveToken(CppParser.Tokens[I], True) then
          BlockMatchInfo.AddToCompDirectiveList(CppParser.Tokens[I]);
    end;

    if BlockMatchInfo.KeyCount > 0 then
    begin
      for I := 0 to BlockMatchInfo.KeyCount - 1 do
        ConvertGeneralTokenPos(Pointer(EditView), BlockMatchInfo.KeyTokens[I]);

      BlockMatchInfo.ConvertLineList;
    end;

    if BlockMatchInfo.CompDirectiveTokenCount > 0 then
    begin
      for I := 0 to BlockMatchInfo.CompDirectiveTokenCount - 1 do
        ConvertGeneralTokenPos(Pointer(EditView), BlockMatchInfo.CompDirectiveTokens[I]);

      BlockMatchInfo.ConvertCompDirectiveLineList;
    end;

    BlockMatchInfo.IsCppSource := CurIsCpp;
    BlockMatchInfo.CheckLineMatch(EditView, False);
    BlockMatchInfo.CheckCompDirectiveMatch(EditView);

    // ������ϣ�׼����λ
    DestToken := nil;
    if LineInfo.CurrentPair <> nil then
    begin
{$IFDEF DEBUG}
      CnDebugger.LogFmt('Jump Matching. Current Token %d:%d - %s.', [LineInfo.CurrentToken.EditLine,
        LineInfo.CurrentToken.EditCol, LineInfo.CurrentToken.Token]);
{$ENDIF}

      if LineInfo.CurrentToken = LineInfo.CurrentPair.StartToken then
      begin
        if LineInfo.CurrentPair.MiddleCount > 0 then
          DestToken := LineInfo.CurrentPair.MiddleToken[0]
        else
          DestToken := LineInfo.CurrentPair.EndToken
      end
      else if LineInfo.CurrentToken = LineInfo.CurrentPair.EndToken then
        DestToken := LineInfo.CurrentPair.StartToken
      else
      begin
        if LineInfo.CurrentPair.MiddleCount > 0 then
        begin
          TokenIndex := LineInfo.CurrentPair.IndexOfMiddleToken(LineInfo.CurrentToken);
          if TokenIndex = LineInfo.CurrentPair.MiddleCount - 1 then // ���һ��
            DestToken := LineInfo.CurrentPair.EndToken
          else
            DestToken := LineInfo.CurrentPair.MiddleToken[TokenIndex + 1];
        end;
      end;
    end
    else if CompDirectiveInfo.CurrentPair <> nil then
    begin
{$IFDEF DEBUG}
      CnDebugger.LogFmt('Jump Matching. Current CompDirective Token %d:%d - %s.', [CompDirectiveInfo.CurrentToken.EditLine,
        CompDirectiveInfo.CurrentToken.EditCol, CompDirectiveInfo.CurrentToken.Token]);
{$ENDIF}

      if CompDirectiveInfo.CurrentToken = CompDirectiveInfo.CurrentPair.StartToken then
      begin
        if CompDirectiveInfo.CurrentPair.MiddleCount > 0 then
          DestToken := CompDirectiveInfo.CurrentPair.MiddleToken[0]
        else
          DestToken := CompDirectiveInfo.CurrentPair.EndToken
      end
      else if CompDirectiveInfo.CurrentToken = CompDirectiveInfo.CurrentPair.EndToken then
        DestToken := CompDirectiveInfo.CurrentPair.StartToken
      else
      begin
        if CompDirectiveInfo.CurrentPair.MiddleCount > 0 then
        begin
          TokenIndex := CompDirectiveInfo.CurrentPair.IndexOfMiddleToken(CompDirectiveInfo.CurrentToken);
          if TokenIndex = CompDirectiveInfo.CurrentPair.MiddleCount - 1 then // ���һ��
            DestToken := CompDirectiveInfo.CurrentPair.EndToken
          else
            DestToken := CompDirectiveInfo.CurrentPair.MiddleToken[TokenIndex + 1];
        end;
      end;
    end;

    if DestToken <> nil then
    begin
{$IFDEF DEBUG}
      CnDebugger.LogFmt('Jump Matching. Destination Token %d:%d - %s.', [DestToken.EditLine,
        DestToken.EditCol, DestToken.Token]);
{$ENDIF}

      CnOtaGotoEditPosAndRepaint(EditView, DestToken.EditLine, DestToken.EditCol);
    end;
  finally
    FreeAndNil(BlockMatchInfo);
    FreeAndNil(LineInfo);
    FreeAndNil(CompDirectiveInfo);
    FreeAndNil(CppParser);
    FreeAndNil(PasParser);
  end;
end;

function TCnEditorJumpMatchedKeyword.GetState: TWizardState;
var
  S: string;
begin
  Result := inherited GetState;
  S := CnOtaGetCurrentSourceFileName;
  if (wsEnabled in Result) and not (IsDprOrPas(S) or IsInc(S) or IsCppSourceModule(S)) then
    Result := [];
end;

function TCnEditorJumpMatchedKeyword.GetDefShortCut: TShortCut;
begin
  Result := TextToShortCut('Ctrl+,');
end;

procedure TCnEditorJumpMatchedKeyword.LoadSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

procedure TCnEditorJumpMatchedKeyword.SaveSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

procedure JumpIdentifierNearby(Prev: Boolean);
var
  EditControl: TControl;
  EditView: IOTAEditView;
  PasParser: TCnGeneralPasStructParser;
  CppParser: TCnGeneralCppStructParser;
  Stream: TMemoryStream;
  EditPos: TOTAEditPos;
  CharPos: TOTACharPos;
  I: Integer;
  CurrentToken: TCnGeneralPasToken;
  CurrentTokenName: AnsiString;
  CurIsPas, CurIsCpp: Boolean;
  CurrentTokenIndex, StartIdx, EndIdx: Integer;

  procedure SetParseRange(MaxCount: Integer);
  begin
    if Prev then
    begin
      StartIdx := CurrentTokenIndex - 1;
      EndIdx := 0;
    end
    else
    begin
      StartIdx := CurrentTokenIndex + 1;
      EndIdx := MaxCount;
    end;
  end;

  function _IsCurrentToken(AView: Pointer; AControl: TControl;
    Token: TCnGeneralPasToken): Boolean;
  begin
{$IFDEF SUPPORT_WIDECHAR_IDENTIFIER}
    Result := IsCurrentTokenW(AView, AControl, Token);
{$ELSE}
    Result := IsCurrentToken(AView, AControl, Token);
{$ENDIF}
  end;

begin
  EditControl := CnOtaGetCurrentEditControl;
  if EditControl = nil then
    Exit;
  try
    EditView := EditControlWrapper.GetEditView(EditControl);
  except
    Exit;
  end;

  if EditView = nil then
    Exit;

  CurIsPas := IsDprOrPas(EditView.Buffer.FileName) or IsInc(EditView.Buffer.FileName);
  CurIsCpp := IsCppSourceModule(EditView.Buffer.FileName);
  if (not CurIsCpp) and (not CurIsPas) then
    Exit;

  PasParser := nil;
  CppParser := nil;

  if CurIsPas then
  begin
    PasParser := TCnGeneralPasStructParser.Create;
{$IFDEF BDS}
    PasParser.UseTabKey := True;
    PasParser.TabWidth := EditControlWrapper.GetTabWidth;
{$ENDIF}
  end;

  if CurIsCpp then
  begin
    CppParser := TCnGeneralCppStructParser.Create;
{$IFDEF BDS}
    CppParser.UseTabKey := True;
    CppParser.TabWidth := EditControlWrapper.GetTabWidth;
{$ENDIF}
  end;

  CurrentToken := nil;
  Stream := TMemoryStream.Create;
  try
    CnGeneralSaveEditorToStream(EditView.Buffer, Stream);

    // ������ǰ��ʾ��Դ�ļ�
    if CurIsPas then
    begin
      CnPasParserParseSource(PasParser, Stream, IsDpr(EditView.Buffer.FileName)
        or IsInc(EditView.Buffer.FileName), False);

      for I := 0 to PasParser.Count - 1 do
      begin
        // �������������������ַ�ƫ��ת���� CharPos
        CnConvertPasTokenPositionToCharPos(Pointer(EditView), PasParser.Tokens[I], CharPos);
        // �ٰ� CharPos ת���� EditPos
        CnOtaConvertEditViewCharPosToEditPos(Pointer(EditView),
          CharPos.Line, CharPos.CharIndex, EditPos);

        PasParser.Tokens[I].EditCol := EditPos.Col;
        PasParser.Tokens[I].EditLine := EditPos.Line;

        if (PasParser.Tokens[I].TokenID = tkIdentifier) and // �˴��жϲ�֧��˫�ֽ��ַ�
          _IsCurrentToken(Pointer(EditView), EditControl, PasParser.Tokens[I]) then
        begin
          if CurrentToken = nil then
          begin
            CurrentToken := PasParser.Tokens[I];
            CurrentTokenName := CurrentToken.Token;
            CurrentTokenIndex := I;
            // Can't Break for Parser Tokens Line/Col need to assigned.
          end;
        end;
      end;

      SetParseRange(PasParser.Count);
      if CurrentTokenName <> '' then
      begin
        if StartIdx > EndIdx then
        begin
          for I := StartIdx downto EndIdx do // Search for previous
          begin
            if (PasParser.Tokens[I].TokenID = tkIdentifier) and
              CheckTokenMatch(PasParser.Tokens[I].Token, CurrentTokenName, False) then
            begin
              // Found. Jump here and Exit;
              CnOtaGotoEditPosAndRepaint(EditView, PasParser.Tokens[I].EditLine, PasParser.Tokens[I].EditCol);
              Exit;
            end;
          end;
        end
        else
        begin
          for I := StartIdx to EndIdx do // Search for Next
          begin
            if (PasParser.Tokens[I].TokenID = tkIdentifier) and
              CheckTokenMatch(PasParser.Tokens[I].Token, CurrentTokenName, False) then
            begin
              // Found. Jump here and Exit;
              CnOtaGotoEditPosAndRepaint(EditView, PasParser.Tokens[I].EditLine, PasParser.Tokens[I].EditCol);
              Exit;
            end;
          end;
        end;
      end;
    end;

    if CurIsCpp then
    begin
      CnOtaGetCurrentCharPosFromCursorPosForParser(CharPos);
      // ����ǰ���λ��ת���� Ansi/Utf16/Utf16 �� CppParser ʹ��
      CnCppParserParseSource(CppParser, Stream, CharPos.Line, CharPos.CharIndex + 1);
      // ת������ CharIndex �� 0 ��ʼ���� CppParser Ҫ�� 1 ��ʼ�����Լ�һ��

      for I := 0 to CppParser.Count - 1 do
      begin
        // �������������������ַ�ƫ��ת���� CharPos
        CnConvertPasTokenPositionToCharPos(Pointer(EditView), CppParser.Tokens[I], CharPos);
        // �ٰ� CharPos ת���� EditPos
        CnOtaConvertEditViewCharPosToEditPos(Pointer(EditView),
          CharPos.Line, CharPos.CharIndex, EditPos);

        CppParser.Tokens[I].EditCol := EditPos.Col;
        CppParser.Tokens[I].EditLine := EditPos.Line;

        if (CppParser.Tokens[I].CppTokenKind = ctkidentifier) and
          _IsCurrentToken(Pointer(EditView), EditControl, CppParser.Tokens[I]) then
        begin
          if CurrentToken = nil then
          begin
            CurrentToken := CppParser.Tokens[I];
            CurrentTokenName := CurrentToken.Token;
            CurrentTokenIndex := I;
            // Can't Break for Parser Tokens Line/Col need to assigned.
          end;
        end;
      end;

      SetParseRange(CppParser.Count);
      if CurrentTokenName <> '' then
      begin
        if StartIdx > EndIdx then
        begin
          for I := StartIdx downto EndIdx do // Search for previous
          begin
            if (CppParser.Tokens[I].CppTokenKind = ctkidentifier) and
              CheckTokenMatch(CppParser.Tokens[I].Token, CurrentTokenName, True) then
            begin
              // Found. Jump here and Exit;
              CnOtaGotoEditPosAndRepaint(EditView, CppParser.Tokens[I].EditLine, CppParser.Tokens[I].EditCol);
              Exit;
            end;
          end;
        end
        else
        begin
          for I := StartIdx to EndIdx do // Search for Next
          begin
            if (CppParser.Tokens[I].CppTokenKind = ctkidentifier) and
              CheckTokenMatch(CppParser.Tokens[I].Token, CurrentTokenName, True) then
            begin
              // Found. Jump here and Exit;
              CnOtaGotoEditPosAndRepaint(EditView, CppParser.Tokens[I].EditLine, CppParser.Tokens[I].EditCol);
              Exit;
            end;
          end;
        end;
      end;
    end;
  finally
    PasParser.Free;
    CppParser.Free;
    Stream.Free;
  end;
end;

{ TCnEditorJumpPrevIdent }

constructor TCnEditorJumpPrevIdent.Create(AOwner: TCnEditorToolsetWizard);
begin
  inherited;

end;

destructor TCnEditorJumpPrevIdent.Destroy;
begin

  inherited;
end;

procedure TCnEditorJumpPrevIdent.Execute;
begin
  JumpIdentifierNearby(True);
end;

function TCnEditorJumpPrevIdent.GetCaption: string;
begin
  Result := SCnEditorJumpPrevIdentMenuCaption;
end;

function TCnEditorJumpPrevIdent.GetDefShortCut: TShortCut;
begin
  Result := ShortCut(VK_UP, [ssAlt, ssCtrl]);
end;

procedure TCnEditorJumpPrevIdent.GetEditorInfo(var Name, Author,
  Email: string);
begin
  Name := SCnEditorJumpPrevIdentName;
  Author := SCnPack_LiuXiao;
  Email := SCnPack_LiuXiaoEmail;
end;

function TCnEditorJumpPrevIdent.GetHint: string;
begin
  Result := SCnEditorJumpPrevIdentMenuHint;
end;

function TCnEditorJumpPrevIdent.GetState: TWizardState;
var
  S: string;
begin
  Result := inherited GetState;
  S := CnOtaGetCurrentSourceFileName;
  if (wsEnabled in Result) and not (IsDprOrPas(S) or IsInc(S) or IsCppSourceModule(S)) then
    Result := [];
end;

procedure TCnEditorJumpPrevIdent.LoadSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

procedure TCnEditorJumpPrevIdent.SaveSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

{ TCnEditorJumpNextIdent }

constructor TCnEditorJumpNextIdent.Create(AOwner: TCnEditorToolsetWizard);
begin
  inherited;

end;

destructor TCnEditorJumpNextIdent.Destroy;
begin

  inherited;
end;

procedure TCnEditorJumpNextIdent.Execute;
begin
  JumpIdentifierNearby(False);
end;

function TCnEditorJumpNextIdent.GetCaption: string;
begin
  Result := SCnEditorJumpNextIdentMenuCaption;
end;

function TCnEditorJumpNextIdent.GetDefShortCut: TShortCut;
begin
  Result := ShortCut(VK_DOWN, [ssAlt, ssCtrl]);
end;

procedure TCnEditorJumpNextIdent.GetEditorInfo(var Name, Author,
  Email: string);
begin
  Name := SCnEditorJumpNextIdentName;
  Author := SCnPack_LiuXiao;
  Email := SCnPack_LiuXiaoEmail;
end;

function TCnEditorJumpNextIdent.GetHint: string;
begin
  Result := SCnEditorJumpNextIdentMenuHint;
end;

function TCnEditorJumpNextIdent.GetState: TWizardState;
var
  S: string;
begin
  Result := inherited GetState;
  S := CnOtaGetCurrentSourceFileName;
  if (wsEnabled in Result) and not (IsDprOrPas(S) or IsInc(S) or IsCppSourceModule(S)) then
    Result := [];
end;

procedure TCnEditorJumpNextIdent.LoadSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

procedure TCnEditorJumpNextIdent.SaveSettings(Ini: TCustomIniFile);
begin
  inherited;

end;

{$ENDIF CNWIZARDS_CNSOURCEHIGHLIGHT}

initialization
  RegisterCnEditor(TCnEditorPrevMessage);
  RegisterCnEditor(TCnEditorNextMessage);

  RegisterCnEditor(TCnEditorJumpIntf);
  RegisterCnEditor(TCnEditorJumpImpl);

{$IFDEF CNWIZARDS_CNSOURCEHIGHLIGHT}
  RegisterCnEditor(TCnEditorJumpMatchedKeyword);
  RegisterCnEditor(TCnEditorJumpPrevIdent);
  RegisterCnEditor(TCnEditorJumpNextIdent);
{$ENDIF CNWIZARDS_CNSOURCEHIGHLIGHT}

{$ENDIF CNWIZARDS_CNEDITORTOOLSETWIZARD}
end.