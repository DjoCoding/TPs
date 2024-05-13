#include <stdio.h>
#include "../include/tree.h"
#include "../include/func.h"

void usage() {
    print_file_content("./interface.txt");
}

void run() {
    Node *root = NULL;
    int value, input;

    usage();

    do {
        input = read_integer("> ");
        switch(input) {
            case 0:
                usage();
                break;
                
            case 1:
                remove_nodes(&root);
                value = read_integer("type the number of the nodes: ");
                root = get_random_bst(value);
                break;
            case 2:
                value = read_integer("type the value to search: ");
                if (search_value_in_bst(root, value)) 
                    printf("NODE FOUND\n");
                else 
                    printf("NODE NOT FOUND\n");
                break;
            case 3:
                printf("THE MAXIMUM VALUE IN THE TREE IS: %d\n", get_max(root));
                break;
            case 4:
                printf("THE MINIMUM VALUE IN THE TREE IS: %d\n", get_min(root));
                break;
            case 5:
                value = read_integer("1-prefix, 2- infix, 3-postfix, 4-bfs: ");
                switch(value) {
                    case 1:
                        pre_order_traversal(root);
                        break;
                    case 2:
                        in_order_traversal(root);
                        break;
                    case 3:
                        post_order_traversal(root);
                        break;
                    case 4:
                        bfs(root);
                        break;
                    default:
                        in_order_traversal(root);
                }
                printf("\n");
                break;
            case 6:
                value = read_integer("type the value to be inserted: ");
                add_nodes_to_bst(&root, value);
                break;
            case 7:
                value = read_integer("type the value to be removed: ");
                remove_node(&root, value);
                break;
        }
    } while (input >= 0 && input < 7);
    remove_nodes(&root);
}

int main(void) {
    run();
    return 0;
}