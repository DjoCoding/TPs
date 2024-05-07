#include <stdio.h>

#ifndef FILE_H
#define FILE_H 

void display_file_content(void) {
    FILE *file;
    char ch;

    file = fopen("/home/djaoued/coding/homework/TPs/sem2/TP6/C/file.txt", "r");


    while ((ch = fgetc(file)) != EOF) {
        printf("%c", ch);
    }

    fclose(file);
}

#endif
