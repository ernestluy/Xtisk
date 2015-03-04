//
//  FoodDetailHeader.m
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "FoodDetailHeader.h"
#import "PublicDefine.h"
@implementation FoodDetailHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    return self;
}

-(void)setUIInit{
    self.labGoodNum.textColor = _rgb2uic(0xff6c0a, 1);
    
    self.labQs.textColor = _rgb2uic(0xef1717, 1);
    self.labTitle.textColor = _rgb2uic(0x3d3d3d, 1);
    self.labPj.textColor = _rgb2uic(0x808080, 1);
    self.labQs.layer.borderColor = _rgb2uic(0xef1717, 1).CGColor;//0xcecece
    self.labQs.layer.borderWidth = 1;
    self.labQs.layer.cornerRadius = 3;
    self.labContent.textColor = _rgb2uic(0x404040, 1);
    self.labYysj.textColor = _rgb2uic(0x404040, 1);
    
    self.imgHeader.backgroundColor = _rgb2uic(0xf6f6f6, 1);
}
/*
 @property(nonatomic,weak)IBOutlet UILabel *labGoodNum;
 @property(nonatomic,weak)IBOutlet UILabel *labTitle;
 @property(nonatomic,weak)IBOutlet UILabel *labPj;
 @property(nonatomic,weak)IBOutlet UILabel *labQs;
 @property(nonatomic,weak)IBOutlet UILabel *labContent;
 @property(nonatomic,weak)IBOutlet UILabel *labYysj;
 @property(nonatomic,weak)IBOutlet UIButton *btnCommend;
 @property(nonatomic,weak)IBOutlet UIButton *btnGood;
 */
-(void)setStoreDetailData:(StoreItem *)storeItem{
    self.labGoodNum.text = [NSString stringWithFormat:@"%d",storeItem.favoritePeople];
    self.labTitle.text = storeItem.storeName;
    self.labPj.text = [NSString stringWithFormat:@"评价%d",storeItem.reviews];
    self.labQs.text = [NSString stringWithFormat:@"%@元起送",storeItem.strPrice];;//storeItem.strPrice;
    if (storeItem.storeInfo) {
        self.labContent.text = storeItem.storeInfo;
    }
    if (storeItem.storeOpenTime) {
        self.labYysj.text = [NSString stringWithFormat:@"营业时间:%@-%@",storeItem.storeOpenTime,storeItem.storeCloseTime];
    }

    [self setFavoriteStatus:storeItem.isFavorite];
}

//设置点赞状态
-(void)setFavoriteStatus:(BOOL)b{
    if (b) {
        [self.btnGood setImage:[UIImage imageNamed:@"good_commend_yes"] forState:UIControlStateNormal];
        [self.btnGood setTitleColor:_rgb2uic(0xff6c0a, 1) forState:UIControlStateNormal];
    }else{
        [self.btnGood setImage:[UIImage imageNamed:@"good_commend"] forState:UIControlStateNormal];
        [self.btnGood setTitleColor:defaultTextGrayColor forState:UIControlStateNormal];
    }
}
@end
