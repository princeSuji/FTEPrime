//
//  EfficiencyIndicator.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/27/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "EfficiencyIndicator.h"

@implementation EfficiencyIndicator

-(id)initWithValue:(NSArray*)components
{
    self = [super init];
    if( !self )
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.opaque = NO;
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 4, 50, 50)];
    valueLabel.text = components[0];
    
    [valueLabel setFont:[UIFont systemFontOfSize:50]];
    [valueLabel sizeToFit];
    
    CGFloat yPoint = valueLabel.frame.origin.y + valueLabel.frame.size.height;
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, yPoint, 50, 50)];
    descriptionLabel.text = components[1];
    
    [descriptionLabel sizeToFit];
    [self addSubview:valueLabel];
    [self addSubview:descriptionLabel];
    self.frame = CGRectMake(0, 0, MAX(valueLabel.frame.size.width, descriptionLabel.frame.size.width)+16, yPoint+descriptionLabel.frame.size.height);
    
    valueLabel.textColor = [UIColor colorWithRed:0.17 green:0.59 blue:0.91 alpha:1.0];
    
    [valueLabel setShadowColor:[UIColor darkGrayColor]];
    [valueLabel setShadowOffset:CGSizeMake(0, -2)];
    valueLabel.center = CGPointMake(self.center.x, valueLabel.center.y);
    
    descriptionLabel.textColor = [UIColor colorWithRed:0.17 green:0.59 blue:0.91 alpha:1.0];
    descriptionLabel.center = CGPointMake(self.center.x, descriptionLabel.center.y);
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    return self;
}

- (void)centralizeSubViews
{
    for (UIView *currentView in self.subviews)
    {
        currentView.center = CGPointMake(self.center.x-8, currentView.center.y);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
