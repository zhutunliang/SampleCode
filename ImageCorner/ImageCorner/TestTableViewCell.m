//
//  TestTableViewCell.m
//  ImageCorner
//
//  Created by nemo on 2018/7/30.
//  Copyright © 2018年 hong. All rights reserved.
//

#import "TestTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+SGAddRoundCorner.h"

@interface TestTableViewCell()

@property (nonatomic ,strong) UIImageView *testImageView;

@end

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setUI];
    return self;
}

- (void)setUI
{
    self.testImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.contentView addSubview:self.testImageView];
}

- (void)setImageWithPath:(NSString *)path
{
    [self.testImageView addRoundedCornerWithRadius:10 size:CGSizeMake(100, 100) color:[UIColor whiteColor] completeBlock:^{
        [self.testImageView sd_setImageWithURL:[NSURL URLWithString:path] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
