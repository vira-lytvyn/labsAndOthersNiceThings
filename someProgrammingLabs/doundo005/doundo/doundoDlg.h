// doundoDlg.h : header file
//

#if !defined(AFX_DOUNDODLG_H__D0D8BA86_DE3F_11D8_BED9_E4DE322CF751__INCLUDED_)
#define AFX_DOUNDODLG_H__D0D8BA86_DE3F_11D8_BED9_E4DE322CF751__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


/////////////////////////////////////////////////////////////////////////////
// CDoundoDlg dialog

#include "DoUndo2_files\DoUndo2.h"

struct sMyItem:public sDoUndo2_item
{
	//данные
	CString m_Text;
	DWORD m_dwdPos;

	//конструктор
	sMyItem()
	{
		m_Text="";
		m_dwdPos=0;
	}


	//------------------------------------------------
	virtual void sDU2i_CopyToThisFrom(const sDoUndo2_item* pCopyFromITEM_in)
	{
		*this=*(sMyItem*)pCopyFromITEM_in;
	}

	virtual sDoUndo2_item* sDU2i_NewObject() const
	{
		return new sMyItem;
	}

	virtual void sDU2i_DeleteThis() const
	{
		delete this;
	}

};

class CDoundoDlg : public CDialog
{

	CString m_CurrentTextState;
	DWORD m_dwdCurrentCursorPos;

// Construction
public:
	void RefreshControls();
	bool m_bThereWereChanges;
	CDoUndo2 m_DoUndo;

	CDoundoDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CDoundoDlg)
	enum { IDD = IDD_DOUNDO_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDoundoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CDoundoDlg)
	virtual BOOL OnInitDialog();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnbnDO();
	afx_msg void OnbnUNDO();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnChangeedTEXT();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DOUNDODLG_H__D0D8BA86_DE3F_11D8_BED9_E4DE322CF751__INCLUDED_)
