//
//  AddCollectionViewCell.m
//  RecordsOfConsumption
//
//  Created by xuhui on 15/6/8.
//  Copyright (c) 2015年 xuhui. All rights reserved.
//

#import "AddCollectionViewCell.h"

#define ItemViewSize 55

@interface AddCollectionViewCell()
{
    UIImageView *_imageView;
    UILabel *_titleLab;
}

@end

@implementation AddCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageView = [UIImageView new];
        _imageView.image = TTIMAGE(@"bug");
//        _imageView.layer.cornerRadius = frame.size.width/2.0f;
//        _imageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (void)viewAnimationAtIndexPath:(NSIndexPath *)path
{
    _imageView.image = TTIMAGE(@"bug-select");
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.equalTo(@(ItemViewSize + 15));
        make.height.equalTo(@(ItemViewSize + 15));
    }];
    [_imageView layoutIfNeeded];
    
    
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.equalTo(@(ItemViewSize));
        make.height.equalTo(@(ItemViewSize));
    }];
    [UIView animateWithDuration:3 delay:0 usingSpringWithDamping:.1 initialSpringVelocity:8 options:UIViewAnimationOptionTransitionNone animations:^{
        
        [_imageView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
    }];
    
}

@end
