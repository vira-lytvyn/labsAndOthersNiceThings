#include <stdio.h>
#include <string.h>
#include <windows.h>
int main(void)
{
DWORD bytes_read;
DWORD bytes_written;
char buf[100];
char f_buf[10000];
HANDLE ph = CreateNamedPipe("\\\\.\\pipe\\pipeksi", PIPE_ACCESS_DUPLEX, PIPE_WAIT, 1, 0, 0, NMPWAIT_WAIT_FOREVER, NULL);
ConnectNamedPipe(ph, NULL);
while (1)
{
ReadFile(ph, buf, sizeof(buf), &bytes_read, 0);
if (bytes_read > 0)
{
buf[bytes_read] = '\0';
if (strcmp(buf, "exit") == 0)
{
break;
}
HANDLE f = CreateFile(buf, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
if (f != INVALID_HANDLE_VALUE)
{
ReadFile(f, f_buf, sizeof(f_buf), &bytes_read, 0);
f_buf[bytes_read] = '\0';
WriteFile(ph, f_buf, sizeof(f_buf), &bytes_written, 0);
}
else
{
WriteFile(ph, " Error opening file ", sizeof("Error opening file"), &bytes_written, 0);
}
}
}
DisconnectNamedPipe(ph);
CloseHandle(ph);
return 0;
}
