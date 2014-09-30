//
//  Rogue.h
//  xswi
//
//  Created by Thomas Skjølberg on 10/20/10.
//  Copyright 2010 Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Rogue : Player {

	BOOL _knife;
}

@property (nonatomic, assign) BOOL knife;

- (id)initWithNameAndKnife:(NSString *)name level:(int)level knife:(BOOL)knife;

@end
