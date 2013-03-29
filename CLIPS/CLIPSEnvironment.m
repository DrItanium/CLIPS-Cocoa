//
//  CLIPSEnvironment.m
//  CLIPS
//
//  Created by Joshua Scoggins on 3/28/13.
//  Copyright (c) 2013 Joshua Scoggins. All rights reserved.
//

#import "CLIPSEnvironment.h"
#include "clips.h"

@implementation CLIPSEnvironment
-(id) init {
    self = [super init];
    if(self) {
    preExistingEnvironment = false;
    env = CreateEnvironment();
    }
    return self;
}
-(id) initWithPreExistingEnvironment: (void*) tEnv {
    self = [super init];
    if(self) {
    preExistingEnvironment = true;
    env = tEnv;
    }
    return self;
}
-(void) dealloc {
    if(!preExistingEnvironment) {
        DestroyEnvironment(env);
    } else {
        //it's up to another to delete this information
        env = 0;
    }
    [super dealloc];
}
-(void) run {
    EnvRun(env, -1);
}
-(void) run: (NSInteger) duration {
    EnvRun(env, duration);
}
-(Boolean) batchStar: (NSString*) path {
    return EnvBatchStar(env, (char*)[path UTF8String]);
}
-(Boolean) load: (NSString*) path {
    return EnvLoad(env, (char*)[path UTF8String]);
}
-(Boolean) batch: (NSString*) path {
    return Batch(env, (char*)[path UTF8String]);
}
-(void) build: (NSString*) input {
    EnvBuild(env, (char*)[input UTF8String]);
}
-(Boolean) eval: (NSString*) input storageUnit: (DATA_OBJECT_PTR) value {
    return EnvEval(env, (char*)[input UTF8String], value);
}
-(void) halt {
    EnvHalt(env);
}
-(void*) assertString: (NSString*) string {
    return EnvAssertString(env, (char*)[string UTF8String]);
}
-(void*) makeInstanceFromString: (NSString*) string {
    return EnvMakeInstance(env, (char*)[string UTF8String]);
}
-(Boolean) makeInstancesFromString:(NSString *)instances {
    return EnvLoadInstancesFromString(env, (char*)[instances UTF8String], -1) != -1;
}
-(void) printRouter: (NSString*) router withMessage: (NSString*) message {
    EnvPrintRouter(env, (char*)[router UTF8String], (char*)[message UTF8String]);
}
-(void) printMessage: (NSString*) message {
    [self printRouter: @"stdout" withMessage: message];
}
-(void) printError: (NSString*) message {
    [self printRouter: @"werror" withMessage: message];
}

-(void*) getEnvironment {
    return env;
}
-(void) defineFunction: (NSString*) name returnType: (char) retType fnPtr: (void*) fPtr fnName: (NSString*) fnName {
    EnvDefineFunction(env, (char*)[name UTF8String], retType, fPtr, (char*)[fnName UTF8String]);
}
-(void) defineFunction2: (NSString*) name returnType: (char) retType fnPtr: (void*) fPtr fnName: (NSString*) fnName fnArgs: (NSString*) fnArgs {
    EnvDefineFunction2(env, (char*)[name UTF8String], retType, fPtr, (char*)[fnName UTF8String], (char*)[fnArgs UTF8String]);
}

-(Boolean) argCountCheck: (NSString*) functionName qualifier: (int) qualifier count: (int) aCount {
    return EnvArgCountCheck(env, (char*)[functionName UTF8String], qualifier, aCount) == -1;
}
-(Boolean) argTypeCheck: (NSString*) functionName type: (int) qType targetIndex: (int) offset
            dataStorage: (DATA_OBJECT*) storage {
    return EnvArgTypeCheck(env, (char*)[functionName UTF8String], qType, offset, storage);
}
-(void) clear {
    EnvClear(env);
}

-(void) reset {
    EnvReset(env);
}
@end
