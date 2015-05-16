//
//  StateDB.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "State.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"

@interface StateDB : NSObject

- (NSMutableArray*) getAllData;
- (void) closeDatabase;
- (void) initializeDatabase;
- (void) insertName:(NSString*)name illState:(NSString*)state Out:(NSString*)patientOut;
- (BOOL) deleteDataOfName:(NSString*)name;
- (BOOL) updateDataOfName:(NSString*)name setState:(State*)state;

@end
