//
//  GameViewController.m
//  2020
//
//  Created by yurong on 2017/6/28.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "GameViewController.h"
#import "HoleviewOfEmpty.h"
#import "NumberViewCollectionViewCell.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface GameViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView * collectionvieww;
    NSMutableDictionary * dictChange;//放 数值为0 的字典
    UIView * frontView;
    UISwipeGestureRecognizer * recognizer;//滑动手势
    UIButton * StarBut;//开始 结束 按钮
    NSMutableDictionary * dictData;//数据字典
    
    UILabel * labelTimer;
    NSTimer * timerss;//计时器
    NSInteger timernumber;//计时时间
    UIImageView * imgview;
    CGFloat cellWidth;
    
    int top,left,dowm,right;
    
}

@end

@implementation GameViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义🌿
    _numViewEmpty = 3;
    _numViewEmptytype = (int)arc4random()%5;
    self.fd_interactivePopDisabled = YES;
    
    [self Creatui]; //游戏控制区域布局
    [self CreatUp];//页面中上部分显示
    [self creaDATA]; //数据管理
    

    
}
//添加初始数据
-(void)creaDATA{
    
    
    dictData = [NSMutableDictionary dictionary];
    for (int i=0; i<16; i++) {
        
        [dictData setObject:@"0" forKey:@(i)];
        
    }
    
    //dictRecord ：   
    
    cellWidth = (self.view.frame.size.width-IPHONEWIDTH(56+10))/5;
    
    
}

//完成游戏。保存记录。
-(void)savegameRecord{
    
    NSString * addString;
    
    if (_challengeName.length >0) {
        //是登陆进来的
        
        
        //游戏记录对比
        NSMutableDictionary * gamecenter = [NSMutableDictionary dictionary];
        [gamecenter setDictionary:UserDefault(dictGame)[_GameNum]];
        
        
        NSDictionary * recordNew = @{@"name":_challengeName,@"record":[NSString stringWithFormat:@"%ld",timernumber]};
        
        //1\ 原来记录是否大于0-》是否大于这个
        if ( [(gamecenter[@"gamerRecord1"][@"record"]) intValue] > 0) {
            
            if  (timernumber < [(gamecenter[@"gamerRecord1"][@"record"]) intValue]) {
                addString = @"创造本等级历史第一！";
                [gamecenter setObject:recordNew forKey:@"gamerRecord1"];
            }
            
            else if ([(gamecenter[@"gamerRecord2"][@"record"]) intValue] >0){
               
                if (timernumber < [(gamecenter[@"gamerRecord2"][@"record"]) intValue]) {
                    addString = @"创造本等级历史第二！";
                    [gamecenter setObject:recordNew forKey:@"gamerRecord2"];
                }else if ([(gamecenter[@"gamerRecord3"][@"record"]) intValue]>0){
                    
                    if (timernumber < [(gamecenter[@"gamerRecord3"][@"record"]) intValue]) {
                        addString = @"创造本等级历史第三！";
                        [gamecenter setObject:recordNew forKey:@"gamerRecord3"];

                    }
                    
                }else{
                    
                    addString = @"创造本等级历史第三！";
                    [gamecenter setObject:recordNew forKey:@"gamerRecord3"];

                }
               
                
            }else{
                
                addString = @"创造本等级历史第二！";
                [gamecenter setObject:recordNew forKey:@"gamerRecord2"];
                
                
            }
            
            
            
        }else{
            
            addString = @"创造本等级历史第一！";
            [gamecenter setObject:recordNew forKey:@"gamerRecord1"];
        }
        
        
        
        //个人记录对比
        
        NSMutableDictionary * challengerRecord = [NSMutableDictionary dictionary];
        
        [challengerRecord setDictionary:UserDefault(dictchallenger)[_challengeName][@"game"] ];
        
        if ([(challengerRecord[_GameNum]) intValue]>0) {
           
            if (timernumber < [(challengerRecord[_GameNum]) intValue]) {
                if (!addString.length) {
                    addString = @"打破个人历史记录！";
                }
                [challengerRecord setObject:[NSString stringWithFormat:@"%ld",timernumber] forKey:_GameNum];
            }
            
        }else{
            
            if (!addString.length) {
                addString = @"打破个人历史记录！";
            }
            [challengerRecord setObject:[NSString stringWithFormat:@"%ld",timernumber] forKey:_GameNum];
            
            
        }
    
    
}
    
    
    
    NSInteger haomiao,miao,fen;
    haomiao = timernumber%100;
    miao = timernumber/100%60;
    fen = timernumber/6000;
    
    [UIView pushAlertTwoActionViewWithMessage:[NSString stringWithFormat:@"恭喜你，完成游戏\n用时：%02ld:%02ld:%02ld \n     %@",fen,miao,haomiao,addString?addString:@""] Target:self Title:@"OH耶！！！" oneAlertTitle:@"挑战时间" twoAlertTitle:@"休息一下" oneActionfunc:^{
        //继续
        [dictData removeAllObjects];
        [self creaDATA];
        [collectionvieww reloadData];
        timernumber = 0;
        [self StarGame];
        [self timerStar];
        
        
    } twoActionfunc:^{
        
        [self.navigationController popViewControllerAnimated:YES];
        //返回上一页
        
    }];

    
    
}
//游戏开始
-(void)StarGame{
    //筛选出 模块上可以添加数据的 位置字典。装到数组，随机分配
    dictChange = [NSMutableDictionary dictionary];
    for (int i=0; i<16; i++) {
        NSString * str = [dictData objectForKey:@(i)];
        if ([str isEqualToString:@"0"]) {
            
            [dictChange setObject:@"0" forKey:@(i)];
            
        }
       
    }
    
    //先判断有没有满足要求
    NSArray * value = [dictData allValues];
    if ([value containsObject:_GameNum]) {
        [timerss invalidate];
        timerss = nil;
        [self savegameRecord];//保存游戏记录
       
        
       
    }
    
    //如果没有位置可以再添加数字了 游戏就结束了
    if (dictChange.count ==0) {
        [timerss invalidate];
        timerss = nil;
        
           [UIView pushAlertTwoActionViewWithMessage:@"游戏结束" Target:self Title:@"再挑战一局吧" oneAlertTitle:@"好的" twoAlertTitle:@"休息一下" oneActionfunc:^{
               //继续
               [dictData removeAllObjects];
               [self creaDATA];
               [collectionvieww reloadData];
               timernumber = 0;
               [self StarGame];
               [self timerStar];
               
               
           } twoActionfunc:^{
               
               
               //返回上一页
               
           }];
        return;
    }
    
    //随机添加数据。刷新表格
    int random = (int)( (arc4random() % (dictChange.count)));
    NSArray * dictKey = [dictChange allKeys];
    [dictChange setObject:@"2" forKey:dictKey[random]];
    //返回给数据字典
    for (NSString * key in dictKey) {
        
        [dictData setObject:dictChange[key] forKey:key];
        
    }
    [dictChange removeAllObjects];
    //刷新表
    [collectionvieww reloadData];
    
    
    
}
-(void)CreatUp{
    NSDictionary * DictChallenge = @{};
    if (_challengeName) {
         DictChallenge = UserDefault(_challengeName);
    }
   
    
    UILabel  * game = [myLabel labelWithframe:CGRectMake(ScreenWidth/2-IPHONEWIDTH(130), IPHONEHIGHT(90), IPHONEWIDTH(260), IPHONEHIGHT(65)) backgroundColor:clearCo title:_GameNum font:IPHONEWIDTH(55) Alignment:NSTextAlignmentCenter textColor:[UIColor yellowColor]];
    
    game.layer.cornerRadius = IPHONEWIDTH(10);
    game.layer.masksToBounds = YES;
    [imgview addSubview:game];
    
    UILabel  * gameRecord = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(30), IPHONEHIGHT(190), IPHONEWIDTH(300), IPHONEHIGHT(65)) backgroundColor:clearCo title:@"" font:IPHONEWIDTH(40) Alignment:NSTextAlignmentLeft textColor:[UIColor redColor]];
    if (!_GameRecord1) {
        gameRecord.text = @"你将创造历史";
    }else{
        gameRecord.text =  [NSString stringWithFormat:@"等级记录：%@",[self timerChangeString:_GameRecord1]];
    }
    gameRecord.shadowColor = [UIColor grayColor];
    gameRecord.shadowOffset = CGSizeMake(1, 2);
    [imgview addSubview:gameRecord];
    
    UILabel * challenger = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(30), IPHONEHIGHT(190+60), IPHONEWIDTH(300), IPHONEHIGHT(50)) backgroundColor:clearCo title:@"" font:IPHONEWIDTH(35) Alignment:NSTextAlignmentLeft textColor:[UIColor greenColor]];
    if (!_challengeName) {
        challenger.text = @"隐身战士";
    }else{
        
        challenger.text= [NSString stringWithFormat:@"挑战者：%@",_challengeName];
    }
    challenger.shadowColor = [UIColor grayColor];
    challenger.shadowOffset = CGSizeMake(2, 1);
    [imgview addSubview:challenger];
    
    UILabel * challengerReco = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(30), IPHONEHIGHT(240+60), IPHONEWIDTH(300), IPHONEHIGHT(50)) backgroundColor:clearCo title:[NSString stringWithFormat:@"挑战者记录：%@",DictChallenge[_GameNum][@"gameTime"]] font:IPHONEWIDTH(35) Alignment:NSTextAlignmentLeft textColor:[UIColor greenColor]];
    if (!DictChallenge[_GameNum][@"gameTime"]) {
        challengerReco.text = @"赶快创造纪录吧";
        
    }
    challengerReco.shadowColor = [UIColor grayColor];
    challengerReco.shadowOffset = CGSizeMake(2, 1);
    [imgview addSubview:challengerReco];
    
    
}
-(NSString*)timerChangeString:(NSString*)string{
    
    int time = [string intValue];
    int miao = time%600;
    int fen = time/6000;
    
    return [NSString stringWithFormat:@"%d:%d",fen,miao];
    
}
-(void)Creatui{
    
    //背景
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    imgview.image = [UIImage imageNamed:@"jing.jpg"];
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    imgview.userInteractionEnabled = YES;
    [self.view addSubview:imgview];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    collectionvieww = [[UICollectionView alloc] initWithFrame:CGRectMake(IPHONEWIDTH(28), (ScreenHeight-ScreenWidth)/3*2+IPHONEHIGHT(140), ScreenWidth-IPHONEWIDTH(28*2), ScreenWidth-IPHONEWIDTH(56)) collectionViewLayout:layout];
    collectionvieww.backgroundColor = [UIColor clearColor];
    collectionvieww.delegate = self;
    collectionvieww.dataSource = self;
    collectionvieww.allowsMultipleSelection = YES;
    [collectionvieww registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
     [collectionvieww registerClass:[NumberViewCollectionViewCell class] forCellWithReuseIdentifier:@"cellnum"];
    [imgview addSubview:collectionvieww];
    
    
    frontView = [[UIView alloc] initWithFrame:CGRectMake(IPHONEWIDTH(28), (ScreenHeight-ScreenWidth)/2, ScreenWidth-IPHONEWIDTH(28*2), ScreenWidth-IPHONEWIDTH(56))];
    frontView.backgroundColor = [UIColor clearColor];
    frontView.userInteractionEnabled = NO;
    [imgview addSubview:frontView];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(silidingTop)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [frontView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(silidingLift)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [frontView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(silidingDown)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [frontView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(silidingRight)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [frontView addGestureRecognizer:recognizer];
    
    
    StarBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    StarBut.frame = CGRectMake(ScreenWidth/2-IPHONEWIDTH(80), IPHONEHIGHT(400), IPHONEWIDTH(200), IPHONEWIDTH(80));
    [StarBut addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [StarBut setTitle:@"开始" forState:UIControlStateNormal];
    [StarBut setTitle:@"🔚结束" forState:UIControlStateSelected];
    StarBut.selected = NO;
    StarBut.layer.cornerRadius = IPHONEWIDTH(10);
    StarBut.layer.masksToBounds = YES;
    StarBut.backgroundColor = [UIColor orangeColor];
    StarBut.titleLabel.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(40)];
    [StarBut setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [StarBut setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [imgview addSubview:StarBut];
    
    
    //计时器
    labelTimer = [myLabel labelWithframe:CGRectMake(ScreenWidth-IPHONEWIDTH(180), IPHONEHIGHT(60), IPHONEWIDTH(150), IPHONEHIGHT(60)) backgroundColor:[UIColor clearColor] title:@"00:00:00" font:IPHONEWIDTH(30) Alignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
    [imgview addSubview:labelTimer];

    
}
-(void)button:(UIButton*)but{
    
    if (but.isSelected == NO) {
        but.selected = YES;
        but.backgroundColor = [UIColor lightGrayColor];
        
        [self StarGame];
        
        [self timerStar];
        frontView.userInteractionEnabled = YES;
    }else{
        
        [timerss invalidate];
        timerss  = nil;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
}

-(void)timerStar{
    
   timerss  =  [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        timernumber +=10;
        NSInteger haomiao,miao,fen;
        
        haomiao = timernumber%100;
        miao = timernumber/100%60;
        fen = timernumber/6000;
        
        labelTimer.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",fen,miao,haomiao];
       [self labelFrame];
        
    }];

    
}
-(void)labelFrame{
    
//    CGFloat orx = labelTimer.frame.origin.x;
//    CGFloat wid = ScreenWidth-IPHONEWIDTH(180);
//    
//    if (orx == wid) {
//        
//        CGRect label = labelTimer.frame;
//        label.origin.x = orx-IPHONEWIDTH(5);
//        labelTimer.frame = label;
//        
//        labelTimer.textColor = [UIColor colorWithRed:timernumber%255*20/255.0f green:timernumber%255*240/255.0f blue:timernumber%255*50/255.0f alpha:1];
//        
//    }else if (orx == IPHONEWIDTH(20)){
//        
//        CGRect label = labelTimer.frame;
//        label.origin.x = orx+IPHONEWIDTH(5);
//        labelTimer.frame = label;
//         labelTimer.textColor = [UIColor colorWithRed:timernumber%255*20/255.0f green:timernumber%255*240/255.0f blue:timernumber%255*50/255.0f alpha:1];
//    }
//    
    
}
//禁止使用同一个手势放下 滑动三次以上
-(void)huadongqingchuWithInt:(int)direction{
    
    for (int i=1; i<5; i++) {
        if (i!=direction) {
            switch (i) {
                case 1:
                    top=0;
                    break;
                    case 2:
                    left = 0;
                    break;
                    
                    case 3:
                    dowm = 0;
                    break;
                    
                    case 4:
                    right = 0;
                    
                default:
                    break;
            }
            
            
        }
        
        
        
    }
    
    
    
}
-(void)silidingTop{
    
    [self huadongqingchuWithInt:1];
    
    if (top>3) {
        return;
    }
    top +=1;
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int h = 0; h<4; h++) {
            
            //选择 筛选相邻数字相加。只相加一次
            for (int i=0; i<4; i++) {
                
                if (![dictData[@(i*4+h)] isEqualToString:@"0"])
                    
                {
                    
                    for (int j=i+1; j<4; j++) {
                        
                        if (![dictData[@(j*4+h)] isEqualToString:@"0"]){
                            
                            if ([dictData[@(i*4+h)] isEqualToString: dictData[@(j*4+h)]]) {
                                
                                //后边的数是 相加后的值
                                [dictData setObject:[NSString stringWithFormat:@"%d",[dictData[@(j*4+h)] intValue] + [dictData[@(i*4+h)] intValue]] forKey:@(i*4+h)];
                                [dictData setObject:@"0" forKey:@(j*4+h)];//前边的 设置为0
                                
                                
                            }
                            break; // 有了 就不再循环了
                            
                        }
                    }
                    
                }
                
                if (i==3) {
                    [self top2:h];
                }
                
            }
            
            
            
        }

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionvieww reloadData];
            
            [self StarGame];
        });
    });
}

-(void)top2:(int)h{
    
    //选择排序  整理位置
    for(int i=0;i<4;i++){
        if ([dictData[@(i*4+h)] isEqualToString:@"0"])//i为0 的时候
        {
            
            for (int j=i+1; j<4; j++)
            {
                if (![dictData[@(j*4+h)] isEqualToString:@"0"]) //j 有值的时候
                    
                    //i 的值 为j 的。j设置为0
                {
                    
                    [dictData setObject:dictData[@(j*4+h)] forKey:@(i*4+h)];
                    [dictData setObject:@"0" forKey:@(j*4+h)];
                    
                    
                    break; // 继续下一次循环
                }
                
            }
            
        }
        
    }
    
}
-(void)silidingLift{
    [self huadongqingchuWithInt:2];
    
    if (left>3) {
        return;
    }
    left +=1;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int h = 0; h<4; h++) {
            
            
            //选择 筛选相邻数字相加。只相加一次
            for (int i=0; i<4; i++) {
                
                if (![dictData[@(i+4*h)] isEqualToString:@"0"])
                    
                {
                    
                    for (int j=i+1; j<4; j++) {
                        
                        
                        if (![dictData[@(j+4*h)] isEqualToString:@"0"]){
                            
                            
                            if ([dictData[@(i+4*h)] isEqualToString: dictData[@(j+4*h)]]) {
                                
                                
                                
                                //后边的数是 相加后的值
                                [dictData setObject:[NSString stringWithFormat:@"%d",[dictData[@(j+4*h)] intValue] + [dictData[@(i+4*h)] intValue]] forKey:@(i+4*h)];
                                [dictData setObject:@"0" forKey:@(j+4*h)];//前边的 设置为0
                                
                                
                            }
                            break; // 有了 就不再循环了
                            
                        }
                    }
                    
                }
                
                if (i==3) {
                    [self Lift2:h];
                }
                
            }
            
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionvieww reloadData];
            
            [self StarGame];
        });
    });
    
}

-(void)Lift2:(int)h{
    
    //选择排序  整理位置
    for(int i=0;i<4;i++){
        if ([dictData[@(i+4*h)] isEqualToString:@"0"])//i为0 的时候
        {
            
            for (int j=i+1; j<4; j++)
            {
                if (![dictData[@(j+4*h)] isEqualToString:@"0"]) //j 有值的时候
                    
                    //i 的值 为j 的。j设置为0
                {
                    
                    [dictData setObject:dictData[@(j+4*h)] forKey:@(i+4*h)];
                    [dictData setObject:@"0" forKey:@(j+4*h)];
                    
                    
                    break; // 继续下一次循环
                }
                
            }
            
        }
        
    }
    
}

-(void)silidingDown{
    
    [self huadongqingchuWithInt:3];
    
    if (dowm>3) {
        return;
    }
    dowm +=1;

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int h = 0; h<4; h++) {
            
            //选择 筛选相邻数字相加。只相加一次
            for (int i=0; i<4; i++) {
                
                if (![dictData[@(12-i*4+h)] isEqualToString:@"0"])
                    
                {
                    
                    for (int j=i+1; j<4; j++) {
                        
                        
                        if (![dictData[@(12-j*4+h)] isEqualToString:@"0"]){
                            
                            
                            if ([dictData[@(12-i*4+h)] isEqualToString: dictData[@(12-j*4+h)]]) {
                                
                                
                                
                                //后边的数是 相加后的值
                                [dictData setObject:[NSString stringWithFormat:@"%d",[dictData[@(12-j*4+h)] intValue] + [dictData[@(12-i*4+h)] intValue]] forKey:@(12-i*4+h)];
                                [dictData setObject:@"0" forKey:@(12-j*4+h)];//前边的 设置为0
                                
                                
                            }
                            break; // 有了 就不再循环了
                            
                        }
                    }
                    
                }
                
                if (i==3) {
                    [self Down2:h];
                }
                
            }
            
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionvieww reloadData];
            
            [self StarGame];
        });
    });
}

-(void)Down2:(int)h{
    
    //选择排序  整理位置
    for(int i=0;i<4;i++){
        if ([dictData[@(12-i*4+h)] isEqualToString:@"0"])//i为0 的时候
        {
            
            for (int j=i+1; j<4; j++)
            {
                if (![dictData[@(12-j*4+h)] isEqualToString:@"0"]) //j 有值的时候
                    
                    //i 的值 为j 的。j设置为0
                {
                    
                    [dictData setObject:dictData[@(12-j*4+h)] forKey:@(12-i*4+h)];
                    [dictData setObject:@"0" forKey:@(12-j*4+h)];
                    
                    
                    break; // 继续下一次循环
                }
                
            }
            
        }
        
    }
    
}
-(void)silidingRight{
    
    [self huadongqingchuWithInt:4];
    
    if (right>3) {
        return;
    }
    right +=1;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int h = 0; h<4; h++) {
            
            //选择 筛选相邻数字相加。只相加一次
            for (int i=0; i<4; i++) {
                
                if (![dictData[@(3-i+h*4)] isEqualToString:@"0"])
                    
                {
                    
                    for (int j=i+1; j<4; j++) {
                        
                        
                        if (![dictData[@(3-j+h*4)] isEqualToString:@"0"]){
                            
                            
                            if ([dictData[@(3-i+h*4)] isEqualToString: dictData[@(3-j+h*4)]]) {
                                
                                
                                
                                //后边的数是 相加后的值
                                [dictData setObject:[NSString stringWithFormat:@"%d",[dictData[@(3-j+h*4)] intValue] + [dictData[@(3-i+h*4)] intValue]] forKey:@(3-i+h*4)];
                                [dictData setObject:@"0" forKey:@(3-j+h*4)];//前边的 设置为0
                                
                                
                            }
                            break; // 有了 就不再循环了
                            
                        }
                    }
                    
                }
                
                if (i==3) {
                    [self right2:h];
                }
                
            }
            
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionvieww reloadData];
            
            [self StarGame];
        });
    });
    
}

-(void)right2:(int)h{
    
    //选择排序  整理位置
    for(int i=0;i<4;i++){
        if ([dictData[@(3-i+h*4)] isEqualToString:@"0"])//i为0 的时候
        {
            
            for (int j=i+1; j<4; j++)
            {
                if (![dictData[@(3-j+h*4)] isEqualToString:@"0"]) //j 有值的时候
                    
                    //i 的值 为j 的。j设置为0
                {
                    
                    [dictData setObject:dictData[@(3-j+h*4)] forKey:@(3-i+h*4)];
                    [dictData setObject:@"0" forKey:@(3-j+h*4)];
                    
                    
                    break; // 继续下一次循环
                }
                
            }
            
        }
        
    }
    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dictData.count;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1, 1, 1, 1);
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(cellWidth,cellWidth);
                      
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

           if ([dictData[@(indexPath.row)] isEqualToString:@"0"] ) {
               
               UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
               
            [cell.contentView addSubview:[HoleviewOfEmpty HoleViewOfEmptyWithNumber:_numViewEmpty andView:cellWidth  typenum:_numViewEmptytype]];
               cell.contentView.layer.cornerRadius = IPHONEWIDTH(15);
               cell.contentView.layer.masksToBounds = YES;
                return cell;
            
        }

    NumberViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellnum" forIndexPath:indexPath];
    
    int _number = [dictData[@(indexPath.row)] intValue];
    cell.contentView.backgroundColor = [UIColor colorWithRed:((_number%255)*20%255)/255.0f green:(40+_number/255+_number%255*10)%255/255.0f blue:(80+((_number%255)%9)*20)%255/255.0f alpha:1];
    
    cell.label.text = dictData[@(indexPath.row)];
    return cell;
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
