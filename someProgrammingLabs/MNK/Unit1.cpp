//---------------------------------------------------------------------------

#include <vcl.h>
#include <math.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
int n;
float *X;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
  void Gauss (float *A[], float B[], int n)
{
		X = new float[n];
        int i, j, k ;
        float R ;
        float eps = 0.0000001;
        for( i = 0; i < n; i++)
   {
        k = i;
		R =   fabs (A[i][i]);
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
        for (j = 0; j<=n; j++)
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
        for (j = i + 1; j <= n; j++)
                R = R - A[i][j] * X[j];
        X[i] = R;
   }
}
//---------------------------------------------------------------------------
