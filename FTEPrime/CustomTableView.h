//
//  CustomTableView.h
//  FTEPrime
//
//  Created by Sujith Achuthan on 11/16/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableView : UIView

@property(nonatomic, strong)NSArray *rowTitles;
@property(nonatomic, strong)NSArray *columnTitles;
@property(nonatomic, strong)NSArray *data;

- (id)initWithValues:(NSDictionary*)dataDictionary;
- (void)startDrawing;

@end
