#include <stdio.h>

#ifndef FUNC_H
#define FUNC_H

int max(int a, int b) {
    if (a > b) return a;
    return b;
}

int min(int a, int b) {
    if (a > b) return b;
    return a;
}

int random_value() {
    return rand() % 100 + 1;
}

int read_integer(char *s) {
    printf("%s", s);
    int result = 0;
    scanf("%d", &result);
    return result;
}


#endif