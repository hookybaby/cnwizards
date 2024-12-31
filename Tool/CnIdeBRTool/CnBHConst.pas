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

unit CnBHConst;
{* |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家辅助备份/恢复工具
* 单元名称：CnWizards 辅助备份/恢复工具字符串常量定义单元
* 单元作者：ccRun(老妖)
* 备    注：CnWizards 专家辅助备份/恢复工具字符串常量定义单元
* 开发平台：PWinXP + Delphi 5.01
* 兼容测试：PWin9X/2000/XP + Delphi 5/6/7 + C++Builder 5/6
* 本 地 化：该单元中的字符串均符合本地化处理方式
* 修改记录：2006.08.23 V1.0
*               LiuXiao 移植此单元
================================================================================
|</PRE>}

interface

type
  // AppBuilder 类型
  TAbiType = (atBCB5, atBCB6, atDelphi5, atDelphi6, atDelphi7, atDelphi8,
    atBDS2005, atBDS2006, atDelphi2007, atDelphi2009, atDelphi2010, atDelphiXE,
    atDelphiXE2, atDelphiXE3, atDelphiXE4, atDelphiXE5, atDelphiXE6, atDelphiXE7,
    atDelphiXE8, atDelphi10S, atDelphi101B, atDelphi102T, atDelphi103R, atDelphi104S,
    atDelphi110A, atDelphi120A);
  TAbiTypes = set of TAbiType; // at := [BCB5, BCB6];

var
  SCnAppName: array [0..Integer(High(TAbiType))] of string =
  (
      'C++Builder 5.0 ', 'C++Builder 6.0 ', 'Delphi 5.0 ', 'Delphi 6.0 ',
      'Delphi 7.0 ', 'Delphi 8.0 ', 'BDS 2005 ', 'BDS 2006 ', 'RAD Studio 2007',
      'RAD Studio 2009', 'RAD Studio 2010', 'RAD Studio XE', 'RAD Studio XE2',
      'RAD Studio XE3', 'RAD Studio XE4', 'RAD Studio XE5', 'RAD Studio XE6',
      'RAD Studio XE7', 'RAD Studio XE8', 'RAD Studio 10 Seattle',
      'RAD Studio 10.1 Berlin', 'RAD Studio 10.2 Tokyo', 'RAD Studio 10.3 Rio',
      'RAD Studio 10.4 Sydney', 'RAD Studio 11 Alexandria', 'RAD Studio 12 Athens'
  );

  SCnAppAbName: array[0..Integer(High(TAbiType))] of string =
  (
      'BCB5', 'BCB6', 'Delphi5', 'Delphi6', 'Delphi7',
      'Delphi8', 'BDS2005', 'BDS2006', 'RADStudio2007',
      'RADStudio2009', 'RADStudio2010', 'RADStudioXE',
      'RADStudioXE2', 'RADStudioXE3', 'RADStudioXE4',
      'RADStudioXE5', 'RADStudioXE6', 'RADStudioXE7',
      'RADStudioXE8', 'RADStudio10Seattle', 'RADStudio101Berlin',
      'RADStudio102Tokyo', 'RADStudio103Rio', 'RADStudio104Sydney',
      'RADStudio110Alexandria', 'RADStudio120Athens'
  );

  SCnRegPath: array[0..Integer(High(TAbiType))] of string =
  (
      'C++Builder\5.0', 'C++Builder\6.0', 'Delphi\5.0', 'Delphi\6.0',
      'Delphi\7.0', 'BDS\2.0', 'BDS\3.0', 'BDS\4.0', 'BDS\5.0', 'BDS\6.0',
      'BDS\7.0', 'BDS\8.0', 'BDS\9.0', 'BDS\10.0', 'BDS\11.0', 'BDS\12.0',
      'BDS\14.0', 'BDS\15.0', 'BDS\16.0', 'BDS\17.0', 'BDS\18.0', 'BDS\19.0',
      'BDS\20.0', 'BDS\21.0', 'BDS\22.0', 'BDS\23.0'
  );

  SCnOpResult: array[0..1] of string =
  (
      ' Failed!', ' Succeed.'
  );

  SCnAbiOptions: array[0..3] of string =
  (
      'Code Templates',
      'Object Repository',
      'IDE Configuration in Registry',
      'Menu Templates'
  );
  
  SCnObjReps: array[0..9] of string =
  (
      'Type', 'Name', 'Page', 'Icon', 'Description', 'Author',
      'DefaultMainForm', 'DefaultNewForm', 'Ancestor', 'Designer'
  );

  SCnFileInvalid: string = 'Invalid Backup File!' + #13#10 +
    'Please Use the File Generated by this Tool.' + #13#10 +
    'Any Bugs or Suggestions, Please Contact us: master@cnpack.org';

  SCnBackup: string = ' --> Backup';
  SCnRestore: string = ' --> Restore';
  SCnBackuping: string = 'Processing Backup ';
  SCnAnalyzing: string = 'Analysing ';
  SCnRestoring: string = 'Processing Restore ';
  SCnCreating: string = 'Creating ';
  SCnNotFound: string = 'Can NOT Find ';
  SCnObjRepConfig: string = 'Object Repository Config';
  SCnObjRepUnit: string = 'Object Repository Units';
  SCnPleaseWait: string = ', Please Wait...';
  SCnUnkownName: string = 'Unknown Name!';
  SCnBakFile: string = 'Backup File';
  SCnCreate: string = ' Creating';
  SCnAnalyseSuccess: string = ' --> Analysis Complete.';
  SCnBackupSuccess: string = ' --> Backup Complete.';
  SCnThanksForRestore: string = 'Restore Complete!';
  SCnThanksForBackup: string = 'Please Keep this File Carefully.';
  SCnPleaseCheckFile: string = 'Please Check whether the File is in Use or Readonly.';
  SCnAppTitle: string = 'CnWizards IDE Config Backup/Restore Tool';
  SCnAppVer: string = ' 1.0';
  SCnBugReportToMe: string = 'Any Bugs or Suggestions, Please Contact us: master@cnpack.org';
  SCnIDEName: string = 'IDE Name: ';
  SCnInstallDir: string = 'Original Installed Directory: ';
  SCnBackupContent: string = 'Backup Item(s): ';
  SCnIDENotInstalled: string = ' NOT Installed';

  SCnErrorSelectApp: string = 'Please Select One IDE.';
  SCnErrorSelectBackup: string = 'Please Select Item(s) to Backup.';
  SCnErrorFileName: string = 'Please Enter the File Name.';
  SCnErrorSelectFile: string = 'Please Select a File First.';
  SCnErrorFileNotExist: string = 'Backup File NOT Found, Please Select Again.';
  SCnErrorNoIDE: string = 'Error. NO Such IDE Installed.';
  SCnErrorSelectRestore: string = 'Please Select Item(s) to Restore.';
  SCnErrorIDERunningFmt: string = '%s is Running.' + #13#10 + 'Please Close it.';
  SCnNotInstalled: string = 'Not Installed';

  SCnQuitAsk: string = 'Sure To Exit?';
  SCnQuitAskCaption: string = 'Information';
  SCnErrorCaption: string = 'Error';
  SCnIDERunning: string = 'IDE is Running, Please Exit IDE and Run Me again!';
  SCnCleaned: string = 'IDE History Cleanned Successfully!';
  SCnHelpOpenError: string = 'Help File Open Error!';

  SCnAboutCaption: string = 'About';
  SCnIDEAbout: string = 'IDE Config Backup/Restore Tool' + #13#10#13#10 +
    'Author:' + #13#10 +
    'ccrun (info@ccrun.com)' + #13#10 +
    'LiuXiao (master@cnpack.org)' + #13#10#13#10 +
    'Copyright 2001-2025 CnPack Team';

implementation

end.
