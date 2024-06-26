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
{            网站地址：https://www.cnpack.org                                  }
{            电子邮件：master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnFrmAICoderOption;
{ |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家包
* 单元名称：AI 辅助编码选项 Frame 单元
* 单元作者：CnPack 开发组
* 备    注：
* 开发平台：PWin7 + Delphi 5
* 兼容测试：PWin7/10/11 + Delphi + C++Builder
* 本 地 化：该窗体中的字符串暂不支持本地化处理方式
* 修改记录：2024.05.09 V1.0
*               创建单元
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CnCommon, CnWizMultiLangFrame;

type
  TCnAICoderOptionFrame = class(TCnTranslateFrame)
    lblURL: TLabel;
    lblAPIKey: TLabel;
    edtURL: TEdit;
    edtAPIKey: TEdit;
    lblModel: TLabel;
    lblApply: TLabel;
    cbbModel: TComboBox;
    procedure lblApplyClick(Sender: TObject);
  private
    FWebAddr: string;
  public
    constructor Create(AOwner: TComponent); override;
    property WebAddr: string read FWebAddr write FWebAddr;
  end;

implementation

{$R *.DFM}

constructor TCnAICoderOptionFrame.Create(AOwner: TComponent);
begin
  inherited;
  lblApply.Font.Color := clBlue;
  lblApply.Font.Style := [fsUnderline];
end;

procedure TCnAICoderOptionFrame.lblApplyClick(Sender: TObject);
begin
  if FWebAddr <> '' then
    OpenUrl(FWebAddr);
end;

end.
