//
//  Player.m
//

#import "Player.h"

@implementation Player
@synthesize name = _name;
@synthesize level = _level;

- (id)initWithName:(NSString *)name level:(int)level {
    if ((self = [super init])) {
        self.name = name;
        self.level = level;
    }    
    return self;
}

- (void) write:(id<XMLStreamWriter>)writer {
	// do superclass behaviour here

	// write <Name>Butch</Name>
	[writer writeStartElement:@"Name"];
	[writer writeCharacters:self.name];
	[writer writeEndElement];
	
	// write <Level>1</Level>
	[writer writeStartElement:@"Level"];
	[writer writeCharacters:[NSString stringWithFormat:@"%i", self.level]];
	[writer writeEndElement];
	
}

@end
