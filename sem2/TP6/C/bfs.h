#ifndef QUEUEF_H
#define QUEUEF_H
    #include "./queuef.h"
#endif

#ifndef NODEF_H
#define NODEF_H
    #include "./nodef.h"
#endif

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