#include <stdio.h>
#include <stdlib.h>


int read_integer(char *s) {
    printf("%s", s);
    int result;
    scanf("%d", &result);
    return result;
}

char *read_string(char *s, int size) {
    char *input = (char *)malloc((size + 1) * sizeof(char));
    if (input == NULL) {
        fprintf(stderr, "Memory allocation failed.\n");
        exit(1);
    }

    printf("%s\n", s);
    fflush(stdout); // Flush stdout to ensure prompt is displayed

    int i = 0;
    char c;
    while (i < size) {
        c = getchar();
        if (c == '\n') {
            break; // Stop reading if newline is encountered
        }
        input[i++] = c;
    }
    input[i] = '\0'; // Null-terminate the string

    return input;
}