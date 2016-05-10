//---------------------------------------------------------------------------

#include <vcl.h>
#include <windows.h>
#include <math>
#include "APPROX.h"
#pragma hdrstop
#pragma argsused

//Цей DLL проект написав Горін Олег Ігорович, групи ФЕІ-12
// Вміст проекту:
//  -процедура Гауса для знаходження коренів поліноміальних кое
//  -процедура Апрокимації для зведення до матричного представлення,
//      яке потім шукається за допомогою процедури Гауса, і табулювання
//      апроксимаційного полінома.
// Також в проекті брали участь допоміжні функція і процедура =) :
//  -float Sum(int N, float y[1000]) -обчислення сум для побудови
//                                          матриці a та вектора b;
//  -void Step (int N,float y[1000], float x[1000]) -обчислення
//                                      степенів компонент масиву XS;

int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void* lpReserved)
{

    return 1;
}
float Sum(int N, float y[1000])
{
    float s=0;
    for (int i=0;i<N;++i)
        s=s+y[i];
    return s;
}
void gaus_slar(float a[10][10], float b[10], int m, float x[10])
{
    int n=m,k,i,j;
    float r;

    bool z=True;
    if (n>0)
    {
        for (i=0;i<=n-1;++i)
        {
            k=i;
            r=fabs(a[i][i]);
            for (j=i+1;j<=n-1;++j)
                if (fabs(a[j][i])>=r)
                {
                    k=j;
                    r=fabs(a[j][i]);
                 };
            if (r<=1e-7)
            {
                z=False;
                ShowMessage("Помилка! \n Гаус: №1");
            };
            if ((!(k==i))&&(z==True))
            {
                r=b[k];
                b[k]=b[i];
                b[i]=r;
                for (j=i;j<=n-1;++j)
                {
                    r=a[k][j];
                    a[k][j]=a[i][j];
                    a[i][j]=r;
                };
            };
            if (z==True)
            {
                r=a[i][i];
                b[i]=b[i]/r;
                for (j=0;j<=n-1;++j)
                    a[i][j]=a[i][j]/r;
                for (k=i+1;k<=n-1;++k)
                {
                    r=a[k][i];
                    b[k]=b[k]-r*b[i];
                    a[k][i]=0;
                    for (j=i+1;j<=n-1;++j)
                        a[k][j]=a[k][j]-r*a[i][j];
                };
            };
        };
        if (fabs(a[n-1][n-1])<=1e-7)
        {
            z=False;
            ShowMessage("Помилка! \n Гаус: №2");
        };
        if (z==True)
        {
            x[n-1]=b[n-1]/a[n-1][n-1];
            for (i=n-2;i>=0;--i)
            {
                r=b[i];
                for (j=i;j<n;++j)
                    r=r-a[i][j]*x[j];
                x[i]=r;
            };
        };
    }
    else
    {
        if (fabs(a[1][1])<1e-7)
        {
            z=False;
            ShowMessage("Помилка! \n Гаус: №3");
        }
        else
            x[1]=b[1]/a[1][1];
    };
    if (!z)
    {
        for (i=0;i<=n;++i)
            x[i]=0;
    }
}
void Step (int N,float y[1000], float x[1000])
{
    for (int i=0;i<N;++i)
        x[i]=x[i]*y[i];
}

void approximation(float Xe [10], float Ye[10],
 int Ne, int M, float x[10], float Xgr[1000],
 float Ygr[1000], int Ngr,float al,float bl)
{
    bool test=True;
    float a[10][10];
    float b[10];
    int MP1;
    int L;
    int i,j;

    for (i=0;i<10;++i)
        for (j=0;j<10;++j)
            a[i][j]=0;
    for (i=0;i<10;++i)
        b[i]=0;
    for (i=0;i<10;++i)
        x[i]=0;
//////////////////////////////////////////////////
//знаходження матриці а та вектора b;
//////////////////////////////////////////////////
    try {
        MP1=M+1;
        float XS[1000];
        for (i=0;i<Ne;++i)
        {
	        XS[i]=1;
        };
	    for (j=0;j<MP1;++j)
	    {
	        a[0][j]=Sum(Ne,XS);
	        Step(Ne,Xe,XS);
        };
        for (i=1;i<MP1;++i)
        {
	        a[i][M]=Sum(Ne,XS);
	        Step(Ne,Xe,XS);
        };

        for (j=1;j<M;++j)
        {
	        L=1;
	        for (i=j-1;i>=0;--i)
	        {
		        a[L][i]=a[0][j];
		        L=L+1;
	        };
        };
        for (i=0;i<M;++i)
        {
	        L=M-1;
	        for (j=i+1;j<MP1;++j)
	        {
		        a[j][L]=a[i][M];
		        L=L-1;
	        };
        };
        for (i=0;i<Ne;++i)
	        XS[i]=Ye[i];
        for (j=0;j<MP1;++j)
        {
	        b[j]=Sum(Ne,XS);
	        Step(Ne,Xe,XS);
        };
    }
    catch ( ... ) {
        ShowMessage("Помилка! \n Апрокимація: №1");
        test=False;
    }
    if (test) {
        try {
    /*for (i=0;i<10;++i)
        for (j=0;j<10;++j)
         if (!a[i][j]==0) ShowMessage(FloatToStr(a[i][j])+" "+FloatToStr(i)+" "+FloatToStr(j));
    for (j=0;j<10;++j)
         if (!b[j]==0) ShowMessage(FloatToStr(b[j])+" "+FloatToStr(j));*/
         //тест матриці
//////////////////////////////////////////////////
            gaus_slar(a,b,MP1,x);
//////////////////////////////////////////////////
        //табулювання полінома
//////////////////////////////////////////////////
            float h;
            h=fabs(bl-al)/Ngr;
            float r,g;
            r=0;
            g=al;
            float x1[1000];
            for (i=0;i<Ngr;++i)
            {
                r=x[0];
                x1[0]=1;
                for (j=1;j<=M;++j)
                {
                    x1[j]=x1[j-1]*g;
                    r=r+x[j]*x1[j];
                };
                Xgr[i]=g;
                Ygr[i]=r;
                g=g+h;
            };
        } catch (...)
        {
            ShowMessage("Помилка! \n Апрокимація: №2");
        };
    };
}
//---------------------------------------------------------------------------
