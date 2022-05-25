{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     中国人自己的开放源码第三方开发包                         }
{                   (C)Copyright 2001-2022 CnPack 开发组                       }
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

unit UnitEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FileCtrl, CnCommon, ComCtrls;

type
  TFormProjectEdit = class(TForm)
    PageControl1: TPageControl;
    tsCWProject: TTabSheet;
    lblCWRoot: TLabel;
    bvl1: TBevel;
    lblCWDpr: TLabel;
    lblCWDprAdd: TLabel;
    bvl2: TBevel;
    lblCWDproj: TLabel;
    lblCWDprojAdd: TLabel;
    bvl3: TBevel;
    lblCWBpf: TLabel;
    lblCWBpfAdd: TLabel;
    bvl4: TBevel;
    lblCWBpr: TLabel;
    lblCWBprAdd: TLabel;
    edtCWRootDir: TEdit;
    btnCWBrowse: TButton;
    edtCWDprBefore: TEdit;
    edtCWDprAdd: TEdit;
    btnCWDprAdd: TButton;
    btnCWDprojAdd: TButton;
    mmoCWDprojAdd: TMemo;
    mmoCWDprojBefore: TMemo;
    btnCWDprTemplate: TButton;
    edtCWBpfBefore: TEdit;
    edtCWBpfAdd: TEdit;
    btnCWBpfAdd: TButton;
    edtCWBprBefore: TEdit;
    edtCWBprAdd: TEdit;
    btnCWBprAdd: TButton;
    tsCVProject: TTabSheet;
    lblCVRoot: TLabel;
    edtCVRootDir: TEdit;
    btnCVBrowse: TButton;
    Bevel1: TBevel;
    edtCVDprBefore: TEdit;
    lblCVDpr: TLabel;
    edtCVDprAdd: TEdit;
    btnCVDprAdd: TButton;
    lblCVDprAdd: TLabel;
    tsCVSort: TTabSheet;
    lblCVSortRoot: TLabel;
    edtCVSortRootDir: TEdit;
    btnCVSortBrowse: TButton;
    btnCVSortAll: TButton;
    btnCVSortOne: TButton;
    dlgOpen1: TOpenDialog;
    btnCVSortAll1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCWBrowseClick(Sender: TObject);
    procedure btnCWDprAddClick(Sender: TObject);
    procedure btnCWDprojAddClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCWBpfAddClick(Sender: TObject);
    procedure btnCWBprAddClick(Sender: TObject);
    procedure btnCVBrowseClick(Sender: TObject);
    procedure btnCVSortBrowseClick(Sender: TObject);
    procedure btnCVSortOneClick(Sender: TObject);
    procedure btnCVSortAllClick(Sender: TObject);
    procedure btnCVSortAll1Click(Sender: TObject);
    procedure btnCVDprAddClick(Sender: TObject);
  private
    FCount: Integer;
    FSingleBefore, FSingleAdd: string;
    FBefores, FAdds: TStrings;
    procedure SingleLineFound(const FileName: string; const Info: TSearchRec;
      var Abort: Boolean);
    procedure MultiLineFound(const FileName: string; const Info: TSearchRec;
      var Abort: Boolean);
  public
    procedure SortFileFound(const FileName: string; const Info: TSearchRec;
      var Abort: Boolean);
    procedure SortOneDpr(const Dpr: string);
  end;

var
  FormProjectEdit: TFormProjectEdit;

implementation

{$R *.DFM}

{
  批量修改以下内容：
  CB5 BPF  - 已实现 USEUNIT/USEFORMNS
  CB6 BPF  - 已实现 USEFORMNS
  CB6 BPR  - 已实现 <FILE FILENAME=
  DPR                 - 已实现
  BDSPROJ/DPROJ       - 已实现

  而 CB5/6 BPF 里 obj 和 dfm 要手工加
}

const
  FILE_COUNT = '处理文件数：';

procedure TFormProjectEdit.FormCreate(Sender: TObject);
var
  S: string;
begin
  S := ExtractFileDir(Application.ExeName);
  S := ExtractFileDir(S);
  edtCWRootDir.Text := S + '\Source\';

  S := ExtractFileDir(S);
  edtCVRootDir.Text := S + '\cnvcl\Packages\';
  edtCVSortRootDir.Text := edtCVRootDir.Text;

  FBefores := TStringList.Create;
  FAdds := TStringList.Create;
end;

procedure TFormProjectEdit.btnCWBrowseClick(Sender: TObject);
var
  S: string;
begin
  if SelectDirectory('Select CnPack IDE Wizards Project Files Directory', '', S) then
    edtCWRootDir.Text := S;
end;

procedure TFormProjectEdit.btnCWDprAddClick(Sender: TObject);
begin
  if not DirectoryExists(edtCWRootDir.Text) then
    Exit;

  if (Trim(edtCWDprBefore.Text) = '') or (Trim(edtCWDprAdd.Text) = '') then
    Exit;

  FCount := 0;
  FSingleBefore := Trim(edtCWDprBefore.Text);
  FSingleAdd := Trim(edtCWDprAdd.Text);
  FindFile(edtCWRootDir.Text, '*.dpr', SingleLineFound, nil, False, False);

  if FCount > 0 then
    InfoDlg(FILE_COUNT + IntToStr(FCount));
end;

procedure TFormProjectEdit.SingleLineFound(const FileName: string;
  const Info: TSearchRec; var Abort: Boolean);
var
  L: TStrings;
  I: Integer;
  S: string;
begin
  L := TStringList.Create;
  try
    L.LoadFromFile(FileName);
    for I := 0 to L.Count - 1 do
    begin
      if StrEndWith(L[I], FSingleBefore) then
      begin
        S := L[I];
        Delete(S, Pos(FSingleBefore, S), MaxInt);
        if Trim(S) = '' then
        begin
          // S 是目标行的前导空格数
          L.Insert(I + 1, S + FSingleAdd);
          L.SaveToFile(FileName);
          Inc(FCount);
          Exit;
        end;
      end;
    end;
  finally
    L.Free;
  end;
end;

procedure TFormProjectEdit.btnCWDprojAddClick(Sender: TObject);
begin
  if not DirectoryExists(edtCWRootDir.Text) then
    Exit;

  if (Trim(mmoCWDprojBefore.Lines.Text) = '') or (Trim(mmoCWDprojAdd.Lines.Text) = '') then
    Exit;

  FCount := 0;
  FBefores.Assign(mmoCWDprojBefore.Lines);
  FAdds.Assign(mmoCWDprojAdd.Lines);

  if Trim(FBefores[FBefores.Count - 1]) = '' then
    FBefores.Delete(FBefores.Count - 1);
  if Trim(FAdds[FAdds.Count - 1]) = '' then
    FAdds.Delete(FAdds.Count - 1);

  FindFile(edtCWRootDir.Text, '*.*proj', MultiLineFound, nil, False, False);

  if FCount > 0 then
    InfoDlg(FILE_COUNT + IntToStr(FCount));
end;

procedure TFormProjectEdit.MultiLineFound(const FileName: string;
  const Info: TSearchRec; var Abort: Boolean);
var
  L: TStrings;
  I, K: Integer;
  S: string;
  IsTab: Boolean;

  function StringsMatch(SourceStartIndex: Integer; Source, Patts: TStrings): Boolean;
  var
    J: Integer;
  begin
    // 判断 Source 的第 SourceStartIndex 行起，是否匹配 Patts 的所有行
    Result := False;
    if SourceStartIndex > Source.Count - Patts.Count then
      Exit; // 不够比的

    for J := 0 to Patts.Count - 1 do
    begin
      if Trim(Source[SourceStartIndex + J]) <> Trim(Patts[J]) then
        Exit;
    end;
    Result := True;
  end;

begin
  L := TStringList.Create;
  try
    L.LoadFromFile(FileName);

    for I := 0 to L.Count - 1 do
    begin
      if StringsMatch(I, L, FBefores) then
      begin
        S := L[I + FBefores.Count - 1];
        Delete(S, Pos(FBefores[0], S), MaxInt);
        // S 是目标行第一行的前导空格数或 Tab 数

        IsTab := (Length(S) > 0) and (S[1] = #9);

        for K := FAdds.Count - 1 downto 0 do
        begin // 挨个插入
          if IsTab and (Length(FAdds[K]) > 0) and (FAdds[K][1] = ' ') then
          begin
            L.Insert(I, S + #9 + FAdds[K]);
          end
          else if not IsTab and (Length(FAdds[K]) > 0) and (FAdds[K][1] = ' ') then
          begin
            L.Insert(I, S + '    ' + FAdds[K]); // 没法判断几个空格，只能先用四个代替
          end
          else
            L.Insert(I, S + FAdds[K]);
        end;

        L.SaveToFile(FileName);
        Inc(FCount);
        Exit;
      end;
    end;
  finally
    L.Free;
  end;
end;

procedure TFormProjectEdit.FormDestroy(Sender: TObject);
begin
  FBefores.Free;
  FAdds.Free;
end;

procedure TFormProjectEdit.btnCWBpfAddClick(Sender: TObject);
begin
  if not DirectoryExists(edtCWRootDir.Text) then
    Exit;

  if (Trim(edtCWBpfBefore.Text) = '') or (Trim(edtCWBpfAdd.Text) = '') then
    Exit;

  FCount := 0;
  FSingleBefore := Trim(edtCWBpfBefore.Text);
  FSingleAdd := Trim(edtCWBpfAdd.Text);
  FindFile(edtCWRootDir.Text, '*.bpf', SingleLineFound, nil, False, False);

  if FCount > 0 then
    InfoDlg(FILE_COUNT + IntToStr(FCount));
end;

procedure TFormProjectEdit.btnCWBprAddClick(Sender: TObject);
begin
  if not DirectoryExists(edtCWRootDir.Text) then
    Exit;

  if (Trim(edtCWBprBefore.Text) = '') or (Trim(edtCWBprAdd.Text) = '') then
    Exit;

  FCount := 0;
  FSingleBefore := Trim(edtCWBprBefore.Text);
  FSingleAdd := Trim(edtCWBprAdd.Text);
  FindFile(edtCWRootDir.Text, '*.bpr', SingleLineFound, nil, False, False);

  if FCount > 0 then
    InfoDlg(FILE_COUNT + IntToStr(FCount));
end;

procedure TFormProjectEdit.btnCVBrowseClick(Sender: TObject);
var
  S: string;
begin
  if SelectDirectory('Select CnPack Component Project Files Directory', '', S) then
    edtCVRootDir.Text := S;
end;

procedure TFormProjectEdit.btnCVSortBrowseClick(Sender: TObject);
var
  S: string;
begin
  if SelectDirectory('Select CnPack Component Project Files Directory', '', S) then
    edtCVRootDir.Text := S;
end;

procedure TFormProjectEdit.btnCVSortOneClick(Sender: TObject);
begin
  if dlgOpen1.Execute then
  begin
    SortOneDpr(dlgOpen1.FileName);
    ShowMessage('文件处理完毕：' + dlgOpen1.FileName);
  end;
end;

function DprCompare(List: TStringList; Index1, Index2: Integer): Integer;
const
  IN_KEYWORD = ' in ';
var
  P: Integer;
  S1, S2: string;
  F1, D1: string;
  F2, D2: string;
begin
  // 解析出文件名与最近一级的目录名来，先排后，再排前
  S1 := Trim(List[Index1]);
  S2 := Trim(List[Index2]);

  // 拿到文件名
  P := Pos(IN_KEYWORD, S1);
  if P > 1 then
  begin
    F1 := Copy(S1, 1, P - 1);
    Delete(S1, 1, P + Length(IN_KEYWORD));
  end;

  P := Pos(IN_KEYWORD, S2);
  if P > 1 then
  begin
    F2 := Copy(S2, 1, P - 1);
    Delete(S2, 1, P + Length(IN_KEYWORD));
  end;

  // 去掉路径名的第一个单引号
  if S1[1] = '''' then
    Delete(S1, 1, 1);
  if S2[1] = '''' then
    Delete(S2, 1, 1);

  // 去掉最后一个 ', 或 '; 以及后面的部分
  if StrEndWith(S1, ''',') or StrEndWith(S1, ''';') then
    Delete(S1, Length(S1) - 1, MaxInt);
  if StrEndWith(S2, ''',') or StrEndWith(S2, ''';') then
    Delete(S2, Length(S2) - 1, MaxInt);

  // 再去掉最后一个单引号以及后面的部分，避免有窗体注释存在
  P := LastCharPos(S1, '''');
  if P > 0 then
    Delete(S1, P, MaxInt);
  P := LastCharPos(S2, '''');
  if P > 0 then
    Delete(S2, P, MaxInt);

  D1 := ExtractFilePath(S1);
  if StrEndWith(D1, '\') then
    Delete(D1, Length(D1), 1);
  D1 := ExtractFileName(D1);

  D2 := ExtractFilePath(S2);
  if StrEndWith(D2, '\') then
    Delete(D2, Length(D2), 1);
  D2 := ExtractFileName(D2);

  Result := CompareStr(UpperCase(D1), UpperCase(D2));
  if Result = 0 then
    Result := CompareStr(UpperCase(F1), UpperCase(F2));
end;

procedure TFormProjectEdit.SortOneDpr(const Dpr: string);
var
  I, F1, F2: Integer;
  L1, L2: TStringList;
begin
  L1 := nil;
  L2 := nil;
  try
    L1 := TStringList.Create;
    L1.LoadFromFile(Dpr);

    F1 := -1;
    F2 := -1;
    for I := 0 to L1.Count - 1 do
    begin
      if Trim(L1[I]) = 'contains' then
        F1 := I + 1;
      if Trim(L1[I]) = 'end.'then
        F2 := I - 2;
    end;

    if (F1 > 1) and (F2 > F1) then
    begin
      L2 := TStringList.Create;
      for I := F1 to F2 do
        L2.Add(L1[I]);

      L2.CustomSort(DprCompare);
      for I := F1 to F2 do
        L1[I] := L2[I - F1];

      L1.SaveToFile(Dpr);
    end;
  finally
    L2.Free;
    L1.Free;
  end;
end;

procedure TFormProjectEdit.btnCVSortAllClick(Sender: TObject);
begin
  if not DirectoryExists(edtCVSortRootDir.Text) then
    Exit;

  FCount := 0;
  FindFile(edtCVSortRootDir.Text, 'CnPack*.dpk', SortFileFound, nil, True, False);

  if FCount > 0 then
    InfoDlg(FILE_COUNT + IntToStr(FCount));
end;

procedure TFormProjectEdit.SortFileFound(const FileName: string;
  const Info: TSearchRec; var Abort: Boolean);
begin
  SortOneDpr(FileName);
  Inc(FCount);
end;

procedure TFormProjectEdit.btnCVSortAll1Click(Sender: TObject);
begin
  if not DirectoryExists(edtCVSortRootDir.Text) then
    Exit;

  FCount := 0;
  FindFile(edtCVSortRootDir.Text, 'dclCnPack*.dpk', SortFileFound, nil, True, False);

  if FCount > 0 then
    InfoDlg(FILE_COUNT + IntToStr(FCount));
end;

procedure TFormProjectEdit.btnCVDprAddClick(Sender: TObject);
begin
  if not DirectoryExists(edtCVRootDir.Text) then
    Exit;

  if (Trim(edtCVDprBefore.Text) = '') or (Trim(edtCVDprAdd.Text) = '') then
    Exit;

  FCount := 0;
  FSingleBefore := Trim(edtCVDprBefore.Text);
  FSingleAdd := Trim(edtCVDprAdd.Text);
  FindFile(edtCVRootDir.Text, '*.dpk', SingleLineFound, nil, True, False);

  if FCount > 0 then
    InfoDlg(FILE_COUNT + IntToStr(FCount));
end;

end.
