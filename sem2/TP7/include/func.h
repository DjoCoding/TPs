#ifndef FUNC_H
#define FUNC_H

#include <stdio.h>

void print_file_content(const char *filename) {
    FILE *file = fopen(filename, "r");

    if (!file) {
        fprintf(stderr, "COULDN'T OPEN THE FILE\n");
        exit(1);
    }

    char c;

    while ((c = fgetc(file)) != EOF) {
        putchar(c);
    }

    printf("\n");

    fclose(file);
}

int read_integer(const char *s) {
    printf("%s", s);
    int result;
    scanf("%d", &result);
    return result;
}

#endif 