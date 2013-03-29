//
//  NSLogRouter.c
//  CLIPS
//
//  Created by Joshua Scoggins on 3/28/13.
//  Copyright (c) 2013 Joshua Scoggins. All rights reserved.
//

#include "NSLogRouter.h"
#include "clips.h"
#include <Foundation/Foundation.h>
int FindNSLogRouter(void*, char*);
int ExitNSLogRouter(void*, int);
int PrintNSLogRouter(void*, char*, char*);
void CallNSLogCommand(void* theEnv);
void RegisterNSLogRouters(void* theEnv) {
    EnvAddRouter(theEnv, (char*)"log",
                 40, FindNSLogRouter, PrintNSLogRouter,
                 NULL, NULL, ExitNSLogRouter);
    EnvDefineFunction2(theEnv,
                       (char*)"log",
                       'v',
                       PTIEF CallNSLogCommand,
                       (char*)"CallNSLogCommand",
                       (char*)"11s");
}

int FindNSLogRouter(void* theEnv, char* logicalName) {
    if(strcmp(logicalName, (char*)"log") == 0) {
        return TRUE;
    } else {
        return FALSE;
    }
}

int ExitNSLogRouter(void* theEnv, int num) {
    return 1;
}

int PrintNSLogRouter(void* theEnv, char* logicalName, char* str) {
    NSLog(@"%s", str);
    return 1;
}

void CallNSLogCommand(void* theEnv) {
    DATA_OBJECT arg0;
    char* msg;
    if(EnvArgTypeCheck(theEnv, (char*)"log", 1, SYMBOL_OR_STRING, &arg0) == 0) {
        return;
    }
    msg = DOToString(arg0);
    NSLog(@"%s", msg);    
}