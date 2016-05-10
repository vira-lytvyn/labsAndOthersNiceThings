// doundoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "doundo.h"
#include "doundoDlg.h"
//#include "StackDoUndo.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif





/////////////////////////////////////////////////////////////////////////////
// CDoundoDlg dialog

void CDoundoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDoundoDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDoundoDlg, CDialog)
	//{{AFX_MSG_MAP(CDoundoDlg)
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_bnDO, OnbnDO)
	ON_BN_CLICKED(IDC_bnUNDO, OnbnUNDO)
	ON_WM_TIMER()
	ON_EN_CHANGE(IDC_edTEXT, OnChangeedTEXT)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

HCURSOR CDoundoDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

/////////////////////////////////////////////////////////////////////////////
// CDoundoDlg message handlers
CDoundoDlg::CDoundoDlg(CWnd* pParent)	: CDialog(CDoundoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDoundoDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT

	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

	m_CurrentTextState="";
	m_dwdCurrentCursorPos=0;

	//глубина наших стеков
	m_DoUndo.SetStacksSizez(100,100);

}

BOOL CDoundoDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon



	//помним текущее состояние среды (окна с текстом) в переменных ,
	//так как "перехватить действие юзера" просто так не получится. Легче помнить,
	//что было до введения новых символов
	CEdit* pE=(CEdit*)GetDlgItem(IDC_edTEXT);
	if(pE)
	{
		pE->GetWindowText(m_CurrentTextState);
		m_dwdCurrentCursorPos=pE->GetSel();
	}

	//флаг для таймера - вызывать ли RefreshControls()
	m_bThereWereChanges=true;//"были изменения"

	SetTimer(1,200,0);//таймер обновления контролов

	return TRUE;
}

//обновление состояний контролов 
void CDoundoDlg::RefreshControls()
{
	//управляем состоянием кнопок DO/UNDO и надписями на них
	CString txt;

	GetDlgItem(IDC_bnDO)->EnableWindow(m_DoUndo.GetDoFilledNum()==0 ? 0 : 1);
	GetDlgItem(IDC_bnUNDO)->EnableWindow(m_DoUndo.GetUndoFilledNum()==0 ? 0 : 1);

	txt.Format("<<\r\n(%d)",m_DoUndo.GetUndoFilledNum());
	GetDlgItem(IDC_bnUNDO)->SetWindowText(txt);

	txt.Format(">>\r\n(%d)",m_DoUndo.GetDoFilledNum());
	GetDlgItem(IDC_bnDO)->SetWindowText(txt);
}

//таймер
void CDoundoDlg::OnTimer(UINT nIDEvent) 
{
	//по флагу m_bThereWereChanges смотрим, надо ли обновить контролы
	if(nIDEvent==1 && m_bThereWereChanges)
	{
		m_bThereWereChanges=false;
		RefreshControls();
	}
	
	CDialog::OnTimer(nIDEvent);
}

//что то поменяли в текстовом окне
void CDoundoDlg::OnChangeedTEXT() 
{
	//сохраняем текущее состояние в стек
	//(оно сейчас в переменных m_CurrentTextState, m_dwdCurrentCursorPos)
	sMyItem item;
	item.m_Text=m_CurrentTextState;
	item.m_dwdPos=m_dwdCurrentCursorPos;
	m_DoUndo.SaveItemBeforeNewAction(&item);

	//новое текущее состояние запоминаем в переменные (это состояние сейчас в текстовом окне)
	CEdit* pE=(CEdit*)GetDlgItem(IDC_edTEXT);
	if(pE)
	{
		pE->GetWindowText(m_CurrentTextState);
		m_dwdCurrentCursorPos=pE->GetSel();
	}

	m_bThereWereChanges=true;
}

void CDoundoDlg::OnbnDO() 
{
	CEdit* pE=(CEdit*)GetDlgItem(IDC_edTEXT);
	if(pE)
	{
		//на всякий случай освежаем текущее состояние (текст из окна)
		pE->GetWindowText(m_CurrentTextState);
		m_dwdCurrentCursorPos=pE->GetSel();

		//восстанавливаем из DO
		sMyItem item;
		item.m_Text=m_CurrentTextState;
		item.m_dwdPos=m_dwdCurrentCursorPos;

		m_DoUndo.OperationDo(&item);

		m_CurrentTextState=item.m_Text;
		m_dwdCurrentCursorPos=item.m_dwdPos;
		pE->SetFocus();
		pE->SetWindowText(m_CurrentTextState);
		pE->SetSel(m_dwdCurrentCursorPos);
	}

	m_bThereWereChanges=true;
	RefreshControls();

}

void CDoundoDlg::OnbnUNDO() 
{
	CEdit* pE=(CEdit*)GetDlgItem(IDC_edTEXT);
	if(pE)
	{
		//на всякий случай освежаем текущее состояние (текст из окна)
		pE->GetWindowText(m_CurrentTextState);
		m_dwdCurrentCursorPos=pE->GetSel();

		//восстанавливаем из UNDO
		sMyItem item;
		item.m_Text=m_CurrentTextState;
		item.m_dwdPos=m_dwdCurrentCursorPos;

		m_DoUndo.OperationUndo(&item);

		m_CurrentTextState=item.m_Text;
		m_dwdCurrentCursorPos=item.m_dwdPos;
		pE->SetFocus();
		pE->SetWindowText(m_CurrentTextState);
		pE->SetSel(m_dwdCurrentCursorPos);
	}

	m_bThereWereChanges=true;
	RefreshControls();
}
