//
//  ViewController.m
//  RecordsOfConsumption
//
//  Created by xuhui on 15/6/4.
//  Copyright (c) 2015年 xuhui. All rights reserved.
//

#import "AddViewController.h"
#import "RESideMenu.h"
#import "Navbar.h"
#import "NSString+Format.h"

#import "AddCollectionViewCell.h"
#import "APLPositionToBoundsMapping.h"

#import "SEFilterControl.h"

@interface AddViewController ()<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    UIView *_textFieldView;
    UITextField *_moneyTextField;
    
    
    UICollectionView *_collectionView;
    UIDynamicAnimator *_animator;
    
    SEFilterControl *_dayFilterControl;
    SEFilterControl *_timeFilterControl;
    
    UIButton *_addButton;
}

@end

@implementation AddViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Title";
    
//    [self.navigationItem setLeftItemWithTarget:self action:@selector(presentLeftMenuViewController:) image:@""];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(presentLeftMenuViewController:) title:@"Menu"];
    
    
    _textFieldView = [UIView new];
    _textFieldView.backgroundColor = [UIColor orangeColor];
    _textFieldView.layer.cornerRadius = 30.0f;
    [self.view addSubview:_textFieldView];
    
    [_textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(20+NavigationBar_HEIGHT));
        make.height.equalTo(@60);
        make.width.equalTo(@240);
        make.centerX.equalTo(self.view);
    }];
    
    _moneyTextField = [UITextField new];
    _moneyTextField.delegate = self;
    [_moneyTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _moneyTextField.textAlignment = NSTextAlignmentCenter;
    _moneyTextField.font = [UIFont systemFontOfSize:40.0f];
    _moneyTextField.layer.cornerRadius = 30.0f;
    _moneyTextField.textColor = [UIColor whiteColor];
    _moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [_textFieldView addSubview:_moneyTextField];
    
    [_moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_textFieldView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    //中间的Tag
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//UICollectionViewScrollDirectionHorizontal
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_collectionView registerClass:[AddCollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = CLEARCOLOR;
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_textFieldView.mas_bottom).and.equalTo(@20);
        make.height.equalTo(@270);
        make.leading.equalTo(@20);
    }];
    
    
    //今、昨、前
    _dayFilterControl = [[SEFilterControl alloc] initWithFrame:CGRectMake(0, 0, 300, 44) titles:[NSArray arrayWithObjects:@"", @"", @"", @"", nil]];
    _dayFilterControl.icons = [NSArray arrayWithObjects:@"早上", @"中午", @"下午", @"晚上", nil];
    [self.view addSubview:_dayFilterControl];
    
    [_dayFilterControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom).and.equalTo(@20);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@44);
        make.width.equalTo(@300);
    }];
    
    
    //早、中、下、晚
    _timeFilterControl = [[SEFilterControl alloc] initWithFrame:CGRectMake(0, 0, 300, 44) titles:[NSArray arrayWithObjects:@"", @"", @"", @"", nil]];
    _timeFilterControl.icons = [NSArray arrayWithObjects:@"早上", @"中午", @"下午", @"晚上", nil];
    [self.view addSubview:_timeFilterControl];
    
    [_timeFilterControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dayFilterControl.mas_bottom).and.equalTo(@20);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@44);
        make.width.equalTo(@300);
    }];
    
    //确定按钮
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setBackgroundColor:[UIColor redColor]];
    [_addButton setTitle:@"ADD" forState:UIControlStateNormal];
    [self.view addSubview:_addButton];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).and.mas_equalTo(-20);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];

}

#pragma mark - Text Field Change
- (void) textFieldDidChange:(id) sender
{
    UITextField *field = (UITextField *)sender;
    NSString *tempStr = field.text;

    NSRange foundObj = [tempStr rangeOfString:@"." options:NSCaseInsensitiveSearch];
    NSLog(@"%ld", foundObj.length);
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL isTrue = YES;
    
    if (textField.text.length == 0) {
        //第一位不能为小数点
        if ([string isEqualToString:@"."]) {
            isTrue = NO;
        }
    } else {
        //如果发现输入的是小数点，从之前的数据中查找有没有小数点
        if ([string isEqualToString:@"."]) {
            NSRange foundObj = [textField.text rangeOfString:@"." options:NSCaseInsensitiveSearch];
            if (foundObj.length > 0) {
                isTrue = NO;
            }
        }
    }
    return isTrue;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    AddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell sizeToFit];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(55, 55);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddCollectionViewCell *cell = (AddCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell viewAnimationAtIndexPath:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
