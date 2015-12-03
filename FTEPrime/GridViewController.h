//
//  GridViewController.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/26/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValueIndicatorView.h"

@interface GridViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (strong, nonatomic) IBOutlet ValueIndicatorView *payperiodView;
@property (strong, nonatomic) IBOutlet ValueIndicatorView *ytdView;
@property (weak, nonatomic) IBOutlet UILabel *payperiodLabel;
@property (weak, nonatomic) IBOutlet UILabel *ytdLabel;
@property (weak, nonatomic) NSArray *keys;

@property (strong, nonatomic)NSDictionary* componentValues;

-(id)initWithItems:(NSDictionary*)component andKeys:(NSArray*) keys;
@end
