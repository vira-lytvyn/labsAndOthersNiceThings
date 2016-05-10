#include <stdio.h> 
#include <windows.h> 
int main(void) 
{ 
HANDLE mh = OpenFileMapping(FILE_MAP_WRITE, 0, "temp"); 
int *fmap = (int*)MapViewOfFile(mh, FILE_MAP_WRITE, 0, 0, sizeof(int)); 
int val = fmap[0]; 
while(1) 
{ 
if (fmap[0] != val) 
{ 
val = fmap[0]; 
if (val == 0) 
{ 
break; 
} 
printf("Client: %d\n", val); 
} 
Sleep(100); 
} 
CloseHandle(mh); 
UnmapViewOfFile(fmap); 
return 0; 
}
