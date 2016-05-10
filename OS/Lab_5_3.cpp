#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
pthread_rwlock_t rwlock = PTHREAD_RWLOCK_INITIALIZER;
int t = 444;
void *f_1(void *par)
{
  usleep(300);
  pthread_rwlock_rdlock(&rwlock);
  printf("start_read_1\n");
  printf("%i\n", t);
  usleep(1500);
  printf("stop_read_1\n");
  pthread_rwlock_unlock(&rwlock);
  pthread_exit(0);
}
void *f_2(void *par)
{
  pthread_rwlock_wrlock(&rwlock);
  printf("start_write\n");
  printf("->111\n");
  t = 111;
  usleep(4000);
  printf("stop_write\n");
  pthread_rwlock_unlock(&rwlock);
  pthread_exit(0);
}
void *f_3(void *par)
{
  usleep(300);
  pthread_rwlock_rdlock(&rwlock);
  printf("start_read_2\n");
  printf("%i\n", t);
  usleep(900);
  printf("stop_read_2\n");
  pthread_rwlock_unlock(&rwlock);
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