//
//  CZRetweetView.m
//  传智微博
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZRetweetView.h"

#import "CZStatus.h"
#import "CZStatusFrame.h"
#import "CZPhotosView.h"

@interface CZRetweetView ()

// 昵称
@property (nonatomic, weak) UILabel *nameView;


// 正文
@property (nonatomic, weak) UILabel *textView;

// 配图
@property (nonatomic, weak) CZPhotosView *photosView;

@end

@implementation CZRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
  
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor blueColor];
    nameView.font = CZNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    

    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CZTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    CZPhotosView *photosView = [[CZPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatusF:(CZStatusFrame *)statusF
{
    _statusF = statusF;
    
    
    CZStatus *status = statusF.status;
    // 昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text = status.retweetName;
    
    // 正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    // 配图
    _photosView.frame = statusF.retweetPhotosFrame;
    
    // 注意：这里一定要转让转发微博的配图数
    _photosView.pic_urls = status.retweeted_status.pic_urls;

}

@end
