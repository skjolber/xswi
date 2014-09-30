//
//  Player.h
//

#import <Foundation/Foundation.h>
#import "XMLSerializable.h"

@interface Player : NSObject <XMLSerializable> {
    NSString *_name;
    int _level;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int level;

- (id)initWithName:(NSString *)name level:(int)level;

@end
