//
//  HomeViewController.m
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "MyLocationViewController.h"
#import "ModulesManager.h"
#import "UserDefault.h"
#import "JPLoginViewController.h"
#import "MyParentsViewController.h"
#import "HealthStoreViewController.h"
#import "FindDoctorViewController.h"
#import "HouseKeepViewController.h"
#import "OldFlatViewController.h"
#import "OldGHViewController.h"
#import "OldHealthViewController.h"
#import "OldLifeViewController.h"
#import "AdvertiseViewController.h"
#import "QiangGouViewController.h"
#import "HomeHoudongCellOne.h"
#import "HealthFileViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,ThemeTitleTableViewCellDelegate,HomeGoudongCellOneDelegate,HuodongCellTwoDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>


@property (strong, nonatomic) CycleScrollView *adsView;
@property (retain, nonatomic) NSArray *adsArray;

@property (nonatomic, strong) NSMutableArray *funlist;

@property (strong, nonatomic) NSString *zoneCode;

@property (strong, nonatomic) UIView *cateView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) BMKGeoCodeSearch *locationSearch;

@property (nonatomic,assign) float lng;
@property (nonatomic,assign) float lat;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"首页"];
    
    self.tabBarItem.title = @"首页";
    self.tabBarItem.image=[UIImage imageNamed:@"frist_normal"];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"frist_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // Do any additional setup after loading the view.
    
    if (_funlist==nil) {
        _funlist=[[NSMutableArray alloc]init];
    }
    
    UIButton *mapBtn=[UIButton buttonWithType:UIButtonTypeCustom];;
    [mapBtn setFrame:CGRectMake(0, 0, 90, 30)];
    
    [mapBtn setImage:[UIImage imageNamed:@"location_pic.png"] forState:UIControlStateNormal];
    mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-40,-mapBtn.titleLabel.bounds.size.width,0);
    
    [mapBtn setTitle:CityZoneName forState:UIControlStateNormal];
    mapBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    mapBtn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [mapBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    mapBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -mapBtn.titleLabel.bounds.size.width-45, 0, 0);
    
    [mapBtn addTarget:self action:@selector(mapClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:mapBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView addHeaderWithTarget:self action:@selector(reloadData)];
    [self.view addSubview:_tableView];
    
    //广告：定时器广告图片切换
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (120.0 + 130.0) * SCREEN_WSCALE)];
    {
        __weak HomeViewController *weakSelf=self;
        self.adsView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120.0 * SCREEN_WSCALE) animationDuration:3];
        
        [_adsView setFetchContentViewAtIndex:^UIView *(NSInteger pageIndex){
            if (pageIndex < [weakSelf.adsArray count]) {
                if (pageIndex == 0) {
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120.9 * SCREEN_WSCALE)];
                    
                    NSString *url= @"";
                    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"image1.jpg"]];
                    
                    return imageView;
                }else if(pageIndex == 1){
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120.9 * SCREEN_WSCALE)];
                    
                    NSString *url= @"";
                    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"image2.jpg"]];
                    
                    return imageView;
                }else if(pageIndex == 2){
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120.9 * SCREEN_WSCALE)];
                    
                    NSString *url= @"";
                    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"image3.jpg"]];
                    
                    return imageView;
                }
            }
            /**
             if (pageIndex < [weakSelf.adsArray count]) {
             NSDictionary *dict=[weakSelf.adsArray objectAtIndex:pageIndex];
             UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150.9 * SCREEN_WSCALE)];
             NSString *name=[dict objectForKey:@"img"];
             NSString *url= [NSString stringWithFormat:@"%@",name];
             
             [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon.png"]];
             
             return imageView;
             }**/
            return [[UIView alloc] initWithFrame:CGRectZero];
        }];
        
        [_adsView setTapActionBlock:^(NSInteger pageIndex){
            if (pageIndex <[weakSelf.adsArray count]) {
                AdvertiseViewController *advertiseVC=[weakSelf.storyboard instantiateViewControllerWithIdentifier:@"AdvertiseViewController"];
                advertiseVC.type=@"guanggao";
                [[ModulesManager defaultManager].navigationController pushViewController:advertiseVC animated:YES];
            }
        }];
        [headerView addSubview:_adsView];
    }
    
    //服务菜单
    {
        self.cateView = [[UIView alloc] initWithFrame:CGRectMake(0, _adsView.frame.size.height+5, SCREEN_WIDTH, 120 * SCREEN_WSCALE)];
        
        NSArray *cateArray = @[@"找医生",@"健康商城",@"健康档案",@"家政服务",@"老年保健",@"老年生活",@"老年公寓",@"老年养生"];
        
        CGFloat width=self.cateView.frame.size.width/4.0;
        for (int i=0; i<[cateArray count]; i++) {
            UIButton *cateButton = [UIButton buttonWithType:UIButtonTypeCustom];
            cateButton.frame = CGRectMake((i % 4) * width, (i / 4) * 60 * SCREEN_WSCALE, width, 60 * SCREEN_WSCALE);
            [cateButton setImage:[UIImage imageNamed:@"no_image.9.png"] forState:UIControlStateNormal];
            //[cateButton.imageView setImage:[UIImage imageNamed:@"no_image.9.png"]];
            cateButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
            cateButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            cateButton.tag = -1;
            
            [cateButton addTarget:self action:@selector(productListButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.cateView addSubview:cateButton];
            
        }
        /**
         for (int i = 1; i < [cateArray count] / 4; i ++) {
         UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, i * 40 * SCREEN_WSCALE, SCREEN_WIDTH, 0.5)];
         lineView.backgroundColor = [UIColor lightGrayColor];
         [self.cateView addSubview:lineView];
         }
         for (int i = 1; i < 3; i ++) {
         UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, 0.5, 120 * SCREEN_WSCALE)];
         lineView.backgroundColor = [UIColor lightGrayColor];
         [self.cateView addSubview:lineView];
         }**/
        
        [headerView addSubview:self.cateView];
    }
    //[self.tableView addSubview:headerView];
    self.tableView.tableHeaderView = headerView;
    
    [self setExtraCellLineHidden:_tableView];
    
    [self reloadData];
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    
    self.locationSearch = [[BMKGeoCodeSearch alloc] init];
    self.locationSearch.delegate = self;
    
    [self.locationService startUserLocationService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![self.zoneCode isEqualToString:CityZoneCode]) {
        self.zoneCode = CityZoneCode;
        [self reloadData];
    }
    
    UIButton *mapBtn=[UIButton buttonWithType:UIButtonTypeCustom];;
    [mapBtn setFrame:CGRectMake(0, 0, 90, 30)];
    
    [mapBtn setImage:[UIImage imageNamed:@"location_pic.png"] forState:UIControlStateNormal];
    mapBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-40,-mapBtn.titleLabel.bounds.size.width,0);
    
    [mapBtn setTitle:CityZoneName forState:UIControlStateNormal];
    mapBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    mapBtn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [mapBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    if (SCREEN_HEIGHT > 480) {
        mapBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -mapBtn.titleLabel.bounds.size.width-45, 0, 0);
    } else {
        mapBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -mapBtn.titleLabel.bounds.size.width, 0, 0);
    }

    [mapBtn addTarget:self action:@selector(mapClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:mapBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];
}


//定位成功
-(void) didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    if (userLocation) {
        
        self.lng = userLocation.location.coordinate.longitude;
        self.lat = userLocation.location.coordinate.latitude;
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        BMKReverseGeoCodeOption *options = [[BMKReverseGeoCodeOption alloc] init];
        options.reverseGeoPoint = pt;
        
        [self.locationSearch reverseGeoCode:options];
    }
}
- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"location error %@",error);
    [Utils showAlertView:@"注意：" :@"当前软件定位权限已被禁止,请到手机设置》金牌保镖》位置中开启!" :@"知道了"];
}

//地址解析
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        [self.locationService stopUserLocationService];
        self.locationService.delegate = nil;
        self.locationSearch.delegate = nil;
        
        
        /**
         NSDictionary *dictData=[NSDictionary dictionaryWithObjectsAndKeys:
         result.addressDetail.district,@"countyName",
         result.addressDetail.city,@"cityName",
         [NSNumber numberWithInteger:3],@"regDevice",
         //CityZoneCode,@"zoneCode",
         @"IOS",@"os",
         [[[NSBundle mainBundle] infoDictionary ] valueForKey:@"CFBundleVersion"],@"appv",
         nil];
         NSString *json = [dictData JSONRepresentation];
         
         NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:
         json,@"postData",
         @"IOS",@"os",
         [[[NSBundle mainBundle] infoDictionary ] valueForKey:@"CFBundleVersion"],@"appv",
         //CityZoneCode,@"zoneCode",
         @"12",@"skey",
         @"13",@"sid",
         @"14",@"slock",nil];
         
         NSString *URL=[NSString stringWithFormat:@"%@%@",COMMON_URL,@"zone/getZoneCode.htm"];
         
         [HttpBaseAction postRequest2:dict url:URL complete:^(id result, NSError *error) {
         int flag=[(NSNumber*)[result objectForKey:@"resultFlag"]intValue];
         //NSString *resultMsg=[result objectForKey:@"resultMsg"];
         if (flag==1) {
         NSDictionary *dic = [result objectForKey:@"resultData"];
         NSString *code = [dic valueForKey:@"code"];
         NSString *name = [dic valueForKey:@"name"];
         
         if ([code isEqualToString:@""] || [name isEqualToString:@""]) {
         return ;
         }
         
         if (![self.zoneCode isEqualToString:code]) {
         [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"CityName"];
         [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"zoneCode"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         self.zoneCode = code;
         
         UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
         rightButton.frame = CGRectMake(0, 0, 55, 30);
         rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
         rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 42, 0, 0);
         rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
         rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
         [rightButton addTarget:self action:@selector(citySelect) forControlEvents:UIControlEventTouchUpInside];
         [rightButton setTitle:CityZoneName forState:UIControlStateNormal];
         [rightButton setImage:[UIImage imageNamed:@"android_list_down@2x.png"] forState:UIControlStateNormal];
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
         
         [self reloadData];
         }
         }
         }];**/
    }
}


- (IBAction)productListButtonClicked:(id)sender {
    
    if(UserDefaultEntity.session_id.length == 0){
        JPLoginViewController *loginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"JPLoginViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    UIButton *button=(UIButton*)sender;
    button.highlighted=NO;
    NSInteger listed=button.tag;
    
    //NSLog(@"参数＋＋＋＋＋：%ld",listed);
    
    if (listed==1) {
        
        FindDoctorViewController *findDoctorVC=[self.storyboard instantiateViewControllerWithIdentifier:@"FindDoctorViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:findDoctorVC animated:YES];
        
    }else if (listed==2){
        
        HealthStoreViewController *healthStoreVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HealthStoreViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:healthStoreVC animated:YES];
        
    }else if (listed==3) {
        HealthFileViewController *healthFileVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HealthFileViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:healthFileVC animated:YES];
    }else if (listed==4) {
        
        HouseKeepViewController *houseKeepVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HouseKeepViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:houseKeepVC animated:YES];
        
    }else if (listed==5) {
        
        OldHealthViewController *oldHealthVC=[self.storyboard instantiateViewControllerWithIdentifier:@"OldHealthViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:oldHealthVC animated:YES];
        
    }else if (listed==6) {
        
        OldLifeViewController *oldLifeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"OldLifeViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:oldLifeVC animated:YES];
        
    }else if (listed==7) {
        
        OldFlatViewController *oldFlatVC=[self.storyboard instantiateViewControllerWithIdentifier:@"OldFlatViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:oldFlatVC animated:YES];
        
    }else if (listed==8) {
        
        OldGHViewController *oldGHVC =[self.storyboard instantiateViewControllerWithIdentifier:@"OldGHViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:oldGHVC animated:YES];
    }
    
}

-(void)reloadData{
    NSArray *buildList=@[@"1",@"2",@"3"];
    self.adsArray = buildList;
    [_adsView setTotalPagesCount:^NSInteger{
        return [buildList count];
    }];
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *item=[[NSMutableArray alloc]init];
    
    [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                     @"西安豪华2日游",@"name",
                     @"999",@"dongPrice",
                     @"2999",@"truePrice",
                     @"lizi_2.png",@"img",nil]];
    
    [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                     @"海南豪华3日游",@"name",
                     @"1999",@"dongPrice",
                     @"3999",@"truePrice",
                     @"lizi_1.png",@"img",nil]];
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:item,@"twoList",@"2",@"dataType", nil];
    
    NSMutableArray *item2=[[NSMutableArray alloc]init];
    
    [item2 addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                      @"海南豪华3日游",@"name",
                      @"1999",@"dongPrice",
                      @"3999",@"truePrice",
                      @"image3.jpg",@"img",nil]];
    
    NSDictionary *dict2=[NSDictionary dictionaryWithObjectsAndKeys:item2,@"oneList",@"1",@"dataType", nil];
    
    NSDictionary *dict3=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"dataType", nil];
    
    [itemArray addObject:dict3];
    [itemArray addObject:dict];
    [itemArray addObject:dict2];
    
    
    _funlist=itemArray;
    
    
    NSArray *temp = @[@"找医生",@"健康商城",@"健康档案",@"家政服务",@"老年保健",@"老年生活",@"老年公寓",@"老年养生"];
    NSArray *btns = [self.cateView subviews];
    NSInteger i = 0;
    NSInteger j = 0;
    for (UIView *view in btns) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* btn = (UIButton*)view;
            if(j < temp.count){
                //NSDictionary* dic = temp[j];
                NSString *name=temp[j];
                
                
                //NSLog(@"类型：%@",[dic objectForKey:@"name"]);
                //NSString* str = [NSString stringWithFormat:@"%@%@",HOME_IMAGE_URL,[dic valueForKey:@"img"]];
                
                // UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
                UIImage *image;
                if ([name isEqualToString:@"找医生"]) {
                    btn.tag = 1;
                    image = [UIImage imageNamed:@"see_doctor.png"];
                }else if ([name isEqualToString:@"健康商城"]){
                    btn.tag = 2;
                    image = [UIImage imageNamed:@"healthmall_pic.png"];
                }else if ([name isEqualToString:@"健康档案"]){
                    btn.tag = 3;
                    image = [UIImage imageNamed:@"healthfile_03.png"];
                }else if ([name isEqualToString:@"家政服务"]){
                    btn.tag = 4;
                    image = [UIImage imageNamed:@"houseservice_pic.png"];
                }else if ([name isEqualToString:@"老年保健"]){
                    btn.tag = 5;
                    image = [UIImage imageNamed:@"older_healthcare_pic.png"];
                }else if ([name isEqualToString:@"老年生活"]){
                    btn.tag = 6;
                    image = [UIImage imageNamed:@"older_life_pic.png"];
                }else if ([name isEqualToString:@"老年公寓"]){
                    btn.tag = 7;
                    image = [UIImage imageNamed:@"older_house.png"];
                }else if ([name isEqualToString:@"老年养生"]){
                    btn.tag = 8;
                    image = [UIImage imageNamed:@"older_health_pic.png"];
                }
                
                [btn setImage:image forState:UIControlStateNormal];
                btn.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
                btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
                
            }else{
                [btn setImage:nil forState:UIControlStateNormal];
                //btn.tag = -1;
            }
            j++;
        }
        i++;
    }
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_funlist count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<=self.funlist.count) {
        NSDictionary *dict=self.funlist[indexPath.row];
        NSInteger dataType=[[dict objectForKey:@"dataType"]integerValue];
        if (dataType ==0) {
            return 35;
        }else if (dataType ==1) {
            return 110;
        }else if (dataType==2){
            NSInteger count = [[dict valueForKey:@"twoList"] count];
            if (count >0) {
                return 185;
            }
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 10;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict=self.funlist[indexPath.row];
    NSInteger dataType=[[dict objectForKey:@"dataType"]integerValue];
    
    if (dataType==0){
        ThemeTitleTableViewCell *cell = (ThemeTitleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ThemeTitleTableViewCell"];
        if (cell == nil) {
            NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"ThemeTitleTableViewCell" owner:self options:nil];
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[ThemeTitleTableViewCell class]]) {
                    cell = (ThemeTitleTableViewCell *)oneObject;
                    cell.delegate = self;
                }
            }
        }
        cell.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (dataType ==1) {
        HomeHoudongCellOne *cell = (HomeHoudongCellOne*)[tableView dequeueReusableCellWithIdentifier:@"HomeHoudongCellOne"];
        if (cell ==nil) {
            NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"HomeHoudongCellOne" owner:self options:nil];
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[HomeHoudongCellOne class]]) {
                    cell = (HomeHoudongCellOne *)oneObject;
                    cell.delegate = self;
                }
            }
            //NSDictionary *oneDict=[dict objectForKey:@"oneList"];
            cell.tag = indexPath.row;
            [cell setCellValue:[dict objectForKey:@"oneList"]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if(dataType==2){
        NSInteger count = [[dict valueForKey:@"twoList"] count];
        if (count >0) {
            
            HuodongCellTwo *cell = (HuodongCellTwo*)[tableView dequeueReusableCellWithIdentifier:@"HuodongCellTwo"];
            if (cell == nil) {
                NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"HuodongCellTwo" owner:self options:nil];
                for (id oneObject in nibs) {
                    if ([oneObject isKindOfClass:[HuodongCellTwo class]]) {
                        cell = (HuodongCellTwo *)oneObject;
                        cell.delegate = self;
                    }
                }
            }
            
            NSMutableArray *funList=(NSMutableArray*)[dict objectForKey:@"twoList"];
            
            [cell updateData:funList];
            cell.tag = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return [[UITableViewCell alloc] init];;
}

//限时抢购
-(void)clickSubject:(ThemeTitleTableViewCell*)cell index:(NSInteger)idndex{
    QiangGouViewController *qiangGouVC=[self.storyboard instantiateViewControllerWithIdentifier:@"QiangGouViewController"];
    [[ModulesManager defaultManager].navigationController pushViewController:qiangGouVC animated:YES];
}

//宣传自己产品
-(void)dongOneCell:(HomeHoudongCellOne *)cell clickAtIndex:(NSInteger)index{
    
}

//活动选择
-(void)dongCell:(HuodongCellTwo *)cell clickAtIndex:(NSInteger)index{
    AdvertiseViewController *advertiseVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AdvertiseViewController"];
    [[ModulesManager defaultManager].navigationController pushViewController:advertiseVC animated:YES];
}

//现实我所在的位置
-(IBAction)mapClick:(id)sender{
    
    if (UserDefaultEntity.session_id.length >0) {
        MyLocationViewController *myLocation=[self.storyboard instantiateViewControllerWithIdentifier:@"MyLocationViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:myLocation animated:YES];
    }else{
        JPLoginViewController *loginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"JPLoginViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:loginVC animated:YES];
    }
}



@end
