//
//  CLIPSEnvironment.h
//  CLIPS
//
//  Created by Joshua Scoggins on 3/28/13.
//  Copyright (c) 2013 Joshua Scoggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "clips.h"
@interface CLIPSEnvironment : NSObject {
    void* env;
    Boolean preExistingEnvironment;
}
-(id) init;
-(id) initWithPreExistingEnvironment: (void*) env;
-(void) dealloc;
-(void) run: (NSInteger) duration;
-(Boolean) batchStar: (NSString*) path;
-(Boolean) batch: (NSString*) path;
-(Boolean) load: (NSString*) path;
-(void) build: (NSString*) input;
-(Boolean) eval: (NSString*) input storageUnit: (DATA_OBJECT_PTR) value;
-(void) halt;
-(void*) assertString: (NSString*) string;
-(void*) makeInstanceFromString: (NSString*) string;
-(Boolean) makeInstancesFromString: (NSString*) instances;
-(void) printRouter: (NSString*) router withMessage: (NSString*) message;
-(void) printMessage: (NSString*) message;
-(void) printError: (NSString*) message;
-(void) defineFunction: (NSString*) name returnType: (char) retType fnPtr: (void*) fPtr fnName: (NSString*) fnName;
-(void) defineFunction2: (NSString*) name returnType: (char) retType fnPtr: (void*) fPtr fnName: (NSString*) fnName fnArgs: (NSString*) fnArgs;
-(Boolean) argCountCheck: (NSString*) functionName qualifier: (int) qualifier count: (int) aCount;
-(Boolean) argTypeCheck: (NSString*) functionName type: (int) qType targetIndex: (int) offset
            dataStorage: (DATA_OBJECT*) storage;
-(void*) getEnvironment;
-(void) clear;
-(void) reset;
@end
