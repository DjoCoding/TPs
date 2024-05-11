#ifndef TREE_H 
#define TREE_H 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// CONSTS!
#define MAX_VALUE 10
#define QUEUE_CAPACITY 100

// MACROS!
#define ARRAY_SIZE(array) sizeof(array) / sizeof((array)[0])
#define RANDOM_VALUE() rand() % MAX_VALUE + 1
#define NODE_VALUE(node) (node)->value
#define NODE_RIGHT(node) (node)->right
#define NODE_LEFT(node) (node)->left
#define PRINT_VALUE(node) "%d ", NODE_VALUE(node)
#define max(a, b) ((a) > (b) ? (a) : (b))
#define min(a, b) ((a) < (b) ? (a) : (b))


// TYPES!
typedef enum {
    LEFT, 
    RIGHT,
} CHILD_TYPE;

typedef struct Node {
    int value; 
    struct Node *left, *right;
} Node;

// QUEUE FOR BFS
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

    for (int i = 0; i < size; i++) 
        queue[i] = queue[i + 1];
    
    return node;
}

// FUNCTIONS!
Node *node_init(int value) {
    Node *node = (Node *)malloc(sizeof(Node));
    node->value = value;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void add_node_to_tree(Node **root, int level) {
    if (level == 0) 
        return;
    
    *root = node_init(RANDOM_VALUE());
    Node *left = (*root)->left;
    Node *right = (*root)->right;

    add_node_to_tree(&left, level - 1);
    add_node_to_tree(&right, level - 1);
}

Node *get_tree(int level) {
    Node *root = NULL;
    add_node_to_tree(&root, level);
    return root;
}

void add_node_to_bst(Node **root, int value) {
    if (*root == NULL)  {
        *root = node_init(value);
        return;
    }

    if((NODE_VALUE(*root) == value)) 
        return;

    if (NODE_VALUE(*root) < value) 
        add_node_to_bst(&(NODE_RIGHT(*root)), value);
    else 
        add_node_to_bst(&(NODE_LEFT(*root)), value); 
}

Node *get_bst(int num_nodes) {
    Node *root = NULL;

    for (int i = 0; i < num_nodes; i++) 
        add_node_to_bst(&root, RANDOM_VALUE());
    
    return root;
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

        printf(PRINT_VALUE(current));

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


void remove_tree(Node **root) {
    if (*root) {
        remove_tree(&(NODE_LEFT(*root)));
        remove_tree(&(NODE_RIGHT(*root)));
        free(*root);
        *root = NULL;
    }
}

size_t get_tree_size(Node *root) {
    if (root == NULL) 
        return 0;
    
    return 1 + get_tree_size(NODE_LEFT(root)) + get_tree_size(NODE_RIGHT(root));
}

int count_number_nodes(Node *root) {
    if (!root) 
        return 0;
    
    return 1 + count_number_nodes(NODE_LEFT(root)) + count_number_nodes(NODE_RIGHT(root));
}

void display_in_order(Node *root) {
    if (root) {
        display_in_order(NODE_LEFT(root));
        printf(PRINT_VALUE(root));
        display_in_order(NODE_RIGHT(root));
    }
}

void in_order(Node *root) {
    display_in_order(root);
    printf("\n");
}

bool tree_cmp(Node *root1, Node *root2) {
    // case of root1 == root2 == NULL;
    // and in case of the same root!
    // remember im comparing addresses here!
    if (root1 == root2) return true; 
    
    if (!root1 ^ !root2) return false;

    if (NODE_VALUE(root1) != NODE_VALUE(root2)) 
        return false;
    
    bool left_cmp = tree_cmp(NODE_LEFT(root1), NODE_LEFT(root2));

    if (!left_cmp) 
        return tree_cmp(NODE_RIGHT(root1), NODE_RIGHT(root2));

    return false;
}

Node *search_for_a_node(Node *root, int value) {
    if(!root) 
        return false;

    if (NODE_VALUE(root) == value) 
        return root;
    
    Node *left_node = search_for_a_node(NODE_LEFT(root), value);

    if (!left_node)
        return search_for_a_node(NODE_RIGHT(root), value);
    
    return left_node;
}

int get_max_in_tree(Node *root, int node_value) {
    if (!root) 
        return node_value;
    
    int max_between_sub_trees = max(get_max_in_tree(NODE_LEFT(root), node_value), get_max_in_tree(NODE_RIGHT(root), node_value));

    int result =  max(NODE_VALUE(root), max_between_sub_trees);

    return result;
}

int get_max(Node *root) {
    return get_max_in_tree(root, NODE_VALUE(root));
}

int get_min_in_tree(Node *root, int node_value) {
    if (!root) 
        return node_value;
    
    int min_between_sub_trees = min(get_min_in_tree(NODE_LEFT(root), node_value), get_min_in_tree(NODE_RIGHT(root), node_value));

    int result =  min(NODE_VALUE(root), min_between_sub_trees);

    return result;
}

int get_min(Node *root) {
    return get_min_in_tree(root, NODE_VALUE(root));
}

bool is_bst(Node *root) {
    if (!root) 
        return true;
    
    int max_in_left_sub_tree = get_max(NODE_LEFT(root));
    int min_in_right_sub_tree = get_min(NODE_RIGHT(root));

    if (!(max_in_left_sub_tree < NODE_VALUE(root) && min_in_right_sub_tree > NODE_VALUE(root))) 
        return false;
    
    bool check_left_sub_tree = is_bst(NODE_LEFT(root));

    if (check_left_sub_tree) 
        return is_bst(NODE_RIGHT(root));
    
    return false;
}

void fill_array_from_bst(Node *root, int *nums, size_t *index) {
    if (!root) 
        return;

    fill_array_from_bst(NODE_LEFT(root), nums, index);
    nums[(*index)++] = NODE_VALUE(root);
    fill_array_from_bst(NODE_RIGHT(root), nums, index);
}

void sort_array(int *nums, size_t size) {
    // filling the tree with the elm in nums 
    Node *root = NULL;
    for (size_t i = 0; i < size; i++) 
        add_node_to_bst(&root, nums[i]);

    size_t index = 0;

    fill_array_from_bst(root, nums, &index); 
    remove_tree(&root);  
}


Node *get_max_node_in_bst(Node *root) {
    Node *current = root;
    while (NODE_RIGHT(current)) {
        current = NODE_RIGHT(current);
    }

    return current;
}

bool has_one_child(Node *node) {
    return (NODE_LEFT(node) == NULL ^ NODE_RIGHT(node) == NULL);
}

bool isleaf(Node *node) {
    return (NODE_LEFT(node) == NULL && NODE_RIGHT(node) == NULL);
}

Node *get_parent_node(Node *root, Node *node) {
    if (root == NULL || root == node) 
        return NULL;

    if (NODE_LEFT(root) == node || NODE_RIGHT(root) == node) 
        return root;
    
    Node *parent = get_parent_node(NODE_LEFT(root), node);
    
    if (parent) 
        return parent;
    
    return get_parent_node(NODE_RIGHT(root), node);
}

void remove_root_node(Node **root) {
    if (isleaf(*root)){
        free(*root);
        *root = NULL;
        return;
    }

    if (has_one_child(*root)) {
        Node *child = NODE_LEFT(*root) == NULL ? NODE_RIGHT(*root) : NODE_LEFT(*root);
        free(*root);
        *root = child;
        return; 
    } 

    Node *max_left_node = get_max_node_in_bst(NODE_LEFT(*root));
    Node *max_left_node_parent = get_parent_node(*root, max_left_node);

    int node_value = NODE_VALUE(max_left_node);

    free(max_left_node);

    if (max_left_node_parent != root)
        NODE_RIGHT(max_left_node_parent) = NULL;

    // that means the max_left_node == NODE_LEFT(*root);
    else 
        NODE_LEFT(*root) = NULL;
    
    NODE_VALUE(*root) = node_value;
}

void remove_simple_node(Node *parent_node, Node *node) {
    if (isleaf(node)) {
        if (NODE_LEFT(parent_node) == node) 
            NODE_LEFT(parent_node) = NULL;
        else 
            NODE_RIGHT(parent_node) = NULL;

        free(node);
        return;
    }

    if (has_one_child(node)) {
        Node *node_child = NODE_LEFT(node) == NULL ? NODE_RIGHT(node) : NODE_LEFT(node);
        if (NODE_LEFT(parent_node) == node) 
            NODE_LEFT(parent_node) = node_child;
        else 
            NODE_RIGHT(parent_node) = node_child;
        
        free(node);
        return; 
    }

    Node *max_left_node = get_max_node_in_bst(NODE_LEFT(node));
    Node *max_left_node_parent = get_parent_node(node, max_left_node);

    int node_value = NODE_VALUE(max_left_node);

    free(max_left_node);

    if (max_left_node_parent != node)
        NODE_RIGHT(max_left_node_parent) = NULL;

    // that means the max_left_node == NODE_LEFT(*root);
    else 
        NODE_LEFT(node) = NULL;
    
    NODE_VALUE(node) = node_value;
}

void remove_node(Node *root, Node *node) {
    Node *parent_node = get_parent_node(root, node);
    if (parent_node == NULL) 
        remove_root_node(&root);
    else 
        remove_simple_node(parent_node, node);
}

void insert_node_in_bst(Node **root, Node *node) {
    if (node == NULL) 
        return;
    
    if (*root == NULL) {
        *root = node;
        return;
    }

    if (NODE_VALUE(*root) <= NODE_VALUE(node)) 
        insert_node_in_bst(&(NODE_RIGHT(*root)), node);
    else 
        insert_node_in_bst(&(NODE_LEFT(*root)), node);
}

void merge_two_trees(Node **root1, Node **root2) {
    if (*root2 == NULL) 
        return;
    
    Node *left = NODE_LEFT(*root2);
    Node *right = NODE_RIGHT(*root2);

    NODE_LEFT(*root2) = NULL;
    NODE_RIGHT(*root2) = NULL;

    // insert the root node!
    insert_node_in_bst(root1, *root2);
    *root2 = NULL;

    // inset the left and right sub trees!
    merge_two_trees(root1, &left);
    merge_two_trees(root1, &right);
}

void merge(Node **root1, Node **root2) {
    if (!(*root1)) {
        *root1 = *root2;
        return;
    }

    if (!(*root2)) return;

    merge_two_trees(root1, root2);
}

#endif 