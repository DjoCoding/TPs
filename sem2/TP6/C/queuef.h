#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


#ifndef NODEF_H
#define NODEF_H
    #include "./nodef.h"
#endif

typedef struct {
    Node *nodes[100];
    int back;
} Queue;

typedef Queue *queue_t;

queue_t queue_init() {
    queue_t queue = (queue_t) malloc(sizeof(Queue));
    queue->back = 0;
    return queue;
}

bool isempty(queue_t queue) {
    return (queue->back == 0);
}

bool isfull(queue_t queue) {
    return (queue->back == 100);
}

void enqueue(queue_t queue, Node *node) {
    if (isfull(queue)) {
        printf("THE QUEUE IS FULL\n");
        exit(1);
    }

    queue->nodes[queue->back] = node;
    (queue->back)++;
}

Node *dequeue(queue_t queue) {
    Node *node = queue->nodes[0];

    (queue->back)--;
    for (int i = 0; i < queue->back; i++) {
        queue->nodes[i] = queue->nodes[i + 1];
    }
    
    return node;
}

void queue_remove(queue_t *queue) {
    free(*queue);
    *queue = NULL;
}
