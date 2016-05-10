#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
const char usage_str[] =
"usage: getopt options\n"
"Options:\n"
" -v - version \n"
" -v1 - option 1\n"
" -v2 arg - option 2\n"
" -v3 - option 3\n " ;
void version ()
{
printf ("getopt test program \n") ;
}
void p_print ()
{
printf ("Option 'p' used\n") ;
}
int main (int argc, char **argv)
{
char opt ;
if (argc < 2)
{
printf (usage_str) ;
exit (0) ;
}
while ((opt=getopt (argc, argv, "vpq:r"))!= -1)
{
switch (opt)
{
case 'v1':
version () ;
break ;
case 'v2':
p_print () ;
break ;
case 'v3':
printf ("Option 'v3' used, with argument: %s\n", optarg) ;
break ;
case -1:
break ;
default:
fprintf (stderr, "Warning: unknown option -%c\n", optopt) ;
fprintf (stderr, usage_str) ;
exit (1) ;
}
}
return 0 ;
}