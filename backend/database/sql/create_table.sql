drop database if exists db_bhw;

create database db_bhw;
use db_bhw;

/*商家信息*/
drop table if exists Mercinf;
create table Mercinf(
    mid int not null primary key auto_increment,/*商户id*/
    mname varchar(256) not null,/*商户名，自己设计*/
    admin_cata varchar(256) not null,/*行政相对人类别*/
    legal_rep varchar(256) not null,/*法人代表*/
    mkey varchar(256) not null,/*密码*/
    realname varchar(256) not null/*真实商户名称*/
);

/*管理员信息*/
drop table if exists admin;
create table admin_user(
    aid int not null primary key auto_increment,/*管理员id*/
    aname varchar(256) not null,/*管理员名*/
    akey varchar(256) not null,/*管理员密码*/
    bureau varchar(256) not null/*所在处*/
);

/*处罚信息*/
drop table if exists Violation;
create table Violation(
    vid int not null primary key auto_increment,/*处罚编号*/
    mid int not null,/*被处罚商户mid*/
    vlass varchar(256) not null,/*处罚类别*/
    vdate date not null,/*处罚日期*/
    vreason varchar(256) not null,/*违法类型*/
    vlaw varchar(256) not null,/*处罚依据，法律*/
    bureau varchar(256) not null,/*惩罚单位*/
    vinf varchar(256),/*一些备注，如果有的话*/
    chufa varchar(256),/*处罚内容*/
    payment float not null CHECK(payment>=0),/*罚金*/
    illegal float not null ChECK(illegal>=0),/*没收非法所得金额*/
    foreign key(mid) references Mercinf(mid)
);

/*罚款缴纳信息表*/
drop table if exists PayInf;
create table PayInf(
    mid int not null,/*商户编号*/
    vid int not null,/*处罚文书编号*/
    foreign key(mid) references Mercinf(mid),
    foreign key(vid) references Violation(vid),
    primary key(mid,vid)
);

/*申诉表*/
drop table if exists appeal;
create table appeal(
    vid int not null,/*文书*/
    mid int not null,/*商家编号*/
    inf varchar(256) not null,/*申诉信息*/
    deal int not null CHECK(deal in(0,1)),/*是否被处理*/
    succ int not null CHECK(succ in(0,1)),/*处理通过？*/
    foreign key(mid) references Mercinf(mid),
    foreign key(vid) references Violation(vid),
    primary key(mid,vid)
);

/*普通用户*/
drop table if exists user;
create table user(
    uid int not null primary key auto_increment,/*用户id*/
    uname varchar(256) not null,/*用户名*/
    ukey varchar(256) not null/*用户密码*/
);

/*举报信息*/
drop table if exists report;
create table report(
    uid int not null,/*用户id*/
    mid int not null,/*举报商户id*/
    rclass varchar(256) not null,/*举报违法类别*/
    inf varchar(256) not null,/*举报信息*/
    deal int not null CHECK(deal in(0,1)),/*是否受理*/
    succ int not null CHECK(succ in(0,1)),/*是否成功*/
    foreign key(mid) references Mercinf(mid),
    foreign key(uid) references user(uid),
    primary key(mid,uid)
);

show tables;

insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市安捷轮科技有限公司","法人及非法人组织","李盈祥","123456","深圳市安捷轮科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区公明兴前商店","个体工商户","胡兴前","123456","深圳市宝安区公明兴前商店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳索感科技有限公司","法人及非法人组织","蔡东斌","123456","深圳索感科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市超义聚贸易有限公司","法人及非法人组织","宋秋琴","123456","深圳市超义聚贸易有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市光明新区公明荣发餐具店","个体工商户","黄嘉荣","123456","深圳市光明新区公明荣发餐具店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华区观澜海明杂货店","个体工商户","张瑞金","123456","深圳市龙华区观澜海明杂货店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市马瑛掌尚网络科技有限公司","法人及非法人组织","廖学成","123456","深圳市马瑛掌尚网络科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区裕通电动车行","个体工商户","张永振","123456","深圳市宝安区裕通电动车行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市福田区金笑笑通信器材经营部","个体工商户","赵小姗","123456","深圳市福田区金笑笑通信器材经营部");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳象鲜科技有限公司","法人及非法人组织","刘建华","123456","深圳象鲜科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区新安街道建锋服装店","个体工商户","李建锋","123456","深圳市宝安区新安街道建锋服装店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区宝民市场周锡钦蔬菜档","个体工商户","周锡钦","123456","深圳市宝安区宝民市场周锡钦蔬菜档");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市南山区小龙坎重庆老火锅店","个体工商户","曲彦霖","123456","深圳市南山区小龙坎重庆老火锅店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳非凡医疗美容医院","法人及非法人组织","王安","123456","深圳非凡医疗美容医院");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华新区民治邓胖哥猪肉档","个体工商户","邓四","123456","深圳市龙华新区民治邓胖哥猪肉档");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("广东魅素羽生物科技有限公司","法人及非法人组织","周丹红","123456","广东魅素羽生物科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市福田区肆季美妆商行","个体工商户","周集海","123456","深圳市福田区肆季美妆商行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市深蓝环科电器有限公司","法人及非法人组织","曾添雄","123456","深圳市深蓝环科电器有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市金四季实业有限公司","法人及非法人组织","林汉伟","123456","深圳市金四季实业有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市菲德越科技有限公司","法人及非法人组织","王强","123456","深圳市菲德越科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳玉玄道中医馆","法人及非法人组织","贺启洲","123456","深圳玉玄道中医馆");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区南湾广涛菜档","个体工商户","杨锡金","123456","深圳市龙岗区南湾广涛菜档");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市福康大药房有限公司","法人及非法人组织","钱慧渊","123456","深圳市福康大药房有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区新安乌兰烧烤店","个体工商户","李艳","123456","深圳市宝安区新安乌兰烧烤店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市健康互动科技有限公司","法人及非法人组织","马桂平","123456","深圳市健康互动科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区张松斌海鲜档","个体工商户","张松斌","123456","深圳市龙岗区张松斌海鲜档");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区燕罗佳怡富五金商行","个体工商户","蔡育欣","123456","深圳市宝安区燕罗佳怡富五金商行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳麦娇奴服饰有限公司","法人及非法人组织","潘伯安","123456","深圳麦娇奴服饰有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市一甜文化传播有限公司","法人及非法人组织","黄颖茵","123456","深圳市一甜文化传播有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市杰西服装有限责任公司","法人及非法人组织","高德康","123456","深圳市杰西服装有限责任公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区益城饮品店","个体工商户","刘思远","123456","深圳市龙岗区益城饮品店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳来福士雾化医学有限公司","法人及非法人组织","华健","123456","深圳来福士雾化医学有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝华药行","法人及非法人组织","卓晓琳","123456","深圳市宝华药行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区平湖创隆达包装材料批发行","个体工商户","林兴龙","123456","深圳市龙岗区平湖创隆达包装材料批发行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市鸿达顺科技开发有限公司","法人及非法人组织","周军","123456","深圳市鸿达顺科技开发有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华新区观澜庆隆木业商行","个体工商户","庄丽冰","123456","深圳市龙华新区观澜庆隆木业商行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市远高照明有限公司","法人及非法人组织","徐仑","123456","深圳市远高照明有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市农耕记餐饮有限公司","法人及非法人组织","冯旭日","123456","深圳市农耕记餐饮有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳华声医疗技术股份有限公司","法人及非法人组织","李永刚","123456","深圳华声医疗技术股份有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市万汇佳商贸有限公司","法人及非法人组织","苏俊仁","123456","深圳市万汇佳商贸有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("德荣堂医药(深圳)有限公司","法人及非法人组织","郭荣贞","123456","德荣堂医药(深圳)有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区宝民市场妙群肉丸档","个体工商户","李妙群","123456","深圳市宝安区宝民市场妙群肉丸档");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市郭杰灯饰有限公司","法人及非法人组织","陈文光","123456","深圳市郭杰灯饰有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("广东一六零医药连锁有限公司","法人及非法人组织","梁宇光","123456","广东一六零医药连锁有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市子安阁母婴服务有限公司","法人及非法人组织","许妙芬","123456","深圳市子安阁母婴服务有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区新桥街道卓记蔬菜批发店","个体工商户","吴雪岸","123456","深圳市宝安区新桥街道卓记蔬菜批发店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市坪山区成安百货","个体工商户","罗素茹","123456","深圳市坪山区成安百货");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳华腾生物医疗电子有限公司","法人及非法人组织","操建彪","123456","深圳华腾生物医疗电子有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市湘粤粮油实业有限公司","法人及非法人组织","罗翠清","123456","深圳市湘粤粮油实业有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区新桥惠实土猪肉档","个体工商户","高惠展","123456","深圳市宝安区新桥惠实土猪肉档");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市利联太阳百货","法人及非法人组织","李卫东","123456","深圳市利联太阳百货");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市星洲时代鞋服有限公司","法人及非法人组织","冯海亮","123456","深圳市星洲时代鞋服有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市光明区百汇生活超市","个体工商户","彭纪业","123456","深圳市光明区百汇生活超市");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市台日电梯有限公司","法人及非法人组织","王道文","123456","深圳市台日电梯有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市探火餐饮管理有限公司","法人及非法人组织","孔新华","123456","深圳市探火餐饮管理有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市即食行","法人及非法人组织","姚小芝","123456","深圳市即食行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳多禾国际物业管理有限公司","法人及非法人组织","汪青","123456","深圳多禾国际物业管理有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳一路发搬家有限公司","法人及非法人组织","程来军","123456","深圳一路发搬家有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市民浩湘当鲜餐饮服务有限公司","法人及非法人组织","张锡燕","123456","深圳市民浩湘当鲜餐饮服务有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市吉达电梯工程有限公司","法人及非法人组织","郭湘玮","123456","深圳市吉达电梯工程有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市博盈利泰贸易有限公司","法人及非法人组织","张桂英","123456","深圳市博盈利泰贸易有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市优优邦贸易有限公司","法人及非法人组织","陈烨明","123456","深圳市优优邦贸易有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区平湖荣昌兴商行","个体工商户","张小林","123456","深圳市龙岗区平湖荣昌兴商行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市企学在线教育有限公司","法人及非法人组织","胡林强","123456","深圳市企学在线教育有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华区民乐一区维客佳便利店","个体工商户","杜波","123456","深圳市龙华区民乐一区维客佳便利店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区平湖伟兴包装批发行","个体工商户","方增伟","123456","深圳市龙岗区平湖伟兴包装批发行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市创一嘉科技有限公司","法人及非法人组织","张楚湖","123456","深圳市创一嘉科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区平湖街道和兴耗材包装商行","个体工商户","郑秀娟","123456","深圳市龙岗区平湖街道和兴耗材包装商行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市永为投资有限公司","法人及非法人组织","吕景强","123456","深圳市永为投资有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区嘉得通食品商行","个体工商户","李建生","123456","深圳市龙岗区嘉得通食品商行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华新区龙华辉煌商店","个体工商户","吴兰桂","123456","深圳市龙华新区龙华辉煌商店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市珺宸健康管理有限公司","法人及非法人组织","卢玲玉","123456","深圳市珺宸健康管理有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市唯芳菲服饰有限公司","法人及非法人组织","蔡钦坤","123456","深圳市唯芳菲服饰有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市叶子茶茶业有限公司","法人及非法人组织","许宏伟","123456","深圳市叶子茶茶业有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市百思盟科技有限公司","法人及非法人组织","罗艳琼","123456","深圳市百思盟科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华区爽爽手捶柠檬茶店","个体工商户","黄远玲","123456","深圳市龙华区爽爽手捶柠檬茶店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市深港万众街市发展有限公司","法人及非法人组织","何晓茹","123456","深圳市深港万众街市发展有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市光明区公明新好润百货","个体工商户","邹永平","123456","深圳市光明区公明新好润百货");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市福田区楚刘湘菜馆","个体工商户","刘军","123456","深圳市福田区楚刘湘菜馆");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳礼纪电子商务有限公司","法人及非法人组织","郑伟财","123456","深圳礼纪电子商务有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区西乡佳联百货","个体工商户","甘寒芳","123456","深圳市宝安区西乡佳联百货");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区满富原便利店","个体工商户","苏洪梅","123456","深圳市宝安区满富原便利店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区西乡深沙美宜多超市","个体工商户","吕坚强","123456","深圳市宝安区西乡深沙美宜多超市");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳深安阳光电子有限公司","法人及非法人组织","豆刘杰","123456","深圳深安阳光电子有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市恒基装卸有限公司","法人及非法人组织","刘配成","123456","深圳市恒基装卸有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市罗湖区远森水产批发行","个体工商户","陈远森","123456","深圳市罗湖区远森水产批发行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区松岗街道隆创数码电器店","个体工商户","陈兴富","123456","深圳市宝安区松岗街道隆创数码电器店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳弘美医疗美容门诊部","法人及非法人组织","胡庄","123456","深圳弘美医疗美容门诊部");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳欣知教育咨询有限公司","法人及非法人组织","马蕾","123456","深圳欣知教育咨询有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市水贝珠宝投资有限公司","法人及非法人组织","朴明山","123456","深圳市水贝珠宝投资有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市光明区小时光好妈妈母婴店","个体工商户","黄雪娇","123456","深圳市光明区小时光好妈妈母婴店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市阿卡索资讯股份有限公司","法人及非法人组织","王志彬","123456","深圳市阿卡索资讯股份有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安潘纳浩斯文化娱乐有限公司","法人及非法人组织","张国友","123456","深圳市宝安潘纳浩斯文化娱乐有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区琴伙便利店","个体工商户","刘孙亮","123456","深圳市宝安区琴伙便利店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市萝卜头不锈钢有限公司","法人及非法人组织","张传","123456","深圳市萝卜头不锈钢有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市程飞科技有限公司","法人及非法人组织","黄成辉","123456","深圳市程飞科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市瑞鑫丰硕电子有限公司","法人及非法人组织","叶冰蕾","123456","深圳市瑞鑫丰硕电子有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("安费诺东亚电子科技(深圳)有限公司","法人及非法人组织","STEPHENBRADLEYDORROUGH","123456","安费诺东亚电子科技(深圳)有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区福永街道凤发一加壹便利店","个体工商户","张发凤","123456","深圳市宝安区福永街道凤发一加壹便利店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区友餐饱冰室餐厅","个体工商户","江达钧","123456","深圳市宝安区友餐饱冰室餐厅");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华新区大浪裕华生活超市","个体工商户","叶武","123456","深圳市龙华新区大浪裕华生活超市");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区福永街道运茂便利店","个体工商户","曾治驹","123456","深圳市宝安区福永街道运茂便利店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市锦珂化妆用品有限责任公司","法人及非法人组织","吕潇寒","123456","深圳市锦珂化妆用品有限责任公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市盛世佳华商贸有限公司","法人及非法人组织","钟泽兴","123456","深圳市盛世佳华商贸有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市光明新区光明兴远粮油店","个体工商户","吴兴远","123456","深圳市光明新区光明兴远粮油店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市亚创达科技有限公司","法人及非法人组织","沈梦","123456","深圳市亚创达科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市和瓷文化发展有限公司","法人及非法人组织","王亮伟","123456","深圳市和瓷文化发展有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市熊吾科技有限公司","法人及非法人组织","陈展来","123456","深圳市熊吾科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳不悔电子商务有限公司","法人及非法人组织","胡军","123456","深圳不悔电子商务有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市林澜塑胶制品有限公司","法人及非法人组织","李道林","123456","深圳市林澜塑胶制品有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市坤鹏电子商务有限公司","法人及非法人组织","张家硕","123456","深圳市坤鹏电子商务有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市欧健药业有限公司","法人及非法人组织","陈芳芳","123456","深圳市欧健药业有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳易倍通商贸有限公司","法人及非法人组织","张明艳","123456","深圳易倍通商贸有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市中履鞋业有限公司","法人及非法人组织","于源清","123456","深圳市中履鞋业有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区航城霞霞牛肉粉店","个体工商户","游业霞","123456","深圳市宝安区航城霞霞牛肉粉店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区达芬奇披萨店","个体工商户","隆秀丽","123456","深圳市宝安区达芬奇披萨店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区坂田松兴装饰材料行","个体工商户","王银彬","123456","深圳市龙岗区坂田松兴装饰材料行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区黎金莲餐饮店","个体工商户","李祥广","123456","深圳市龙岗区黎金莲餐饮店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市弗瑞尔科技有限公司","法人及非法人组织","王彬","123456","深圳市弗瑞尔科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市威立讯电子有限公司生产不符合执行","法人及非法人组织","何振森","123456","深圳市威立讯电子有限公司生产不符合执行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("群侠传实业(深圳)有限公司","法人及非法人组织","曹艳军","123456","群侠传实业(深圳)有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市纯净之源化妆品销售有限公司","法人及非法人组织","TOMMORAD","123456","深圳市纯净之源化妆品销售有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市深汕特别合作区佳佳福百货","个体工商户","陈佳妮","123456","深圳市深汕特别合作区佳佳福百货");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳松岗琥珀有限公司","法人及非法人组织","李宏勉","123456","深圳松岗琥珀有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市荣格科技有限公司","法人及非法人组织","孙小玲","123456","深圳市荣格科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区九美电动自行","个体工商户","张耀进","123456","深圳市宝安区九美电动自行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市都酷科技有限公司","法人及非法人组织","胡忠","123456","深圳市都酷科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市泓茂隆电子科技有限公司","法人及非法人组织","覃桂荣","123456","深圳市泓茂隆电子科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区忠意建材店","个体工商户","黄志意","123456","深圳市宝安区忠意建材店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区智园小学食堂","法人及非法人组织","郑和傲","123456","深圳市宝安区智园小学食堂");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华区绿康优品生鲜超市","个体工商户","罗素梦","123456","深圳市龙华区绿康优品生鲜超市");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市奥达电梯有限公司","法人及非法人组织","罗国光","123456","深圳市奥达电梯有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市启迪电子商务有限公司","法人及非法人组织","林修钊","123456","深圳市启迪电子商务有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市鹏安电梯有限公司","法人及非法人组织","向坚","123456","深圳市鹏安电梯有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市宝安区吃了个栗干货店","个体工商户","冯洲","123456","深圳市宝安区吃了个栗干货店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市福田区华记二朗田鸡火锅店","个体工商户","孙长赐","123456","深圳市福田区华记二朗田鸡火锅店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市润德丰大药房管理有限公司","法人及非法人组织","邓炳锋","123456","深圳市润德丰大药房管理有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市新启数码科技有限公司","法人及非法人组织","张佳雄","123456","深圳市新启数码科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳阳光兴亚大健康科技有限公司","法人及非法人组织","李亚兴","123456","深圳阳光兴亚大健康科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市寻秋电子科技有限公司","法人及非法人组织","官桂春","123456","深圳市寻秋电子科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市南山区羊家莊小吃店","个体工商户","杨春晓","123456","深圳市南山区羊家莊小吃店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳伊慈佑医疗美容门诊部","法人及非法人组织","陈敏","123456","深圳伊慈佑医疗美容门诊部");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市坪山新区丕业建材店","个体工商户","黄辉丕","123456","深圳市坪山新区丕业建材店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市永康连锁超市","法人及非法人组织","林俊光","123456","深圳市永康连锁超市");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙华区玖叔餐饮店","个体工商户","刘欢","123456","深圳市龙华区玖叔餐饮店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳星荟丽格医疗美容诊所","法人及非法人组织","江修峰","123456","深圳星荟丽格医疗美容诊所");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市咪咪兔科技有限公司","法人及非法人组织","郭洪利","123456","深圳市咪咪兔科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市龙岗区坂田文霞劳保消防器材用品商行","个体工商户","王文霞","123456","深圳市龙岗区坂田文霞劳保消防器材用品商行");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市罗湖区广拓印章店","个体工商户","李广添","123456","深圳市罗湖区广拓印章店");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市立丰大药房有限公司","法人及非法人组织","李玲","123456","深圳市立丰大药房有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市芃羽科技有限公司","法人及非法人组织","唐倩倩","123456","深圳市芃羽科技有限公司");
insert into Mercinf(mname,admin_cata,legal_rep,mkey,realname) values("深圳市凯迪实业发展有限公司","法人及非法人组织","马庆彬","123456","深圳市凯迪实业发展有限公司");
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(1,"罚款","20220516","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市安捷轮科技有限公司在经营中使用虚假广告宣传案","罚款300元",0.03,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(2,"罚款;没收违法所得","20220516","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第六十条","admin","深圳市宝安区公明兴前商店销售抽检不合格塑料袋案","罚款67.5元;没收违法所得",0.00675,0.0005);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(3,"罚款","20220516","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳索感科技有限公司医疗器械广告违法案","罚款1743元",0.1743,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(4,"罚款","20220516","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款；中华人民共和国广告法/第五章法律责任/第五十八条/第一款","admin","深圳市超义聚贸易有限公司在经营中使用虚假广告宣传案","罚款300元",0.03,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(5,"罚款;没收违法所得","20220516","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十八条。深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市光明新区公明荣发餐具店销售抽检不合格塑料袋案","罚款291元;没收违法所得",0.0291,0.00092);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(6,"罚款","20220516","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市龙华区观澜海明杂货店销售过期食品案","罚款500元",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(7,"罚款","20220516","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市马瑛掌尚网络科技有限公司广告违法案","罚款2025元",0.2025,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(8,"罚款;没收非法财物","20220513","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市宝安区裕通电动车行销售不符合国家标准的产品案","罚款7806元;没收非法财物",0.7806,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(9,"罚款;没收违法所得","20220513","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市福田区金笑笑通信器材经营部销售无3C认证的产品案","罚款10185元;没收违法所得",1.0185,0.014448);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(10,"罚款","20220513","其他","中华人民共和国固体废物污染环境防治法/第八章法律责任/第一百零六条","admin","深圳象鲜科技有限公司使用不可降解塑料袋案","罚款90000元",9,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(11,"警告;罚款;没收违法所得;没收非法财物","20220513","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市宝安区新安街道建锋服装店销售不合格服装案","警告;罚款34723.65元;没收违法所得;没收非法财物",3.472365,0.360165);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(12,"罚款;没收违法所得","20220513","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十八条","admin","深圳市宝安区宝民市场周锡钦蔬菜档经营未标注执行标准号的塑料袋案","罚款7.5元;没收违法所得",0.00075,0.001);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(13,"罚款;没收违法所得","20220513","无照经营","中华人民共和国食品安全法/第九章法律责任/第一百二十二条/第一款","admin","深圳市南山区小龙坎重庆老火锅店无证经营食品案","罚款50000元;没收违法所得",5,0.98);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(14,"罚款","20220513","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳非凡医疗美容医院广告违法案","罚款3200元",0.32,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(15,"罚款","20220513","计量违法行为","深圳经济特区计量条例(2019修正)/第八章罚则/第四十二条","admin","深圳市龙华新区民治邓胖哥猪肉档使用无检定合格印的电子秤案","罚款3000元",0.3,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(16,"罚款","20220513","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","广东魅素羽生物科技有限公司发布虚假广告案","罚款2000元",0.2,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(17,"警告;没收违法所得;没收非法财物;罚款","20220513","化妆品违法行为","化妆品监督管理条例/第五章法律责任/第六十一条/第一款,广东省化妆品安全条例/第五章法律责任/第五十七条违反本条例第二十八条,化妆品监督管理条例/第五章法律责任/第六十二条/第一款,中华人民共和国市场主体登记管理条例/第五章法律责任/第四十六条","admin","深圳市福田区肆季美妆商行销售无中文标签化妆品案","警告;没收违法所得;没收非法财物;罚款48153元",4.8153,0.0677);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(18,"罚款;没收违法所得","20220513","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市深蓝环科电器有限公司销售抽检不合格的手持挂烫机案","罚款11592元;没收违法所得",1.1592,0.20171);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(19,"罚款","20220513","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十五条/第一款","admin","深圳市金四季实业有限公司经营无中文标签进口酒案","罚款2000元",0.2,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(20,"罚款;没收违法所得;没收非法财物","20220513","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市菲德越科技有限公司经营不符合国家标准的产品案","罚款23910元;没收违法所得;没收非法财物",2.391,0.03722);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(21,"罚款","20220513","其他","中华人民共和国广告法/第五章法律责任/第五十八条/第一款","admin","深圳玉玄道中医馆发布虚假广告案","罚款800元",0.08,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(22,"罚款;没收违法所得","20220513","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市龙岗区南湾广涛菜档经营农药残留超过国家限量标准豇豆案","罚款5000元;没收违法所得",0.5,0.002454);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(23,"罚款","20220513","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十八条/第一款,中华人民共和国广告法/第五章法律责任/第五十八条/第一款,中华人民共和国广告法/第五章法律责任/第五十五条/第一款,中华人民共和国行政处罚法/第四章","admin","深圳市福康大药房有限公司发布虚假广告案","罚款800元",0.08,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(24,"罚款;警告","20220513","食品违法行为","食品经营许可管理办法(2017修正)/第七章法律责任/第四十九条/第1款,广东省食品安全条例/第五章法律责任/第六十条","admin","深圳市宝安区新安乌兰烧烤店超范围经营冷食类食品案","罚款500元;警告",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(25,"罚款","20220513","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市健康互动科技有限公司发布虚假广告案","罚款5200元",0.52,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(26,"罚款;没收违法所得","20220513","食品违法行为","中华人民共和国食品安全法/第四章食品生产经营/第一节","admin","深圳市龙岗区张松斌海鲜档经营的生鱼经抽检不合格案","罚款10000元;没收违法所得",1,0.0104);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(27,"罚款;没收违法所得","20220513","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市宝安区燕罗佳怡富五金商行销售抽检不合格的产品案","罚款1320元;没收违法所得",0.132,0.0072);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(28,"罚款;没收违法所得","20220513","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳麦娇奴服饰有限公司生产不合格产品案","罚款14220元;没收违法所得",1.422,0.196);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(23,"罚款","20220513","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款,中华人民共和国广告法/第五章法律责任/第五十八条/第一款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第二十八条/第一款","admin","深圳市福康大药房有限公司发布虚假广告案","罚款800元",0.08,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(29,"罚款","20220513","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市一甜文化传播有限公司违反广告法案","罚款6333.2元",0.63332,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(30,"没收违法所得","20220513","侵害消费者权益行为","侵害消费者权益行为处罚办法/第十二条/第一款","admin","深圳市杰西服装有限责任公司侵犯消费者权益案","没收违法所得",0,0.0133);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(31,"罚款","20220513","其他","中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第三十二条/第一款","admin","深圳市龙岗区益城饮品店使用不可降解塑料袋对外提供打包服务案","罚款2000元",0.2,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(32,"罚款;没收非法财物","20220512","医疗器械违法行为","医疗器械监督管理条例(2017修正)/第七章法律责任/第六十六条/第1款","admin","深圳来福士雾化医学有限公司生产不符合强制性标准的医疗器械便携式超声雾化器案","罚款20000元;没收非法财物",2,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(33,"罚款","20220512","药品违法行为","深圳市药品零售监督管理办法/第五章法律责任/第四十一条","admin","深圳市宝华药行连锁有限公司新安分店药品混放案","罚款1000元",0.1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(34,"罚款;没收违法所得","20220512","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市龙岗区平湖创隆达包装材料批发行销售不合格产品案","罚款360元;没收违法所得",0.036,0.0048);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(35,"罚款;没收违法所得;没收非法财物","20220512","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市鸿达顺科技开发有限公司生产质量不合格电源适配器产品案","罚款6477元;没收违法所得;没收非法财物",0.6477,0.02422);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(36,"罚款;没收违法所得","20220512","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市龙华新区观澜庆隆木业商行销售抽检不合格的阻燃胶合板案","罚款11100元;没收违法所得",1.11,0.006);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(37,"警告","20220512","其他","医疗器械网络销售监督管理办法/第五章法律责任/第四十一条/第1款","admin","深圳市远高照明有限公司销售与备案信息不相符的医疗器械案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(38,"罚款;没收违法所得;警告","20220512","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第三十二条/第一款","admin","深圳市农耕记餐饮有限公司坪山益田假日分公司使用经抽检不合格的鸡蛋案","罚款10000元;没收违法所得;警告",1,0.0162);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(39,"罚款","20220512","医疗器械违法行为","医疗器械监督管理条例(2017修正)/第七章法律责任/第六十六条/第1款","admin","深圳华声医疗技术股份有限公司生产不符合强制性标准的医疗器械案","罚款80500元",8.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(40,"罚款;没收违法所得","20220512","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款,深圳经济特区食品安全监督条例/第六章法律责任/第一百一十五条","admin","深圳市万汇佳商贸有限公司坪山万福佳商场销售超过保质期的散装食品案","罚款2240元;没收违法所得",0.224,0.01009);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(41,"罚款","20220512","药品违法行为","深圳市药品零售监督管理办法/第五章法律责任/第四十一条","admin","德荣堂医药(深圳)有限公司处方药与非处方药未分类管理案","罚款1000元",0.1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(42,"罚款;没收违法所得","20220512","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十八条","admin","深圳市宝安区宝民市场妙群肉丸档经营未标注执行标准号的塑料袋案","罚款7.5元;没收违法所得",0.00075,0.001);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(43,"罚款;没收违法所得","20220512","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市郭杰灯饰有限公司销售抽检不合格灯具案","罚款194.4元;没收违法所得",0.01944,0.00483);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(44,"警告","20220512","药品违法行为","药品流通监督管理办法/第四章法律责任/第三十八条/第一款","admin","广东一六零医药连锁有限公司未凭处方销售处方药案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(45,"罚款","20220512","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市子安阁母婴服务有限公司虚假广告案","罚款450元",0.045,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(46,"罚款;没收违法所得","20220512","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市宝安区新桥街道卓记蔬菜批发店销售抽检不合格的食品(豇豆)案","罚款5000元;没收违法所得",0.5,0.00028);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(47,"警告;罚款;没收非法财物","20220512","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款,中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","深圳市坪山区成安百货店销售超过保质期的食品案","警告;罚款585元;没收非法财物",0.0585,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(48,"罚款","20220512","医疗器械违法行为","医疗器械监督管理条例/第七章法律责任/第八十六条/第一款","admin","深圳华腾生物医疗电子有限公司生产不符合强制性标准的医疗器械案","罚款20000元",2,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(49,"没收违法所得;罚款;没收非法财物","20220512","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十五条/第一款","admin","深圳市湘粤粮油实业有限公司销售标签不符合规定的食品案","没收违法所得;罚款162800元;没收非法财物",16.28,0.004);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(50,"罚款;没收违法所得","20220512","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市宝安区新桥惠实土猪肉档销售抽检不合格的猪肉案","罚款5000元;没收违法所得",0.5,0.04);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(51,"罚款;没收违法所得;没收非法财物","20220512","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市利联太阳百货有限公司销售不合格服装案","罚款15147元;没收违法所得;没收非法财物",1.5147,0.0353);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(52,"罚款;没收违法所得","20220512","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十八条","admin","深圳市星洲时代鞋服有限公司标准号的产品案","罚款449.1元;没收违法所得",0.04491,0.03882);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(53,"罚款","20220511","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市光明区百汇生活超市销售不合格产品案","罚款75元",0.0075,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(54,"罚款","20220511","特种设备违法行为","深圳经济特区特种设备安全条例/第七章法律责任/第七十一条","admin","深圳市台日电梯有限公司未按期书面告知维保合同案","罚款10000元",1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(55,"罚款","20220511","食品违法行为","广东省食品安全条例/第五章法律责任/第六十条,深圳经济特区食品安全监督条例/第六章法律责任/第一百一十五条,中华人民共和国行政处罚法/第一章总则/第五条/第二款","admin","深圳市探火餐饮管理有限公司超范围经营案","罚款550元",0.055,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(56,"罚款","20220511","食品违法行为","广东省食品安全条例/第二章食品生产经营/第一节生产经营规范/第十二条/第一款","admin","深圳市即食行乐餐饮管理有限公司超范围经营案","罚款500元",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(57,"罚款","20220511","特种设备违法行为","中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第二十八条/第一款","admin","深圳多禾国际物业管理有限公司使用未经检验的电梯案","罚款30000元",3,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(58,"罚款","20220511","广告违法行为","中华人民共和国广告法(2018修正)/第二章广告内容准则/第二十八条","admin","深圳一路发搬家有限公司涉嫌虚假宣传案","罚款3240元",0.324,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(59,"罚款","20220511","其他","中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","深圳市民浩湘当鲜餐饮服务有限公司未按规定实施经营过程控制要求案","罚款5000元",0.5,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(60,"罚款","20220511","特种设备违法行为","深圳经济特区特种设备安全条例/第七章法律责任/第七十一条","admin","深圳市吉达电梯工程有限公司未按规定每十五日进行维护保养案","罚款10000元",1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(61,"罚款","20220511","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市博盈利泰贸易有限公司虚假宣传案","罚款600元",0.06,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(62,"罚款","20220511","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十八条/第一款","admin","深圳市优优邦贸易有限公司发布以虚假或者引人误解的内容欺骗、误导消费者的其他情形的虚假广告案","罚款1800元",0.18,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(63,"罚款;没收违法所得","20220511","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条,深圳经济特区产品质量管理条例/第五章法律责任/第六十条","admin","深圳市龙岗区平湖荣昌兴商行销售不合格产品案","罚款594元;没收违法所得",0.0594,0.00381);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(64,"罚款;没收违法所得","20220511","其他","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市企学在线教育有限公司抽检不合格案","罚款454.8元;没收违法所得",0.04548,0.004128);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(65,"罚款","20220511","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市龙华区民乐一区维客佳便利店销售超保质期食品案","罚款500元",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(66,"罚款;没收违法所得","20220511","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条,深圳经济特区产品质量管理条例/第五章法律责任/第六十条","admin","深圳市龙岗区平湖伟兴包装批发行销售不合格产品案","罚款135元;没收违法所得",0.0135,0.0009);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(67,"罚款","20220511","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第三章产品质量责任和义务/第二十三条/第二款","admin","深圳市创一嘉科技有限公司生产不合格充电宝案","罚款12300元",1.23,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(68,"罚款;没收违法所得","20220511","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市龙岗区平湖街道和兴耗材包装商行销售不合格产品案","罚款375元;没收违法所得",0.0375,0.00146);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(69,"罚款;没收违法所得","20220511","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款,深圳经济特区食品安全监督条例/第六章法律责任/第一百一十五条,中华人民共和国行政处罚法/第一章总则/第四条/第二款","admin","深圳市永为投资有限公司龙岗丹竹头分店销售过期食品案","罚款500元;没收违法所得",0.05,0.00018);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(70,"罚款;没收违法所得","20220511","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第六十条","admin","深圳市龙岗区嘉得通食品商行销售不合格产品案","罚款330元;没收违法所得",0.033,0.0012);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(71,"罚款;没收违法所得","20220511","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市龙华新区龙华辉煌商店销售不符合产品质量相关规定的产品案案","罚款592.2元;没收违法所得",0.05922,0.004428);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(72,"罚款","20220511","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市珺宸健康管理有限公司广告违法案","罚款3000元",0.3,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(73,"罚款;没收违法所得","20220511","产品(商品)质量违法行为","中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第二十八条/第一款","admin","深圳市唯芳菲服饰有限公司销售抽检不合格的文胸案","罚款3464.6元;没收违法所得",0.34646,0.05096);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(74,"罚款;没收违法所得","20220511","食品违法行为","中华人民共和国行政处罚法/第一章总则/第五条/第二款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第三十二条/第一款,深圳经济特区食品安全监督条例/第六章法律责任/第一百一十五条","admin","深圳市叶子茶茶业有限公司销售标签违法食品案","罚款5000元;没收违法所得",0.5,0.0223);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(75,"罚款;没收违法所得","20220511","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市百思盟科技有限公司销售不符合产品质量标准的产品案","罚款1014元;没收违法所得",0.1014,0.0068);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(76,"警告","20220511","食品违法行为","食品经营许可管理办法(2017修正)/第七章法律责任/第四十九条/第1款","admin","深圳市龙华区爽爽手捶柠檬茶店超范围网络经营案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(77,"罚款","20220511","计量违法行为","深圳经济特区计量条例(2019修正)/第八章罚则/第四十二条","admin","深圳市深港万众街市发展有限公司主办市场内经营者使用未经检定的计量器具案","罚款5000元",0.5,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(78,"警告","20220511","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","深圳市光明区公明新好润百货店未按要求销售散装食品案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(79,"罚款","20220511","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十二条/第一款","admin","深圳市福田区楚刘湘菜馆未经许可从事食品经营活动案","罚款5000元",0.5,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(80,"罚款","20220510","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳礼纪电子商务有限公司发布虚假广告案","罚款3000元",0.3,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(81,"警告;罚款;没收违法所得","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款,中华人民共和国行政处罚法/第一章总则/第六条,中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市宝安区西乡佳联百货销售过期食品案","警告;罚款500元;没收违法所得",0.05,0.00018);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(82,"罚款;没收违法所得","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市宝安区满富原便利店销售超过保质期的食品案","罚款500元;没收违法所得",0.05,0.00004);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(83,"警告;罚款;没收违法所得","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款,中华人民共和国行政处罚法/第一章总则/第六条,中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","深圳市宝安区西乡深沙美宜多超市销售过期食品案","警告;罚款500元;没收违法所得",0.05,0.00025);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(84,"罚款","20220510","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳深安阳光电子有限公司广告违法案","罚款600元",0.06,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(85,"罚款","20220510","特种设备违法行为","深圳经济特区特种设备安全条例/第三章特种设备的使用/第二十条/第一款","admin","深圳市恒基装卸有限公司使用超期未检叉车案","罚款30000元",3,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(86,"警告;罚款;没收违法所得","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款,中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第四款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第二十八条/第二款","admin","深圳市罗湖区远森水产批发行未完全履行进货查验记录制度和销售重金属超过食品安全标准限量的花蟹(海水蟹)案","警告;罚款5000元;没收违法所得",0.5,0.0604);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(87,"罚款;没收违法所得;没收非法财物","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十八条","admin","深圳市宝安区松岗街道隆创数码电器店标准号的产品案","罚款1804元;没收违法所得;没收非法财物",0.1804,0.0098);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(88,"罚款","20220510","广告违法行为","中华人民共和国广告法(2021修正)/第五章法律责任/第五十五条","admin","深圳弘美医疗美容门诊部涉嫌发布违法广告案","罚款3000元",0.3,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(89,"罚款","20220510","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳欣知教育咨询有限公司广告违法案","罚款840元",0.084,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(90,"罚款;没收非法财物","20220510","商标违法行为","奥林匹克标志保护条例/第十二条/第1款","admin","深圳市水贝珠宝投资有限公司销售侵犯奥林匹克标志专有权商品案","罚款10000元;没收非法财物",1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(91,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第六十条,深圳经济特区产品质量管理条例/第五章法律责任/第五十七条违反本条例第二十三条、第二十五条","admin","深圳市光明区小时光好妈妈母婴店销售不合格的玩具案","罚款429元;没收违法所得",0.0429,0.0059);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(92,"罚款","20220510","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十八条/第一款","admin","深圳市阿卡索资讯股份有限公司发布违法广告案","罚款35730.42元",3.573042,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(93,"罚款","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十二条/第一款,中华人民共和国食品安全法/第九章法律责任/第一百二十五条/第一款","admin","深圳市宝安潘纳浩斯文化娱乐有限公司无证从事餐饮服务案","罚款7000元",0.7,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(94,"罚款;没收违法所得","20220510","食品违法行为","中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第三十二条/第一款","admin","深圳市宝安区琴伙便利店销售超过保质期食品案","罚款500元;没收违法所得",0.05,0.00012);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(95,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市萝卜头不锈钢有限公司销售不合格蚊帐案","罚款288元;没收违法所得",0.0288,0.006402);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(38,"警告","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","深圳市农耕记餐饮有限公司海雅缤纷城分公司食品经营过程中未做好设备维护案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(96,"罚款;没收违法所得","20220510","广告违法行为","中华人民共和国专利法/第七章专利权的保护/第六十八条","admin","深圳市程飞科技有限公司广告违法案","罚款384元;没收违法所得",0.0384,0.0384);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(97,"罚款","20220510","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市瑞鑫丰硕电子有限公司广告违法案","罚款900元",0.09,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(98,"警告","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","安费诺东亚电子科技(深圳)有限公司在经营过程中使用过期的腐竹案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(99,"罚款;没收违法所得","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市宝安区福永街道凤发一加壹便利店销售超过保质期食品案","罚款500元;没收违法所得",0.05,0.0002);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(100,"警告","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","深圳市宝安区友餐饱冰室餐厅安排未取得健康证明的人员从事接触直接入口食品的工作案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(101,"警告;罚款;没收违法所得","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款,中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","深圳市龙华新区大浪裕华生活超市销售过期食品案","警告;罚款500元;没收违法所得",0.05,0.00013);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(102,"罚款;没收违法所得","20220510","食品违法行为","中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第三十二条/第一款","admin","深圳市宝安区福永街道运茂便利店销售过期食品案","罚款500元;没收违法所得",0.05,0.00025);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(103,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十八条,中华人民共和国产品质量法/第五章罚则/第五十四条","admin","深圳市锦珂化妆用品有限责任公司标准的冰球案","罚款294.7元;没收违法所得",0.02947,0.01554);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(104,"罚款;没收违法所得;没收非法财物","20220510","食品违法行为","中华人民共和国行政处罚法/第一章总则/第五条/第二款,中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市盛世佳华商贸有限公司销售过期食品案","罚款500元;没收违法所得;没收非法财物",0.05,0.00125);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(105,"警告;罚款;没收违法所得","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市光明新区光明兴远粮油店经营不合格干百合案","警告;罚款5000元;没收违法所得",0.5,0.016);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(106,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市亚创达科技有限公司生产、销售不符合国家强制性标准要求、以不合格品冒充合格品的A8手机案","罚款450元;没收违法所得",0.045,0.0006);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(107,"罚款","20220510","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十九条/第一款","admin","深圳市和瓷文化发展有限公司发布违法广告案","罚款10000元",1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(108,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市熊吾科技有限公司销售以不合格品冒充合格品的口罩案","罚款414元;没收违法所得",0.0414,0.0091);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(109,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳不悔电子商务有限公司销售的西裤及长袖衬衫经抽检不合格案","罚款8370元;没收违法所得",0.837,0.0499);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(110,"罚款","20220510","特种设备违法行为","深圳经济特区特种设备安全条例/第七章法律责任/第六十八条","admin","深圳市林澜塑胶制品有限公司使用未经定期检验的特种设备案","罚款30000元",3,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(111,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市坤鹏电子商务有限公司销售不符合国家强制性标准要求的P20P10手机案","罚款3222元;没收违法所得",0.3222,0.0414);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(112,"罚款;没收违法所得;没收非法财物","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十五条/第一款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第三十二条/第一款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第二十八条/第一款","admin","深圳市欧健药业有限公司凤凰分店经营标签不合格的食品案","罚款2000元;没收违法所得;没收非法财物",0.2,0.052);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(113,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳易倍通商贸有限公司生产、销售不符合国家强制性标准要求、以不合格品冒充合格品的女童哈衣案","罚款1068元;没收违法所得",0.1068,0.0161);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(114,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市中履鞋业有限公司经营质量不合格的拖鞋案","罚款1240.8元;没收违法所得",0.12408,0.00693);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(115,"罚款;没收非法财物","20220510","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市宝安区航城霞霞牛肉粉店使用过期的食品原料制售牛肉粉案","罚款500元;没收非法财物",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(116,"罚款","20220510","食品违法行为","广东省食品安全条例/第五章法律责任/第六十条","admin","深圳市宝安区达芬奇披萨店超许可范围从事自制饮品制售案","罚款500元",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(117,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市龙岗区坂田松兴装饰材料行销售不符合国家强制性标准要求的9mm阻燃胶合板案","罚款1650元;没收违法所得",0.165,0.007);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(118,"罚款","20220510","食品违法行为","广东省食品安全条例/第五章法律责任/第六十条","admin","深圳市龙岗区黎金莲餐饮店未按照许可范围从事食品经营案","罚款1000元",0.1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(119,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市弗瑞尔科技有限公司销售不符合国家强制性标准要求的G20200420手机案","罚款1782元;没收违法所得",0.1782,0.0024);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(120,"没收违法所得;罚款","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市威立讯电子有限公司生产不符合执行标准的移动电源案","没收违法所得;罚款1747.2元",0.17472,0.00272);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(121,"罚款;没收违法所得","20220510","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","群侠传实业(深圳)有限公司销售的西裤经抽检不合格案","罚款5880元;没收违法所得",0.588,0.0212);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(122,"警告;罚款","20220509","化妆品违法行为","化妆品监督管理条例/第五章法律责任/第六十二条/第一款","admin","深圳市纯净之源化妆品销售有限公司进货查验记录制度案","警告;罚款10000元",1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(123,"没收违法所得;罚款;没收非法财物","20220507","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市深汕特别合作区佳佳福百货商店销售超过保质期的食品案","没收违法所得;罚款500元;没收非法财物",0.05,0.000234);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(124,"警告","20220506","侵害消费者权益行为","侵害消费者权益行为处罚办法/第十四条,中华人民共和国消费者权益保护法(2013修正)/第七章法律责任/第五十六条/第一款","admin","深圳松岗琥珀有限公司侵害消费者合法权益案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(125,"罚款","20220505","不正当竞争行为","中华人民共和国广告法/第五章法律责任/第五十八条/第一款,中华人民共和国广告法/第二章广告内容准则/第十七条","admin","深圳市荣格科技有限公司销售的食品虚假宣传功能案","罚款10500元",1.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(126,"罚款;没收非法财物","20220505","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市宝安区九美电动自行车行销售不符合强制性认证产品案","罚款1521元;没收非法财物",0.1521,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(127,"罚款;没收违法所得","20220505","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市都酷科技有限公司经营抽检不合格产品案","罚款14142元;没收违法所得",1.4142,0.0165);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(128,"罚款","20220505","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十九条/第一款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第二十八条/第一款","admin","深圳市泓茂隆电子科技有限公司发布违法广告案","罚款10000元",1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(129,"罚款;没收违法所得","20220505","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市宝安区忠意建材店销售不合格产品(水泥)案","罚款840元;没收违法所得",0.084,0.008);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(130,"罚款","20220505","食品违法行为","深圳经济特区食品安全监督条例/第六章法律责任/第一百一十五条,中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款","admin","深圳市宝安区智园小学食堂使用超过保质期的食品原料案","罚款50000元",5,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(131,"罚款;没收违法所得","20220505","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十四条/第一款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第二十七条/第一款","admin","深圳市龙华区绿康优品生鲜超市销售过期食品(泡椒鱼仔和香酥鱼仔)案","罚款500元;没收违法所得",0.05,0.000145);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(132,"罚款","20220505","特种设备违法行为","深圳经济特区特种设备安全条例/第七章法律责任/第五十八条","admin","深圳市奥达电梯有限公司电梯安装改造修理单位监督抽查不合格案","罚款20000元",2,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(133,"罚款;没收违法所得","20220505","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市启迪电子商务有限公司销售抽检不合格的产品案","罚款298.5元;没收违法所得",0.02985,0.002);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(134,"罚款","20220505","特种设备违法行为","深圳经济特区特种设备安全条例/第七章法律责任/第八十条","admin","深圳市鹏安电梯有限公司维护保养的电梯经检测电梯载荷试验监督抽查不合格案","罚款20000元",2,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(135,"罚款","20220505","食品违法行为","广东省食品安全条例/第五章法律责任/第六十条,中华人民共和国行政处罚法/第一章总则/第五条/第二款,中华人民共和国行政处罚法/第四章行政处罚的管辖和适用/第三十二条/第一款","admin","深圳市宝安区吃了个栗干货店超出食品经营许可范围销售散装食品案","罚款500元",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(136,"罚款;没收违法所得","20220505","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十二条/第一款","admin","深圳市福田区华记二朗田鸡火锅店未经许可从事食品经营活动案","罚款5000元;没收违法所得",0.5,0.731);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(137,"罚款","20220505","药品违法行为","深圳市药品零售监督管理办法/第五章法律责任/第四十一条","admin","深圳市润德丰大药房管理有限公司白石厦分店未按规定分类摆放药品案","罚款1000元",0.1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(138,"罚款;没收违法所得","20220505","医疗器械违法行为","奥林匹克标志保护条例/第十二条/第1款,中华人民共和国产品质量法/第三章生产者、销售者的产品质量责任和义务/第一节生产者的产品质量责任和义务/第二十七条/第一款,中华人民共和国商标法(2019修正)/第一章总则/第十条/第1款","admin","深圳市新启数码科技有限公司销售假冒伪劣产品案","罚款10000元;没收违法所得",1,0.265);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(139,"罚款","20220505","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳阳光兴亚大健康科技有限公司虚假宣传案","罚款3000元",0.3,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(140,"罚款","20220505","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市寻秋电子科技有限公司违法发布虚假广告案","罚款1500元",0.15,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(141,"罚款","20220501","其他","广东省食品安全条例/第五章法律责任/第六十条","admin","深圳市南山区羊家莊小吃店未经许可制售冷食类食品案","罚款500元",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(142,"罚款","20220429","广告违法行为","中华人民共和国广告法(2018修正)/第五章法律责任/第五十五条","admin","深圳伊慈佑医疗美容门诊部涉嫌广告违法案","罚款720元",0.072,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(143,"罚款;没收违法所得","20220429","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市坪山新区丕业建材店(黄辉丕)经营不合格产品案","罚款576元;没收违法所得",0.0576,0.0024);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(144,"警告","20220429","食品违法行为","中华人民共和国食品安全法/第九章法律责任/第一百二十六条/第一款","admin","深圳市永康连锁超市有限公司根竹园分公司未按规定销售散装食品案","警告",0,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(145,"罚款","20220429","食品违法行为","广东省食品安全条例/第五章法律责任/第六十条。,中华人民共和国行政处罚法/第一章总则/第五条/第二款","admin","深圳市龙华区玖叔餐饮店超范围经营冷食案","罚款500元",0.05,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(146,"罚款","20220429","广告违法行为","中华人民共和国广告法(2018修正)/第五章法律责任/第五十八条，中华人民共和国广告法(2018修正)/第五章法律责任/第五十八条，医疗广告管理办法/第二十二条","admin","深圳星荟丽格医疗美容诊所涉嫌违反广告法案","罚款11417元",1.1417,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(147,"罚款;没收违法所得","20220429","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市咪咪兔科技有限公司生产、销售不符合国家强制性标准要求的产品(水画本0恐龙世界)案","罚款45元;没收违法所得",0.0045,0.00066);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(148,"罚款;没收违法所得","20220429","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市龙岗区坂田文霞劳保消防器材用品商行销售抽检不合格多功能安全鞋案","罚款1500元;没收违法所得",0.15,0.012);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(149,"罚款","20220429","价格(含行政事业性收费)违法行为","中华人民共和国价格法/第二章经营者的价格行为/第十四条/第1款,中华人民共和国价格法/第六章法律责任/第四十条/第1款","admin","深圳市罗湖区广拓印章店价格违法案","罚款5000元",0.5,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(150,"罚款","20220429","价格(含行政事业性收费)违法行为","中华人民共和国价格法/第六章法律责任/第四十二条","admin","深圳市立丰大药房有限公司新和分店未明码标价案","罚款1000元",0.1,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(151,"罚款","20220429","广告违法行为","中华人民共和国广告法/第五章法律责任/第五十五条/第一款","admin","深圳市芃羽科技有限公司虚假广告宣传案","罚款.15元",0.000015,0);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(152,"罚款;没收违法所得","20220429","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市凯迪实业发展有限公司生产、销售以不合格品冒充合格品的素雅竹纤维毛巾案","罚款336元;没收违法所得",0.0336,0.0032);
insert into Violation(mid,vlass,vdate,vreason,vlaw,bureau,vinf,chufa,payment,illegal) values(147,"罚款;没收违法所得","20220429","产品(商品)质量违法行为","深圳经济特区产品质量管理条例/第五章法律责任/第五十七条","admin","深圳市咪咪兔科技有限公司生产、销售不符合国家强制性标准要求的产品(水画本0水果乐园)案","罚款45元;没收违法所得",0.0045,0.00066);

insert into admin_user(aname,akey,bureau) values('admin','123456','admin')

select * from Violation;
select * from Mercinf;