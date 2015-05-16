//
//  MedCostDB.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "MedCostModel.h"

@interface MedCostDB : NSObject
- (NSMutableArray*) getAllData:(NSString*)patientName;
- (void) closeDatabase;
- (void) initializeDatabase;
- (void) insertMedData:(MedCostModel*)medCost;
- (BOOL) deleteDataOfName:(NSString*)name;
- (void) updateDataOfName:(NSString*)name;

@end
