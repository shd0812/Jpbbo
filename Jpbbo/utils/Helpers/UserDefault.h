
//
//

#import <Foundation/Foundation.h>
//	==================================================== 系统宏 =============================================
#define UserDefaultEntity             [UserDefault currentDefault]

#define CityZoneCode                    ([[NSUserDefaults standardUserDefaults] objectForKey:@"zoneCode"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"zoneCode"]:@"4101")

#define CityZoneName                   ([[NSUserDefaults standardUserDefaults] objectForKey:@"CityName"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"CityName"]:@"郑州市")

@interface UserDefault : NSObject

@property(nonatomic,strong) NSString* session_id;
@property(nonatomic,strong) NSString* uid;
@property(nonatomic,strong) NSString *uuid;
@property(nonatomic,strong) NSString *refAccount;
@property(nonatomic,strong) NSString* account;
@property(nonatomic,strong) NSString* zoneCode;
@property(nonatomic,strong) NSString* realName;
@property(nonatomic,strong) NSString* nickName;
@property(nonatomic,strong) NSString* telePhone;

@property(nonatomic,strong) NSString* mailAdd;
@property(nonatomic,strong) NSString* birDate;
@property(nonatomic,strong) NSString* sex;

@property(nonatomic,strong) NSString *userKey;

@property(nonatomic,strong) NSString* refOneName;
@property(nonatomic,strong) NSString* refTwoName;

@property(nonatomic,strong) NSString* zone;
@property(nonatomic,strong) NSString* zoneDetail;

@property(nonatomic,strong) NSString* qrPath;
@property(nonatomic,strong) NSString* qrRelPath;

@property(nonatomic,strong) NSString* headPath;
@property(nonatomic,strong) NSString* splashPath;

@property(nonatomic,strong) NSString *vipBean;
@property(nonatomic,strong) NSString *vipCoin;

//选中的设备ID
@property(nonatomic,strong) NSString *equipmentId;

//account = 15838279930;
//birDate = 20150107;
//createDate = "2014-11-25 17:57:45";
//id = 1343;
//idCard = "<null>";
//mailAdd = "646869341@qq.com";
//nickName = "\U8d85\U795e\U4f9d\U5728";
//password = e10adc3949ba59abbe56e057f20f883e;
//qrPath = "/opt/wps/file/fup/member_qr_path/2014/12/09/1418119278774.png";
//qrRelPath = "2014/12/09/1418119278774.png";
//realName = "\U5218\U82f1\U8d85";
//refOneName = 18550036381;
//refTwoName = 4008609519;
//sex = 1;
//status = 0;
//telePhone = 15838279930;
//uuid = "c62c3e6b-60a7-4529-9d98-ac19b2b3c1e5";
//zone = "<null>";
//zoneDetail = "<null>";


+(UserDefault *)currentDefault;
+(void)saveUserDefault;
//将类objcet存到userDefault里面，对应的key值为strKey
+(BOOL)saveObject:(id)object key:(NSString *)strKey;
//根据key为strKey获取存入的类
+(id)getObject:(NSString *)strKey;


@end
