#include <stdio.h>
#include <stdlib.h>
#include <sys/wait>
#include <unistd.h>
#include <signal.h>
#include <string.h>

void clear_z (int sign)
{
  waitpid(-1, NULL, 0);
}

void null_handler(int sign)
{
  waitpid(-1, NULL, 0);
}

int main()
{  
  pid_t pid;
  char * pch;
  char com[256];
  char *argv[10];
  int argc;
  int is_async;
  
  struct sigaction act = {0};
  act.sa_handler = clear_z;
  sigaction(SIGINT, &act, 0);
  
  while (1)
  {
    printf(">");
    gets(com);
    
    if (com [strlen(com) - 1] == '&')
    {
      is_async = 1;
      com [strlen(com) - 1] = '\0';
    }
    else
    {
      is_async = 0;
    }
    
    argc=0;
    pch = strtok(com, " ");
    while (pch != NULL)
    {
      argv[argc++] = pch;
      pch = strtok(NULL, " ");
    }
    
    if (strcmp(com, "exit") == 0) exit(0);
    
    if (is_async == 1)
    {
      struct sigaction action = {0};
      action.sa_handler = clear_z;
      sigaction(SIGCHLD, &action, 0);
    }
    
    if ((pid = fork()) == -1) exit(-1);
    if (pid == 0)
    {
      if (execvp(argv[0], argv) == -1) exit(-1);
    }
    else
    {     
      if (is_async == 0)
      {
	int *status;
	waitpid(pid, status, 0);
      }
      
      struct sigaction act = {0};
      act.sa_handler = clear_z;
      sigaction(SIGINT, &act, 0);
    }
  }
  
  return 0;
} 
