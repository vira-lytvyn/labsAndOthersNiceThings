//---------------------------------------------------------------------------

#include <vcl.h>
#include <windows.h>
#pragma hdrstop
#pragma argsused
#include <DLLOCHKA.h>
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void* lpReserved)
{
	return 1;
}

float  Cel_Far ( float cel)
{
	float f = ((cel * 9) / 5) + 32;
	return f;
}
//---------------------------------------------------------------------------
