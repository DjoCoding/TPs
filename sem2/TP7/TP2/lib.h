#ifndef LIB_H
#define LIB_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "../include/tree.h"

void insert_node_in_bst(Node **root, Node *node) {
    if (*root == NULL) {
        *root = node;
        return;
    }

    if (NODE_VALUE(node) < NODE_VALUE(*root)) 
        insert_node_in_bst(&(NODE_LEFT(*root)), node);
    else 
        insert_node_in_bst(&(NODE_RIGHT(*root)), node);
}

void merge_two_trees(Node **root1, Node *root2) {
    if (root2 == NULL)
        return;

    Node *left = NODE_LEFT(root2);
    Node *right = NODE_RIGHT(root2);

    NODE_LEFT(root2) = NULL;
    NODE_RIGHT(root2) = NULL;

    insert_node_in_bst(root1, root2);

    merge_two_trees(root1, left);
    merge_two_trees(root1, right);
}

void merge(Node **root1, Node *root2) {
    if (*root1 == NULL) {
        *root1 = root2;
        return;
    }

    merge_two_trees(root1, root2);
}

Node *get_bst(int value, Node **root1, Node *root2) {
    Node *root = node_init(value);
    merge(root1, root2);

    if (value < NODE_VALUE(*root1)) 
        NODE_RIGHT(root) = *root1;
    else 
        NODE_LEFT(root) = *root1;

    return root;
}

int count_number_nodes(Node *root) {
    if (root == NULL)
        return 0;

    return 1 + count_number_nodes(NODE_LEFT(root)) + count_number_nodes(NODE_RIGHT(root));
}

void increasing_display(Node *root) {
    if (root) {
        in_order_traversal(NODE_LEFT(root));
        printf(PRINT_NODE_VALUE(root));
        in_order_traversal(NODE_RIGHT(root));
    }
}

int tree_cmp(Node *root1, Node *root2) {
    if (root1 == NULL && root2 == NULL) 
        return 0;
    
    if (root1 == NULL ^ root2 == NULL) 
        return 1;
    
    if (NODE_VALUE(root1) != NODE_VALUE(root2))
        return 1;
    
    int left_cmp = tree_cmp(NODE_LEFT(root1), NODE_RIGHT(root2));

    if (left_cmp == 1)
        return 1;
    
    return tree_cmp(NODE_RIGHT(root1), NODE_RIGHT(root2));
}

Node *search_node_in_bst(Node *root, int value) {
    if (root == NULL)
        return NULL;
    
    if (NODE_VALUE(root) == value)  
        return root;
    
    if (value < NODE_VALUE(root))
        return search_node_in_bst(NODE_LEFT(root), value);
    
    return search_node_in_bst(NODE_RIGHT(root), value);
}

bool check_if_bst(Node *root) {
    if (root == NULL) 
        return true;

    int max_left_value = get_max_value(NODE_LEFT(root), NODE_VALUE(root));
    int min_right_value = get_min_value(NODE_RIGHT(root), NODE_VALUE(root));

    if (max_left_value < NODE_VALUE(root) && NODE_VALUE(root) < min_right_value) 
        return check_if_bst(NODE_LEFT(root)) && check_if_bst(NODE_RIGHT(root));

    return false;
}

Node *convert_array_to_bst(int *nums, int size) {
    Node *root = NULL;
    for (int i = 0; i < size; i++) 
        add_nodes_to_bst(&root, nums[i]);
    
    return root;
}

void add_node_to_array_from_bst(Node *root, int *nums, int *index) {
    if (root == NULL)
        return;
    
    add_node_to_array_from_bst(NODE_LEFT(root), nums, index);
    nums[*index++] = NODE_VALUE(root);
    add_node_to_array_from_bst(NODE_RIGHT(root), nums, index);
}

void convert_bst_to_array(Node *root, int *nums) {
    int index = 0;
    add_node_to_array_from_bst(root, nums, &index);
}

void sort_array_using_bst(int *nums, int size) {
    Node *root = convert_array_to_bst(nums, size);
    convert_bst_to_array(root, nums);
    remove_nodes(&root);
}

#endif