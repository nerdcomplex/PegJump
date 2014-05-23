//
//  PreferencesViewController.m
//  PegJump
//
//  Created by brshapiro on 5/22/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import "PreferencesViewController.h"
#import "DropDownViewController.h"
#import "MainViewController.h"
#import "MusicDelegate.h"

@implementation PreferencesViewController
DropDownViewController *musicTemp;
DropDownViewController *boardThemeTemp;
DropDownViewController *pegColorTemp;
DropDownViewController *backgroundTemp;
DropDownViewController *boardShapeTemp;

- (id)init
{
    self = [super init];
    if (self) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, .75*self.view.frame.size.height/9.0,
                                                                   self.view.frame.size.width,
                                                                   self.view.frame.size.height/9.0)];
        UILabel *boardShape = [[UILabel alloc] initWithFrame:CGRectMake(20, 2*self.view.frame.size.height/9.0,
                                                                   self.view.frame.size.width/2,
                                                                   self.view.frame.size.height/9.0)];
        UILabel *background = [[UILabel alloc] initWithFrame:CGRectMake(20, 3*self.view.frame.size.height/9.0,
                                                                        self.view.frame.size.width/2,
                                                                        self.view.frame.size.height/9.0)];
        UILabel *pegColor = [[UILabel alloc] initWithFrame:CGRectMake(20, 4*self.view.frame.size.height/9.0,
                                                                        self.view.frame.size.width/2,
                                                                        self.view.frame.size.height/9.0)];
        UILabel *boardTheme = [[UILabel alloc] initWithFrame:CGRectMake(20, 5*self.view.frame.size.height/9.0,
                                                                        self.view.frame.size.width/2,
                                                                        self.view.frame.size.height/9.0)];
        UILabel *music = [[UILabel alloc] initWithFrame:CGRectMake(20, 6*self.view.frame.size.height/9.0,
                                                                        self.view.frame.size.width/2,
                                                                        self.view.frame.size.height/9.0)];

        [title setTextAlignment:NSTextAlignmentCenter];
        [title setText:@"Preferences"];
        [boardShape setText:@"Board Shape"];
        [background setText:@"Background"];
        [pegColor setText:@"Peg Color"];
        [boardTheme setText:@"Board Theme"];
        [music setText:@"Music"];
        
        [self.view addSubview:title];
        [self.view addSubview:boardShape];
        [self.view addSubview:background];
        [self.view addSubview:pegColor];
        [self.view addSubview:boardTheme];
        [self.view addSubview:music];
        
        
        
        
        self.musicSelect = [[DropDownViewController alloc]
                                               init:[NSMutableArray arrayWithObjects: @"Mute",@"Unmute", nil]];
        UIView *musicStore = [[UIView alloc] initWithFrame:
                              CGRectMake(self.view.frame.size.width/2, 6*self.view.frame.size.height/9.0-10,
                                         self.view.frame.size.width/2, 62)];
        [self addChildViewController:self.musicSelect];
        [self.musicSelect didMoveToParentViewController:self];
        [musicStore addSubview:self.musicSelect.view];
        [self.view addSubview:musicStore];
        
        self.boardThemeSelect = [[DropDownViewController alloc]
                                                    init:[NSMutableArray arrayWithObjects: @"Wooden",@"Metal", nil]];
        UIView *boardThemeStore = [[UIView alloc] initWithFrame:
                                   CGRectMake(self.view.frame.size.width/2, 5*self.view.frame.size.height/9.0-10,
                                              self.view.frame.size.width/2, 62)];
        [self addChildViewController:self.boardThemeSelect];
        [self.boardThemeSelect didMoveToParentViewController:self];
        [boardThemeStore addSubview:self.boardThemeSelect.view];
        [self.view addSubview:boardThemeStore];
        
        self.pegColorSelect = [[DropDownViewController alloc]
                                                  init:[NSMutableArray arrayWithObjects:
                                                        @"Blue",@"Red",@"Green",@"Yellow", nil]];
        UIView *pegColorStore = [[UIView alloc] initWithFrame:
                                 CGRectMake(self.view.frame.size.width/2, 4*self.view.frame.size.height/9.0-10,
                                            self.view.frame.size.width/2, 62)];
        [self addChildViewController:self.pegColorSelect];
        [self.pegColorSelect didMoveToParentViewController:self];
        [pegColorStore addSubview:self.pegColorSelect.view];
        [self.view addSubview:pegColorStore];
        
        self.backgroundSelect = [[DropDownViewController alloc]
                                                    init:[NSMutableArray arrayWithObjects:
                                                          @"White",@"Red",@"Blue",@"Green", nil]];
        UIView *backgroundStore = [[UIView alloc] initWithFrame:
                                   CGRectMake(self.view.frame.size.width/2, 3*self.view.frame.size.height/9.0-10,
                                              self.view.frame.size.width/2, 62)];
        [self addChildViewController:self.backgroundSelect];
        [self.backgroundSelect didMoveToParentViewController:self];
        [backgroundStore addSubview:self.backgroundSelect.view];
        [self.view addSubview:backgroundStore];
        
        self.boardShapeSelect = [[DropDownViewController alloc]
                                                    init:[NSMutableArray arrayWithObjects:@"Triangle",@"Plus", nil]];
        UIView *boardShapeStore = [[UIView alloc] initWithFrame:
                                   CGRectMake(self.view.frame.size.width/2, 2*self.view.frame.size.height/9.0-10,
                                              self.view.frame.size.width/2, 62)];
        [self addChildViewController:self.boardShapeSelect];
        [self.boardShapeSelect didMoveToParentViewController:self];
        [boardShapeStore addSubview:self.boardShapeSelect.view];
        [self.view addSubview:boardShapeStore];
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    musicTemp = [self.musicSelect copy];
    boardThemeTemp = [self.boardThemeSelect copy];
    pegColorTemp = [self.pegColorSelect copy];
    backgroundTemp = [self.backgroundSelect copy];
    boardShapeTemp = [self.boardShapeSelect copy];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DropDownViewController *temp = self.opened;
    self.opened = nil;
    [temp collapse];
}

- (IBAction)save:(id)sender
{
    ((MainViewController *)[self parentViewController]).boardShape = [self.boardShapeSelect.options objectAtIndex:0];
    ((MainViewController *)[self parentViewController]).boardTheme = [self.boardThemeSelect.options objectAtIndex:0];
    
    ((MainViewController *)[self parentViewController]).background = [UIColor performSelector:
                           NSSelectorFromString([[[self.backgroundSelect.options objectAtIndex:0] lowercaseString] stringByAppendingString:@"Color"])];
    ((MainViewController *)[self parentViewController]).pegColor = [UIColor performSelector:
                           NSSelectorFromString([[[self.pegColorSelect.options objectAtIndex:0] lowercaseString] stringByAppendingString:@"Color"])];
    
    if (((MainViewController *)[self parentViewController]).music == nil && [[self.musicSelect.options objectAtIndex:0] isEqualToString:@"Unmute"]) {
        ((MainViewController *)[self parentViewController]).music = [[MusicDelegate alloc] init];
    }
    
    [((MainViewController *)[self parentViewController]).view addSubview:self.returnTo.view];
    [self.view removeFromSuperview];
}

- (IBAction)cancel:(id)sender
{
    [self.musicSelect setOptions:[musicTemp options]];
    [self.musicSelect.tableView reloadData];
    [self.boardThemeSelect setOptions:[boardThemeTemp options]];
    [self.boardThemeSelect.tableView reloadData];
    [self.pegColorSelect setOptions:[pegColorTemp options]];
    [self.pegColorSelect.tableView reloadData];
    [self.backgroundSelect setOptions:[backgroundTemp options]];
    [self.backgroundSelect.tableView reloadData];
    [self.boardShapeSelect setOptions:[boardShapeTemp options]];
    [self.boardShapeSelect.tableView reloadData];
    
    [[self parentViewController].view addSubview:self.returnTo.view];
    [self.view removeFromSuperview];
}

@end
