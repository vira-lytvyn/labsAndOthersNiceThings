#include <stdio.h> 
#include <windows.h> 
int main(void) 
{ 
int val; 
HANDLE mh = CreateFileMapping (INVALID_HANDLE_VALUE, 0, PAGE_READWRITE, 0, sizeof(int), "temp"); 
int *fmap = (int*)MapViewOfFile (mh, FILE_MAP_WRITE, 0, 0, sizeof(int)); 
while(1) 
{ 
printf("Client: "); 
scanf("%d", &val); 
fmap[0] = val; 
if (val == 0) 
{ 
break; 
} 
} 
CloseHandle(mh); 
UnmapViewOfFile(fmap); 
return 0; 
} 
