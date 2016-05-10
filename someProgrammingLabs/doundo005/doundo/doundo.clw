; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CDoundoDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "doundo.h"

ClassCount=3
Class1=CDoundoApp
Class2=CDoundoDlg
Class3=CAboutDlg

ResourceCount=2
Resource1=IDR_MAINFRAME
Resource2=IDD_DOUNDO_DIALOG

[CLS:CDoundoApp]
Type=0
HeaderFile=doundo.h
ImplementationFile=doundo.cpp
Filter=N

[CLS:CDoundoDlg]
Type=0
HeaderFile=doundoDlg.h
ImplementationFile=doundoDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=IDC_edTEXT

[CLS:CAboutDlg]
Type=0
HeaderFile=doundoDlg.h
ImplementationFile=doundoDlg.cpp
Filter=D

[DLG:IDD_DOUNDO_DIALOG]
Type=1
Class=CDoundoDlg
ControlCount=3
Control1=IDC_bnUNDO,button,1476472576
Control2=IDC_bnDO,button,1476472576
Control3=IDC_edTEXT,edit,1350635524

