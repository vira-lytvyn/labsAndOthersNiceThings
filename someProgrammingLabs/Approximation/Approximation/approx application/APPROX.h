#ifndef _APPROX_H
#define _APPROX_H
#ifdef __DLL__
# define DLL_EI __declspec(dllexport)
#else
# define DLL_EI __declspec(dllimport)
#endif
////////////////////////////////////////////////////////////
//оголошення процедури approximation для зовнішнього виклику
////////////////////////////////////////////////////////////
extern "C" void DLL_EI approximation(float Xe [10], float Ye[10],
 int Ne, int M, float x[10], float Xgr[1000],
 float Ygr[1000], int Ngr,float al,float bl);
#endif
////////////////////////////////////////////////////////////
//виконав Горін Олег Ігорович, групи ФЕІ-12
////////////////////////////////////////////////////////////