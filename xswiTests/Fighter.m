//
//  Fighter.m
//  xswi
//
//  Created by Thomas Skjølberg on 10/20/10.
//  Copyright 2010 Thomas. All rights reserved.
//

#import "Fighter.h"


@implementation Fighter

@synthesize sword = _sword;

- (id)initWithNameAndSword:(NSString *)name level:(int)level sword:(BOOL)sword {
    if ((self = [super initWithName:name level:level])) {
        self.sword = sword;
    }    
    return self;
}

- (void) write:(id<XMLStreamWriter>)writer {
	[writer writeStartElement:@"Fighter"];
	
	// write optional attribute
	if(self.sword) {
		[writer writeAttribute:@"sword" value:@"Yes"];
	} else {
		// dont write anything
	}
	
	[super write:writer];

	[writer writeEndElement];
}

@end
