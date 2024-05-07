#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "rand.h"


// the structure:

typedef struct node {
    int value;
    struct node *next;
} node;

node *create_node(int value) {
    node *result = (node *) malloc(sizeof(node));
    result -> next = NULL;
    result -> value = value;
    return result;
}

void add_node(node **head, int value) {
    node *new_node = create_node(value);
    new_node -> next = *head;
    *head = new_node;
}

node *get_list(int num_nodes, int max_value) {
    int i;
    node *head = NULL;
    for (i = 0; i < num_nodes; i++) {
        add_node(&head, get_random(max_number));
    }
    return head;
}

void print_list(node *head) {
    node *curr = head;
    printf("{ ");
    while (curr) {
        printf("%d ", curr -> value);
        curr = curr -> next;
    }
    printf("}\n");
}

void destroy_list(node **head) {
    node *next;
    while (*head) {
        next = (*head) -> next;
        free(*head);
        *head = next;
    }
}



