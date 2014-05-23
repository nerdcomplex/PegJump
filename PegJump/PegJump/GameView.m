//
//  GameView.m
//  PegJumper
//
//  Created by Adham Meguid on 5/18/14.
//  Copyright (c) 2014 Organization XIII. All rights reserved.
//

#import "GameView.h"
#import "PegData.h"
#import "PegButton.h"
#import "BoardView.h"
#import "GameRecord.h"
#import "EndGameViewController.h"
#import "MainViewController.h"

@implementation GameView

- (id)initWithFrame:(CGRect)frame : (NSString *) shape : (int) size
{
    self = [super initWithFrame:frame];
    if (self) {
        self.data = [[PegData alloc] init:shape :size];
        self.started = [shape isEqualToString:@"Plus"];
        self.possibleMoves = [NSArray array];
        self.currentPeg = [NSArray array];
        self.recorder = [[GameRecord alloc] initWithFrame:frame];
        self.timer = nil;
        self.time = 0;
        self.opaque = NO;
    }
    return self;
}

- (id)initShortCut:(CGRect)frame : (PegData *)data
{
    self = [super initWithFrame:frame];
    self.data = data;
    self.started = [[data format] isEqualToString:@"Plus"];
    self.possibleMoves = [NSArray array];
    self.currentPeg = [NSArray array];
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
/*    NSLog(@"%@",[(MainViewController *)[[self superview] nextResponder] background]);
    self.backgroundColor = [(MainViewController *)[[self superview] nextResponder] background];
    NSLog(@"%@",self.backgroundColor);
*/
    //Clear the screen
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *background = [[UIView alloc] initWithFrame:self.frame];
    [background setBackgroundColor:[(MainViewController *)[[self superview] nextResponder] background]];
    [self addSubview:background];
    
    //Give instructions
    UILabel *instructions = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, rect.size.width-20, 60)];
    [instructions setTextAlignment:NSTextAlignmentCenter];
    if (!self.started) {
        [instructions setText:@"Remove a peg to begin"];
    }
    else if ([self.data isDone]) {
    }
    else if ([self.currentPeg count]==0) {
        [instructions setText:@"Tap a peg to move it"];
    }
    else {
        [instructions setNumberOfLines:2];
        [instructions setFont:[UIFont systemFontOfSize:15]];
        [instructions setText:@"Tap a location to move there, or tap outside the board to move a different peg"];
    }
    [self addSubview:instructions];
    
    //TableView is a subview that holds the game board and its pegs. Its exact location and size depend on its shape.
    BoardView *table;
    if ([[self.data format] isEqualToString:@"Triangle"]) {
         table = [[BoardView alloc] initWithFrame:CGRectMake(
                                                             (rect.size.width - 60*[[self.data data] count])/2,
                                                             (rect.size.height - 40*[[self.data data] count])/2,
                                                             60*[[self.data data] count],
                                                             40*[[self.data data] count]) : [self.data format]];
    }
    else if ([[self.data format] isEqualToString:@"Plus"]) {
        table = [[BoardView alloc] initWithFrame:CGRectMake((rect.size.width - 40*[[self.data data] count])/2,
                                                            (rect.size.height - 40*[[self.data data] count])/2,
                                                            40*[[self.data data] count],
                                                            40*[[self.data data] count]) : [self.data format]];
    }
    
    for (int row=0; row<[[self.data data] count]; row++) {
        for (int col=0; col<[[[self.data data] objectAtIndex:row] count]; col++) {
            //Frame contains the peg to be added. Its size and location depends on the shape.
            CGRect frame;
            if ([[self.data format] isEqualToString:@"Triangle"]) {
                int newcol = [[self.data data] count]-[[[self.data data] objectAtIndex:row] count]+2*col;
                frame = CGRectMake(30*newcol+15, 40*row, 30, 40);
            }
            if ([[self.data format] isEqualToString:@"Plus"]) {
                frame = CGRectMake(40*col, 40*row, 40, 40);
            }
            
            //Different colors indicate different things. If the code doesn't make it clear what each one represents, just play through a single game.
            if ([[self.data getPeg:row :col] isEqualToString:@"1"]) {
                if ([self.currentPeg isEqual:[NSArray arrayWithObjects:[NSNumber numberWithInt:row],[NSNumber numberWithInt:col], nil]]) {
                    [table addSubview:[[PegButton alloc] initWithFrame:frame :@"Light Blue Dot" :row :col :self]];
                }
                else {
                    [table addSubview:[[PegButton alloc] initWithFrame:frame :@"Blue Dot" :row :col :self]];
                }
            }
            else if ([[self.data getPeg:row :col] isEqualToString:@"0"]) {
                if ([self.possibleMoves containsObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:row],[NSNumber numberWithInt:col], nil]]) {
                    [table addSubview:[[PegButton alloc] initWithFrame:frame :@"Purple Dot" :row :col :self]];
                }
                else {
                    [table addSubview:[[PegButton alloc] initWithFrame:frame :@"Black Dot" :row :col :self]];
                }
            }
        }
    }
    [self addSubview:table];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-20, 30, 20)];
    if (self.time<60) {
        timeLabel.text = [NSString stringWithFormat:@"%d",self.time];
    }
    else if (self.time<3600) {
        timeLabel.text = [NSString stringWithFormat:@"%d:%d",self.time/60,self.time%60];
    }
    else {
        timeLabel.text = [NSString stringWithFormat:@"%d:%d:%d",self.time/3600,(self.time%3600)/60,self.time%60];
    }
    [self addSubview:timeLabel];
    
    if (self.started && [self.data isDone]) {
        [self.timer invalidate];
        self.timer = nil;
        [(MainViewController *)[[self superview] nextResponder] endGame:self.time
                                                                       :[self.data numPegs]==1 :[self.data numPegs]];
        [self.recorder movePeg:[self.data copy] :[NSArray array]];
        
        UIView *endScreenContainer = [[UIButton alloc] initWithFrame:self.frame];
        [endScreenContainer setBackgroundColor:[UIColor clearColor]];
        [[((MainViewController *)[[self superview] nextResponder]) endVC] setWin:[self.data numPegs]==1];
        [[((MainViewController *)[[self superview] nextResponder]) endVC] clearView];
        [[((MainViewController *)[[self superview] nextResponder]) endVC] viewDidLoad];
        UIView *endScreen = [[((MainViewController *)[[self superview] nextResponder]) endVC] view];
        [endScreen setBackgroundColor:[UIColor colorWithRed:1 green:.5 blue:0 alpha:.7]];
        [endScreenContainer addSubview:endScreen];
        [self addSubview:endScreenContainer];
        [self setNeedsDisplay];
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:1];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromBottom];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [[endScreen layer] addAnimation:animation forKey:@"SwitchToView1"];
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.possibleMoves = [[NSArray alloc] init];
    self.currentPeg = [[NSArray alloc] init];
    [self setNeedsDisplay];
}

- (void) startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTick:)
                                                  userInfo:nil repeats:YES];
}

- (void) onTick: (NSTimer *) timer
{
    self.time++;
    [self setNeedsDisplay];
}

@end
