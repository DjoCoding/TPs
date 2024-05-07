#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct List
{
    int *arr;
    int size;
    int max_size;
} List;

int list_getSize(List *myList)
{
    return (myList->size);
}

int list_getMaxSize(List *myList)
{
    return (myList->max_size);
}

void list_setSize(List *myList, int size)
{
    myList->size = size;
}

void list_setMaxSize(List *myList, int max_size)
{
    myList->max_size = max_size;
}

List *create_list()
{
    List *myList = (List *)malloc(sizeof(List));

    list_setSize(myList, 0);
    list_setMaxSize(myList, 2);

    myList->arr = (int *)malloc(sizeof(int) * list_getMaxSize(myList));
    return myList;
}

bool list_full(List *myList)
{
    return (list_getSize(myList) == list_getMaxSize(myList));
}

void list_resize(List *myList)
{
    list_setMaxSize(myList, list_getMaxSize(myList) * 2);
    myList->arr = realloc(myList->arr, sizeof(int) * list_getMaxSize(myList));
}

void list_incSize(List *myList)
{
    (myList->size)++;
}

void list_setItem(List *myList, int index, int value)
{
    (myList->arr)[index] = value;
}

int list_getItem(List *myList, int index)
{
    return (myList->arr)[index];
}

void list_append(List *myList, int item)
{
    if (list_full(myList))
        list_resize(myList);

    list_setItem(myList, list_getSize(myList), item);
    list_incSize(myList);
}

void list_destroy(List **myList)
{
    if (*myList)
    {
        free((*myList)->arr);
        free(*myList);
    }
}

void list_showItems(List *myList)
{
    if (!list_getSize(myList))
        printf("the list is empty!\n");
    else
    {
        int i;
        printf("[");
        for (i = 0; i < list_getSize(myList) - 1; i++)
        {
            printf("%d, ", list_getItem(myList, i));
        }
        printf("%d]\n", list_getItem(myList, list_getSize(myList)));
    }
}

int list_empty(List *myList)
{
    return (list_getSize(myList) == 0);
}

int list_pop(List *myList)
{
    int result = list_getItem(myList, list_getSize(myList) - 1);
    list_setSize(myList, list_getSize(myList) - 1);
    return result;
}

int main(void)
{
    int i;
    List *my_list = create_list();

    for (i = 0; i <= 10; i++)
    {
        list_append(my_list, i);
    }

    list_showItems(my_list);
    list_destroy(&my_list);

    return 0;
}