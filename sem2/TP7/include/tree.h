#ifndef TREE_H
#define TREE_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define QUEUE_CAPACITY 100

#define ARRAY_SIZE(arr) sizeof(arr) / sizeof((arr)[0])
#define NODE_VALUE(node) (node)->value
#define NODE_LEFT(node) (node)->left
#define NODE_RIGHT(node) (node)->right
#define PRINT_NODE_VALUE(node) "%d ", NODE_VALUE(node)
#define RANDOM_VALUE() rand() % 100 + 1
#define max(a, b) (a) > (b) ? (a) : (b)
#define min(a, b) (a) > (b) ? (b) : (a)

typedef struct Node {
    int value;
    struct Node *left, *right;
} Node;


Node *queue[QUEUE_CAPACITY] = {0};
size_t size = 0;

void queue_init() {
    size = 0;
}

void enqueue(Node *root) {
    if (size == QUEUE_CAPACITY) {
        printf("[QUEUE] SIZE == CAPACITY\n");
        exit(1);
    }

    queue[size++] = root;
}

Node *dequeue() {
    if (size == 0) {
        printf("[QUEUE] SIZE == 0\n");
        exit(1);
    }

    Node *node = queue[0];
    size--;

    for (size_t i = 0; i < size; i++) 
        queue[i] = queue[i + 1];
    
    return node;
}

Node *node_init(int value) {
    Node *node = (Node *)malloc(sizeof(Node));
    node->value = value;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void add_nodes_to_bst(Node **root, int value) {
    if (*root == NULL) {
        *root = node_init(value);
        return;
    }

    if (value < NODE_VALUE(*root)) 
        add_nodes_to_bst(&(NODE_LEFT(*root)), value);
    else 
        add_nodes_to_bst(&(NODE_RIGHT(*root)), value);
}

Node *get_random_bst(const int num_nodes) {
    Node *root = NULL;
    
    for (int i = 0; i < num_nodes; i++)
        add_nodes_to_bst(&root, RANDOM_VALUE());
    
    return root;
}

bool search_value_in_bst(Node *root, int value) {
    if (root == NULL)
        return false;
    
    if (NODE_VALUE(root) == value)  
        return true;
    
    if (value < NODE_VALUE(root))
        return search_value_in_bst(NODE_LEFT(root), value);
    
    return search_value_in_bst(NODE_RIGHT(root), value);
}

int get_max_value(Node *root, int node_value) {
    if (!root)
        return node_value;
    
    return max(NODE_VALUE(root), max(get_max_value(NODE_LEFT(root), node_value), get_max_value(NODE_RIGHT(root), node_value)));
}

int get_max(Node *root) {
    return get_max_value(root, NODE_VALUE(root));
}


int get_min_value(Node *root, int node_value) {
    if (!root)
        return node_value;
    
    return min(NODE_VALUE(root), min(get_min_value(NODE_LEFT(root), node_value), get_min_value(NODE_RIGHT(root), node_value)));
}

int get_min(Node *root) {
    return get_min_value(root, NODE_VALUE(root));
}

void pre_order_traversal(Node *root) {
    if (root) {
        printf(PRINT_NODE_VALUE(root));
        pre_order_traversal(NODE_LEFT(root));
        pre_order_traversal(NODE_RIGHT(root));
    }
}


void bfs(Node *root) {
    if (root == NULL) 
        return;

    queue_init();

    enqueue(root);

    int num_nodes = 1;
    int count = 0;

    while (size != 0) {
        Node *current = dequeue();

        count++;

        printf(PRINT_NODE_VALUE(current));

        if (NODE_LEFT(current)) 
            enqueue(NODE_LEFT(current));
        
        if (NODE_RIGHT(current)) 
            enqueue(NODE_RIGHT(current));
        
        if (count == num_nodes) {
            printf("\n");
            count = 0;
            num_nodes *= 2;
        }

    }
    
    printf("\n");
}


bool isleaf(Node *root) {
    return (NODE_LEFT(root) == NULL) && (NODE_RIGHT(root) == NULL); 
}

bool has_one_child(Node *root) {
    return (NODE_LEFT(root) == NULL) ^ (NODE_RIGHT(root) == NULL); 
}

void remove_node(Node **root, int value) {
    if (*root == NULL)
        return;
    
    if (NODE_VALUE(*root) < value)
        remove_node(&(NODE_RIGHT(*root)), value);
    else if (NODE_VALUE(*root) > value) 
        remove_node(&(NODE_LEFT(*root)), value);
    else {

        if (isleaf(*root)) {
            free(*root);
            *root = NULL;
            return;
        } else if (has_one_child(*root)) {
            Node *current = *root;
            if (NODE_LEFT(*root))
                *root = NODE_LEFT(*root);
            else    
                *root = NODE_RIGHT(*root);
            free(current);
            return;
        }

        int max_value_in_left_sub_tree = get_max(NODE_LEFT(*root));
        remove_node(root, max_value_in_left_sub_tree);
        NODE_VALUE(*root) = max_value_in_left_sub_tree;
        return;
    }
}


void in_order_traversal(Node *root) {
    if (root) {
        in_order_traversal(NODE_LEFT(root));
        printf(PRINT_NODE_VALUE(root));
        in_order_traversal(NODE_RIGHT(root));
    }
}


void post_order_traversal(Node *root) {
    if (root) {
        post_order_traversal(NODE_LEFT(root));
        post_order_traversal(NODE_RIGHT(root));
        printf(PRINT_NODE_VALUE(root));
    }
}

void print_tree_nodes(Node *root) {
    in_order_traversal(root);
    printf("\n");
}


void remove_nodes(Node **root) {
    if (*root == NULL) 
        return;

    Node *left = NODE_LEFT(*root);
    Node *right = NODE_RIGHT(*root);

    free(*root);
    *root = NULL;

    remove_nodes(&left);
    remove_nodes(&right);
}

#endif