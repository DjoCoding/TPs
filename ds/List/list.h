typedef struct node {
    int value;
    struct node *next;
} node;

node *create_node(int value);

void add_node(node **head, int value);

node *get_list(int num_nodes, int max_value);

void print_list(node *head);

void destroy_list(node **head);
