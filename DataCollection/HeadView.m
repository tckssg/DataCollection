//
//  HeadView.m
//  DataCollection
//
//  Created by ChuanKai on 15/3/16.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "HeadView.h"
#import "MenuGroup.h"

@interface  HeadView(){
    UIButton *_bgButton;
    UILabel *_numLabel;
    UIButton *_addButton;
    UIButton *_infoButton;
    UIImageView *_bgView;
}

@end

@implementation HeadView
+(instancetype)headViewWithTableView:(UITableView *)tableView{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[HeadView alloc]initWithReuseIdentifier:headIdentifier];
    }
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"buddy_header_bg"];
        [self addSubview:_bgView];
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textAlignment = NSTextAlignmentRight;
        //[self addSubview:numLabel];
        _numLabel = numLabel;
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"add_btn"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.hidden = YES;
        
        _infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_infoButton setImage:[UIImage imageNamed:@"add_btn"] forState:UIControlStateNormal];
        [_infoButton addTarget:self action:@selector(infoButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        _infoButton.hidden = YES;
        
        //_addButton.tintColor = [UIColor greenColor];
        [self addSubview:_addButton];
        [self addSubview:_infoButton];
    }
    return self;
}

-(void)addButtonClicked:(UIButton *)sender{
    if (self.addButtonDidClicked) {
        self.addButtonDidClicked((UIButton *)sender, self.tableId);
    }
}

-(void)infoButtonDidClicked:(UIButton *)sender{
    if (self.infoButtonDidClicked) {
        self.infoButtonDidClicked(sender, self.tableId);
    }
}

-(void)setMenuGroup:(MenuGroup *)menuGroup{
    _menuGroup = menuGroup;
    [_bgButton setTitle:menuGroup.mainMenu forState:UIControlStateNormal];
}

- (void)headBtnClick
{
    _menuGroup.opened = !_menuGroup.isOpened;
    if ([_delegate respondsToSelector:@selector(headViewDidClicked)]) {
        [_delegate headViewDidClicked];
    }
}

- (void)didMoveToSuperview
{
//    [UIView animateWithDuration:0.2 animations:^{
//        _bgButton.imageView.transform = _menuGroup.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
//    }];
    _bgButton.imageView.transform = _menuGroup.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
    _addButton.hidden = !_menuGroup.isOpened;
    _infoButton.hidden = !_menuGroup.isOpened;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _addButton .frame = CGRectMake(0, 0, 50, 50);
    _addButton.center = CGPointMake(self.bounds.size.width - 25, self.bounds.size.height/2);
    
    _infoButton .frame = CGRectMake(0, 0, 50, 50);
    _infoButton.center = CGPointMake(self.bounds.size.width - 85, self.bounds.size.height/2);
    
    _bgButton.frame = (CGRect){self.bounds.origin, self.bounds.size.width - 30, self.bounds.size.height};
    _bgView.frame = self.bounds;
}
@end