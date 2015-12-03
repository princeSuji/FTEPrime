//
//  ThreeBoxGridViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/27/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "ThreeBoxGridViewController.h"

@interface ThreeBoxGridViewController ()

@end

@implementation ThreeBoxGridViewController

-(id)initWithItems:(NSDictionary*)component
{
    self = [super init];
    if( !self )
    {
        return nil;
    }
    
    _components = component;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = [self.components valueForKey:@"Label"];
    
    CGFloat xPoint = 8;
    CGFloat maxWidth = 0;
    
    for (NSString *currentKey in self.components)
    {
        NSString *value = [self.components valueForKey:currentKey];
        CGFloat fontSize = 50;
        
        if ([currentKey containsString:@"Label"])
        {
            fontSize = 17;
        }
        
        CGRect r = [value boundingRectWithSize:CGSizeMake(200, 0)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                         context:nil];
        
        if (r.size.width>maxWidth)
        {
            maxWidth = r.size.width;
        }
        
    }

    //First Box
    EfficiencyIndicator *firstBox = [[EfficiencyIndicator alloc] initWithValue:@[[self.components valueForKey:@"Value1"],[self.components valueForKey:@"Value1Label"] ]];
    firstBox.frame = CGRectMake(8, 8, maxWidth+16, firstBox.frame.size.height);
    
    [self.firstBox addSubview:firstBox];
    self.firstBox.frame = CGRectMake(xPoint, self.firstBox.frame.origin.y, firstBox.frame.size.width+16, firstBox.frame.size.height+16);
    self.firstBox.opaque = NO;
    
    xPoint = xPoint+self.firstBox.frame.size.width + 8;
    
    //Second Box
    EfficiencyIndicator *secondBox = [[EfficiencyIndicator alloc] initWithValue:@[[self.components valueForKey:@"Value2"],[self.components valueForKey:@"Value2Label"] ]];
    secondBox.frame = CGRectMake(8, 8, maxWidth+16, secondBox.frame.size.height);
    
    [self.secondBox addSubview:secondBox];
    self.secondBox.frame = CGRectMake(xPoint, self.secondBox.frame.origin.y, secondBox.frame.size.width+16, secondBox.frame.size.height+16);
    self.secondBox.opaque = NO;
    
    xPoint = xPoint+self.secondBox.frame.size.width + 8;
    
    //Second Box
    EfficiencyIndicator *thirdBox = [[EfficiencyIndicator alloc] initWithValue:@[[self.components valueForKey:@"Value3"],[self.components valueForKey:@"Value3Label"] ]];
    thirdBox.frame = CGRectMake(8, 8, maxWidth+16, thirdBox.frame.size.height);
    
    [self.thirdBox addSubview:thirdBox];
    self.thirdBox.frame = CGRectMake(xPoint, self.thirdBox.frame.origin.y, thirdBox.frame.size.width+16, thirdBox.frame.size.height+16);
    self.thirdBox.opaque = NO;

    self.view.frame = [self calculateViewFrame];
    self.titleLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, self.titleLabel.frame.size.height);
    
    [firstBox centralizeSubViews];
    [secondBox centralizeSubViews];
    [thirdBox centralizeSubViews];
    // Do any additional setup after loading the view from its nib.
}

- (CGRect)calculateViewFrame
{
    CGFloat width = self.firstBox.frame.size.width + self.secondBox.frame.size.width + self.thirdBox.frame.size.width + 32;
    CGFloat height = self.titleLabel.frame.size.height + self.firstBox.frame.size.height+self.firstBox.frame.origin.y;
    
    CGRect newSize = CGRectMake(0, 0, width, height);
    
    return  newSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
