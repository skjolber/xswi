//
//  Fighter.h
//  xswi
//
//  Created by Thomas Skjølberg on 10/20/10.
//  Copyright 2010 Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLSerializable.h"
#import "Player.h"

@interface Fighter : Player {

	BOOL _sword;
}

@property (nonatomic, assign) BOOL sword;

- (id)initWithNameAndSword:(NSString *)name level:(int)level sword:(BOOL)sword;

@end
