//
//  MyViewController.m
//  18_我的通讯录
//
//  Created by wxhl on 16-4-21.
//  Copyright (c) 2016年 wxhl. All rights reserved.
//

#import "MyViewController.h"

//默认账号
#define kAccount @"123456"
//默认密码
#define kPassWord  @"123456"

//定义宏下面可以不用重复写
#define myUserDefaults [NSUserDefaults standardUserDefaults]
//定义静态变量，不用重复写，可以有系统提示
static NSString *nameKey=@"name";
static NSString *passKey=@"pass";
static NSString *rmbKey=@"rmb";
static NSString *autoKey=@"antoIn";
@interface MyViewController ()


@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UIButton *myButton;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//  在次加载的时候读取已存的数据
    NSString *name=[myUserDefaults objectForKey:nameKey];
    NSString *pass=[myUserDefaults objectForKey:passKey];
    BOOL rmb=[myUserDefaults boolForKey:rmbKey];
    BOOL  autoIn=[myUserDefaults boolForKey:autoKey];
//  一些登录之前的逻辑
    _number.text=name;
    
//  点击记住密码时，下次登录密码自动显示
    if (rmb==YES) {
        _passWord.text=pass;
    }
// 记住密码勾选了后，记住密码下次登录时就是勾选的
    _switch1.on=rmb;
// 自动登录勾选后，自动登录下次登录就自动勾选上
    _switch2.on=autoIn;
    
    if (autoIn==YES) {
        [self buttonAction:nil];//自动登录勾选上了，下次直接进入主页面不用再点击登录按钮
    }
    
//文本框添加监听自己内容方法
    [self.number addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventEditingChanged];
     [self.passWord addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventEditingChanged];
    
    [self changeValue];//因为设置了固定内容，文本框一开始就有文字，所有按钮让他能显示
    
}
//实现两个switch之间的一些逻辑
- (IBAction)switch1Act:(id)sender {
    if (_switch1.on==NO) {
        _switch2.on=NO;
    }
}
//实现两个switch之间的一些逻辑
- (IBAction)swtich2Act:(id)sender {
    if (_switch2.on==YES) {
        _switch1.on=YES;
    }
}
//当文本框有内容时调用
-(void)changeValue{
    if (_number.text.length&&_passWord.text.length) {
        _myButton.enabled=YES;//按钮为可点击状态
    }
}
//点击登录按钮时调用
- (IBAction)buttonAction:(id)sender {
    
    
// 模拟网络延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        

        if ([_number.text isEqualToString:kAccount]&&[_passWord.text isEqualToString:kPassWord]) {//输入正确
            
          //存储数据
         //账号，密码，记住密码，自动登录
            
            [myUserDefaults setObject:_number.text forKey:nameKey];
            [myUserDefaults setObject:_passWord.text forKey:passKey];
            [myUserDefaults setBool:_switch1.on forKey:rmbKey];
            [myUserDefaults setBool:_switch2.on forKey:autoKey];
            
            
            
            [self performSegueWithIdentifier:@"myLogin" sender:nil];
            
        }else{
            
            
        }
    });
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
