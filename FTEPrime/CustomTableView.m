//
//  CustomTableView.m
//  FTEPrime
//
//  Created by Sujith Achuthan on 11/16/15.
//  Copyright © 2015 Sujith Achuthan. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithValues:(NSDictionary*)dataDictionary
{
    self = [super init];
    
    if (!self)
    {
        return nil;
    }

    _rowTitles = [dataDictionary valueForKey:@"rowTitles"];
    _columnTitles = [dataDictionary valueForKey:@"columnTitles"];
    _data = [dataDictionary valueForKey:@"data"];
    
    return self;
}
-(void)startDrawing
{
    CGFloat columnMaxHeight = 0.0;
    CGFloat columnMaxWidth = 0.0;
    CGFloat maxHeight = 0.0;
    CGFloat rowMaxHeight = 0.0;
    CGFloat rowMaxWidth = 0.0;
    CGFloat fontSize = 21;
    
    NSInteger xPoint = 0;
    NSInteger yPoint = 8;
    
    for (NSString *currentValue in self.columnTitles)
    {
        CGRect r = [currentValue boundingRectWithSize:CGSizeMake(200, 0)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize]}
                                       context:nil];
        
        if (r.size.width>columnMaxWidth)
        {
            columnMaxWidth = r.size.width;
        }
        
        if (r.size.height>columnMaxHeight)
        {
            columnMaxHeight = r.size.height;
        }
        
    }
    
    for (NSString *currentValue in self.rowTitles)
    {
        CGRect r = [currentValue boundingRectWithSize:CGSizeMake(200, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize]}
                                              context:nil];
        
        if (r.size.width>rowMaxWidth)
        {
            rowMaxWidth = r.size.width;
        }
        
        if (r.size.height>rowMaxHeight)
        {
            rowMaxHeight = r.size.height;
        }
    }
    
    maxHeight = MAX(rowMaxHeight, columnMaxHeight);
    columnMaxWidth += 16;
    rowMaxWidth += 90;
    
    columnMaxWidth = MAX(columnMaxWidth, 30);
    
    BOOL isColumnHeading = YES;
    
    int i =0;
    
    for (NSString *currentRowTitle in self.rowTitles)
    {
        CGRect rowTitleRect = CGRectMake(xPoint, yPoint, rowMaxWidth, maxHeight);
        UILabel *rowHeading = [self titleWithRect:rowTitleRect andText:currentRowTitle];
        
        [self addSubview:rowHeading];
        
        xPoint = xPoint + rowMaxWidth + 5;
        
        if (isColumnHeading == YES)
        {
            for (NSString *currentColumnTitle in self.columnTitles)
            {
                CGRect columnTitleRect = CGRectMake(xPoint, yPoint, columnMaxWidth , maxHeight);
                UILabel *colHeading = [self titleWithRect:columnTitleRect andText:currentColumnTitle];
                
                [self addSubview:colHeading];
                
                xPoint = xPoint + columnMaxWidth + 1;
            }
            
            isColumnHeading = NO;
            yPoint += 4;
        }
        else
        {
            int i =0;
            for (NSString *currentColumnValue in [self.data objectAtIndex:i])
            {
                CGRect dataRect = CGRectMake(xPoint, yPoint, columnMaxWidth , maxHeight);
                UILabel *colValue = [self valueWithRect:dataRect andText:currentColumnValue];
                
                [self addSubview:colValue];
                
                xPoint = xPoint + columnMaxWidth + 1;
            }
        }
        
        xPoint = 0;
        yPoint = yPoint + maxHeight + 1;
        i++;
    }
    
    self.frame = CGRectMake(0,0,xPoint + 8, yPoint + 8);
}

- (UILabel *)titleWithRect:(CGRect)frameValues andText:(NSString *)titleText
{
    UILabel *columnTitleLabel = [[UILabel alloc] initWithFrame:frameValues];
    
    columnTitleLabel.backgroundColor = [UIColor colorWithRed:60/255.f green:170/255.f blue:134/255.f alpha:1];
    columnTitleLabel.text = titleText;
    UIFont *lableFont = [UIFont systemFontOfSize:21 weight:UIFontWeightBold];
    
    columnTitleLabel.font = lableFont;
    columnTitleLabel.textColor = [UIColor whiteColor];
    columnTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    return  columnTitleLabel;
}

- (UILabel *)valueWithRect:(CGRect)frameValues andText:(NSString *)valueText
{
    UILabel *columnValueLabel = [[UILabel alloc] initWithFrame:frameValues];
    
    columnValueLabel.backgroundColor = [UIColor colorWithRed:158/255.f green:224/255.f blue:172/255.f alpha:1];
    columnValueLabel.text = valueText;
    UIFont *lableFont = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    
    columnValueLabel.font = lableFont;
    columnValueLabel.textColor = [UIColor whiteColor];
    columnValueLabel.textAlignment = NSTextAlignmentCenter;
    
    return  columnValueLabel;
}

@end
