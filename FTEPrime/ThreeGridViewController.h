//
//  ThreeGridViewController.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 11/12/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import "ViewController.h"
#import "ValueIndicatorView.h"

@interface ThreeGridViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (strong, nonatomic) IBOutlet ValueIndicatorView *payperiodView;
@property (strong, nonatomic) IBOutlet ValueIndicatorView *ytdView;
@property (strong, nonatomic) IBOutlet ValueIndicatorView *thirdView;
@property (weak, nonatomic) IBOutlet UILabel *payperiodLabel;
@property (weak, nonatomic) IBOutlet UILabel *ytdLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) NSArray *keys;

@property (strong, nonatomic)NSDictionary* componentValues;

-(id)initWithItems:(NSDictionary*)component andKeys:(NSArray*) keys;

@end
