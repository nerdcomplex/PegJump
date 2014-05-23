//
//  GameRecord.h
//  PegJumper
//
//  Created by brshapiro on 5/19/14.
//
//

#import <UIKit/UIKit.h>
#import "PegData.h"

@interface GameRecord : UIView

-(void) movePeg: (PegData *)state : (NSArray *)peg;

@end
