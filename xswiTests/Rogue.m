//
//  Rogue.m
//  xswi
//
//  Created by Thomas Skjølberg on 10/20/10.
//  Copyright 2010 Thomas. All rights reserved.
//

#import "Rogue.h"


@implementation Rogue

@synthesize knife = _knife;

- (id)initWithNameAndKnife:(NSString *)name level:(int)level knife:(BOOL)knife {
    if ((self = [super initWithName:name level:level])) {
        self.knife = knife;
    }    
    return self;
}

- (void) write:(id<XMLStreamWriter>)writer {
	[writer writeStartElement:@"Rogue"];
		
	[super write:writer];
	
	// write knife element
	[writer writeStartElement:@"Knife"];
	if(self.knife) {
		[writer writeCharacters:@"Yes"];
	} else {
		[writer writeCharacters:@"No"];
	}
	[writer writeEndElement];
	
	[writer writeEndElement];
}

@end
