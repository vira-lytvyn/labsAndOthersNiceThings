#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <process.h>
HANDLE mutex;
int stack[100];
int stack_p = -1;
void push(int value)
{
WaitForSingleObject(mutex, INFINITE);
stack[++stack_p] = value;
printf("push %i\n", value);
ReleaseMutex(mutex);
}
int pop()
{
int value = -1;
WaitForSingleObject(mutex, INFINITE);
if (stack_p >= 0)
{
value = stack[stack_p--];
}
printf("pop %i\n", value);
ReleaseMutex(mutex);
return value;
}
unsigned int WINAPI thr1(void *par)
{
push(1);
push(2);
pop();
push(3);
push(4);
return 0; 
}
unsigned int WINAPI thr2(void *par)
{
pop();
push(5);
sleep(1);
pop();
pop();
push(9);
return 0; 
}
unsigned int WINAPI thr3(void *par)
{
pop();
push(11);
pop();
pop();
pop();
return 0; 
}
int main()
{
unsigned id_t;
int par = 0;
mutex = CreateMutex (0, FALSE, 0);
HANDLE th_1 = (HANDLE) _beginthreadex(NULL, 0, thr1, (void *)par, 0, &id_t);
HANDLE th_2 = (HANDLE) _beginthreadex(NULL, 0, thr2, (void *)par, 0, &id_t);
HANDLE th_3 = (HANDLE) _beginthreadex(NULL, 0, thr3, (void *)par, 0, &id_t); 
WaitForSingleObject(th_1, INFINITE);
WaitForSingleObject(th_2, INFINITE); 
WaitForSingleObject(th_3, INFINITE); 
CloseHandle(th_1);
CloseHandle(th_2);
CloseHandle(th_3);
CloseHandle(mutex);
getch();
return 0; 
}
