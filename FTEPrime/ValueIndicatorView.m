//
//  ValueIndicatorView.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/27/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "ValueIndicatorView.h"

@implementation ValueIndicatorView

- (id)initWithValue:(NSString *)value andIndicator:(NSInteger)indicator andMaxWidth:(CGFloat)maxWidth
{
    self = [super init];
    if( !self )
    {
        return nil;
    }
    
    _value = value;
    _indicator = indicator;

    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.opaque = NO;
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 50, 50)];
    valueLabel.text = self.value;
    
    [valueLabel setFont:[UIFont systemFontOfSize:50]];
    [valueLabel sizeToFit];
    
    CGFloat xPoint = valueLabel.frame.size.width + valueLabel.frame.origin.x + 8;
    CGFloat yPoint = valueLabel.frame.size.height-14;
    UIImageView *indicatorImage = [[UIImageView alloc] initWithFrame:CGRectMake(xPoint, yPoint, 10, 10) ];
    
    if (indicator == 1)
    {
        indicatorImage.image = [UIImage imageNamed:@"DownRedArrow.png"];
    }
    else if (indicator == 2)
    {
        indicatorImage.image = [UIImage imageNamed:@"UpBlueArrow.png"];
    }
    else if (indicator == 3)
    {
        indicatorImage.image = [UIImage imageNamed:@"DownBlueArrow.png"];
    }
    else if (indicator == 4)
    {
        indicatorImage.image = [UIImage imageNamed:@"UpRedArrow.png"];
    }
    
    [self addSubview:valueLabel];
    [self addSubview:indicatorImage];
    self.frame = CGRectMake(0, 0, maxWidth, yPoint+indicatorImage.frame.size.height+8);
    
    valueLabel.textColor = [UIColor colorWithRed:0.17 green:0.59 blue:0.91 alpha:1.0];
    
    [valueLabel setShadowColor:[UIColor darkGrayColor]];
    [valueLabel setShadowOffset:CGSizeMake(0, -2)];
    valueLabel.center = CGPointMake(self.center.x-5, valueLabel.center.y);
    
    xPoint = valueLabel.frame.size.width + valueLabel.frame.origin.x + 4;
    yPoint = valueLabel.frame.size.height-14;
    
    indicatorImage.frame = CGRectMake(xPoint, yPoint, 10, 10);
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self sizeToFit];
    return self;
}

- (void)centralizeSubViews
{
    CGPoint oldCenter = [self.subviews[0] center];
    [self.subviews[0] setCenter:CGPointMake(self.center.x-26, [self.subviews[0] center].y)];
    [self.subviews[1] setCenter:CGPointMake([self.subviews[1] center].x + [self.subviews[0] center].x - oldCenter.x, [self.subviews[0] center].y)];
}

@end
