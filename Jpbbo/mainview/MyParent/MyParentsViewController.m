//
//  MyParentsViewController.m
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "MyParentsViewController.h"
#import "ParentsCollectionViewCell.h"
#import "ServiceCode.h"
#import "AddParentCell.h"
#import "AddParentViewController.h"
#import "ParamTableViewCell.h"
#import "JKSideSlipView.h"
#import "MenuView.h"
#import "ManagerParentViewController.h"
#import "SiderbarViewController.h"
#import "HttpParentAction.h"
#import "MyParentLocation.h"
#import "JPRateViewController.h"
#import "PedometerViewController.h"
#import "JPWebViewController.h"

@interface MyParentsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>{
    BOOL selected;
    BOOL requestFlag;
    JKSideSlipView *_sideSlipView;
    
    MenuView *menu;
}

@property (nonatomic,retain) SiderbarViewController *sidebarVC;

@property (nonatomic, strong) UIView *faceView;

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *faceList;

@property (nonatomic, strong) NSMutableArray *funList;

@property (nonatomic, assign) float longitude;//jin
@property (nonatomic, assign) float latitude;//wei

@property (nonatomic, strong) NSString *rateURL;
@property (nonatomic, strong) NSString *pedometeURL;

@end

@implementation MyParentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的父母"];
    // Do any additional setup after loading the view
    
    self.tabBarItem.title = @"我的父母";
    self.tabBarItem.image=[UIImage imageNamed:@"parent_normal"];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"parent_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (_faceList == nil) {
        _faceList=[[NSMutableArray alloc]init];
    }
    
    if (_funList == nil) {
        _funList=[[NSMutableArray alloc]init];
    }
 
    CGSize itemSize = CGSizeMake(320 / 4, 100);
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = itemSize;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120) collectionViewLayout:layout];
    //UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                          //collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"ParentsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"parentViewCell"];
    
    [collectionView registerNib:[UINib nibWithNibName:@"AddParentCell" bundle:nil] forCellWithReuseIdentifier:@"addParentCell"];
    
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self setExtraCellLineHidden:_tableView];
    
    _sideSlipView = [[JKSideSlipView alloc]initWithSender:self];
    _sideSlipView.backgroundColor = [UIColor redColor];
    
    menu = [MenuView menuView];
    [menu didSelectRowAtIndexPath:^(id cell, NSIndexPath *indexPath) {
        //NSLog(@"click");
        [_sideSlipView hide];
        
         NSString *equid=[NSString stringWithFormat:@"%@",UserDefaultEntity.equipmentId];
        if (indexPath.row ==10) {
            ManagerParentViewController *managerPVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ManagerParentViewController"];
            [[ModulesManager defaultManager].navigationController pushViewController:managerPVC animated:YES];
        }else if (indexPath.row == 3) {//心率
            JPRateViewController *rateVC=[self.storyboard instantiateViewControllerWithIdentifier:@"JPRateViewController"];
            [[ModulesManager defaultManager].navigationController pushViewController:rateVC animated:YES];
        }else if (indexPath.row == 4) {//计步
            PedometerViewController *pedometerVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PedometerViewController"];
            [[ModulesManager defaultManager].navigationController pushViewController:pedometerVC animated:YES];
        }

    }];
    
    [self loadSetView];
    
    [_sideSlipView setContentView:menu];
    [self.view addSubview:_sideSlipView];

    
    [self loadCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)viewDidAppear:(BOOL)animated{
    
    [self loadCollectionView];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)loadCollectionView{
    
    [HttpParentAction getManagerSetList:UserDefaultEntity.uid complete:^(id result, NSError *error) {
        if (result) {
            NSArray *returnArray=result;
            _faceList=[[NSMutableArray alloc]initWithArray: [RMMapper arrayOfClass:[MyParents class] fromArrayOfDictionary:returnArray]];
            [self.collectionView reloadData];
        }else{
            MyParents *myparents=[[MyParents alloc]init];
            [self loadTableView:myparents];
        }
    }];

}

-(void)loadTableView:(MyParents *)dict{
    
    [HttpParentAction getParentsDetail:dict.ID complete:^(id result, NSError *error) {
        
        int flag=[(NSNumber*)[result valueForKey:@"ResultFlag"]intValue];
        NSDictionary *dict=[result valueForKey:@"ResultData"];
        
        if (flag ==1) {
            
            NSDictionary *EquipmentHeartrate=[dict valueForKey:@"EquipmentHeartrate"];;
            NSDictionary *EquipmentLocation=[dict valueForKey:@"EquipmentLocation"];
            NSDictionary *EquipmentMovementSummary=[dict valueForKey:@"EquipmentMovementSummary"];
            
            self.longitude=[(NSNumber*)[EquipmentLocation valueForKey:@"BaiduX"]floatValue];
            self.latitude=[(NSNumber*)[EquipmentLocation valueForKey:@"BaiduY"]floatValue];
            
            self.rateURL=[EquipmentHeartrate valueForKey:@"Extended1"];
            self.pedometeURL=[EquipmentMovementSummary valueForKey:@"Extended1"];
            
            NSMutableArray *item=[[NSMutableArray alloc]init];
            
            NSString *xinlv= [NSString stringWithFormat:@"%@",[EquipmentHeartrate valueForKey:@"RateData"] ];
            if (xinlv != NULL && ![xinlv isEqualToString:@""]) {
                xinlv=[NSString stringWithFormat:@"%@%@",xinlv,@"bpm"];
            } else {
                xinlv=@"暂无数据";
            }
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"心率",@"name",
                             @"xinlv_14.png",@"img",
                             xinlv,@"param",nil]];
            
            NSString *jibu= [NSString stringWithFormat:@"%@",[EquipmentMovementSummary valueForKey:@"StepsNum"] ];
            if (jibu != NULL && ![jibu isEqualToString:@""]) {
                jibu=[NSString stringWithFormat:@"%@%@",jibu,@"步"];
            } else {
                jibu=@"暂无数据";
            }
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"计步",@"name",
                             @"jibu_21.png",@"img",
                             jibu,@"param",nil]];
            
            NSString *dingwei= [NSString stringWithFormat:@"%@",[EquipmentLocation valueForKey:@"Address"] ];
            if (dingwei != NULL && ![dingwei isEqualToString:@""]) {
                dingwei=[NSString stringWithFormat:@"%@",dingwei];
            } else {
                dingwei=@"暂无定位";
            }
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"定位",@"name",
                             @"dingwei_23.png",@"img",
                             dingwei,@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"睡眠",@"name",
                             @"shuimin_25.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"血压",@"name",
                             @"xueya_27.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"血糖",@"name",
                             @"xuetang_29.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"体温",@"name",
                             @"tiwen_31.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"健康档案",@"name",
                             @"",@"param",
                             @"jiangkangdangan_33.png",@"img",nil]];
            
            _funList=item;
            
            [_tableView reloadData];
            
        }else{
            //[Utils showToastWithText:resultMsg];
            NSMutableArray *item=[[NSMutableArray alloc]init];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"心率",@"name",
                             @"xinlv_14.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"计步",@"name",
                             @"jibu_21.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"定位",@"name",
                             @"dingwei_23.png",@"img",
                             @"暂无定位",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"睡眠",@"name",
                             @"shuimin_25.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"血压",@"name",
                             @"xueya_27.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"血糖",@"name",
                             @"xuetang_29.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"体温",@"name",
                             @"tiwen_31.png",@"img",
                             @"暂无数据",@"param",nil]];
            
            [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                             @"健康档案",@"name",
                             @"",@"param",
                             @"jiangkangdangan_33.png",@"img",nil]];
            
            _funList=item;
            [_tableView reloadData];
        }
    }];
}

-(void)loadSetView{
    
    NSMutableArray *item=[[NSMutableArray alloc]init];
    
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     @"健康周报",@"title",
                     @"zhoubao_03.png",@"imagename",
                     @"1",@"type",nil]];
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     @"123",@"title",
                     @"123",@"imagename",
                     @"2",@"type", nil]];
    
    
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     @"健康设定",@"title",
                     @"jkset_10.png",@"imagename",
                     @"3",@"type", nil]];
    
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                      @"心率",@"title",
                      @"xinlv_14.png",@"imagename",@"4",@"type", nil]];
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                      @"计步",@"title",
                      @"jibu_23.png",@"imagename",@"4",@"type", nil]];
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                      @"定位",@"title",
                      @"dingwei_26.png",@"imagename",@"4",@"type", nil]];
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                      @"睡眠",@"title",
                      @"shuimin_28.png",@"imagename", @"4",@"type",nil]];
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                      @"血压",@"title",
                      @"xueya_30.png",@"imagename",@"4",@"type", nil]];
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                      @"血糖",@"title",
                      @"xuetang_32.png",@"imagename",
                     @"4",@"type",nil]];
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                      @"体温",@"title",
                      @"tiwen_34.png",@"imagename",
                     @"4",@"type",nil]];
    
    [item addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     @"设备管理",@"title",
                     @"setmanager_36.png",@"imagename",
                     @"5",@"type",nil]];
    
    menu.items =item;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_faceList count]+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_faceList count] == indexPath.row) {
        AddParentCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"addParentCell" forIndexPath:indexPath];
        [cell.addImageView setImage:[UIImage imageNamed:@"addParent_03.png"]];
        
        return cell;
    }

    MyParents *myparents = [_faceList objectAtIndex:indexPath.row];
    ParentsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"parentViewCell" forIndexPath:indexPath];
    
    //NSString *url=[NSString stringWithFormat:@"%@%@",HOME_IMAGE_URL,[dict objectForKey:@"PhotoParth"]];
    //[cell.faceImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"oldman_03.png"]];
    [cell.faceImageView setImage:[UIImage imageNamed:@"oldman_03.png"]];
    cell.nameLabel.text = myparents.CustomerName;
    
    NSString *EID=[NSString stringWithFormat:@"%@",myparents.ID];
    NSString *equid=[NSString stringWithFormat:@"%@",UserDefaultEntity.equipmentId];

    if ([EID isEqualToString:equid]) {
        [cell.selectedImageView setImage:[UIImage imageNamed:@"selected_03.png"]];
        
        [self loadTableView:myparents];
        
    }else if (![EID isEqualToString:equid]){
        [cell.selectedImageView setImage:[UIImage imageNamed:@""]];
    }else if (UserDefaultEntity.equipmentId == nil) {
        if (indexPath.row ==0) {
            [cell.selectedImageView setImage:[UIImage imageNamed:@"selected_03.png"]];
            UserDefaultEntity.equipmentId=myparents.ID;
            [UserDefault saveUserDefault];
            
            [self loadTableView:myparents];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_faceList count] == indexPath.row) {
        AddParentViewController *addParentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddParentViewController"];
        addParentVC.type=@"add";
        [[ModulesManager defaultManager].navigationController pushViewController:addParentVC animated:YES];
    }else{
        MyParents *dict = [_faceList objectAtIndex:indexPath.row];
        
        UserDefaultEntity.equipmentId=dict.ID;
        [UserDefault saveUserDefault];
        
        [self loadCollectionView];
        [self loadTableView:dict];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;//分组数
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_funList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict=[_funList objectAtIndex:indexPath.row];
    
    ParamTableViewCell *cell = (ParamTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ParamTableViewCell"];
    if (cell == nil) {
        NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"ParamTableViewCell" owner:self options:nil];
        for (id oneObject in nibs) {
            if ([oneObject isKindOfClass:[ParamTableViewCell class]]) {
                cell = (ParamTableViewCell *)oneObject;
            }
        }
    }
    
    [cell updateData:dict];
    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSDictionary *dict=[_funList objectAtIndex:indexPath.row];
    
    if(indexPath.row ==0){
        JPWebViewController *webViewVC=[self.storyboard instantiateViewControllerWithIdentifier:@"JPWebViewController"];
        webViewVC.url=self.rateURL;
        [[ModulesManager defaultManager].navigationController pushViewController:webViewVC animated:YES];
    }else if(indexPath.row ==1){
        JPWebViewController *webViewVC=[self.storyboard instantiateViewControllerWithIdentifier:@"JPWebViewController"];
        webViewVC.url=self.pedometeURL;
        [[ModulesManager defaultManager].navigationController pushViewController:webViewVC animated:YES];
    }else if(indexPath.row ==2){
        MyParentLocation *mpLocation=[self.storyboard instantiateViewControllerWithIdentifier:@"MyParentLocation"];
        mpLocation.longitude=_longitude;
        mpLocation.latitude=_latitude;
        [[ModulesManager defaultManager].navigationController pushViewController:mpLocation animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(IBAction)setParam:(id)sender{
    [_sideSlipView switchMenu];
}

-(IBAction)refresh:(id)sender{
    [self loadCollectionView];
}

@end
