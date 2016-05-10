#include <stdio.h>
#include <string.h>
#include <windows.h>
int main(void)
{
DWORD bytes_read;
DWORD bytes_written;
char inputString[100];
char buf[10000];
while (WaitNamedPipe("\\\\.\\pipe\\pipeksi", NMPWAIT_WAIT_FOREVER) == 0);
HANDLE ph = CreateFile("\\\\.\\pipe\\pipeksi", (GENERIC_READ | GENERIC_WRITE), 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
while (1)
{
printf(">");
scanf("%s", &inputString);
WriteFile(ph, inputString, sizeof(inputString), &bytes_written, 0);
if (strcmp(inputString, "exit") == 0)
{
break;
}
ReadFile(ph, buf, sizeof(buf), &bytes_read, 0);
if (bytes_read > 0)
{
buf[bytes_read] = '\0';
printf("Отримано: \n%s\n", buf);
}
}
CloseHandle(ph);
return 0;
}
