#include <stdio.h>
int main(void)
{
    FILE *f = fopen("/sdcard/coc/hello_android.txt", "w");
    if (f) {
        fprintf(f, "File created by an ANSI C program.");
        fclose(f);
    }
    return 0;
}