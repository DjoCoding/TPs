#ifndef FUNC_H
#define FUNC_H
    #include "./func.h"
#endif


typedef struct Node {
    int value;
    struct Node *left, *right; 
} Node;

Node *node_create(int value) {
    Node *root = (Node *)malloc(sizeof(Node));
    root->value = value;
    root->left = NULL;
    root->right = NULL;
    return root;
}

void add_node(Node **root, int value) {
    if (!(*root)) {
        *root = node_create(value);
    } else {
        if (value < (*root)->value) {
            add_node(&((*root)->left), value);
        } else {
            add_node(&((*root)->right), value);
        }
    }
}

Node *get_bst(int number_nodes) {
    Node *root = NULL;
    for (int i = 0; i < number_nodes; i++) add_node(&root, random_value());
    return root;
}


void remove_tree(Node **root) {
    if (*root) {
        remove_tree(&((*root)->left));
        remove_tree(&((*root)->right));
        free(*root);
        *root = NULL;
    }
}

void add_nodes(Node *root, int level) {
    if (level) {
        root->left = node_create(random_value());
        root->right = node_create(random_value());
        add_nodes(root->left, level - 1);
        add_nodes(root->right, level - 1);
    }
}

Node *get_tree(int level) {
    Node *root = node_create(random_value());
    add_nodes(root, level - 1);
    return root;   
}

bool search_value(Node *root, int value) {
    if (!root) return false;
    else {
        if (root->value == value) return true;
        bool search = search_value(root->left, value);
        if (!search) search = search_value(root->right, value);
        return search;
    }
} 

int get_max(Node *root, int node_value) {
    if (!root) {
        return node_value;
    } else {
        return max(root->value, max(get_max(root->left, node_value), get_max(root->right, node_value)));
    }
}


int get_min(Node *root, int node_value) {
    if (!root) {
        return node_value;
    } else {
        return min(root->value, min(get_min(root->left, node_value), get_min(root->right, node_value)));
    }
}

int max_value_in_tree(Node *root) {
    return get_max(root, root->value);
}

int min_value_in_tree(Node *root) {
    return get_min(root, root->value);
}

int get_sum(Node *root) {
    if (!root) return 0;
    return root->value + get_sum(root->left) + get_sum(root->right);
}

void in_dfs(Node *root) {
    if (root) {
        in_dfs(root->left);
        printf("%d ", root->value);
        in_dfs(root->right);
    }
}

void in_order(Node *root) {
    in_dfs(root);
    printf("\n");
}

void pre_dfs(Node *root) {
    if (root) {
        printf("%d ", root->value);
        in_dfs(root->left);
        in_dfs(root->right);
    }
}

void pre_order(Node *root) {
    pre_dfs(root);
    printf("\n");
}

void post_dfs(Node *root) {
    if (root) {
        in_dfs(root->left);
        in_dfs(root->right);
        printf("%d ", root->value);
    }
}


void post_order(Node *root) {
    post_dfs(root);
    printf("\n");
}



Node *get_left_most_child(Node *root) {
    if (!root) return NULL;
    if (!(root->left)) return root;
    return get_left_most_child(root->left);
}

Node *get_right_most_child(Node *root) {
    if (!root) return NULL;
    if (!(root->right)) return root;
    return get_right_most_child(root->right);
}

void add_node_to_left_most_child(Node *root) {
    Node *left = get_left_most_child(root);
    if (left) {
        left->right = node_create(9);
    }
}


void add_node_to_right_most_child(Node *root) {
    Node *right = get_right_most_child(root);
    if (right) {
        right->left = node_create(27);
    }
}

void add_nodes_to_childs(Node *root) {
    add_node_to_left_most_child(root);
    add_node_to_right_most_child(root);
}

// return -1 if node not found! else return it's depth

int get_depth_of_value(Node *root, int value, int depth) {
    if (!root) return -1;
    if (root->value == value) return depth;
    int node_depth  =  get_depth_of_value(root->left, value, depth + 1);
    if (node_depth != -1) return node_depth;
    return get_depth_of_value(root->right, value, depth + 1);
}

int get_depth(Node *root, int value) {
    // if (!root) {
    //     return -1;
    // }

    // if (root->value == value) return 0; 
    
    // int left_depth =  1 + get_depth(root->left, value);

    // if (left_depth != -1) return left_depth;
    // return 1 + get_depth(root->right, value);

    return get_depth_of_value(root, value, 0);
}

bool isleaf(Node *root) {
    if (!root) return false;
    return !((root->left) || (root->right));
}

void remove_left_most_child(Node **root) {

    if (isleaf(*root)) {
        free(*root);
        *root = NULL;
        return;
    }


    Node *current = *root;
    while (current->left) {
        if (isleaf(current->left)) {
            free(current->left);
            current->left = NULL;
            return;
        }
        current = current->left;
    }
}

void remove_right_most_child(Node **root) {

    if (isleaf(*root)) {
        free(*root);
        *root = NULL;
        return;
    }


    Node *current = *root;
    while (current->right) {
        if (isleaf(current->right)) {
            free(current->right);
            current->right = NULL;
            return;
        }
        current = current->right;
    }
}

void remove_nodes(Node **root) {
    remove_left_most_child(root);
    remove_right_most_child(root);
}