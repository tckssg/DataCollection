//
//  CKCheckBox.m
//  XianBIngJie
//
//  Created by ChuanKai on 15/1/23.
//  Copyright (c) 2015年 lsk. All rights reserved.
//

#import "CKCheckBox.h"

#define CK_CHECK_ICON_WH                    (15.0)
#define CK_ICON_TITLE_MARGIN                (5.0)
@implementation CKCheckBox
- (instancetype)initWithDelegate:(id)delegate{
    self = [super init];
    if (self) {
        _delegate = delegate;
        self.exclusiveTouch = YES;
        [self inilization];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self inilization];
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        [self inilization];
    }
    return self;
}

-(void)inilization{
    [self setImage:[UIImage imageNamed:@"uncheck_icon"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)checkboxBtnChecked {
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, (CGRectGetHeight(contentRect) - CK_CHECK_ICON_WH)/2.0, CK_CHECK_ICON_WH, CK_CHECK_ICON_WH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(CK_CHECK_ICON_WH + CK_ICON_TITLE_MARGIN+2, 2,
                      CGRectGetWidth(contentRect) - CK_CHECK_ICON_WH - CK_ICON_TITLE_MARGIN-4,
                      CGRectGetHeight(contentRect)-4);
}
@end
