#对数据库的增删查改操作
from sqlalchemy.orm import Session
from sqlalchemy import func,and_
from . import models
import datetime

####################################Mercinf##################################
def get_Merc_by_Name(db:Session,mname:str):
    return db.query(models.Mercinf).filter(models.Mercinf.mname==mname).first()

def get_Merc_by_Name_mohu(db:Session,mname:str):
    return db.query(models.Mercinf).filter(models.Mercinf.mname.like('%'+mname+'%'))

def get_Merc_by_id(db:Session,mid:int):
    return db.query(models.Mercinf).filter(models.Mercinf.mid==mid).first()
    
def create_Merc(db:Session,mname:str,admin_cata:str,legal_rep:str,mkey:str,realname:str):
    db_merc=models.Mercinf(mname=mname,admin_cata=admin_cata,legal_rep=legal_rep,mkey=mkey,realname=realname)
    db.add(db_merc)
    db.commit()#提交保存到数据库中
    db.refresh(db_merc)#刷新
    return db_merc

def modify_Merc(db:Session,mid:int,mname:str,mkey:str):
    db_merc=db.query(models.Mercinf).filter(models.Mercinf.mid==mid).first()
    if db_merc:
        db_merc.mname=mname
        db_merc.mkey=mkey
        db.commit()
    return db_merc

def get_all_Merc(db:Session):
    return db.query(models.Mercinf).all()

####################################admin_user################################
def get_Admin_by_Name(db:Session,aname:str):
    return db.query(models.admin_user).filter(models.admin_user.aname==aname).first()

def create_Admin(db:Session,aname:str,akey:str,bureau:str):
    db_admin=models.admin_user(aname=aname,akey=akey,bureau=bureau)
    db.add(db_admin)
    db.commit()
    db.refresh(db_admin)
    return db_admin

#####################################Violation###################################
def add_vio(db:Session,mid:int,vlass:str,vdate:str,vreason:str,vlaw:str,vinf:str,chufa:str,payment:float,illegal:float):
    a=vdate.split('-')
    time1=a[0]
    if len(a[1])==1:
        time1+='0'+a[1]
    else:
        time1+=a[1]
    if len(a[2])==1:
        time1+='0'+a[2]
    else:
        time1+=a[2]
    db_vio=models.Violation(mid=mid,vlass=vlass,vdate=time1,vreason=vreason,vlaw=vlaw,vinf=vinf,chufa=chufa,payment=payment,illegal=illegal,bureau='admin')
    db.add(db_vio)
    db.commit()
    db.refresh(db_vio)
    return db_vio

def get_all_vio(db:Session):
    return db.query(models.Violation).all()

def get_vio_by_vid(db:Session,vid:int):
    return db.query(models.Violation).filter(models.Violation.vid==vid).first()

def get_vio_by_class(db:Session,vclass:list):
    return db.query(models.Violation).filter(models.Violation.vreason.in_(vclass))
# def get_vio_by_class(db:Session,vclass:str):
    # return db.query(models.Violation).filter(models.Violation.vreason==vclass).all()

def get_vio_by_mid_list(db:Session,mid:list):
    return db.query(models.Violation).filter(models.Violation.mid.in_(mid))

def get_vio_by_mname(db:Session,mid:int):
    return db.query(models.Violation).filter(models.Violation.mid==mid).all()

def get_vio_name_class(db:Session,mid:list,vclass:list):
    return db.query(models.Violation).filter(and_(models.Violation.mid.in_(mid),models.Violation.vreason.in_(vclass)))

def get_vio_by_time(db:Session,prior_time:str,last_time:str,vclass:list,mid:list):
    # print(prior_time,'----',last_time)
    a=prior_time.split('-')
    time1=a[0]
    if len(a[1])==1:
        time1+='0'+a[1]
    else:
        time1+=a[1]
    if len(a[2])==1:
        time1+='0'+a[2]
    else:
        time1+=a[2]
    a=last_time.split('-')
    time2=a[0]
    if len(a[1])==1:
        time2+='0'+a[1]
    else:
        time2+=a[1]
    if len(a[2])==1:
        time2+='0'+a[2]
    else:
        time2+=a[2]
    # print(time1,'---',time2)
    if len(vclass)==0 and len(mid)==0:#只有时间
        return db.query(models.Violation).filter(and_(models.Violation.vdate>=time1,models.Violation.vdate<=time2))
    elif len(mid)==0:#时间&类型
        return db.query(models.Violation).filter(and_(models.Violation.vdate>=time1,models.Violation.vdate<=time2,models.Violation.vreason.in_(vclass)))
    elif len(vclass)==0:#时间&姓名
        return db.query(models.Violation).filter(and_(models.Violation.vdate>=time1,models.Violation.vdate<=time2,models.Violation.mid.in_(mid)))
    else:#all
        return db.query(models.Violation).filter(and_(models.Violation.vdate>=time1,models.Violation.vdate<=time2,models.Violation.vreason.in_(vclass),models.Violation.mid.in_(mid)))

########################################PayInf###################################
def mid_pay(db:Session,vid:int):
    return db.query(models.PayInf).filter(models.PayInf.vid==vid).first()

def add_pay(db:Session,vid:int,mid:int):
    db_pay=models.PayInf(vid=vid,mid=mid)
    db.add(db_pay)
    db.commit()
    db.refresh(db_pay)
    return db_pay

######################################appeal###########################
def get_all_appeal(db:Session):
    return db.query(models.appeal).all()

def get_appeal_nohandle(db:Session):
    return db.query(models.appeal).filter(models.appeal.deal==0).all()

def get_appeal_handled(db:Session):
    return db.query(models.appeal).filter(models.appeal.deal==1).all()

def get_appeal_by_mid(db:Session,mid:int):
    return db.query(models.appeal).filter(models.appeal.mid==mid).all()

def get_appeal_by_vid(db:Session,vid:int):
    return db.query(models.appeal).filter(models.appeal.vid==vid).first()

def add_appeal(db:Session,mid:int,vid:int,inf:str):
    db_appeal=models.appeal(vid=vid,mid=mid,inf=inf,deal=0,succ=0)
    db.add(db_appeal)
    db.commit()
    db.refresh(db_appeal)
    return db_appeal

def deal_appeal(db:Session,vid:int,succ:int):
    db_appeal=db.query(models.appeal).filter(models.appeal.vid==vid).first()
    if db_appeal:
        db_appeal.deal=1
        db_appeal.succ=succ
        db.commit()
    return db_appeal

########################################user################################
def get_user_by_name(db:Session,uname:str):
    return db.query(models.user).filter(models.user.uname==uname).first()

def get_user_by_id(db:Session,uid:int):
    return db.query(models.user).filter(models.user.uid==uid).first()

def get_all_user(db:Session):
    return db.query(models.user).all()

def insert_user(db:Session,uname:str,ukey:str):
    db_user=models.user(uname=uname,ukey=ukey)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def modify_user(db:Session,uid:int,uname:str,ukey:str):
    db_user=db.query(models.user).filter(models.user.uid==uid).first()
    if db_user:
        db_user.uname=uname
        db_user.ukey=ukey
        db.commit()
    return db_user

def delete_user(db:Session,uid:int):
    db_user=db.query(models.user).filter(models.user.uid==uid).first()
    if db_user:
        db.delete(db_user)
        db.commit()
        return 1
    else:
        return 0

####################################report########################
def get_report_by_uid(db:Session,uid:int):
    return db.query(models.report).filter(models.report.uid==uid).all()

def get_all_report(db:Session):
    return db.query(models.report).all()

def add_report(db:Session,uid:int,mid:int,inf:str,rclass:str):
    db_rep=models.report(uid=uid,mid=mid,rclass=rclass,inf=inf,deal=0,succ=0)
    db.add(db_rep)
    db.commit()
    db.refresh(db_rep)
    return db_rep

def deal_report(db:Session,uid:int,mid:int,succ:int):
    db_appeal=db.query(models.report).filter(and_(models.report.uid==uid,models.report.mid==mid)).first()
    if db_appeal:
        db_appeal.deal=1
        db_appeal.succ=succ
        db.commit()
    return db_appeal

def get_report_unhandle(db:Session):
    return db.query(models.report).filter(models.report.deal==0).all()

def get_report_handle(db:Session):
    return db.query(models.report).filter(models.report.deal==1).all()
    