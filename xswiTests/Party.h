//
//  Party.h
//

#import <Foundation/Foundation.h>
#import "XMLSerializable.h"

@interface Party : NSObject <XMLSerializable>{
    NSMutableArray *_players;
}

@property (nonatomic, retain) NSMutableArray *players;

@end
