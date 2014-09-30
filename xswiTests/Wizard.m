//
//  Wizard.m
//  xswi
//
//  Created by Thomas Skjølberg on 10/20/10.
//  Copyright 2010 Thomas. All rights reserved.
//

#import "Wizard.h"


@implementation Wizard

@synthesize staff = _staff;

- (id)initWithNameAndStaff:(NSString *)name level:(int)level staff:(BOOL)staff {
    if ((self = [super initWithName:name level:level])) {
        self.staff = staff;
    }    
    return self;
}

- (void) write:(id<XMLStreamWriter>)writer {
	[writer writeStartElement:@"Wizard"];
	
	[super write:writer];
	
	// write optional knife element
	if(self.staff) {
		[writer writeStartElement:@"Staff"];
		[writer writeCharacters:@"Yes"];
		[writer writeEndElement];
	} else {
		// dont write anything
	}
	
	[writer writeEndElement];
}


@end
