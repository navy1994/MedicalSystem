//
//  PatientCostDB.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "PatientCostModel.h"

@interface PatientCostDB : NSObject
- (NSMutableArray*) getAllData;
- (void) closeDatabase;
- (void) initializeDatabase;
- (void) insertName:(NSString*)name cash:(NSString*)cash;
- (BOOL) deleteDataOfName:(NSString*)name;
- (void) updateDataOfName:(NSString*)name;
- (PatientCostModel*)searchPatientCostOfName:(NSString*)name;
@end
