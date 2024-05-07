#include <stdlib.h>
#include <time.h>


int get_random(int max_number) {
    return rand() % (max_number + 1);
}