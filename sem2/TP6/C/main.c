#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

#ifndef INTERFACE_H
#define INTERFACE_H
    #include "./interface.h"
#endif


int main(void) {
    srand(time(NULL));
    run();
    return 0;
}