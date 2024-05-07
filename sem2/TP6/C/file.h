#include <stdio.h>

void display_file_content(void) {
    FILE *file;
    char ch;

    file = fopen("file.txt", "r");


    while ((ch = fgetc(file)) != EOF) {
        printf("%c", ch);
    }

    fclose(file);

}