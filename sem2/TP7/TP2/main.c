#include <stdio.h>
#include "./lib.h"
#include "../include/tree.h"
#include "../include/func.h"

#define NUMBER_OF_ELEMENTS 10

int nums[NUMBER_OF_ELEMENTS] = {0};

void fill_array_with_random_values() {
    for (int i = 0; i < NUMBER_OF_ELEMENTS; i++)
        nums[i] = RANDOM_VALUE();
}

void display_array() {
    printf("{ ");
    for (int i = 0; i < NUMBER_OF_ELEMENTS; i++)
        printf("%d ", nums[i]);
    printf("}\n");
}

void usage() {
    print_file_content("./interface.txt");
}

void run() {
    Node *root = NULL;
    Node *root1 = NULL, *root2 = NULL;
    int value, input;

    usage();

    do {
        input = read_integer("> ");
        switch(input) {
            case 0: 
                usage();
                break;
                
            case 1:
                remove_nodes(&root1);
                remove_nodes(&root2);
                
                root1 = get_random_bst(12);
                root2 = get_random_bst(4);
                
                value  = read_integer("type the number of the nodes: ");
                
                printf("FIRST TREE\n");
                print_tree_nodes(root1);

                printf("SECOND TREE\n");
                print_tree_nodes(root2);

                Node *new_root = get_bst(value, &root1, root2);                

                print_tree_nodes(new_root);

                remove_nodes(&new_root);
                break;

            case 2:
                remove_nodes(&root);
                break;

            case 3:
                printf("THE NUMBER OF THE NODES IS: %d\n", count_number_nodes(root));
                break;

            case 4:
                in_order_traversal(root);
                printf("\n");
                break;

            case 5:
                root1 = get_random_bst(10);
                root2 = get_random_bst(10);

                printf("FIRST TREE\n");
                print_tree_nodes(root1);

                printf("SECOND TREE\n");
                print_tree_nodes(root2);

                if (tree_cmp(root, root2) == 0)
                    printf("TREES ARE THE SAME\n");
                else 
                    printf("TREES ARE NOT THE SAME\n");

                remove_nodes(&root1);
                remove_nodes(&root2);
                break;

            case 6:
                value = read_integer("type the value to be inserted: ");
                add_nodes_to_bst(&root, value);
                break;

            case 7:
                value = read_integer("type the value to be removed: ");
                Node *result = search_node_in_bst(root, value);

                if (result)
                    printf("NODE FOUND AT: %p\n", result);
                else 
                    printf("NOT FOUND\n");
                break;
            
            case 8:
                if (check_if_bst(root)) 
                    printf("THE TREE IS A BST\n");
                else 
                    printf("THE TREE ISN'T A BST\n");
                break;
            
            case 9:
                fill_array_with_random_values();
                display_array();
                sort_array_using_bst(nums, NUMBER_OF_ELEMENTS);
                display_array();
                break;

            case 10:
                value = read_integer("type the value to be removed: ");
                remove_node(&root, value);
                break;
            
            case 11:
                remove_nodes(&root);
                root = get_random_bst(13);
                break;
        }
    } while (input >= 0 && input < 12);
    remove_nodes(&root);
}

int main(void) {
    run();
    return 0;
}