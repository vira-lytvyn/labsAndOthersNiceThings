#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <mntent.h>
#include <fcntl.h>
#include <sys/utsname.h>
#include<sys/statvfs.h>
#include <sys/wait.h>
#define _GNU_SOURCE
#define line_length 80
int main()
{
struct utsname uts;
struct mntent * entry;
struct statvfs fs;
FILE *filer;
if (uname(&uts) == -1)
printf("machinename  %s\n", uts.machine);
printf("systemname %s\n",uts.sysname);
printf("Version %s\n", uts.version);
printf("Release %s\n", uts.release);
printf("nodename %s\n", uts.nodename);
FILE * file;
file = setmntent ("/etc/mtab", "r");
if (file == NULL) { fprintf (stderr, "Cannot open /etc/mtab\n"); return 1; }
while ((entry = getmntent (file)) != NULL) {
if (statvfs (entry->mnt_dir, &fs) == -1) { fprintf (stderr, "statvfs() error\n"); return 1; }
printf ("Block size: %ld\n", (unsigned long int) fs.f_bsize);
printf ("Blocks: %ld\n", (unsigned long int) fs.f_blocks);
printf ("Blocks free: %ld\n", (unsigned long int) fs.f_bfree);
printf ("Blocks available: %ld\n", (unsigned long int) fs.f_bavail);
printf ("Filesystem: %s\n", entry->mnt_fsname);
printf ("Max. filename length: %ld\n", (unsigned long int) fs.f_namemax);
printf ("Mountpoint: %s\n", entry->mnt_dir);
printf ("---\n");
}
endmntent (file);
filer=fopen("filesysinfo,txt","wt");
if (uname(&uts) == -1)
fprintf(filer,"nodename %s\n", uts.nodename);
fprintf(filer,"systemname %s\n",uts.sysname);
fprintf(filer,"Release %s\n", uts.release);
fprintf(filer,"Version %s\n", uts.version);
fprintf(filer,"machinename  %s\n", uts.machine);
fclose(filer);

return 0;
}
