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

{*******************************************************}
{                                                       }
{       Pascal Script Source File                       }
{       Run by RemObjects Pascal Script in CnWizards    }
{                                                       }
{       Generated by CnPack IDE Wizards                 }
{                                                       }
{*******************************************************}

program CnGenerateInc;
{* |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家包
* 单元名称：生成初始 CnWizards.inc 的脚本单元
* 单元作者：CnPack开发组
* 备    注：该单元是 Pascal Script 脚本，用来生成初始的 CnWizards.inc 文件
* 开发平台：PWin2000Pro + Delphi 5.01
* 兼容测试：PWin9X/2000/XP + Delphi 5/6/7 + C++Builder 5/6
* 本 地 化：该单元中的字符串均符合本地化处理方式
* 修改记录：2007.02.11 V1.0
*               创建单元
================================================================================
|</PRE>}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolsAPI, StdCtrls, ExtCtrls, Buttons, CnCommon, CnWizUtils, CnWizIdeUtils;

const
  SCnPackGenAsk =
    'This Script is Used to Generate a Full Functional CnWizards.inc in CnWizards Project Directory.' + #13#10 +
    'It Only needs to be Run when Cnwizards.inc Corrupted or Lost.' + #13#10 + #13#10 +
    'Please Open CnWizards Project and Run this Script from Script Window.'+ #13#10 + #13#10 +
    'Generate a Full CnWizards.inc?';
    
  SCnPackCopyRight =
    '{******************************************************************************}' + #13#10 +
    '{                       CnPack For Delphi/C++Builder                           }' + #13#10 +
    '{                     中国人自己的开放源码第三方开发包                         }' + #13#10 +
    '{                   (C)Copyright 2001-2025 CnPack 开发组                       }' + #13#10 +
    '{                   ------------------------------------                       }' + #13#10 +
    '{                                                                              }' + #13#10 +
    '{            本开发包是开源的自由软件，您可以遵照 CnPack 的发布协议来修        }' + #13#10 +
    '{        改和重新发布这一程序。                                                }' + #13#10 +
    '{                                                                              }' + #13#10 +
    '{            发布这一开发包的目的是希望它有用，但没有任何担保。甚至没有        }' + #13#10 +
    '{        适合特定目的而隐含的担保。更详细的情况请参阅 CnPack 发布协议。        }' + #13#10 +
    '{                                                                              }' + #13#10 +
    '{            您应该已经和开发包一起收到一份 CnPack 发布协议的副本。如果        }' + #13#10 +
    '{        还没有，可访问我们的网站：                                            }' + #13#10 +
    '{                                                                              }' + #13#10 +
    '{            网站地址：https://www.cnpack.org                                  }' + #13#10 +
    '{            电子邮件：master@cnpack.org                                       }' + #13#10 +
    '{                                                                              }' + #13#10 +
    '{******************************************************************************}';

var
  Wizards: TStringList;

procedure ProcessFile(const FileName: string);
var
  Lines: TStringList;
  I, P: Integer;
  S: string;
begin
  Lines := TStringList.Create;
  try
    Lines.Text := IdeGetSourceByFileName(FileName);

    for I := Lines.Count - 1 downto 0 do
    begin
      S := Trim(Lines[I]);
      if Copy(S, 1, Length('RegisterCnWizard')) = 'RegisterCnWizard' then
      begin
        Delete(S, 1, Length('RegisterCnWizard(T'));
        if S <> '' then
        begin
          P := Pos(')', S);
          if P > 0 then
          begin
            Delete(S, P, MaxInt);
            
            Wizards.Add('// Wizard: ' + S );
            Wizards.Add('{$DEFINE CNWIZARDS_'+UpperCase(S) + '}');
            Wizards.Add('');
          end;
        end;
      end;
    end;
  finally
    Lines.Free;
  end;
end;

procedure ProcessProject(Project: IOTAProject);
var
  I: Integer;
  FileName: string;
begin
  if Project = nil then Exit;

  ProcessFile(Project.GetFileName);        // 处理工程文件自身

  for I := 0 to Project.GetModuleCount - 1 do
  begin
    FileName := Project.GetModule(I).GetFileName;
    if IsSourceModule(FileName) then
      ProcessFile(FileName);
  end;
end;

begin
  Wizards := TStringList.Create;
  Wizards.Add(SCnPackCopyRight);
  Wizards.Add('');
  Wizards.Add('{$I CnPack.inc}');
  Wizards.Add('');
  try
    if QueryDlg(SCnPackGenAsk, False) then
    begin
      Screen.Cursor := crHourGlass;
      ProcessProject(CnOtaGetCurrentProject);
      Screen.Cursor := crDefault;
      Wizards.SaveToFile('CnWizards.inc');
      InfoDlg('Generated OK.');
    end;
  finally
    Wizards.Free;
  end;
end.

