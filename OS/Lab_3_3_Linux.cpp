#include <stdio.h>
#include <windows.h>
#include <string.h>
#include <conio.h>

int main()
{
 	char *line;
BOOL isAsync;
 	while (true)
{
  		printf(">");
  		gets(line);
  		if (strcmp(line, "exit") == 0) break;
  		if (line[strlen(line) - 1] == '&')
  		{
   			line[strlen(line) - 1] = '\0';
   			isAsync = TRUE;
  		}
  		else
  		{
   			isAsync = FALSE;
  		}
  		STARTUPINFO si = { sizeof(si) };
  		si.lpTitle = "Child process ---made by ksi---";
  		PROCESS_INFORMATION pi;
  		if (CreateProcess(NULL, line, NULL, NULL, TRUE, CREATE_NEW_CONSOLE, NULL, NULL, &si, &pi))
  		{
   			CloseHandle(pi.hThread);
   			if (!isAsync)
   			{
    				DWORD exitCode;
    				if (WaitForSingleObject(pi.hProcess, INFINITE) != WAIT_FAILED)
    				{
     					GetExitCodeProcess(pi.hProcess, &exitCode);
    				}
   			}
   			CloseHandle(pi.hProcess);
  		}
 	}
 	return 0;
}

