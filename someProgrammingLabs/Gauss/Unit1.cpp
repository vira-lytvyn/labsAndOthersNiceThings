//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <math.h>

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
typedef  Matrix [5][5];
typedef  Vector [5];
Vector X;
int n;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void Gauss (Matrix A, Vector B)
{
        int i, j, k ;
        float R ;
        float eps = 0.000001;
        for( i = 0; i <= n - 1 ; i++)
   {
        k = i;
        R = fabs (A[i][i]);
        for (j = i; j <= n; j++)
        {
                if (fabs(A[j][i]) > R)
                {
                        k = j;
                        R = fabs ( A [j][i]);
                }
        }
        if ( R < eps )
        {
                ShowMessage("система вироджена");
                //Application->MessageBoxA("Message","Systema vyrodgena",0);
        }
        else
        if ( k != i)
        {
                R = B[k];
                B[k] = B[i];
                B[i] = R;
                for (j = i; j <= n; j++)
                {
                        R = A[k][j];
                        A[k][j] = A[i][j];
                        A[i][j] = R;
                }
        }
        R = A[i][i];
        B[i] = B[i] / R;
        for (j = 0; j <= n; j++)
                A[i][j] = A[i][j] / R;
        for (k = i + 1; k <= n; k++)
        {
                R = A[k][i];
			B[k] = B[k] - R * B[i];
			A[k][i] = 0;
			for (j = i+1; j <= n; j++)
				A[k][j] = A[k][j] - R * A[i][j];
        }
   }
   if (fabs(A[n][n]) < eps)
   {
        ShowMessage("система вироджена");
   }
   else
        X[n] = B[n] / A[n][n];
   for (i = n - 1; i > -1; i--)
   {
        R = B[i];
        for (j = i+1; j <= n; j++)
                R = R - A[i][j] * X[j];
        X[i] = R;
   }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{

        Matrix A;
        Vector B;
        int i, j ;
        for ( i = 0; i <= n; i++)
        {
	        for ( j = 0; j <= n; j++)
                {
                        A[i][j] = StrToFloat(StringGrid1->Cells[j][i]);
                }
                B[i] = StrToFloat(StringGrid2->Cells[0][i]);
        }
        Gauss (A,B);
        for ( i = 0; i <= n; i++)
        {
                StringGrid3->Cells[0][i] = FloatToStr(X[i]);
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn2Click(TObject *Sender)
{
        int i, j ;
        Edit1->Text="";
        for ( i = 0; i <= n; i++)
        {
	        for ( j = 0; j <= n; j++)
                {
                StringGrid1->Cells[j][i] = "";
                }
                StringGrid2->Cells[0][i] = "";
                StringGrid3->Cells[0][i] = "";
        }

}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit1Exit(TObject *Sender)
{
       n = StrToFloat(Edit1->Text) - 1;
        StringGrid1->RowCount=n + 1;
        StringGrid1->ColCount=n + 1;
        StringGrid2->RowCount=n + 1;
        StringGrid2->ColCount=1;
        StringGrid3->RowCount=n + 1;
        StringGrid3->ColCount=1;
}
//---------------------------------------------------------------------------

