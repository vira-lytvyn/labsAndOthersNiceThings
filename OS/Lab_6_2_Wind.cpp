#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
int main(void)
{
int fr, fw, f;
int bytes_read, f_bytes_read;
char read_buf[10000], f_read_buf[10000];
mkfifo("fifo_server", 0644);
while (1)
{
fr = open("fifo_server", O_RDONLY);
bytes_read = read(fr, read_buf, sizeof(read_buf));
close(fr);
if (bytes_read > 0)
{
read_buf[bytes_read] = '\0';
if (strcmp(read_buf, "exit") == 0)
{
break;
}
f = open(read_buf, O_RDONLY);
f_bytes_read = read(f, f_read_buf, sizeof(f_read_buf));
close(f);
if (f_bytes_read > 0)
{
f_read_buf[f_bytes_read] = '\0';
fw = open("fifo_client", O_WRONLY);
write(fw, f_read_buf, sizeof(f_read_buf));
close(fw);
}
else
{
fw = open("fifo_client", O_WRONLY);
write(fw, "Помилка", sizeof("Помилка"));
close(fw);
}
}
}
unlink("fifo_server");
return 0;
}
