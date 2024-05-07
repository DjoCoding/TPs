#include <stdio.h>

#ifndef NODEF_H
#define NODEF_H
    #include "./nodef.h"
#endif

#ifndef BFS_H
#define BFS_H
    #include "./bfs.h"
#endif

#ifndef FILE_H
#define FILE_H
    #include "./file.h"
#endif



void run() {
    Node *root = NULL;
    int user_choice = -1;

    display_file_content();

    do {
        user_choice = read_integer("type the function number: ");
       
        printf("\n");
        switch(user_choice) {
            case 0: {
                display_file_content();
                break;
            }
            case 1: {
                remove_tree(&root);
                int level = read_integer("type the level number: ");
                root = get_tree(level);
                break;
            }
            case 2: {
                int value = read_integer("type the value: ");
                if (search_value(root, value)) {
                    printf("FOUND\n");
                } else {
                    printf("NOT FOUND\n");
                }
                break;
            }
            case 3: {
                printf("the maximum value in the tree is: %d\n", max_value_in_tree(root));
                break;
            } 
            case 4: {
                printf("the minimum value in the tree is: %d\n", min_value_in_tree(root));
                break;
            }
            case 5: {
                printf("the sum of all the elements in the tree is: %d\n", get_sum(root));
                break;
            }
            case 6: {
                int type = read_integer("1-prefix, 2-infix, 3-postfix: ");
                switch(type) {
                    case 1: {
                        pre_order(root);
                        break;
                    } 
                    case 2: {
                        in_order(root);
                        break;
                    }
                    case 3: {
                        post_order(root);
                        break;
                    }
                }
                break;
            }
            case 7: {
                bfs(root);
                break;
            }
            case 8: {
                add_nodes_to_childs(root);
                break;
            }
            case 9: {
                int value = read_integer("type the value: ");
                int depth = get_depth(root, value);
                if (depth == -1) {
                    printf("NODE NOT FOUND!\n");
                } else {
                    printf("NODE FOUND AT DEPTH: %d\n", depth);
                }
                break;
            }
            case 10: {
                if (!root) {
                    printf("FILL THE TREE FIRST!\n");
                    break;
                }
                remove_nodes(&root);
                break;
            }
        }
        printf("\n");
    } while (user_choice != -1);
    remove_tree(&root);
}   