//
//  main.c
//  hashSet
//
//  Created by Fei Yuan on 2021/5/21.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
struct List {
    int val;
    struct List * next;
};

void listPush(struct List * head, int x) {
    struct List * p = malloc(sizeof(struct List ));
    //头插入
    p->val = x;
    p->next = head->next;
    head->next = p;
}

void listDelete (struct List * head, int x) {
    for (struct List * it = head; it -> next; it = it->next) {
        if (it->next->val == x) {
            struct List * t = it->next;
            it->next = t->next;
            free(t);
            break;
        }
    }
}

bool listContains (struct List * head, int x) {
    for (struct List * it = head; it -> next; it = it->next) {
        if (it->next->val == x) {
            return true;
        }
    }
    return false;
}

void listFree(struct List * head) {
    while (head -> next) {
        struct List * t = head -> next;
        head->next = t->next;
        free(t);
    }
}

const int base = 769;


int hash(int key) {
    return  key % base;
}

typedef struct {
    struct List * data;
}HashSet;



HashSet * create () {
    HashSet * ret = malloc(sizeof(HashSet));
    ret->data = malloc(sizeof(struct List) * base);
    for (int i = 0; i < base; i ++) {
        ret->data[i].val = 0;
        ret->data[i].next = NULL;
    }
    return ret;
}

void HashSetAdd(HashSet* obj,int key) {
    int h = hash(key);
    if (!listContains(&(obj->data[h]), key)) {
        listPush(&(obj->data[h]), key);
    }
}

void HashSetRemove(HashSet* obj, int key) {
    int h = hash(key);
    listDelete(&(obj->data[h]), key);
}

bool HashSetContains(HashSet* obj, int key) {
    int h = hash(key);
    return listContains(&(obj->data[h]), key);
}

void HashSetFree(HashSet* obj) {
    for (int i = 0; i < base; i++) {
        listFree(&(obj->data[i]));
    }
    free(obj->data);
}


int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    return 0;
}
