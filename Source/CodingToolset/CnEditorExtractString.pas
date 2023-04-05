{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     �й����Լ��Ŀ���Դ�������������                         }
{                   (C)Copyright 2001-2023 CnPack ������                       }
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

unit CnEditorExtractString;
{* |<PRE>
================================================================================
* �������ƣ�CnPack IDE ר�Ұ�
* ��Ԫ���ƣ���Դ���г�ȡ�ַ�����Ԫ
* ��Ԫ���ߣ���Х (liuxiao@cnpack.org)
* ��    ע��
* ����ƽ̨��PWin2000Pro + Delphi 5.01
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6/7
* �� �� �����ô����е��ַ��������ϱ��ػ�������ʽ
* �޸ļ�¼��2023.02.10 V1.0
*               ������Ԫ��ʵ�ֹ���
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

{$IFDEF CNWIZARDS_CNCODINGTOOLSETWIZARD}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ToolsAPI,
  TypInfo, StdCtrls, ExtCtrls, ComCtrls, IniFiles, Clipbrd, Buttons, ActnList,
  CnConsts, CnCommon, CnHashMap, CnWizConsts, CnWizUtils, CnCodingToolsetWizard,
  CnWizMultiLang, CnEditControlWrapper, mPasLex, CnPasCodeParser, CnWidePasParser;

type
  TCnStringHeadType = (htVar, htConst, htResourcestring);

  TCnStringAreaType = (atInterface, atImplementation);

  TCnEditorExtractString = class(TCnBaseCodingToolset)
  private
    FUseUnderLine: Boolean;
    FIgnoreSingleChar: Boolean;
    FMaxWords: Integer;
    FMaxPinYinWords: Integer;
    FPrefix: string;
    FIdentWordStyle: TCnIdentWordStyle;
    FUseFullPinYin: Boolean;
    FShowPreview: Boolean;
    FIgnoreSimpleFormat: Boolean;
    FEditStream: TMemoryStream;
    FPasParser: TCnGeneralPasStructParser;
    FTokenListRef: TCnIdeStringList;
    FBeforeImpl: Boolean;
    function CanExtract(const S: PCnIdeTokenChar): Boolean;
  protected
    function GetPasTokenStr(Token: TCnGeneralPasToken): TCnIdeTokenString;
  public
    constructor Create(AOwner: TCnCodingToolsetWizard); override;
    destructor Destroy; override;

    function GetCaption: string; override;
    function GetHint: string; override;
    function GetDefShortCut: TShortCut; override;
    function GetState: TWizardState; override;
    procedure Execute; override;
    procedure GetEditorInfo(var Name, Author, Email: string); override;

    function Scan: Boolean;
    {* ɨ�赱ǰԴ���е��ַ���������ɨ���Ƿ�ɹ���
    ���ڲ����� Stream/Parser���������� TokenListRef �У��Լ� FBeforeImpl}
    procedure MakeUnique;
    {* �� TokenListRef �е��ַ������ز����� 1 �Ⱥ�׺}
    function GenerateDecl(OutList: TCnIdeStringList; HeadType: TCnStringHeadType): Boolean;
    {* �� FTokenListRef ������ var �� const �������飬�ڲ�Ҫʹ�� FEditStream���������ݷ� OutList ��}
    function Replace: Integer;
    {* ���ַ����滻Ϊ���������������������ڲ�Ҫʹ�� FEditStream�������滻�ĸ���}
    function InsertDecl(Area: TCnStringAreaType; HeadType: TCnStringHeadType): Integer;
    {* ���������뵱ǰԴ��ָ�����֡����ز��������}

    procedure FreeTokens;
    {* ������Ϻ������������ͷ��ڴ�}
    property TokenListRef: TCnIdeStringList read FTokenListRef;
    {* ɨ�����������������}
    property BeforeImpl: Boolean read FBeforeImpl;
    {* �Ƿ����� implementation ֮ǰ���ַ���}

  published
    property IgnoreSingleChar: Boolean read FIgnoreSingleChar write FIgnoreSingleChar;
    {* ɨ��ʱ�Ƿ���Ե��ַ����ַ���}
    property IgnoreSimpleFormat: Boolean read FIgnoreSimpleFormat write FIgnoreSimpleFormat;
    {* ɨ��ʱ�Ƿ���Լ򵥵ĸ�ʽ���ַ���}

    property Prefix: string read FPrefix write FPrefix;
    {* ���ɵı�������ǰ׺����Ϊ�գ������Ƽ�}
    property UseUnderLine: Boolean read FUseUnderLine write FUseUnderLine;
    {* �������ķִ��Ƿ�ʹ���»�����Ϊ�ָ���}
    property IdentWordStyle: TCnIdentWordStyle read FIdentWordStyle write FIdentWordStyle;
    {* �������ķִʷ��ȫ��д����ȫСд��������ĸ��д���Сд}
    property UseFullPinYin: Boolean read FUseFullPinYin write FUseFullPinYin;
    {* ��������ʱ��ʹ��ȫƴ����ƴ������ĸ��True Ϊǰ��}
    property MaxPinYinWords: Integer read FMaxPinYinWords write FMaxPinYinWords;
    {* ����ƴ���ִʸ���}
    property MaxWords: Integer read FMaxWords write FMaxWords;
    {* ������ͨӢ�ķִʸ���}

    property ShowPreview: Boolean read FShowPreview write FShowPreview;
    {* �Ƿ���ʾԤ������}
  end;

  TCnExtractStringForm = class(TCnTranslateForm)
    grpScanOption: TGroupBox;
    chkIgnoreSingleChar: TCheckBox;
    chkIgnoreSimpleFormat: TCheckBox;
    grpPinYinOption: TGroupBox;
    lblPinYin: TLabel;
    cbbPinYinRule: TComboBox;
    btnReScan: TButton;
    pnl1: TPanel;
    lvStrings: TListView;
    mmoPreview: TMemo;
    spl1: TSplitter;
    cbbMakeType: TComboBox;
    lblMake: TLabel;
    lblToArea: TLabel;
    cbbToArea: TComboBox;
    btnHelp: TButton;
    btnReplace: TButton;
    btnClose: TButton;
    lblPrefix: TLabel;
    edtPrefix: TEdit;
    lblStyle: TLabel;
    cbbIdentWordStyle: TComboBox;
    lblMaxWords: TLabel;
    edtMaxWords: TEdit;
    udMaxWords: TUpDown;
    lblMaxPinYin: TLabel;
    edtMaxPinYin: TEdit;
    udMaxPinYin: TUpDown;
    chkUseUnderLine: TCheckBox;
    chkShowPreview: TCheckBox;
    btnCopy: TSpeedButton;
    actlstExtract: TActionList;
    actRescan: TAction;
    actCopy: TAction;
    actReplace: TAction;
    actEdit: TAction;
    procedure chkShowPreviewClick(Sender: TObject);
    procedure lvStringsData(Sender: TObject; Item: TListItem);
    procedure FormCreate(Sender: TObject);
    procedure lvStringsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvStringsDblClick(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actRescanExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actReplaceExecute(Sender: TObject);
    procedure actlstExtractUpdate(Action: TBasicAction;
      var Handled: Boolean);
  private
    FTool: TCnEditorExtractString;
    procedure UpdateTokenToListView;
    procedure LoadSettings;
    procedure SaveSettings;
  public
    property Tool: TCnEditorExtractString read FTool write FTool;
  end;

{$ENDIF CNWIZARDS_CNCODINGTOOLSETWIZARD}

implementation

{$IFDEF CNWIZARDS_CNCODINGTOOLSETWIZARD}

{$R *.DFM}

{$IFDEF DEBUG}
uses
  CnDebug;
{$ENDIF}

const
  CnSourceStringPosKinds: TCodePosKinds = [pkField, pkProcedure, pkFunction,
    pkConstructor, pkDestructor, pkFieldDot];

  SCN_HEAD_STRS: array[TCnStringHeadType] of string = ('var', 'const', 'resourcestring');

  SCN_AREA_STRS: array[TCnStringAreaType] of string = ('interface', 'implementation');
  CN_DEF_MAX_WORDS = 6;

{ TCnExtractStringForm }

procedure TCnExtractStringForm.chkShowPreviewClick(Sender: TObject);
begin
  mmoPreview.Visible := chkShowPreview.Checked;
  // spl1.Visible := chkShowPreview.Checked;
end;

procedure TCnExtractStringForm.UpdateTokenToListView;
begin
  lvStrings.Items.Count := FTool.FTokenListRef.Count;
  lvStrings.Invalidate;
end;

procedure TCnExtractStringForm.lvStringsData(Sender: TObject;
  Item: TListItem);
var
  Token: TCnGeneralPasToken;
begin
  if (Item.Index >= 0) and (Item.Index < FTool.TokenListRef.Count) then
  begin
    Token := TCnGeneralPasToken(FTool.TokenListRef.Objects[Item.Index]);
    Item.Caption := IntToStr(Item.Index + 1);
    Item.Data := Token;

    with Item.SubItems do
    begin
      Add(FTool.TokenListRef[Item.Index]);
      Add(FTool.GetPasTokenStr(Token));
    end;
  end;
end;

procedure TCnExtractStringForm.LoadSettings;
begin
  if FTool = nil then
    Exit;

  edtPrefix.Text := FTool.Prefix;
  cbbIdentWordStyle.ItemIndex := Ord(FTool.IdentWordStyle);
  if FTool.UseFullPinYin then
    cbbPinYinRule.ItemIndex := 1
  else
    cbbPinYinRule.ItemIndex := 0;
  udMaxWords.Position := FTool.MaxWords;
  udMaxPinYin.Position := FTool.MaxPinYinWords;
  chkUseUnderLine.Checked := FTool.UseUnderLine;
  chkIgnoreSingleChar.Checked := FTool.IgnoreSingleChar;
  chkIgnoreSimpleFormat.Checked := FTool.IgnoreSimpleFormat;
  chkShowPreview.Checked := FTool.ShowPreview;
end;

procedure TCnExtractStringForm.SaveSettings;
begin
  if FTool = nil then
    Exit;

  FTool.Prefix := edtPrefix.Text;
  FTool.IdentWordStyle := TCnIdentWordStyle(cbbIdentWordStyle.ItemIndex);
  FTool.UseFullPinYin := cbbPinYinRule.ItemIndex = 1;

  FTool.MaxWords := udMaxWords.Position;
  FTool.MaxPinYinWords := udMaxPinYin.Position;
  FTool.UseUnderLine := chkUseUnderLine.Checked;
  FTool.IgnoreSingleChar := chkIgnoreSingleChar.Checked;
  FTool.IgnoreSimpleFormat := chkIgnoreSimpleFormat.Checked;
  FTool.ShowPreview := chkShowPreview.Checked;
end;

procedure TCnExtractStringForm.FormCreate(Sender: TObject);
var
  EditorCanvas: TCanvas;
  I: TCnStringHeadType;
  J: TCnStringAreaType;
begin
  btnCopy.Caption := '';

  for I := Low(SCN_HEAD_STRS) to High(SCN_HEAD_STRS) do
    cbbMakeType.Items.Add(SCN_HEAD_STRS[I]);
  for J := Low(SCN_AREA_STRS) to High(SCN_AREA_STRS) do
    cbbToArea.Items.Add(SCN_AREA_STRS[J]);

  cbbMakeType.ItemIndex := 0;
  cbbToArea.ItemIndex := 0;

  EditorCanvas := EditControlWrapper.GetEditControlCanvas(CnOtaGetCurrentEditControl);
  if EditorCanvas <> nil then
  begin
    if EditorCanvas.Font.Name <> mmoPreview.Font.Name then
      mmoPreview.Font.Name := EditorCanvas.Font.Name;
    mmoPreview.Font.Size := EditorCanvas.Font.Size;
    mmoPreview.Font.Style := EditorCanvas.Font.Style - [fsUnderline, fsStrikeOut, fsItalic];
  end;
end;

procedure TCnExtractStringForm.lvStringsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
const
  CnBeforeLine = 1;
  CnAfterLine = 4;
var
  Token: TCnGeneralPasToken;
begin
  if not Selected or (Item = nil) or (Item.Data = nil) then
    Exit;

  Token := TCnGeneralPasToken(Item.Data);
  mmoPreview.Lines.Text := CnOtaGetLineText(Token.EditLine - CnBeforeLine,
    nil, CnBeforeLine + CnAfterLine);
end;

{ TCnEditorExtractString }

function TCnEditorExtractString.CanExtract(const S: PCnIdeTokenChar): Boolean;
var
  L: Integer;
begin
  Result := False;
  L := StrLen(S);
  if L <= 2 then // �����Ż�ȫ������
    Exit;

  if FIgnoreSingleChar and (L = 3) and (S[0] = '''') and (S[2] = '''') then // �����ַ�Ҳ����
    Exit;

  if FIgnoreSingleChar and (L = 4) and (S[0] = '''') and (S[1] = '''')
    and (S[2] = '''') and (S[2] = '''') then // ����������Ҳ����
    Exit;

  if FIgnoreSimpleFormat and IsSimpleFormat(S) then
    Exit;

  Result := True;
end;

constructor TCnEditorExtractString.Create(AOwner: TCnCodingToolsetWizard);
begin
  inherited;
  FIdentWordStyle := iwsUpperCase;
  FPrefix := 'S';
  FMaxWords := CN_DEF_MAX_WORDS;
  FMaxPinYinWords := CN_DEF_MAX_WORDS;
  FUseUnderLine := True;
  FIgnoreSingleChar := True;
  FIgnoreSimpleFormat := True;
  FShowPreview := True;
end;

destructor TCnEditorExtractString.Destroy;
begin
  FTokenListRef.Free;
  FPasParser.Free;
  FEditStream.Free;
  inherited;
end;

procedure TCnEditorExtractString.Execute;
var
  PasParser: TCnGeneralPasStructParser;
  Stream: TMemoryStream;
  I, CurrPos, LastTokenPos: Integer;
  EditView: IOTAEditView;
  Token, StartToken, EndToken, PrevToken: TCnGeneralPasToken;
  EditPos: TOTAEditPos;
  Info: TCodePosInfo;
  TokenList: TCnIdeStringList;
  S, NewCode: TCnIdeTokenString;
  EditWriter: IOTAEditWriter;
begin
  EditView := CnOtaGetTopMostEditView;
  if EditView = nil then
    Exit;

  with TCnExtractStringForm.Create(Application) do
  begin
    Tool := Self;
    LoadSettings;

    if ShowModal = mrOK then
    begin
      SaveSettings;

    end;

    Free;
  end;
end;

procedure TCnEditorExtractString.FreeTokens;
begin
  FreeAndNil(FTokenListRef);
  FreeAndNil(FPasParser);
  FreeAndNil(FEditStream);
end;

function TCnEditorExtractString.GenerateDecl(OutList: TCnIdeStringList;
  HeadType: TCnStringHeadType): Boolean;
var
  I, L: Integer;
  Token: TCnGeneralPasToken;
begin
  Result := False;
  if (OutList = nil) or (FTokenListRef = nil) or (FTokenListRef.Count <= 0) then
    Exit;

  L := EditControlWrapper.GetBlockIndent;
  OutList.Clear;
  OutList.Add(SCN_HEAD_STRS[HeadType]);

  if HeadType in [htVar] then
  begin
    for I := 0 to FTokenListRef.Count - 1 do
    begin
      Token := TCnGeneralPasToken(FTokenListRef.Objects[I]);
      OutList.Add(Spc(L) + FTokenListRef[I] + ': string = ' + GetPasTokenStr(Token) + ';');
    end;
    RemoveDuplicatedStrings(OutList);
    Result := True;
  end
  else if HeadType in [htConst, htResourcestring] then
  begin
    for I := 0 to FTokenListRef.Count - 1 do
    begin
      Token := TCnGeneralPasToken(FTokenListRef.Objects[I]);
      OutList.Add(Spc(L) + FTokenListRef[I] + ' = ' + GetPasTokenStr(Token) + ';');
    end;
    RemoveDuplicatedStrings(OutList);
    Result := True;
  end;
end;

function TCnEditorExtractString.GetCaption: string;
begin
  Result := SCnEditorExtractStringMenuCaption;
end;

function TCnEditorExtractString.GetDefShortCut: TShortCut;
begin
  Result := 0;
end;

procedure TCnEditorExtractString.GetEditorInfo(var Name, Author,
  Email: string);
begin
  Name := SCnEditorExtractStringName;
  Author := SCnPack_LiuXiao;
  Email := SCnPack_LiuXiaoEmail;
end;

function TCnEditorExtractString.GetHint: string;
begin
  Result := SCnEditorExtractStringMenuHint;
end;

function TCnEditorExtractString.GetPasTokenStr(Token: TCnGeneralPasToken): TCnIdeTokenString;
var
  P: PByte;
begin
  Result := '';
  if (Token <> nil) and (Token.TokenLength > 0) then
  begin
    if Token.TokenLength < CN_TOKEN_MAX_SIZE then
      Result := TCnIdeTokenString(Token.Token)
    else if (FEditStream <> nil) and
      (FEditStream.Size >= (Token.TokenPos + Token.TokenLength) * SizeOf(Char)) then
    begin
      SetLength(Result, Token.TokenLength);
      P := FEditStream.Memory;
      Inc(P, Token.TokenPos * SizeOf(Char));
      Move(P^, Result[1], Token.TokenLength * SizeOf(Char));
    end;
  end;
end;

function TCnEditorExtractString.GetState: TWizardState;
begin
  Result := inherited GetState;
  if wsEnabled in Result then
  begin
    if not CurrentIsDelphiSource then
      Result := [];
  end;
end;

function TCnEditorExtractString.InsertDecl(Area: TCnStringAreaType;
  HeadType: TCnStringHeadType): Integer;
const
  KINDS: array[TCnStringAreaType] of TTokenKind = (tkInterface, tkImplementation);
var
  Lex: TCnGeneralWidePasLex;
  Stream: TMemoryStream;
  EditView: IOTAEditView;
  AreaFound: Boolean;
  InsPos: Integer;
  Names: TCnIdeStringList;
  S: TCnIdeTokenString;
  EditWriter: IOTAEditWriter;
begin
  Result := 0;
  // �� interface �� implementation ��� uses �ķֺſգ�������������� uses��ֱ�Ӳ������

  EditView := CnOtaGetTopMostEditView;
  if EditView = nil then
    Exit;

  Stream := nil;
  Lex := nil;
  Names := nil;

  try
    Stream := TMemoryStream.Create;
    CnGeneralSaveEditorToStream(EditView.Buffer, Stream);

    Lex := TCnGeneralWidePasLex.Create;
    Lex.Origin := Stream.Memory;

    AreaFound := False;
    while (Lex.TokenID <> tkNull) and (Lex.TokenID <> KINDS[Area]) do
      Lex.NextNoJunk;

    if Lex.TokenID = tkNull then
      Exit;

    // �˿��ҵ��� interface �� implementation����¼��β��λ��
    InsPos := Lex.TokenPos + Length(Lex.Token);

    while (Lex.TokenID <> tkNull) and (Lex.TokenID <> tkUses) do
      Lex.NextNoJunk;

    if Lex.TokenID <> tkNull then
    begin
      // �˿��ҵ��� uses�����Һ���ĵ�һ���ֺ�
      while (Lex.TokenID <> tkNull) and (Lex.TokenID <> tkSemiColon) do
        Lex.NextNoJunk;

      if Lex.TokenID <> tkNull then
      begin
        // �ҵ��� uses ��ĵ�һ���ֺţ��ټ�¼��β��λ��
        InsPos := Lex.TokenPos + Length(Lex.Token);
      end;
    end;

    // ���ø�λ�ã�����ɱ༭���������λ�ã��ٲ��뻻�мӿ��м�����
    Names := TCnIdeStringList.Create;
    if not GenerateDecl(Names, HeadType) then
      Exit;

    if Names.Count <= 1 then
      Exit;

    Result := Names.Count - 1;
    Names.Insert(0, '');
    Names.Insert(0, '');
    S := Names.Text;

    if Length(S) > 2 then // ȥ��ĩβ����Ļس�
    begin
      if (S[Length(S) - 1] = #13) and (S[Length(S)] = #10) then
        Delete(S, Length(S) - 1, 2);
    end;

    EditWriter := CnOtaGetEditWriterForSourceEditor;

{$IFDEF IDE_WIDECONTROL}
    // ����ʱ��Wide Ҫ�� Utf8 ת��
    EditWriter.CopyTo(Length(UTF8Encode(Copy(Lex.Origin, 1, InsPos))));
  {$IFDEF UNICODE}
    EditWriter.Insert(PAnsiChar(ConvertTextToEditorTextW(S)));
  {$ELSE}
    EditWriter.Insert(PAnsiChar(ConvertWTextToEditorText(S)));
  {$ENDIF}
{$ELSE}
    EditWriter.CopyTo(InsPos);
    EditWriter.Insert(PAnsiChar(ConvertTextToEditorText(S)));
{$ENDIF}
    EditWriter := nil;
  finally
    Names.Free;
    Lex.Free;
    Stream.Free;
  end;
end;

procedure TCnEditorExtractString.MakeUnique;
var
  I, J: Integer;
  Map: TCnStrToStrHashMap;
  S, H: string;
  Token: TCnGeneralPasToken;
begin
  if FTokenListRef.Count <= 1 then
    Exit;

  Map := TCnStrToStrHashMap.Create;
  try
    for I := 0 to FTokenListRef.Count - 1 do
    begin
      Token := TCnGeneralPasToken(FTokenListRef.Objects[I]);
      if Map.Find(string(FTokenListRef[I]), S) then
      begin
        if S <> string(GetPasTokenStr(Token)) then
        begin
          // ��ͬ���ģ���ֵ��ͬ��Ҫ����
          J := 1;
          H := FTokenListRef[I];
          repeat
            FTokenListRef[I] := H + IntToStr(J);
            Inc(J);
          until not Map.Find(string(FTokenListRef[I]), S);

          // ������Ҫ����
          Map.Add(string(FTokenListRef[I]), string(GetPasTokenStr(Token)));
        end;
        // ͬ��ֵͬ����
      end
      else // ��ͬ���ģ�ֱ������
        Map.Add(string(FTokenListRef[I]), string(GetPasTokenStr(Token)));
    end;
  finally
    Map.Free;
  end;
end;

function TCnEditorExtractString.Replace: Integer;
var
  I, LastTokenPos: Integer;
  EditView: IOTAEditView;
  Token, StartToken, EndToken, PrevToken: TCnGeneralPasToken;
  NewCode: TCnIdeTokenString;
  EditWriter: IOTAEditWriter;
begin
  Result := 0;
  EditView := CnOtaGetTopMostEditView;
  if EditView = nil then
    Exit;

  StartToken := TCnGeneralPasToken(FTokenListRef.Objects[0]);
  EndToken := TCnGeneralPasToken(FTokenListRef.Objects[FTokenListRef.Count - 1]);
  PrevToken := nil;

  // ƴ���滻����ַ���
  for I := 0 to FTokenListRef.Count - 1 do
  begin
    Token := TCnGeneralPasToken(FTokenListRef.Objects[I]);
    if PrevToken = nil then
      NewCode := FTokenListRef[I]
    else
    begin
      // ����һ Token ��β�ͣ������� Token ��ͷ���ټ��滻������֣��� Ansi/Wide/Wide String ������
      LastTokenPos := PrevToken.TokenPos + PrevToken.TokenLength;
      NewCode := NewCode + Copy(FPasParser.Source, LastTokenPos + 1,
        Token.TokenPos - LastTokenPos) + FTokenListRef[I];
    end;
    Inc(Result);
    PrevToken := TCnGeneralPasToken(FTokenListRef.Objects[I]);
  end;

  EditWriter := CnOtaGetEditWriterForSourceEditor;

{$IFDEF IDE_WIDECONTROL}
  // ����ʱ��Wide Ҫ�� Utf8 ת��
  EditWriter.CopyTo(Length(UTF8Encode(Copy(FPasParser.Source, 1, StartToken.TokenPos))));
  EditWriter.DeleteTo(Length(UTF8Encode(Copy(FPasParser.Source, 1, EndToken.TokenPos + EndToken.TokenLength))));
  {$IFDEF UNICODE}
  EditWriter.Insert(PAnsiChar(ConvertTextToEditorTextW(NewCode)));
  {$ELSE}
  EditWriter.Insert(PAnsiChar(ConvertWTextToEditorText(NewCode)));
  {$ENDIF}
{$ELSE}
  EditWriter.CopyTo(StartToken.TokenPos);
  EditWriter.DeleteTo(EndToken.TokenPos + (EndToken.TokenLength));
  EditWriter.Insert(PAnsiChar(ConvertTextToEditorText(AnsiString(NewCode))));
{$ENDIF}
  EditWriter := nil;
end;

function TCnEditorExtractString.Scan: Boolean;
var
  I, CurrPos, LastTokenPos: Integer;
  EditView: IOTAEditView;
  Token: TCnGeneralPasToken;
  EditPos: TOTAEditPos;
  Info: TCodePosInfo;
  S: TCnIdeTokenString;
  Lex: TCnGeneralWidePasLex;
begin
  Result := False;
  EditView := CnOtaGetTopMostEditView;
  if EditView = nil then
    Exit;

  Lex := nil;

  try
    FreeTokens;

    FPasParser := TCnGeneralPasStructParser.Create;
{$IFDEF BDS}
    FPasParser.UseTabKey := True;
    FPasParser.TabWidth := EditControlWrapper.GetTabWidth;
{$ENDIF}

    FEditStream := TMemoryStream.Create;
    CnGeneralSaveEditorToStream(EditView.Buffer, FEditStream);

{$IFDEF DEBUG}
    CnDebugger.LogMsg('CnEditorExtractString Scan to ParseString.');
{$ENDIF}

    // ������ǰ��ʾ��Դ�ļ��е��ַ���
    CnPasParserParseString(FPasParser, FEditStream);
    for I := 0 to FPasParser.Count - 1 do
    begin
      Token := FPasParser.Tokens[I];
      if CanExtract(Token.Token) then
      begin
        ConvertGeneralTokenPos(Pointer(EditView), Token);

{$IFDEF UNICODE}
        ParsePasCodePosInfoW(PChar(FEditStream.Memory), Token.EditLine, Token.EditCol, Info);
{$ELSE}
        EditPos.Line := Token.EditLine;
        EditPos.Col := Token.EditCol;
        CurrPos := CnOtaGetLinePosFromEditPos(EditPos);

        Info := ParsePasCodePosInfo(PChar(FEditStream.Memory), CurrPos);
{$ENDIF}
        Token.Tag := Ord(Info.PosKind);
      end
      else
        Token.Tag := Ord(pkUnknown);
    end;

{$IFDEF DEBUG}
    CnDebugger.LogInteger(FPasParser.Count, 'PasParser.Count');
{$ENDIF}

    if FTokenListRef = nil then
      FTokenListRef := TCnIdeStringList.Create
    else
      FTokenListRef.Clear;

    for I := 0 to FPasParser.Count - 1 do
    begin
      Token := FPasParser.Tokens[I];
      if TCodePosKind(Token.Tag) in CnSourceStringPosKinds then
      begin
        S := ConvertStringToIdent(string(Token.Token), FPrefix, FUseUnderLine,
          FIdentWordStyle, FUseFullPinYin, FMaxPinYinWords, FMaxWords);
        // �� D2005~2007 ���� AnsiString �� WideString ��ת����Ҳ��Ӱ��

        FTokenListRef.AddObject(S, Token);
      end;
    end;

{$IFDEF DEBUG}
    CnDebugger.LogInteger(FTokenListRef.Count, 'TokensRefList.Count');
{$ENDIF}

    FBeforeImpl := False;
    if FTokenListRef.Count > 0 then
    begin
      Token := TCnGeneralPasToken(FTokenListRef.Objects[0]);

      // ���� implementation������һ���Ƿ�����ǰ��
      FEditStream.Position := 0;
      Lex := TCnGeneralWidePasLex.Create;
      Lex.Origin := FEditStream.Memory;

      while not (Lex.TokenID in [tkNull, tkImplementation]) do
        Lex.NextNoJunk;

      if Lex.TokenID = tkImplementation then
      begin
{$IFDEF SUPPORT_WIDECHAR_IDENTIFIER}
        FBeforeImpl := Token.LineNumber < Lex.LineNumber - 1;
{$ELSE}
        FBeforeImpl := Token.LineNumber < Lex.LineNumber;
{$ENDIF}
      end;
    end;
    Result := True;
  finally
    Lex.Free;
  end;
end;

procedure TCnExtractStringForm.lvStringsDblClick(Sender: TObject);
begin
  actEdit.Execute;
end;

procedure TCnExtractStringForm.actCopyExecute(Sender: TObject);
var
  L: TStringList;
  HT: TCnStringHeadType;
begin
  if (FTool.TokenListRef = nil) or (FTool.TokenListRef.Count <= 0) then
    Exit;

  L := TStringList.Create;
  try
    HT := TCnStringHeadType(cbbMakeType.ItemIndex);
    if FTool.GenerateDecl(L, HT) then
    begin
      Clipboard.AsText := L.Text;
      InfoDlg(Format(SCnEditorExtractStringCopiedFmt, [L.Count - 1, SCN_HEAD_STRS[HT]]));
    end;
  finally
    L.Free;
  end;
end;

procedure TCnExtractStringForm.actRescanExecute(Sender: TObject);
begin
  if FTool = nil then
    Exit;

  SaveSettings;
  if FTool.Scan then
  begin
    if FTool.TokenListRef.Count <= 0 then
    begin
      ErrorDlg(SCnEditorExtractStringNotFound);
      Exit;
    end;
{$IFDEF DEBUG}
    CnDebugger.LogMsg('Rescan OK. To Make Unique.');
{$ENDIF}

    FTool.MakeUnique;

{$IFDEF DEBUG}
    CnDebugger.LogMsg('Make Unique OK. Update To ListView.');
{$ENDIF}

    if FTool.BeforeImpl then
      cbbToArea.ItemIndex := Ord(atInterface)
    else
      cbbToArea.ItemIndex := Ord(atImplementation);

    UpdateTokenToListView;
  end;
end;

procedure TCnExtractStringForm.actEditExecute(Sender: TObject);
var
  Idx, K: Integer;
  S: string;
begin
  if lvStrings.Selected = nil then
    Exit;

  Idx := lvStrings.Selected.Index;
  if (Idx < 0) or (Idx >= FTool.TokenListRef.Count) then
    Exit;

  S := FTool.TokenListRef[Idx];
  if CnWizInputQuery(SCnEditorExtractStringChangeName, SCnEditorExtractStringEnterNewName, S) then
  begin
    K := FTool.TokenListRef.IndexOf(S);
    if (K >= 0) and (K <> Idx) then
    begin
      ErrorDlg(SCnEditorExtractStringDuplicatedName);
    end
    else
    begin
      FTool.TokenListRef[Idx] := S;
      lvStrings.Invalidate;
    end;
  end;
end;

procedure TCnExtractStringForm.actReplaceExecute(Sender: TObject);
var
  N, S: Integer;
begin
  if not QueryDlg(SCnEditorExtractStringAskReplace) then
    Exit;

  N := FTool.Replace;
  if N > 0 then
  begin
    S := FTool.InsertDecl(TCnStringAreaType(cbbToArea.ItemIndex),
      TCnStringHeadType(cbbMakeType.ItemIndex));
    if S > 0 then
    begin
      InfoDlg(Format(SCnEditorExtractStringReplacedFmt, [N, S]));
      Close;
    end;
  end;
end;

procedure TCnExtractStringForm.actlstExtractUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  if Action = actEdit then
    (Action as TCustomAction).Enabled := lvStrings.Selected <> nil
  else if {(Action = actCopy) or } (Action = actReplace) then
    (Action as TCustomAction).Enabled := lvStrings.Items.Count > 0
  else if Action = actRescan then
    (Action as TCustomAction).Enabled := CurrentIsDelphiSource;
end;

initialization
  RegisterCnCodingToolset(TCnEditorExtractString); // ע�Ṥ��

{$ENDIF CNWIZARDS_CNCODINGTOOLSETWIZARD}
end.