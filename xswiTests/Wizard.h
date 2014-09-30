//
//  Wizard.h
//  xswi
//
//  Created by Thomas Skjølberg on 10/20/10.
//  Copyright 2010 Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Wizard : Player {
	
	BOOL _staff;
}

@property (nonatomic, assign) BOOL staff;

- (id)initWithNameAndStaff:(NSString *)name level:(int)level staff:(BOOL)staff;

@end
