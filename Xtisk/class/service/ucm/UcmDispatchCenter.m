

#import "UcmDispatchCenter.h"
#import "PublicDefine.h"

@implementation UcmDispatchCenter


-(void)dealloc{
    
}

-(NSString *)getErrorString:(int)error{
    switch (error) {
        case UCM_SUCCESS:{
            return @"操作成功";
            break;
        }
        
        case INVALID_INPUT:{
            return @"输入内容错误";
            break;
        }
        case TOKEN_EXPIRED:{
            return @"令牌无效或已过期";
            break;
        }
        case ACCESS_DENIED:{
            return @"拒绝访问（权限不足）";
            break;
        }
        case SERVER_NOT_READY:{
            return @"服务器未就绪";
            break;
        }
        case INTERNAL_ERROR:{
            return @"服务器内部错误";
            break;
        }
        case RECORD_NOT_FOUND:{
            return @"记录不存在";
            break;
        }
        case ORG_DUPLICATE_CODE:{
            return @"组织代码重复";
            break;
        }
        case LOGIN_ID_ERROR:{
            return @"登录帐号无效";
            break;
        }
        case LOGIN_PASSWORD_ERROR:{
            return @"登录密码无效";
            break;
        }
        case LOGIN_ACCOUNT_DISABLED:{
            return @"登录帐号已被禁用";
            break;
        }
        case USER_DUPLICATE_LOGIN_ID:{
            return @"用户登录帐号重复";
            break;
        }
        case INVALID_CURRENT_PASSWORD:{
            return @"当前密码不正确";
            break;
        }
        case INVALID_NEW_PASSWORD:{
            return @"新密码无效";
            break;
        }
        default:{
            return nil;
            break;
        }
            
    }
}


/**
 *解析服务器返回数据 入库 duanye 2013.3.18
 */
/*
-(void)dispatchHandle:(int *)header body:(char *)body{
    int topLen = 5*sizeof(int);
    int bodyLen = [NetWorkUtility intFormatTransfer:header[0]] - topLen;
    int t = [NetWorkUtility intFormatTransfer:header[1]];//header[1]
    int error = [NetWorkUtility intFormatTransfer:header[3]];
    //NSLog(@"t:%d,error:%d",t,error);
    NSString *eStr = [self getErrorString:error];
    if (eStr) {
        //NSLog(@"operation:%@",eStr);
    }
    if (bodyLen >100000) {
        return;
    }
    //NSLog(@"dispatchHandle");
    switch (t) {
        case USER_LOGIN_RESP:{
            NSLog(@"登录请求回来");
            NSData *loginData = [NSData dataWithBytes:body length:bodyLen];
            PBUserLoginResp *userLoginResp = [PBUserLoginResp parseFromData:loginData];
            NSLog(@"message:%@",userLoginResp.message);
            NSLog(@"key:%@",userLoginResp.key);
            //[DBManager insertWithSql: inDBOfName:@"ubox"]

            [[CropHandleDataCenter shareInstance] syncPrivateContactReq];
            [[CropHandleDataCenter shareInstance] syncPublicContactReq];
            

            //NSLog(kDATABASE_REAL_PATH);
            break;
        }
        case SYNC_PUBLIC_CONTACT_OVER_RESP://企业通讯录同步结束信息ok
        {
            NSLog(@"服务器下载通讯录结束");
            NSData *publicContactOverData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncPublicContactOverResp *publicContactOverResp=[PBSyncPublicContactOverResp parseFromData:publicContactOverData];
            NSLog(@"message:%@",publicContactOverResp.message);
            NSString *message = publicContactOverResp.message;
            NSString *timestamp = publicContactOverResp.timestamp;
           // NSLog(@"message:%@,timestamp:%@",message,timestamp);
            NSString *delSql = [NSString stringWithFormat:@"delete from SYNC_RESULT where RESPONSE='%@'",PUBLIC_UCM_END];
            [DBManager deleteWithSql:delSql inDBOfName:DATABASE_PATH];
            NSString *sql = [NSString stringWithFormat:@"insert into SYNC_RESULT(MESSAGE,SYNC_TIMESTAMP,RESPONSE,RESULT) values('%@','%@','%@','result')",message,timestamp,PUBLIC_UCM_END];
             [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            [[RmDataCenter shareInstance] flushFriendData];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_SYNC_PUBLIC_CONTACT_OVER_RESP object:nil];
            break;
        }
        case SYNC_PUBLIC_ORG_RESP://企业通讯录同步组织信息
        {
            NSLog(@"服务器返回企业通讯录组织");
            NSData *publicOrgData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncOrgsResp *publicOrgResp=[PBSyncOrgsResp parseFromData:publicOrgData];
            //NSLog(@"orgsList:%@",publicOrgResp.orgsList);
            NSArray *array = publicOrgResp.orgsList;
            int count= [array count];
            NSLog(@"DATABASE_PATH:%@",DATABASE_PATH);
            for (int i = 0; i<count; i++) {
                PBSyncOrgsResp_PBDTOrg *orgItem = [array objectAtIndex:i];
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_ORGANIZATION(ORG_ID,INDEX_SORT,ENABLED) values('%@','%@',%d)",orgItem.id,orgItem.index,orgItem.enable];
                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case SYNC_PUBLIC_DEPT_RESP://企业通讯录同步部门信息
        {
            //PIM_GROUP check by 61
            NSLog(@"服务器返回企业通讯录部门");
            NSData *publicOrgData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncDepartmentsResp *deptResp=[PBSyncDepartmentsResp parseFromData:publicOrgData];
            //NSLog(@"deptsList:%@",deptResp.deptsList);
            NSArray *array = deptResp.deptsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncDepartmentsResp_PBDTDepartment *deparItem = [array objectAtIndex:i];
                //deparItem.
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_GROUP(GROUP_ID,ENABLED,INDEX_SORT,HIDDEN_LEDER_INFO) values('%@',%d,'%@',%d)",deparItem.id,deparItem.enable,deparItem.index,deparItem.hiddenLeaderInfo];
                

                BOOL r =[DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
                //NSLog(@"r:%d,sql：%@",r,sql);//BOOL r =
                r = YES;
            }
            break;
        }
        case SYNC_PUBLIC_USER_RESP://企业通讯录同步用户信息
        {
            //check by 61
            NSLog(@"服务器返回企业通讯录用户");
            //            char ct[bodyLen] ;
            //            memcpy(ct, body, bodyLen);
            //[NSData ]
            NSData *publicUserData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncCoUsersResp *userResp=[PBSyncCoUsersResp parseFromData:publicUserData];
            //NSLog(@"coUsersList:%@",userResp.coUsersList);
            
            NSArray *array = userResp.coUsersList;
            int count= [array count];
            NSLog(@"count:%d",count);
            for (int i = 0; i<count; i++) {
                PBSyncCoUsersResp_PBDTCoUser *userItem = [array objectAtIndex:i];
                NSString *gender = @"男";
                if (!userItem.gender) {
                    gender = @"女";
                }
                NSString *sql = [NSString stringWithFormat:
                                 @"insert into PIM_USER(USER_ID,EMPLOYEE_ID,GENDER,IS_LEADER,HEAD_ICON,ENABLED,INDEX_SORT) values('%@','%@','%@',%d,%d,%d,'%@')"
                                 ,userItem.id
                                 ,userItem.employeeid
                                 ,gender
                                 ,userItem.isLeader
                                 ,[Utility stringToInteger:userItem.logoindex]
                                 ,userItem.enable,userItem.index
                                 ];
                
                BOOL r = [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
                //NSLog(@"返回结果：%d,sql：%@",r,sql);//BOOL r =
                r = YES;
            }
            
            break;
        }
        case SYNC_PUBLIC_ROOTDEPT_RESP://企业通讯录同步一级部门信息
        {
            //
            NSLog(@"服务器返回企业通讯录一级部门");
            NSData *publicRootData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncRootDeptsResp *rootDeptResp=[PBSyncRootDeptsResp parseFromData:publicRootData];
            //NSLog(@"rootDeptsList:%@",rootDeptResp.rootDeptsList);
            NSArray *array = rootDeptResp.rootDeptsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncRootDeptsResp_PBDTRootDept *rootDeparItem = [array objectAtIndex:i];
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_ORG_GROUPS(ORG_ID,GROUP_ID,ENABLED) values('%@','%@',%d)",rootDeparItem.orgid,rootDeparItem.groupid,rootDeparItem.enable];
                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case SYNC_PUBLIC_MEMBER_RESP://企业通讯录同步部门成员信息
        {
            //有问题
            NSLog(@"服务器返回企业通讯录部门成员");
            NSData *publicMemberData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncDeptMembersResp *deptMemberResp=[PBSyncDeptMembersResp parseFromData:publicMemberData];
            //NSLog(@"deptMembersList:%@",deptMemberResp.deptMembersList);
            NSArray *array = deptMemberResp.deptMembersList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncDeptMembersResp_PBDTDeptMember *deptMemberItem = [array objectAtIndex:i];
                //修订后的字段memberid,member_type
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_ORG_GROUPS(ORG_GROUP_ID,MEMBER_ID,ENABLED,MEMBER_TYPE) values('%@','%@',%d,%d)",deptMemberItem.groupid,deptMemberItem.memberid,deptMemberItem.enable,deptMemberItem.membertype];
                BOOL r =[DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
                NSLog(@"返回结果：%d,sql：%@",r,sql);//BOOL r =
                r =YES;
            }
            break;
        }
        case SYNC_PUBLIC_ACCOUNT_RESP://企业通讯录同步通讯录帐号信息
        {
            NSLog(@"服务器返回企业通讯录账号");
            NSData *publicAccountData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncAccountsResp *accountResp=[PBSyncAccountsResp parseFromData:publicAccountData];
            //NSLog(@"accountsList:%@",accountResp.accountsList);
            NSArray *array = accountResp.accountsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncAccountsResp_PBDTAccount *accountItem = [array objectAtIndex:i];
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_UCM_CONTACT(USER_ID,ENABLED,ACCOUNT_ID,DAS_ACCOUNT_ID,SOFT_CODE,IS_DAS_ACCOUNT) values('%@',%d,'%@','%@','%@',%d)",accountItem.userid,accountItem.enable, accountItem.accountid,accountItem.dasaccountid,accountItem.softcode,accountItem.hasdasaccount];
                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case SYNC_PUBLIC_NAMECARD_RESP://企业通讯录同步通讯录名片信息
        {
            NSLog(@"服务器返回企业通讯录名片");
            NSData *publicNameCardData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncCoNameCardsResp *namedCardResp=[PBSyncCoNameCardsResp parseFromData:publicNameCardData];
            //NSLog(@"coNameCardsList:%@",namedCardResp.coNameCardsList);
            NSArray *array = namedCardResp.coNameCardsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncCoNameCardsResp_PBDTCoNameCard *coNameCardItem = [array objectAtIndex:i];
               //缺少了language字段
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_NAME_CARD(NAME_CARD_ID,ENABLED,FULL_NAME,PINYIN_NAME,PINYIN_NIMENICK,ACCESS_TYPE,USER_ID) values('%@',%d,'%@','%@','%@',%d,'%@')",coNameCardItem.id,coNameCardItem.enable,coNameCardItem.name,coNameCardItem.pinyinname,coNameCardItem.pinyinnickname,coNameCardItem.type,coNameCardItem.owner];
                BOOL r =[DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
                //NSLog(@"返回结果：%d,sql：%@",r,sql);//BOOL r =
                r = YES;
            }
            break;
        }
        case SYNC_PUBLIC_CONTACTS_RESP://企业通讯录同步通讯录联系方式信息
        {
            NSLog(@"服务器返回企业通讯录联系方式");
            NSData *publicContactData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncCoUserContactResp *contactResp=[PBSyncCoUserContactResp parseFromData:publicContactData];
            //NSLog(@"publicContactsList:%@",contactResp.contactsList);
            NSArray *array = contactResp.contactsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncCoUserContactResp_PBDTCoUserContact *coUserContactItem = [array objectAtIndex:i];
               // 缺少了extension字段
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_CONTACT(CONTACT_ID,USER_ID,COUNTRY_CODE,CONTENT,ENABLED,AREA_CODE,TYPE,PRIORITY) values('%@','%@','%@','%@',%d,'%@',%d,'%@')",coUserContactItem.id,
                    coUserContactItem.userid,
                    coUserContactItem.countrycode,coUserContactItem.content,
                    coUserContactItem.enable,
                    coUserContactItem.areacode,
                    coUserContactItem.type,
                    //coUserContactItem.extension,
                    coUserContactItem.priority];
                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case SYNC_PUBLIC_ADDRESS_RESP://企业通讯录同步通讯录地址信息
        {
            //modify by 61  //check by 61
            NSLog(@"企业通讯录同步通讯录地址信息");
            NSData *publicAddressData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncCoUserAddressResp *userAddressResp=[PBSyncCoUserAddressResp parseFromData:publicAddressData];
            NSArray *array = userAddressResp.addressesList;
            int count = [array count];
            NSLog(@"count:%d",count);
            for (int i = 0; i<count; i++) {
                PBSyncCoUserAddressResp_PBDTCoUserAddress *coUserAddress = [array objectAtIndex:i];
                //NSString *sql = coUserAddress.id;sql = coUserAddress.workplace;
                NSString *sql = [NSString stringWithFormat:@"insert into USER_ADDRESS(ADDRESS_ID,USER_ID,TYPE,WORK_PLACE,POSITION,ENABLED) values('%@','%@',%d,'%@','%@',%d)",coUserAddress.id,coUserAddress.owner,coUserAddress.type,coUserAddress.workplace,coUserAddress.position,coUserAddress.enable];
                BOOL r =[DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
                //NSLog(@"返回结果：%d,sql：%@",r,sql);//BOOL r =
                r = YES;
            }
            break;
        }
        case SYNC_PRIVATE_GROUP_RESP://个人通讯录分组信息
        {
            NSLog(@"服务器返回个人通讯录分组");
            NSData *privateGroupData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncPrivateGroupsResp *groupResp=[PBSyncPrivateGroupsResp parseFromData:privateGroupData];
            //NSLog(@"addressesList:%@",groupResp.groupsList);
            NSArray *array = groupResp.groupsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncPrivateGroupsResp_PBDTPrivateGroup *coprivateGroupItem = [array objectAtIndex:i];
                
                NSString *delSql= [NSString stringWithFormat:@"delete from PIM_FRIENDS_GROUP where GROUP_ID = '%@'",coprivateGroupItem.id];
                [DBManager insertWithSql:delSql inDBOfName:DATABASE_PATH];
                
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_FRIENDS_GROUP(GROUP_ID,MEMO,NAME,ENABLED,RELATIONSHIP) values('%@','%@','%@',%d,'%@')",coprivateGroupItem.id,coprivateGroupItem.memo,coprivateGroupItem.name,coprivateGroupItem.enable,[Single shareSingle].m_id];
                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
                //NSLog(@"返回结果：%d,sql：%@",r,sql);//BOOL r =
            }
            break;
        }
        case SYNC_PRIVATE_NAMECARD_RESP://个人通讯录名片
        {
            //modify by 61
            NSLog(@"服务器返回个人通讯录名片");
            NSData *privateNameCardData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncPrivateNamecardsResp *privateNameCardResp=[PBSyncPrivateNamecardsResp parseFromData:privateNameCardData];
            //NSLog(@"nameCardsList:%@",privateNameCardResp.nameCardsList);
            NSArray *array = privateNameCardResp.nameCardsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncPrivateNamecardsResp_PBDTPrivateNameCard *coprivateNameCardItem = [array objectAtIndex:i];
                NSString *gender = @"男";
                if (!coprivateNameCardItem.gender) {
                    gender = @"女";
                }
                
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_NAME_CARD(NAME_CARD_ID,FULL_NAME,MEMO,GENDER,DEPARTMENT,COMPANY_NAME,ENABLED,PINYIN_NAME,PINYIN_NIMENICK,POSITION,TITLE,INDEX_LETTER) values('%@','%@','%@','%@','%@','%@',%d,'%@','%@','%@','%@','%@')"
                                 ,coprivateNameCardItem.id
                                 ,coprivateNameCardItem.name
                                 ,coprivateNameCardItem.memo
                                 ,gender
                                 ,coprivateNameCardItem.department
                                 ,coprivateNameCardItem.companyname
                                 ,coprivateNameCardItem.enable
                                 ,coprivateNameCardItem.pinyinname
                                 ,coprivateNameCardItem.pinyinnickname
                                 ,coprivateNameCardItem.position
                                 ,coprivateNameCardItem.title
                                 ,coprivateNameCardItem.logoindex];
                BOOL r =[DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
                //NSLog(@"返回结果：%d,sql：%@",r,sql);//BOOL r =
                r = YES;
            }
            break;
        }
        case SYNC_PRIVATE_ADDRESS_RESP://个人通讯录地址
        {
            NSLog(@"服务器返回个人通讯录地址");
            NSData *privateNameCardData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncPrivateAddressesResp *privateAddreddResp=[PBSyncPrivateAddressesResp parseFromData:privateNameCardData];
            //NSLog(@"nameCardsList:%@",privateAddreddResp.addressesList);
            NSArray *array = privateAddreddResp.addressesList;
            int count= [array count];
            NSLog(@"count:%d",count);
            for (int i = 0; i<count; i++) {
                PBSyncPrivateAddressesResp_PBDTPrivateAddress *coprivateAddressItem = [array objectAtIndex:i];
                NSString *sql = [NSString stringWithFormat:@"insert into USER_ADDRESS(ADDRESS_ID,MEMO,CONTENT,NAME_CARD_ID,ENABLED,TYPE,PRIORITY) values('%@','%@','%@','%@',%d,%d,'%@')",coprivateAddressItem.id,coprivateAddressItem.memo,coprivateAddressItem.content,coprivateAddressItem.namecardid,coprivateAddressItem.enable,
                    coprivateAddressItem.type,coprivateAddressItem.priority];
                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case SYNC_PRIVATE_CONTACTS_RESP://个人通讯录联系方式
        {
            NSLog(@"服务器返回个人通讯录联系方式");
            NSData *privateContactsData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncPrivateContactsResp *privateContactsResp=[PBSyncPrivateContactsResp parseFromData:privateContactsData];
            //NSLog(@"contactsList:%@",privateContactsResp.contactsList);
            NSArray *array = privateContactsResp.contactsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSyncPrivateContactsResp_PBDTPrivateContact *coprivateContactsItem = [array objectAtIndex:i];
                //少了memo字段
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_CONTACT(CONTACT_ID,CONTENT,COUNTRY_CODE,ENABLED,USER_ID,PRIORITY,TYPE,EXTENSION,AREA_CODE) values('%@','%@','%@',%d,'%@','%@',%d,'%@','%@')",coprivateContactsItem.id,coprivateContactsItem.content,coprivateContactsItem.countrycode,coprivateContactsItem.enable,
                    coprivateContactsItem.namecardid,
                    coprivateContactsItem.priority,
                    coprivateContactsItem.type,
                    coprivateContactsItem.extension,
                    //coprivateContactsItem.memo,
                    coprivateContactsItem.areacode];
                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case SYNC_PRIVATE_MEMBER_RESP://个人通讯录分组成员
        {
            NSLog(@"服务器返回个人通讯录分组成员");
            NSData *privateMemberData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncPrivateMemberResp *privateMemberResp=[PBSyncPrivateMemberResp parseFromData:privateMemberData];
            //NSLog(@"contactsList:%@",privateMemberResp.groupMembersList);
            NSArray *array = privateMemberResp.groupMembersList;
            int count= [array count];
            NSLog(@"count:%d",count);
            for (int i = 0; i<count; i++) {
                PBSyncPrivateMemberResp_PBDTPrivateGroupNember *coprivateGroupNemberItem = [array objectAtIndex:i];
                
                NSString *delSql= [NSString stringWithFormat:@"delete from PIM_FRIENDS_GROUP_MEMBERS where USER_ID = '%@'",coprivateGroupNemberItem.id];
                
                [DBManager insertWithSql:delSql inDBOfName:DATABASE_PATH];
                
                NSString *sql = [NSString stringWithFormat:@"insert into PIM_FRIENDS_GROUP_MEMBERS(USER_ID,GROUP_ID,OWNER,TYPE,ENABLED,RELATIONSHIP) values('%@','%@','%@',%d,%d,'%@')",coprivateGroupNemberItem.id,coprivateGroupNemberItem.groupid,coprivateGroupNemberItem.owner,coprivateGroupNemberItem.type,
                    coprivateGroupNemberItem.enable,[Single shareSingle].m_id];
                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case SYNC_PRIVATE_CONTACT_OVER_RESP://下载个人通讯录完成
        {
            NSLog(@"服务器返回下载个人通讯录完成");
            NSData *privateContactOverData = [NSData dataWithBytes:body length:bodyLen];
            PBSyncPrivateContactOverResp *privateContactOverResp=[PBSyncPrivateContactOverResp parseFromData:privateContactOverData];
            //NSLog(@"privateContactOverResp.message:%@",privateContactOverResp.message);
            NSString *message = privateContactOverResp.message;
            NSString *timestamp = privateContactOverResp.timestamp;
            NSLog(@"个人通讯录完成:%@",timestamp);
            //NSString *delSql = [NSString stringWithFormat:@"delete from SYNC_RESULT where RESPONSE='%@'",PRIVATE_UCM_END];
            NSString *delSql = [NSString stringWithFormat:@"delete from SYNC_RESULT where RESULT='%@'",[Single shareSingle].m_id];
            BOOL r = NO;

            r = [DBManager deleteWithSql:delSql inDBOfName:DATABASE_PATH];
            
            
            NSLog(@"返回结果：%d,delSql：%@",r,delSql);//BOOL r =
            r = YES;
            NSString *sql = [NSString stringWithFormat:@"insert into SYNC_RESULT(MESSAGE,SYNC_TIMESTAMP,RESPONSE,RESULT) values('%@','%@','%@','%@')",message,timestamp,PRIVATE_UCM_END,[Single shareSingle].m_id];
            [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            
            [[RmDataCenter shareInstance] flushFriendData];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_SYNC_PUBLIC_CONTACT_OVER_RESP object:nil];
            break;
        }
        case SUBMIT_MY_LOGO_RESP://提交本人在企业通讯录的头像应答
        {
            NSLog(@"提交本人在企业通讯录中的头像");
            NSData *privateMyLogoData = [NSData dataWithBytes:body length:bodyLen];
            PBSubmitMyLogoResp *privateMyLogoResp=[PBSubmitMyLogoResp parseFromData:privateMyLogoData];
            NSLog(@"message:%@",privateMyLogoResp.message);
            //NSLog(@"privateMyLogoResp.message:%@",privateMyLogoResp.message);
            
            break;
        }
        case SUBMIT_MYROSTER_LOGO_RESP://提交本人在企业通讯录的自定义头像应答
        {
            NSLog(@"提交本人企业通讯录自定义头像应答");
            break;
        }
        case SUBMIT_MYUSERINFO_RESP://提交本人在企业通讯录的信息应答
        {
            NSLog(@"提交本人的企业通讯录信息应答");
            NSData *privateMyRecvisitsData = [NSData dataWithBytes:body length:bodyLen];
            PBSubmitMyRecvisitsResp *privateMyRecvisitsResp=[PBSubmitMyRecvisitsResp parseFromData:privateMyRecvisitsData];
            //NSLog(@"privateMyRecvisitsResp.resultsList:%@",privateMyRecvisitsResp.resultsList);
            NSArray *array = privateMyRecvisitsResp.resultsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBSubmitMyRecvisitsResp_PBOprRecvisitsResult *recvisitsResultItem = [array objectAtIndex:i];
                NSLog(@"message:%@",recvisitsResultItem.message);
//                 NSString *sql = [NSString stringWithFormat:@"insert into SYNC_RESULT(ACCOUNT_ID,MESSAGE) values('%@','%@')",recvisitsResultItem.id,recvisitsResultItem.message];
//                 [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case OPERATE_GROUP_RESP://操作个人通讯录分组结果应答信息
        {
            NSLog(@"操作个人通讯录分组结果应答");
            NSData *operateGroupData = [NSData dataWithBytes:body length:bodyLen];
            PBPrivateOprResp *operateResp=[PBPrivateOprResp parseFromData:operateGroupData];
            //NSLog(@"operateResp.resultsList:%@",operateResp.resultsList);
            NSArray *array = operateResp.resultsList;
            int count= [array count];
            for (int i = 0; i<count; i++) {
                PBPrivateOprResp_PBDTPrivateOprResult *oprGroupNemberItem = [array objectAtIndex:i];
                NSLog(@"message:%@",oprGroupNemberItem.message);
//                NSString *sql = [NSString stringWithFormat:@"insert into SYNC_RESULT(ACCOUNT_ID,MESSAGE,SYNC_TIMESTAMP) values('%@','%@','%@')",oprGroupNemberItem.id,oprGroupNemberItem.message,operateResp.timestamp];
//                [DBManager insertWithSql:sql inDBOfName:DATABASE_PATH];
            }
            break;
        }
        case OPERATE_GROUP_MEMBER_RESP://4.3.3.3	分组成员操作请求
        {
            NSLog(@"4.3.3.3	分组成员 结果应答");
            NSData *operateData = [NSData dataWithBytes:body length:bodyLen];
            PBPrivateOprResp *opr = [PBPrivateOprResp parseFromData:operateData];
            NSArray *array = opr.resultsList;
            int count = [array count];
            NSLog(@"count:%d",count);
            for (int i =0; i<count; i++) {
                PBPrivateOprResp_PBDTPrivateOprResult *oprResultItem = [array objectAtIndex:i];
                NSLog(@"tempid:%@,message:%@",oprResultItem.tempid  ,oprResultItem.message);
            }
            [[CropHandleDataCenter shareInstance] syncPrivateContactReq];
            break;
        }
        default:
        {
           
        }
            break;
    }
    
}

*/
@end
