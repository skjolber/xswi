//
//  XMLSerializable.h
//  xswi
//
//  Created by Thomas Skjølberg on 10/20/10.
//  Copyright 2010 Thomas. All rights reserved.
//

#import "XMLWriter.h"

@protocol XMLSerializable

- (void) write:(id<XMLStreamWriter>)writer;

@end
