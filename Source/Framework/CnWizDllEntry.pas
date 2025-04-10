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

unit CnWizDllEntry;
{* |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家包
* 单元名称：CnWizard 专家 DLL 入口单元
* 单元作者：周劲羽 (zjy@cnpack.org)
* 备    注：
* 开发平台：PWin2000Pro + Delphi 5.01
* 兼容测试：PWin9X/2000/XP + Delphi 5/6/7 + C++Builder 5/6
* 本 地 化：该单元中的字符串均符合本地化处理方式
* 修改记录：2018.08.27 V1.1
*               增加开关允许不调用 AddWizard
*           2002.12.07 V1.0
*               创建单元
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

uses
  SysUtils, ToolsAPI, CnWizConsts;

// 专家 DLL 初始化入口函数
function InitWizard(const BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc;
  var Terminate: TWizardTerminateProc): Boolean; stdcall;
{* 专家 DLL 初始化入口函数}

exports
  InitWizard name WizardEntryPoint;

implementation

uses
{$IFDEF DEBUG}
  CnDebug,
{$ENDIF}
  CnWizManager;

const
  InvalidIndex = -1;

var
  FWizardIndex: Integer = InvalidIndex;

// 专家 DLL 释放过程
procedure FinalizeWizard;
var
  WizardServices: IOTAWizardServices;
begin
  if (FWizardIndex <> InvalidIndex) and (TObject(CnWizardMgr) is TInterfacedObject) then
  begin
    Assert(Assigned(BorlandIDEServices));
    WizardServices := BorlandIDEServices as IOTAWizardServices;
    Assert(Assigned(WizardServices));
{$IFDEF DEBUG}
    CnDebugger.LogMsg('CnWizardMgr Remove at ' + IntToStr(FWizardIndex));
{$ENDIF}
    WizardServices.RemoveWizard(FWizardIndex);
    FWizardIndex := InvalidIndex;
  end
  else
  begin
    FreeAndNil(CnWizardMgr);
{$IFDEF DEBUG}
    CnDebugger.LogMsg('Manually Free CnWizardMgr');
{$ENDIF}
  end;
end;

// 专家 DLL 初始化入口函数
function InitWizard(const BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc;
  var Terminate: TWizardTerminateProc): Boolean; stdcall;
var
  WizardServices: IOTAWizardServices;
  AWizard: IOTAWizard;
  Reg: Boolean;
begin
  if FindCmdLineSwitch(SCnNoServiceCnWizardsSwitch, ['/', '-'], True) then
  begin
    Reg := False;
{$IFDEF DEBUG}
    CnDebugger.LogMsg('Create but Do NOT Register CnWizards');
{$ENDIF}
  end
  else
    Reg := True;

{$IFDEF DEBUG}
  CnDebugger.StartTimeMark('CWS');  // CnWizards Start-Up Timing Start
  CnDebugger.LogMsg('Wizard Dll Entry');
{$ENDIF}

  Result := BorlandIDEServices <> nil;
  if Result then
  begin
    Assert(ToolsAPI.BorlandIDEServices = BorlandIDEServices);
    Terminate := FinalizeWizard;
    WizardServices := BorlandIDEServices as IOTAWizardServices;
    Assert(Assigned(WizardServices));

    CnWizardMgr := TCnWizardMgr.Create;
    if Reg and Supports(TObject(CnWizardMgr), IOTAWizard, AWizard) then
    begin
      // 只有命令行不要求不注册，且 CnWizardMgr 支持 IOTAWizard 接口，才注册
      FWizardIndex := WizardServices.AddWizard(AWizard);
      Result := (FWizardIndex >= 0);
{$IFDEF DEBUG}
      CnDebugger.LogBoolean(Result, 'CnWizardMgr Registered at ' + IntToStr(FWizardIndex));
{$ENDIF}
    end
    else
    begin
      Result := True;
{$IFDEF DEBUG}
      CnDebugger.LogBoolean(Result, 'CnWizardMgr Created');
{$ENDIF}
    end;
  end;
end;

initialization
{$IFDEF DEBUG}
  if CnDebugger.ExceptTracking then
    CnDebugger.LogMsg('DllEntry initialization. CaptureStack Enabled')
  else
    CnDebugger.LogMsg('DllEntry initialization. CaptureStack Disabled')
{$ENDIF}

end.

