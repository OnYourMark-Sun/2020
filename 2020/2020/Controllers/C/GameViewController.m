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

#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface GameViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UMSocialShareMenuViewDelegate>
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
    int SameHandNum,backKong;
    int top,left,dowm,right;
    
    
    UIImage * viewimage;
}

@end

@implementation GameViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.fd_interactivePopDisabled = YES;
    //状态栏颜色
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor =clearCo;
    }
    

    
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
    //自定义🌿_numViewEmptytype
    backKong = 0;
    int backkong =[[[NSUserDefaults standardUserDefaults]objectForKey:@"backKong"] intValue];
    _numViewEmptytype = backkong>0?backkong:(int)arc4random()%5;
    //同一个手势 最多可以滑动的次数
    SameHandNum = 3;
}

//完成游戏。保存记录。
-(void)savegameRecord{
    
   
    
    NSString * addString;
    
    if (_challengeName.length >0) {
        //是登陆进来的
        
        
        //游戏记录对比
        NSMutableDictionary * gamecenter = [NSMutableDictionary dictionary];
        NSMutableDictionary * dictgame = [NSMutableDictionary dictionary];
        [dictgame setDictionary:UserDefault(dictGame)];
        [gamecenter setDictionary:dictgame[_GameNum]];
        
        
        NSDictionary * recordNew = @{@"name":_challengeName,@"record":[NSString stringWithFormat:@"%ld",timernumber]};
        
        //1\ 原来记录是否大于0-》是否大于这个
        if ( [(gamecenter[@"gamerRecord1"][@"record"]) intValue] > 0) {
            
            if  (timernumber < [(gamecenter[@"gamerRecord1"][@"record"]) intValue]) {
               
                UILabel * noOne = (UILabel*)[self.view viewWithTag:123];
                noOne.text = [NSString stringWithFormat:@"%@\n%@",_record1Name,[self timerChangeString:[NSString stringWithFormat:@"%ld",timernumber]]];
                addString = @"创造本等级历史第一！";
                [gamecenter setValue:gamecenter[@"gamerRecord2"] forKey:@"gamerRecord3"];
                [gamecenter setValue:gamecenter[@"gamerRecord1"] forKey:@"gamerRecord2"];
                [gamecenter setObject:recordNew forKey:@"gamerRecord1"];
                
            }
            
            else if ([(gamecenter[@"gamerRecord2"][@"record"]) intValue] >0){
               
                if (timernumber < [(gamecenter[@"gamerRecord2"][@"record"]) intValue]) {
                    addString = @"创造本等级历史第二！";
                    [gamecenter setValue:gamecenter[@"gamerRecord2"] forKey:@"gamerRecord3"];
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
          
            UILabel * noOne = (UILabel*)[self.view viewWithTag:123];
            noOne.text = [NSString stringWithFormat:@"%@\n%@",_record1Name,[self timerChangeString:[NSString stringWithFormat:@"%ld",timernumber]]];
            addString = @"创造本等级历史第一！";
            [gamecenter setObject:recordNew forKey:@"gamerRecord1"];
            
        }
        
        [dictgame setValue:gamecenter forKey:_GameNum];
        
        UserDefaults(dictgame, dictGame);
        
        
        //个人记录对比
        
        NSMutableDictionary * challengerRecordzong = [NSMutableDictionary dictionary];
        NSMutableDictionary * challengerRecord = [NSMutableDictionary dictionary];
        NSMutableDictionary * challlengeGame = [NSMutableDictionary dictionary];
       //个人游戏记录
        [challengerRecordzong setDictionary:UserDefault(dictchallenger)];
        [challengerRecord setDictionary:challengerRecordzong[_challengeName]];
        [challlengeGame setDictionary:challengerRecord[@"game"]];
        
        
        if ([(challlengeGame[_GameNum]) intValue]>0) {
           
            if (timernumber < [challlengeGame[_GameNum] intValue]) {
                if (!addString.length) {
                    UILabel * noOne = (UILabel*)[self.view viewWithTag:125];
                    noOne.text = [NSString stringWithFormat:@"%@\n%@",_record1Name,[self timerChangeString:[NSString stringWithFormat:@"%ld",timernumber]]];
                    addString = @"打破个人历史记录！";
                }
                [challlengeGame setObject:[NSString stringWithFormat:@"%ld",timernumber] forKey:_GameNum];
            }
            
        }else{
            
            if (!addString.length) {
                UILabel * noOne = (UILabel*)[self.view viewWithTag:125];
                noOne.text = [NSString stringWithFormat:@"%@\n%@",_record1Name,[self timerChangeString:[NSString stringWithFormat:@"%ld",timernumber]]];
                addString = @"打破个人历史记录！";
            }
            
            [challlengeGame setObject:[NSString stringWithFormat:@"%ld",timernumber] forKey:_GameNum];
            
            
        }
        
        [challengerRecord setObject:challlengeGame forKey:@"game"];
        [challengerRecordzong setObject:challengerRecord forKey:_challengeName];
        
        UserDefaults(challengerRecordzong, dictchallenger);
    
    
}
    
    
    
    NSInteger haomiao,miao,fen;
    haomiao = timernumber%100;
    miao = timernumber/100%60;
    fen = timernumber/6000;

    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"OH耶！！！" message:[NSString stringWithFormat:@"\n%02ld:%02ld:%02ld \n %@\n 分享给好盆有一起挑战吧",fen,miao,haomiao,addString?addString:@""] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * jixu = [UIAlertAction actionWithTitle:@"再来一局" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //继续
        [dictData removeAllObjects];
        [self creaDATA];
        [collectionvieww reloadData];
        timernumber = 0;
        [self StarGame];
        [self timerStar];
    }];
    
    UIAlertAction * fenxiang = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //分享
        [self shareImageText:[NSString stringWithFormat:@"【%@】%02ld:%02ld:%02ld完成【%@】,快来挑战吧",_challengeName,fen,miao,haomiao,_GameNum] ];
        

    }];
  
    [alert addAction:jixu];
    [alert addAction:fenxiang];
    
    [self presentViewController:alert animated:YES completion:^{
    }];
     [self starVimage];
}
//开始剪裁图片
-(void)starVimage{
    UIGraphicsBeginImageContext(self.view.bounds.size);     //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    viewimage = image;
//    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    

}
//修改图片尺寸
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
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
-(void)shareImageText:(NSString*)string{
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina)]];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//         根据获取的platformType确定所选平台进行下一步操作
         [self shareImageAndTextToPlatformType:platformType WithShareText:string title:@"【2020】任意等级来挑战！" withSmallImage:nil withImage:viewimage];
    }];
    
    //设置分享面板的显示和隐藏的代理回调
    [UMSocialUIManager setShareMenuViewDelegate:self];
    
}
//分享 图文
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType WithShareText:(NSString*)textShare  title:(NSString*)title withSmallImage:(UIImage *)smallImage withImage:(UIImage *)image
{

    //网页
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:textShare thumImage:image];
    //设置网页地址
    shareObject.webpageUrl =@"https://mp.weixin.qq.com/s?__biz=MzUxMjE4NDAxNg==&mid=2247486092&idx=1&sn=709c55d5a9114b9804b09680c0b2d448&chksm=f9691133ce1e98259122ba60ad817f5604cd957e3782145a67cc86ecc3aff593d962aa08451c&mpshare=1&scene=1&srcid=09158idmjCMi3G6HYPmX8iyH&key=2b90ec7443e03053de48c360d0f1e1c97388e84d74dcfb4011234d18de49a665c08365ac2d9d03de0574e47264b677944c1cdb08dda6413291697701522e927e67a76663ef214460c12029a64c82a56e&ascene=0&uin=MTYzNDMzNDQ0MQ%3D%3D&devicetype=iMac+Macmini7%2C1+OSX+OSX+10.12.1+build(16B2657)&version=12020810&nettype=WIFI&fontScale=100&pass_ticket=%2BonKGGVZNln9yRB1%2FcBvBjJw4HMaXw0FksAAupfQDMNtmTXNv3w9wWVGpgDsN6rb";
//    @"http://m.youku.com/video/id_XMjg3ODgyMTI4OA==.html?sharefrom=iphone&from=message&source=";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
       
       
        if (error) {
              [MBProgressHUD showText:@"分享失败了，我里个去😯" HUDAddedTo:self.view animated:YES afterDelay:1];
            
        }else{
            
            
            [MBProgressHUD showText:@"分享成功，再挑战一下记录吧" HUDAddedTo:self.view animated:YES afterDelay:1];
                   }
      
      
    }];
    
    [self performSelector:@selector(fanhuizhu) withObject:nil afterDelay:1.5];
}
-(void)fanhuizhu{
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)CreatUp{

    UILabel  * game = [myLabel labelWithframe:CGRectMake(ScreenWidth/2-IPHONEWIDTH(110), IPHONEHIGHT(70), IPHONEWIDTH(260), IPHONEHIGHT(90)) backgroundColor:clearCo title:_GameNum font:IPHONEWIDTH(90) Alignment:NSTextAlignmentCenter textColor:[UIColor yellowColor]];
    
    game.layer.cornerRadius = IPHONEWIDTH(10);
    game.layer.masksToBounds = YES;
    [imgview addSubview:game];
    
    UILabel  * gameRecord = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(5), IPHONEHIGHT(110), IPHONEWIDTH(300), IPHONEHIGHT(120)) backgroundColor:clearCo title:@"" font:IPHONEWIDTH(45) Alignment:NSTextAlignmentLeft textColor:[UIColor redColor]];
    gameRecord.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    if ([_GameRecord1 isEqualToString:@"00:00:00"]) {
        gameRecord.text = @"你将创造历史";
    }else{
        gameRecord.text =  [NSString stringWithFormat:@"%@\n%@",_record1Name,_GameRecord1];
    }
    gameRecord.textAlignment = NSTextAlignmentCenter;
    gameRecord.numberOfLines = 2;
    [imgview addSubview:gameRecord];
 

    if (!_challengeName) {
         UILabel * challenger = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(30), IPHONEHIGHT(190+60), IPHONEWIDTH(280), IPHONEHIGHT(120)) backgroundColor:clearCo title:@"" font:IPHONEWIDTH(40) Alignment:NSTextAlignmentLeft textColor:ColorRGB(29, 115, 235)];
        challenger.text = @"游客身份\n时间不记录";
        challenger.tag = 123;
        challenger.numberOfLines = 2;
        [imgview addSubview:challenger];
    }else{

        UILabel * challengerReco = [myLabel labelWithframe:CGRectMake(IPHONEWIDTH(5), IPHONEHIGHT(260), IPHONEWIDTH(300), IPHONEHIGHT(120)) backgroundColor:clearCo title:[NSString stringWithFormat:@"%@\n%@",_challengeName,[self timerChangeString:_challengeRecord]] font:IPHONEWIDTH(45) Alignment:NSTextAlignmentLeft textColor:ColorRGB(29, 115, 230)];
        challengerReco.tag = 125;
        challengerReco.textAlignment = NSTextAlignmentCenter;
        challengerReco.numberOfLines = 2;
        if (!_challengeRecord.length) {
            challengerReco.text = @"赶快创造纪录吧";
            
        }
        [imgview addSubview:challengerReco];
  
    }

    /*
     //设置 空位背景
    //空位背景图
    CGFloat widthb = IPHONEWIDTH(100);
    NSArray * arraybut = @[@"空",@"位",@"图",@"案",@"~"];
    NSArray * arrayImg = @[@"maquan.jpg",@"xuanzhuan.jpg",@"zhima.jpg",@"liangdian.jpg",@"555.jpg"];
    for (int i=0; i<4; i++) {
        //[UIColor colorWithPatternImage:[UIImage imageNamed:arrayImg[i]]]
        UIImageView * imgVi = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-IPHONEWIDTH(240)+i%2*(widthb+IPHONEWIDTH(20)), i/2*(widthb+IPHONEWIDTH(20))+IPHONEHIGHT(220), widthb, widthb)];
        imgVi.image = [UIImage imageNamed:arrayImg[i]];
        imgVi.layer.cornerRadius = widthb/2;
        imgVi.layer.masksToBounds = YES;
        [self.view addSubview:imgVi];
        
        
        UIButton *but = [myButton buttonWithType:UIButtonTypeSystem frame:CGRectMake(ScreenWidth-IPHONEWIDTH(240)+i%2*(widthb+IPHONEWIDTH(20)), i/2*(widthb+IPHONEWIDTH(20))+IPHONEHIGHT(220), widthb, widthb) title:arraybut[i] andBackground:clearCo tag:i+1001 andBlock:^(myButton *button) {
            backKong =0;
            _numViewEmptytype =button.tag-1001;
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",_numViewEmptytype] forKey:@"backKong"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",_numViewEmpty] forKey:@"backKongkong"];
            
            //刷新 空图
            [collectionvieww reloadData];
            
            
        }];
        but.layer.cornerRadius = widthb/2;
        but.layer.masksToBounds = YES;
        [but setTitleColor:ColorRGB(29, 115, 230) forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(40)];
        [self.view addSubview:but];
    }
    
    //第五个
    UIImageView * imgVi = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-IPHONEWIDTH(240)+0.5*(widthb+IPHONEWIDTH(20)), 0.5*(widthb+IPHONEWIDTH(20))+IPHONEHIGHT(220), widthb, widthb)];
    imgVi.image = [UIImage imageNamed:arrayImg[4]];
    imgVi.layer.cornerRadius = widthb/2;
    imgVi.layer.masksToBounds = YES;
    [self.view addSubview:imgVi];
    
    
    UIButton *but = [myButton buttonWithType:UIButtonTypeSystem frame:CGRectMake(ScreenWidth-IPHONEWIDTH(240)+0.5*(widthb+IPHONEWIDTH(20)), 0.5*(widthb+IPHONEWIDTH(20))+IPHONEHIGHT(220), widthb, widthb) title:arraybut[4] andBackground:clearCo tag:1005 andBlock:^(myButton *button) {
        _numViewEmpty =backKong%3+2;
        _numViewEmptytype = 4;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",_numViewEmptytype] forKey:@"backKong"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",_numViewEmpty] forKey:@"backKongkong"];
        
        //刷新 空图
        if (!backKong) {
            [collectionvieww removeFromSuperview];
            [self creatCollc];
        }else{
            
            [collectionvieww reloadData];
        }
        backKong++;
        
    }];
    but.layer.cornerRadius = widthb/2;
    but.layer.masksToBounds = YES;
    [but setTitleColor:ColorRGB(29, 115, 230) forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(40)];
    [self.view addSubview:but];
    
    */
}
-(NSString*)timerChangeString:(NSString*)string{
    
    int time = [string intValue];
    int hao = time/100;
    int miao = time/100%60;
    int fen = time/6000;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",fen,miao,hao];
}
-(void)creatCollc{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    collectionvieww = [[UICollectionView alloc] initWithFrame:CGRectMake(IPHONEWIDTH(28), (ScreenHeight-ScreenWidth)/3*2+IPHONEHIGHT(190), ScreenWidth-IPHONEWIDTH(28*2), ScreenWidth-IPHONEWIDTH(56)) collectionViewLayout:layout];
    collectionvieww.backgroundColor = [UIColor clearColor];
    collectionvieww.delegate = self;
    collectionvieww.dataSource = self;
    collectionvieww.allowsMultipleSelection = YES;
    [collectionvieww registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionvieww registerClass:[NumberViewCollectionViewCell class] forCellWithReuseIdentifier:@"cellnum"];
    [imgview addSubview:collectionvieww];
}
-(void)Creatui{
    
    //背景
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    imgview.image = [UIImage imageNamed:@"jing.jpg"];
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    imgview.userInteractionEnabled = YES;
    [self.view addSubview:imgview];
    [self creatCollc];
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
    
    StarBut.frame = CGRectMake(ScreenWidth/2-IPHONEWIDTH(80), IPHONEHIGHT(430), IPHONEWIDTH(200), IPHONEWIDTH(80));
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
    labelTimer = [myLabel labelWithframe:CGRectMake(ScreenWidth-IPHONEWIDTH(180+28), IPHONEHIGHT(130), IPHONEWIDTH(180), IPHONEHIGHT(60)) backgroundColor:[UIColor clearColor] title:@"00:00:00" font:IPHONEWIDTH(40) Alignment:NSTextAlignmentCenter textColor:[UIColor redColor]];
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
        [timerss setFireDate:[NSDate distantFuture]];
        
       [UIView pushAlertTwoActionViewWithMessage:@"游戏暂停\n点击继续／退出" Target:self Title:@"提示" oneAlertTitle:@"继续🎮" twoAlertTitle:@"退出🎮" oneActionfunc:^{
           
           [timerss setFireDate:[NSDate date]];
           
       } twoActionfunc:^{
           
           [timerss invalidate];
           timerss  = nil;
           [self.navigationController popViewControllerAnimated:YES];
           
       }];
        
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
    
    if (top>SameHandNum-1) {
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
    
    if (left>SameHandNum-1) {
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
    
    if (dowm>SameHandNum-1) {
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
    
    if (right>SameHandNum-1) {
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
