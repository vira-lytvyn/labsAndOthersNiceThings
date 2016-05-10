#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <process.h>
HANDLE mutex;
HANDLE bdc_ev;
int cond_exp;
void rcv_msg()
{
    WaitForSingleObject(mutex, INFINITE);
    while (cond_exp != 1) 
    {
        SignalObjectAndWait(mutex, bdc_ev, INFINITE, FALSE);
        WaitForSingleObject(mutex, INFINITE);
    };
    ReleaseMutex(mutex);       
}
void send_msg()
{
    WaitForSingleObject(mutex, INFINITE);
    cond_exp = 1;
    PulseEvent(bdc_ev);
    ReleaseMutex(mutex);
}
unsigned int WINAPI thr_1(void *par)
{
    printf("i-thread ¹1 is running...\n");  
    rcv_msg();
    printf("i-thread ¹1 was terminated :(\n");
    return 0;        
}
unsigned int WINAPI thr_2(void *par)
{
    printf("i-thread ¹2 is running...\n");  
    rcv_msg();
    printf("i-thread ¹2 was terminated :(\n");
    return 0;        
}
unsigned int WINAPI thr_3(void *par)
{
    printf("i-thread ¹3 is running...\n");  
    rcv_msg();
    printf("i-thread ¹3 was terminated :(\n");
    return 0;        
}
int main()
{
    unsigned id_t;
    int par = 0;
    cond_exp = 0;
    mutex = CreateMutex (0, FALSE, 0);
    bdc_ev = CreateEvent(0, TRUE, FALSE, 0);
    HANDLE th_1 = (HANDLE) _beginthreadex(NULL, 0, thr_1, (void *)par, 0, &id_t);
    HANDLE th_2 = (HANDLE) _beginthreadex(NULL, 0, thr_2, (void *)par, 0, &id_t);
    HANDLE th_3 = (HANDLE) _beginthreadex(NULL, 0, thr_3, (void *)par, 0, &id_t);    
    printf("i~main thread is running...\n");
    send_msg();
    WaitForSingleObject(th_1, INFINITE);
    WaitForSingleObject(th_2, INFINITE);    
    WaitForSingleObject(th_3, INFINITE);    
    CloseHandle(th_1);
    CloseHandle(th_2);
    CloseHandle(th_3);
    CloseHandle(mutex);
    printf("i~main thread was terminated :(:(:( \n");
    getch();
    return 0;    
}
