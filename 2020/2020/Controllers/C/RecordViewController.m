//
//  RecordViewController.m
//  2020
//
//  Created by yurong on 2017/6/29.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "RecordViewController.h"
#import "GameViewController.h"
@interface RecordViewController ()
{
    //jilu
    UILabel * name3;
    UILabel * record3;
    UILabel * name1;
    UILabel * record1;
    UILabel * name2;
    UILabel * record2;
    
    UIButton * butChallengeNum;
    UIButton * butBegin;
    
    UITextField * name;
    UIButton * nameTable;
    UITextField * mima;
    NSInteger suijinum;
    UIScrollView * scrollvie;
    CGFloat keyboardHeight;
    BOOL keyBoardShow;
    //需要记录的数值
     int numViewEmptytype;//空背景类型
    NSString * GameNum;//游戏数量
    NSDictionary * dictGameCenter;//关卡的数据 ： key 关卡数值； value：dict（gamerRecord123:用时间最少的前三个时间 ；gameRecordname123）
    NSDictionary * dictChallengeCenter;//用户字典 key：用户名pinyin  value：dict（game:{gamename:@{gamenaem:time}};name:str;mima:mima）
    
    int butNearFuture;
}
@end

@implementation RecordViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    dictGameCenter = UserDefault(dictGame);
    
    dictChallengeCenter = UserDefault(dictchallenger);
    keyBoardShow = NO;
    if (scrollvie) {
        [scrollvie removeFromSuperview];
        
    }
    butNearFuture = 0;
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillShowNotification
//                                                  object:nil];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillHideNotification
//                                                  object:nil];
    
    keyBoardShow = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    //self.view.backgroundColor = ColorRGB(236, 200, 135);
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mofa.jpg"]];
    
    [self creatData];
    [self CreatUp];
    [self CreatDown];//用户名 密码 开始but
    
    
    
    //键盘😠通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];


}


-(void)keyboardWillShow:(NSNotification*)notification{
    if (keyBoardShow) {
        return;
    }
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
   keyboardHeight = keyboardRect.size.height-IPHONEHIGHT(200);
    
    CGRect frame = name.frame;
    frame.origin.y -= keyboardHeight;
    name.frame = frame;
    
    CGRect framee = mima.frame;
    framee.origin.y -= keyboardHeight;
    mima.frame = framee;
    keyBoardShow = YES;
    
    
}
-(void)keyboardWillHide:(NSNotification*)notification{
    
    if (!keyBoardShow) {
        return;
    }
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
  
    CGRect frame = name.frame;
    frame.origin.y += keyboardHeight;
    name.frame = frame;
    
    CGRect framee = mima.frame;
    framee.origin.y += keyboardHeight;
    mima.frame = framee;
    
    keyBoardShow = NO;
    
}


-(void)creatData{
    suijinum = 4096*2;

   
}
-(void)CreatUp{
   //状态栏颜色
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = [UIColor orangeColor];
    }

    
    UIImageView * imgViewTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, IPHONEHIGHT(0), ScreenWidth, ScreenWidth/3*2)];
    imgViewTop.image = [UIImage imageNamed:@"bang"];
    imgViewTop.contentMode = UIViewContentModeScaleAspectFill;
    imgViewTop.layer.shadowColor = ColorRGB(63, 90, 127).CGColor;
    imgViewTop.layer.shadowOffset = CGSizeMake(2, 1);
    [self.view addSubview:imgViewTop];
    
    //3
    name3 = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(74), IPHONEHIGHT(174), IPHONEWIDTH(70), IPHONEHIGHT(80)) backgroundColor:clearCo title:@"铜" font:IPHONEWIDTH(30) Alignment:NSTextAlignmentCenter textColor:blackCo];
    name3.numberOfLines = 2;
    [imgViewTop addSubview:name3];
    
    record3 = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(36), IPHONEHIGHT(269), IPHONEWIDTH(150), IPHONEHIGHT(60)) backgroundColor:clearCo title:@"等待挑战" font:IPHONEWIDTH(30) Alignment:NSTextAlignmentCenter textColor:blackCo];
    [imgViewTop addSubview:record3];
    
    
    //1
    name1 = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(312), IPHONEHIGHT(75), IPHONEWIDTH(90), IPHONEHIGHT(90)) backgroundColor:clearCo title:@"金" font:IPHONEWIDTH(35) Alignment:NSTextAlignmentCenter textColor:blackCo];
    name1.numberOfLines = 2;
    
    [imgViewTop addSubview:name1];
    
    record1 = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(281), IPHONEHIGHT(200), IPHONEWIDTH(150), IPHONEHIGHT(60)) backgroundColor:clearCo title:@"等待创造" font:IPHONEWIDTH(35) Alignment:NSTextAlignmentCenter textColor:blackCo];
    [imgViewTop addSubview:record1];
    
    
    //2
    name2 = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(615), IPHONEHIGHT(143), IPHONEWIDTH(70), IPHONEHIGHT(80)) backgroundColor:clearCo title:@"银" font:IPHONEWIDTH(30) Alignment:NSTextAlignmentCenter textColor:blackCo];
    name2.numberOfLines = 2;
    [imgViewTop addSubview:name2];
    
    record2 = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(571), IPHONEHIGHT(235), IPHONEWIDTH(150), IPHONEHIGHT(60)) backgroundColor:clearCo title:@"等你来战" font:IPHONEWIDTH(30) Alignment:NSTextAlignmentCenter textColor:blackCo];
    [imgViewTop addSubview:record2];
    
    CGFloat butwidth = ScreenWidth/4;
    //随机 设置
    UIButton * suiji = [[UIButton alloc] initWithFrame:CGRectMake(IPHONEWIDTH(30), butwidth+ScreenWidth/3*2, IPHONEWIDTH(110), IPHONEHIGHT(55))];
    suiji.backgroundColor = clearCo;
    [suiji setImage:[UIImage imageNamed:@"suiji"] forState:UIControlStateNormal];
    [suiji addTarget:self action:@selector(suiji) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:suiji];
    
    UIButton * shezhi = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-IPHONEWIDTH(140), butwidth+ScreenWidth/3*2, IPHONEWIDTH(110), IPHONEHIGHT(55))];
    shezhi.backgroundColor = clearCo;
    [shezhi setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
    [shezhi addTarget:self action:@selector(shezhi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shezhi];
    
    //选择挑战 数值
    UILabel * la = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(40), ScreenWidth/3*2-IPHONEHIGHT(50), ScreenWidth-IPHONEWIDTH(80), IPHONEHIGHT(50)) backgroundColor:clearCo title:@"点击数字爽玩近期关卡" font:IPHONEHIGHT(35) Alignment:NSTextAlignmentCenter textColor:[UIColor greenColor]];
    [self.view addSubview:la];
    
    
    for (int i=0; i<4; i++) {
        
        UIButton * but = [[UIButton alloc] initWithFrame:CGRectMake(i%2*(butwidth)+ScreenWidth/2-butwidth, i/2*butwidth+ScreenWidth/3*2, butwidth, butwidth)];
        but.layer.cornerRadius = butwidth/3;
        but.layer.masksToBounds = YES;
        but.backgroundColor = clearCo;
        [but setImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
        but.tag = i+101;
        [but addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:but];
        
    }
    
    
}

-(void)CreatDown{
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(IPHONEWIDTH(50), ScreenWidth+IPHONEHIGHT(130), ScreenWidth-IPHONEWIDTH(200+80), IPHONEHIGHT(90))];
    name.placeholder = @"输入用户名(字母／数字)";
    name.borderStyle = UITextBorderStyleRoundedRect;
    name.textColor = [UIColor orangeColor];
    
    mima = [[UITextField alloc] initWithFrame:CGRectMake(IPHONEWIDTH(50),ScreenWidth+IPHONEHIGHT(230), ScreenWidth-IPHONEWIDTH(100), IPHONEHIGHT(90))];
    mima.placeholder = @"输入密码(字母／数字)";
    mima.borderStyle = UITextBorderStyleRoundedRect;
    mima.textColor = [UIColor orangeColor];
    
    [self.view addSubview:name];
    [self.view addSubview:mima];
    
    
    //name button
    nameTable = [myButton buttonWithType:UIButtonTypeSystem frame:CGRectMake(ScreenWidth-IPHONEWIDTH(220), ScreenWidth+IPHONEHIGHT(140), IPHONEWIDTH(200), IPHONEHIGHT(80)) tag:666 image:@"" andBlock:^(myButton *button) {
        NSArray * challenger = [dictChallengeCenter allKeys];
        if (!challenger.count) {
            
            [MBProgressHUD showText:@"还没有挑战记录，去创造历史吧" HUDAddedTo:self.view animated:YES afterDelay:2];
            return ;
        }
       
        
        
        scrollvie = [[UIScrollView alloc] initWithFrame:CGRectMake(ScreenWidth-IPHONEWIDTH(220), ScreenWidth+IPHONEHIGHT(230), IPHONEWIDTH(200), challenger.count<3?challenger.count*IPHONEHIGHT(70):IPHONEHIGHT(70)*3)];
        scrollvie.contentSize =CGSizeMake(IPHONEWIDTH(80), challenger.count*IPHONEHIGHT(70));
        scrollvie.scrollEnabled = YES;
        scrollvie.backgroundColor = clearCo;
        scrollvie.bounces  = YES;
        [self.view addSubview:scrollvie];
    
        for (int i=0; i<challenger.count; i++) {
            
            UIButton * butt = [myButton buttonWithType:UIButtonTypeSystem frame:CGRectMake(0,i*IPHONEHIGHT(70), IPHONEWIDTH(200), IPHONEHIGHT(60)) title:challenger[i] andBackground:ColorRGB(240, 143, 70) tag:i andBlock:^(myButton *button) {
                
                name.text =challenger[button.tag];
                
                [scrollvie removeFromSuperview];
               
            }];
            butt.titleLabel.font = [UIFont systemFontOfSize:IPHONEHIGHT(30)];
            butt.layer.cornerRadius = IPHONEWIDTH(10);
            butt.layer.masksToBounds = YES;
            [butt setTitleColor:whiteCo forState:UIControlStateNormal];
            [scrollvie addSubview:butt];
            
        }
        
    }];
    nameTable.backgroundColor = [UIColor orangeColor];
    [nameTable setTitle:@"历史玩家" forState:UIControlStateNormal];
    [nameTable setTitleColor:ColorRGB(71, 56, 105) forState:UIControlStateNormal];
    nameTable.titleLabel.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(35)];
     [self.view addSubview:nameTable];
    
    
    
    //开始游戏按钮
    butBegin = [myButton buttonWithType:UIButtonTypeSystem frame:CGRectMake(IPHONEWIDTH(150), ScreenWidth+IPHONEHIGHT(160+190)   , ScreenWidth-IPHONEWIDTH(300), IPHONEHIGHT(120))  title:@"开始游戏" andBackground:[UIColor orangeColor] tag:111000 andBlock:^(myButton *button) {
        
        [self beginGame];
        
    }];
   butBegin.titleLabel.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(55)];
    butBegin.layer.cornerRadius = IPHONEWIDTH(15);
    butBegin.layer.masksToBounds = YES;
    [butBegin setTitleColor:ColorRGB(71, 56, 105) forState:UIControlStateNormal];
    [self.view addSubview:butBegin];

    
    UIImageView * imgViedown = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgViedown.image = [UIImage imageNamed:@"mofa.jpg"];
    imgViedown.userInteractionEnabled = YES;
    [self.view addSubview:imgViedown];
    [self.view sendSubviewToBack:imgViedown];
}
-(NSString *)suijishuwithInt{
    int num = (int)(arc4random()%9);
    int zong = suijinum;
    for (int i=0; i<num; i++) {
        zong = zong/2;
    }
    return [NSString stringWithFormat:@"%d",zong];
}
-(void)Gamerecordlabel{
    NSDictionary * game =  dictGameCenter[GameNum];
    
    name1.text =  game[@"gamerRecord1"][@"name"];
    name2.text = game[@"gamerRecord2"][@"name"];
    name3.text = game[@"gamerRecord3"][@"name"];
    
    record1.text =[self timerChangeString: game[@"gamerRecord1"][@"record"]];
    record2.text =[self timerChangeString: game[@"gamerRecord2"][@"record"]];
    record3.text =[self timerChangeString: game[@"gamerRecord3"][@"record"]];
    
}
-(NSString*)timerChangeString:(NSString*)string{
    
    int time = [string intValue];
    int miao = time%600;
    int fen = time/6000;
    
    return [NSString stringWithFormat:@"%d:%d",fen,miao];
    
}
//游戏开始与否判断
-(void)beginGame{
    
     GameViewController * gameview = [[GameViewController alloc]init];
    gameview.GameNum = GameNum;
    
    gameview.GameRecord1 = record1.text;
    gameview.GameRecord2 = record2.text;
    gameview.GameRecord3 = record3.text;
    //游戏等级
    if (!GameNum.length) {
        
        [MBProgressHUD showText:@"请选择游戏等级" HUDAddedTo:self.view animated:YES afterDelay:1.5];
        return;
    }
    
    //检测用户名
    if(!name.text.length){
        
        [UIView pushAlertTwoActionViewWithMessage:@"还没有输入用户名，直接进入游戏，不保存游戏记录" Target:self Title:@"提示" oneAlertTitle:@"直接游戏" twoAlertTitle:@"返回" oneActionfunc:^{
            if(!dictGameCenter[GameNum]){
                NSMutableDictionary * gamecenter = [NSMutableDictionary dictionary];
                [gamecenter setDictionary:dictGameCenter];
                [gamecenter setObject:@{@"gamerRecord1":@{@"name":@"",@"record":@""}} forKey:GameNum];
                
                UserDefaults(gamecenter, dictGame);
            }
            [self.navigationController pushViewController:gameview animated:YES];
            
            
        } twoActionfunc:^{
            return ;
        }];
        
    }else{
    
        //在有用户名输入的情况下判断密码
    if (mima.text.length>0) {
        
        NSString * mimaa = dictChallengeCenter[name.text][mima];
       
        if (mimaa.length>0) {
            //密码 有值
            if ([mima.text isEqualToString:mimaa]) {
            
                //密码正确进入
                [self.navigationController pushViewController:gameview animated:YES];
                
                
            }else{
                [MBProgressHUD showText:@"密码错误，请检查用户名／密码" HUDAddedTo:self.view animated:YES afterDelay:1.5];
                
            
            }
            
            
        }else{
            
            //没有相应的密码 不存在是否创建
        
                [UIView pushAlertTwoActionViewWithMessage:[NSString stringWithFormat:@"是否创建新用户:%@",name.text] Target:self Title:@"提示" oneAlertTitle:@"好的" twoAlertTitle:@"不" oneActionfunc:^{
                    //创建用户啊
                     NSDictionary * dictname = @{@"mima":mima.text,@"name":name.text,@"game":@{GameNum:@""}};
                    
                    NSMutableDictionary * dictmu = [NSMutableDictionary dictionary];
                    [dictmu setDictionary:dictChallengeCenter];
                    [dictmu setObject:dictname forKey:name.text];
                    if(!dictGameCenter[GameNum]){
                        NSMutableDictionary * gamecenter = [NSMutableDictionary dictionary];
                        [gamecenter setDictionary:dictGameCenter];
                        [gamecenter setObject:@{@"gamerRecord1":@{@"name":@"",@"record":@""}} forKey:GameNum];
                        
                        UserDefaults(gamecenter, dictGame);
                    }
                  
                    UserDefaults(dictmu, dictchallenger);
                    gameview.challengeName = name.text;
                    [self.navigationController pushViewController:gameview animated:YES];
                    
                } twoActionfunc:^{
                    return ;
                }];
  
        
    }
        
    }else{
        [MBProgressHUD showText:@"请输入密码" HUDAddedTo:self.view animated:YES afterDelay:1.5];
        
    }
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}
//设置关卡显示的数值
-(void)SetGuanButWith:(NSString*)string{
    
    //设置关卡
    GameNum = string;
    [self Gamerecordlabel];//
    //如果 数值位数不足四位 在前边补〇
    NSMutableString * ChallengeNum = [NSMutableString stringWithString:GameNum];
    for (int j=0; j<(4-GameNum.length); j++) {
        
        [ChallengeNum insertString:@"0" atIndex:0];
    }
    //数值符合要求
    for (int i=0; i<4; i++) {
        
        UIButton * but = (UIButton*)[self.view viewWithTag:i+101];
        NSString * str = [ChallengeNum substringWithRange:NSMakeRange(i, 1)];
        [but  setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        
    }
    
}
//点击 数字 给出推荐的 选项
-(void)butAction:(UIButton*)but{
   
    NSArray * arrayNumkey = [dictGameCenter allKeys];
    if (arrayNumkey.count==0) {
        [MBProgressHUD showText:@"还没有游戏记录，可随机选取" HUDAddedTo:self.view animated:YES afterDelay:1.5];
        
        return;
    }
    [self SetGuanButWith:arrayNumkey[butNearFuture%arrayNumkey.count]];
    
    butNearFuture++;
    
}

-(void)suiji{
   
   [self SetGuanButWith:[self suijishuwithInt]];



}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    if (scrollvie) {
        [scrollvie removeFromSuperview];
        
    }
}
-(void)shezhi{
    
    //弹出数字键盘
    
    UIAlertController * shenum = [UIAlertController alertControllerWithTitle:@"关卡设置" message:@"请输入任意四位关卡数" preferredStyle:UIAlertControllerStyleAlert];
    [shenum addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder =@"输入各位为偶数的数值";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction * haode = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField * shuzhi = shenum.textFields.firstObject;
        if (![self isNum:shuzhi.text] || [shuzhi.text isEqualToString:@"0"] || !shuzhi.text || ([shuzhi.text intValue]%2 || shuzhi.text.length>4)) {
            
            [UIView pushAlertViewWithMessage:@"输入数值不符合要求，请重新输入" Target:self Title:@"提示" AlertTitle:@"好的"];
        }else{
            //
           
            [self SetGuanButWith:shuzhi.text];
        }
        
        
        
    }];
    UIAlertAction * quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [shenum addAction:haode];
    [shenum addAction:quxiao];
    
    [self presentViewController:shenum animated:YES completion:nil];
    
}
//判断字符串是否全数字
- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}
@end
