//
//  PatientDB.h
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "Patient.h"

@interface PatientDB : NSObject

- (NSMutableArray*) getAllData;
- (void) closeDatabase;
- (void) initializeDatabase;
- (void) insertToDB:(Patient*)patient;
- (BOOL) deleteDataOfName:(NSString*)name;
- (BOOL) updateDataOfName:(NSString*)name andMedModel:(Patient*)patient;
- (Patient*) searchPatientOfName:(NSString*)name;

@end
