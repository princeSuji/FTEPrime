//
//  ValueIndicatorView.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 8/27/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValueIndicatorView : UIView

- (id)initWithValue:(NSString *)value andIndicator:(NSInteger)indicator andMaxWidth:(CGFloat)maxWidth;
- (void)centralizeSubViews;

@property (strong)NSString *value;
@property (assign)NSInteger indicator;

@end
