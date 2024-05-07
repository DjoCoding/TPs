#include "./queuef.h"
#include "./nodef.h"

#ifndef BFS_H
#define BFS_H

void bfs(Node *root) {
    queue_t queue = queue_init();
    enqueue(queue, root);

    int count = 0;
    int num_nodes_in_level = 1;
    
    
    while (!isempty(queue)) {
        Node *current = dequeue(queue);

        printf("%d ", current->value);

        if (current->left) enqueue(queue, current->left);
        if (current->right) enqueue(queue, current->right);
    
        count++;

        if (count == num_nodes_in_level) {
            printf("\n");
            num_nodes_in_level *= 2;
            count = 0;
        }
    }

    printf("\n");
    queue_remove(&queue);
}

#endif