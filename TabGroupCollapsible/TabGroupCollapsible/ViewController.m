//
//  ViewController.m
//  TabGroupCollapsible
//
//  Created by 苏庆林 on 2018/6/30.
//  Copyright © 2018年 苏庆林. All rights reserved.
// Lin

#import "ViewController.h"
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define kCell_Height 44
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *contentArr;
/** 展开合并状态*/
@property (nonatomic, strong) NSMutableArray *states;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
    self.states = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArr.count; i ++) {
        if (i == 0) {
            [self.states addObject:@"1"];
        } else {
            [self.states addObject:@"0"];
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.states[section] isEqualToString:@"1"]) {
        return 1;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = self.contentArr[indexPath.section];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textAlignment = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *rowH = self.contentHArr[indexPath.section];
    return rowH.floatValue;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, kCell_Height)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(20 , (kCell_Height-20)/2, 300, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    [tlabel setText:self.titleArr[section]];
    [tlabel setTextColor:[UIColor blackColor]];
    [button addSubview:tlabel];
    return button;
}


#pragma mark -action
- (void)buttonPress:(UIButton *)sender//headButton点击
{
    NSInteger currentTag = sender.tag - 1;
    if ([self.states[currentTag] isEqual:@"1"]) {
        [self.states replaceObjectAtIndex:currentTag withObject:@"0"];
    } else {
        [self.states enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:@"1"]) {
                [self.states replaceObjectAtIndex:idx withObject:@"0"];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:idx] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
        [self.states replaceObjectAtIndex:currentTag withObject:@"1"];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:currentTag] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark ---
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = @[@"1、关于tableview？", @"2、什么是互联网金融?", @"3、什么是先息后本?", @"4、什么是等额本息？", @"5、什么是安存？", @"6、为什么充值时提示交易拒绝?", @"7、如何更换绑定手机号码?", @"8、无法接收到验证码？", @"9、新手标最大金额可以投多少，可以投几次？", @"10、你们有发标预告吗？"];
    }
    
    return _titleArr;
}
- (NSArray *)contentArr
{
    if (_contentArr == nil) {
        NSString *str1 = @"  xxx公司是一家专注于汽车抵押贷款这一细分市场的P2P互联网金融公司。以银行的高标准，互联网的高效率，发展普惠金融，市场定位于小微投资群体和借贷群体，为民间投融资双方搭建一个安全、便捷、稳健的信息服务平台，将原先的信用借贷，转型于动产抵押借贷，做市场细分化，做专做强做稳，让小额借贷不再难。国恒金服着力解决民间投融资的信息不对称、征信不健全等问题，促进民间投融资便利化、民间借贷阳光化，力争成为国家倡导的多层次投融资体系中领先的专业汽车抵押贷款服务平台，开启金融定制时代";
        
        
        NSString *str7 = @"  将修改原因及需求、用户名、旧手机号、新手机号、姓名、身份证号，本人手持身份证近照，及身份证正反面照片，发送到xxx@163.com邮箱，我们的工作人员会在3个工作日内进行审核更改。";
        
        _contentArr = @[str1,
                        @"  互联网金融是传统金融行业与互联网精神相结合的新兴领域，互联网金融与传统金融的区别不仅仅在于金融业务所采用的媒介不同，更重要的在于金融参与者深谙互联网开放平等协作分享的精髓，通过互联网移动互联网等工具使得传统金融业务具备透明度更强、参与度更高、协作性更好、中间成本更低、操作上更便捷等一系列特征。",
                        @"  先息后本的本义是：先还利息再还本金",
                        @"  等额本息还款是指借入者每月按相等的金额偿还贷款本息，其中每月贷款利息按月初剩余贷款本金计算并逐月结清。 贷款初期和后期所还本金不同是由于每月的还款额相等，因此在贷款初期每月的还款中，剔除按月结清的利息后，所还的贷款本金就较少；而在贷款后期因贷款本金不断减少、每月的还款额中贷款利息也不断减少，每月所还的贷款本金就较多。即借款人每月还款额中的本金比重逐月递增、利息比重逐月递减。",
                        @"  第三方数据存管机构，保全用户信息安全。",
                        @"您的充值环境出现异常，建议您使用本人设备或更换安全环境下充值。",
                        str7,
                        @"  1. 请确认手机是否安装短信拦截或过滤软件;\n  2. 可以通过接收语音验证码来输入验证码;\n  3. 如是充值时的验证码没有接收到，请咨询银行;",
                        @"  当前新手标的额度最大金额由标的决定，新手标用户只能投一次。",
                        @"  国恒金服没有发标预告。"];
        
    }
    return _contentArr;
}

- (NSArray *)contentHArr
{
    NSArray *heights = [NSArray arrayWithArray:[self getHeightForRows]];
    return heights;
}
- (NSMutableArray *)getHeightForRows
{
    NSMutableArray *conHArr = [NSMutableArray array];
    for (NSInteger i = 0; i < self.contentArr.count; i ++) {
        NSString * str = self.contentArr[i];
        
        CGSize textSize =  [str boundingRectWithSize:CGSizeMake(ScreenWidth *0.83, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]} context:nil].size;
        CGFloat hei = textSize.height + 20;
        [conHArr addObject:[NSNumber numberWithFloat:hei]];
    }
    return conHArr;
}


@end
