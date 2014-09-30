//
//  Party.m
//

#import "Party.h"
#import "Player.h"

@implementation Party
@synthesize players = _players;

- (id)init {
 
    if ((self = [super init])) {
        self.players = [[NSMutableArray alloc] init];
    }
    return self;
    
}

- (void) write:(id<XMLStreamWriter>)writer {
	[writer writeStartDocument];

	[writer writeStartElement:@"Party"];

	// serialize children
	for(Player *player in self.players) {
		[player write:writer];
	}

	[writer writeEndElement];

	[writer writeEndDocument];
}


@end
