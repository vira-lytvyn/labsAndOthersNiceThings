#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
pthread_mutex_t mnt = PTHREAD_MUTEX_INITIALIZER;
int stack[100];
int stack_p = -1;
void push(int value)
{
pthread_mutex_lock(&mnt);
stack[++stack_p] = value;
printf("push %i\n", value);
pthread_mutex_unlock(&mnt);
}
int pop()
{
int value = 0;
pthread_mutex_lock(&mnt);
if (stack_p >= 0)
{
value = stack[stack_p--];
}
printf("pop %i\n", value);
pthread_mutex_unlock(&mnt);
return value;
}
void *f_1(void *par)
{
push(1);
push(2);
pop();
push(3);
push(4);
pthread_exit(0);
}
void *f_2(void *par)
{
pop();
push(5);
usleep(10);
pop();
pop();
push(9);
pthread_exit(0);
}
void *f_3(void *par)
{
pop();
push(11);
pop();
pop();
pop();
pthread_exit(0);
}
int main()
{// Створення нових потоків
pthread_t thr1;
pthread_t thr2;
pthread_t thr3;
pthread_create(&thr1, NULL, f_1, (void *)0);
pthread_create(&thr2, NULL, f_2, (void *)0);
pthread_create(&thr3, NULL, f_3, (void *)0);
void *st;// Приєднання потоків
pthread_join(thr1, &st);
pthread_join(thr2, &st);
pthread_join(thr3, &st);
return 0;
}