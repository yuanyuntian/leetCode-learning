//
//  main.c
//  CircularQueue
//
//  Created by Fei Yuan on 2021/7/6.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


typedef struct {
    int len;
    int size;
    int head;
    int tail;
    int * buf;
}CircularQueue;

CircularQueue* myCircularQueueCreate(int k) {
    CircularQueue * obj = (CircularQueue*)malloc(sizeof(CircularQueue));
    if (obj == NULL) {
        return NULL;
    }
    obj->buf = (int *)malloc(sizeof(int) * k);
    if (obj->buf == NULL) {
        free(obj);
        return NULL;
    }
    
    obj->size = k;
    obj->len = 0;
    obj->head = 0;
    obj->tail = 0;
    return obj;
}

bool myCircularQueueIsFull(CircularQueue* obj) {
    return obj->len == obj->size;
}

bool myCircularQueueIsEmpty(CircularQueue* obj) {
    return (obj->len == 0);
}

bool myCircularQueueEnQueue(CircularQueue* obj, int value) {
    if (myCircularQueueIsFull(obj)) {
        return  false;
    }
    obj->buf[obj->tail]= value;
    obj->tail = (obj->tail + 1)%(obj->size);
    obj->len++;
    return true;
}

bool myCircularQueueDeQueue(CircularQueue* obj) {
    if (myCircularQueueIsEmpty(obj)) {
        return false;
    }
    obj->head = (obj->head + 1)%(obj->size);
    obj->len --;
    return true;
}

int myCircularQueueFront(CircularQueue* obj) {
    if (myCircularQueueIsEmpty(obj)) {
        return  -1;
    }
    return obj->buf[obj->head];
}

int myCircularQueueRear(CircularQueue* obj) {
    if (myCircularQueueIsEmpty(obj)) {
        return -1;
    }
    if (obj->tail == 0) {
        return obj->buf[obj->size - 1];
    }else{
        return obj->buf[obj->tail - 1];
    }
}


void myCircularQueueFree(CircularQueue* obj) {
    free(obj->buf);
    obj->buf = NULL;
    free(obj);
    obj = NULL;
}


int main(int argc, const char * argv[]) {
    // insert code here...
    CircularQueue* obj = myCircularQueueCreate(5);
    bool param_1 = myCircularQueueEnQueue(obj, 10);
    
    bool param_2 = myCircularQueueDeQueue(obj);
    
    int param_3 = myCircularQueueFront(obj);
    
    int param_4 = myCircularQueueRear(obj);
    
    bool param_5 = myCircularQueueIsEmpty(obj);
    
    bool param_6 = myCircularQueueIsFull(obj);
    
    myCircularQueueFree(obj);
    
    return 0;
}
