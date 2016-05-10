 #ifndef _DLLOCHKA_H
 #define _DLLOCHKA_H
 #ifdef __DLL__
 # define  DLL_EI __declspec(dllexport)
 #else
 # define  DLL_EI __declspec(dllimport)
 #endif
 extern "C" float DLL_EI Cel_Far ( float c);
 #endif
