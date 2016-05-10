#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
int cond_exp = 0;
void send_msg()
{
  cond_exp = 1;
  pthread_cond_broadcast(&cond);
}

void rcv_msg()
{
  pthread_mutex_lock(&mutex);
  while (cond_exp != 1) pthread_cond_wait(&cond, &mutex);
  pthread_mutex_unlock(&mutex);
}
void *f_1(void *par)
{
  printf("i~thread #1 is running...\n");
  rcv_msg();
  printf("i~thread #1 was terminated :(\n");
  pthread_exit(0);
}
void *f_2(void *par){
  printf("i~thread #2 is running...\n");  
  rcv_msg();
  printf("i~thread #2 was terminated :(\n");
  pthread_exit(0);
}
void *f_3(void *par)
{
  printf("i~thread #3 is running...\n");  
  rcv_msg();
  printf("i~thread #3 was terminated :(\n");
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
  // Виконання головного потоку 
  printf("i-*-main thread is running...\n");
  pthread_mutex_lock(&mutex);
  send_msg();
  pthread_mutex_unlock(&mutex);
  void *status;// Приєднання потоків
  pthread_join(thr1, &status);
  pthread_join(thr2, &status);
  pthread_join(thr3, &status);
  printf("i-*-main thread was terminated!\n");
  return 0;
}