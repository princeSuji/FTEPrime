//
//  ThreeGridViewController.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 11/12/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import "ThreeGridViewController.h"

@interface ThreeGridViewController ()

@end

@implementation ThreeGridViewController

-(id)initWithItems:(NSDictionary*)component andKeys:(NSArray*) keys
{
    self = [super init];
    if( !self )
    {
        return nil;
    }
    
    _componentValues = component;
    _keys = keys;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat xPoint = 8;
    CGFloat maxWidth = 0;
    self.payperiodLabel.text = self.keys[0];
    self.ytdLabel.text = self.keys[1];
    self.thirdLabel.text = self.keys[2];
    
    CGSize payperiodConstraint = CGSizeMake(self.payperiodLabel.frame.size.width, 20000.0f);
    CGSize payperiodSize;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize payperiodBoundingBox = [self.payperiodLabel.text boundingRectWithSize:payperiodConstraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:self.payperiodLabel.font}
                                                  context:context].size;
    
    payperiodSize = CGSizeMake(ceil(payperiodBoundingBox.width), ceil(payperiodBoundingBox.height));
    
    CGSize ytdConstraint = CGSizeMake(self.ytdLabel.frame.size.width, 20000.0f);
    CGSize ytdSize;
    CGSize ytdBoundingBox = [self.ytdLabel.text boundingRectWithSize:ytdConstraint
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:@{NSFontAttributeName:self.ytdLabel.font}
                                                                context:context].size;
    
    ytdSize = CGSizeMake(ceil(ytdBoundingBox.width), ceil(ytdBoundingBox.height));
    
    CGSize thirdConstraint = CGSizeMake(self.thirdLabel.frame.size.width, 20000.0f);
    CGSize thirdSize;
    CGSize thirdBoundingBox = [self.thirdLabel.text boundingRectWithSize:thirdConstraint
                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                          attributes:@{NSFontAttributeName:self.thirdLabel.font}
                                                             context:context].size;
    
    thirdSize = CGSizeMake(ceil(thirdBoundingBox.width), ceil(thirdBoundingBox.height));
    
    for (NSString *currentKey in self.keys)
    {
        NSString *value = [self.componentValues valueForKey:currentKey];
        CGFloat fontSize = 50;
        
        CGRect r = [value boundingRectWithSize:CGSizeMake(200, 0)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                       context:nil];
        
        if (r.size.width>maxWidth)
        {
            maxWidth = r.size.width;
        }
        
    }
    maxWidth+=34;
    CGFloat maxHeight = MAX(MAX(payperiodSize.height, ytdSize.height), thirdSize.height);
    
    self.Title.text = [self.componentValues valueForKey:@"Label"];
    [self.payperiodLabel sizeToFit];
    [self.ytdLabel sizeToFit];
    //    self.payperiodCount.text = [self.componentValues valueForKey:@"PayPeriod_Count"];
    //    self.ytdLabel.text = [self.componentValues valueForKey:@"YTD_Value"];
    
    ValueIndicatorView *valueIndicator = [[ValueIndicatorView alloc] initWithValue:[self.componentValues valueForKey:self.keys[0]] andIndicator:[[self.componentValues valueForKey:@"Value_Change"] integerValue] andMaxWidth:maxWidth];
    valueIndicator.frame = CGRectMake(0, maxHeight + 8, valueIndicator.frame.size.width, valueIndicator.frame.size.height);
    
    [self.payperiodView addSubview:valueIndicator];
    
    self.payperiodView.frame = CGRectMake(xPoint, self.payperiodView.frame.origin.y, MAX(valueIndicator.frame.size.width, self.payperiodLabel.frame.size.width)+16, valueIndicator.frame.size.height+43);
    valueIndicator.center = CGPointMake(self.payperiodView.frame.size.width/2, valueIndicator.center.y);
    self.payperiodLabel.center = CGPointMake(valueIndicator.center.x, self.ytdLabel.center.y);
    
    xPoint = xPoint + self.payperiodView.frame.size.width + 8;
    self.payperiodView.opaque = NO;
    
    ValueIndicatorView *ytdValueIndicator = [[ValueIndicatorView alloc] initWithValue:[self.componentValues valueForKey:self.keys[1]] andIndicator:[[self.componentValues valueForKey:@"YTD_Value_Change"] integerValue] andMaxWidth:maxWidth];
    
    ytdValueIndicator.frame = CGRectMake(0, maxHeight + 8, ytdValueIndicator.frame.size.width, ytdValueIndicator.frame.size.height);
    
    [self.ytdView addSubview:ytdValueIndicator];
    
    self.ytdView.frame = CGRectMake(xPoint, self.ytdView.frame.origin.y, MAX(ytdValueIndicator.frame.size.width,self.ytdLabel.frame.size.width)+16, ytdValueIndicator.frame.size.height+43);
    
    ytdValueIndicator.center = CGPointMake(self.ytdView.frame.size.width/2, ytdValueIndicator.center.y);
    self.ytdLabel.center=CGPointMake(ytdValueIndicator.center.x, self.ytdLabel.center.y);
    
    xPoint = xPoint + self.ytdView.frame.size.width + 8;
    self.ytdView.opaque = NO;
    
    ValueIndicatorView *thirdValueIndicator = [[ValueIndicatorView alloc] initWithValue:[self.componentValues valueForKey:self.keys[2]] andIndicator:[[self.componentValues valueForKey:@"Third_Value_Change"] integerValue] andMaxWidth:maxWidth];
    
    thirdValueIndicator.frame = CGRectMake(0, maxHeight + 8, thirdValueIndicator.frame.size.width, thirdValueIndicator.frame.size.height);
    
    [self.thirdView addSubview:thirdValueIndicator];
    [self.thirdLabel sizeToFit];
    
    self.thirdView.frame = CGRectMake(xPoint, self.thirdView.frame.origin.y, MAX(thirdValueIndicator.frame.size.width,self.thirdLabel.frame.size.width)+16, thirdValueIndicator.frame.size.height+43);
    
    thirdValueIndicator.center = CGPointMake(self.thirdView.frame.size.width/2, thirdValueIndicator.center.y);
    self.thirdLabel.center=CGPointMake(thirdValueIndicator.center.x, self.thirdLabel.center.y);
    
    self.thirdView.opaque = NO;
    
    self.view.frame = [self calculateViewFrame];
    self.Title.frame = CGRectMake(0, 0, self.view.frame.size.width, self.Title.frame.size.height);
    // Do any additional setup after loading the view from its nib.
}

- (CGRect)calculateViewFrame
{
    CGFloat width = self.payperiodView.frame.size.width + self.ytdView.frame.size.width + self.thirdView.frame.size.width + 32;
    CGFloat height = self.Title.frame.size.height + self.payperiodView.frame.size.height+self.payperiodView.frame.origin.y;
    
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
