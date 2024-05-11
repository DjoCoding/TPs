#include <stdio.h>

#include "./tree.h"

void print_array(int *nums, size_t size) {
    printf("{ ");
    for (size_t i = 0; i < size; i++)
        printf("%d ", nums[i]);
    printf("}\n");
}

int nums[] = {5, 4, 3, 2, 1};

int read_integer(char *s) {
    printf("%s", s);
    int result = 0;
    scanf("%d", &result);
    return result;
}

int main(void) {
    printf("HELLO WORLD\n");
    return 0;
}



