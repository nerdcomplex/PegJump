//
//  GameRecord.m
//  PegJumper
//
//  Created by brshapiro on 5/19/14.
//
//

#import "GameRecord.h"
#import "PegData.h"
#import "GameView.h"
#import "MainViewController.h"

@implementation GameRecord
NSMutableArray *states;
NSMutableArray *movedPegs;
int t;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        states = [NSMutableArray array];
        movedPegs = [NSMutableArray array];
        t = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void) movePeg: (PegData *)state : (NSArray *)peg
{
    [states addObject:state];
    [movedPegs addObject:peg];
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"%d",t);

    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *background = [[UIView alloc] initWithFrame:self.frame];
    [background setBackgroundColor:[(MainViewController *)[[self superview] nextResponder] background]];
    [self addSubview:background];
    
    GameView *gameState = [[GameView alloc] initShortCut:rect :[states objectAtIndex:t/2]];
    if (t%2==1) {
        [gameState setCurrentPeg:[movedPegs objectAtIndex:t/2]];
    }
    [gameState drawRect:rect];
    [self addSubview:[[gameState subviews] objectAtIndex:2]];
    [self addSubview:[[UIButton alloc] initWithFrame:rect]];
    
    if (t < 2*[states count]-1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, rect.size.width-20, 60)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:@"Replaying saved game"];
        [self addSubview:label];

        t++;
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:1];
    }
    else {
        t=0;
        NSLog(@"%d",t);
        [((MainViewController *)[[self superview] nextResponder]).view addSubview:[
                                                                                   (MainViewController *)[[self superview] nextResponder] statVC].view];
        [self removeFromSuperview];
    }

}

@end