//
//  TextInputView.m
//  DataCollection
//
//  Created by ChuanKai on 15/3/17.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "TextInputView.h"

@interface  TextInputView()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation TextInputView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self inilization];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
    }
    return self;
}

-(void)inilization{
    _label = [[UILabel alloc]init];
    _label.text = self.inputText;
    [self addSubview:_label];
    
    _textField = [[UITextField alloc]init];
    self.inputText = _textField.text;
    _textField.layer.borderWidth = 0.5;
    [self addSubview:_textField];
}

-(void)layoutSubviews{
    _textField.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
}

@end
