from .database import Base
from sqlalchemy import Boolean, Column, ForeignKey, Integer, String,DateTime,FLOAT
from datetime import datetime

# /*商家信息*/
class Mercinf(Base):
    __tablename__="Mercinf"
    mid=Column(Integer,primary_key=True,autoincrement = True)
    mname=Column(String)
    admin_cata=Column(String)
    legal_rep=Column(String)
    mkey=Column(String)
    realname=Column(String)
    
# /*管理员信息*/
class admin_user(Base):
    __tablename__="admin_user"
    aid=Column(Integer,primary_key=True,autoincrement = True)
    aname=Column(String)
    akey=Column(String)
    bureau=Column(String)
    
# 处罚信息
class Violation(Base):
    __tablename__="Violation"
    vid=Column(Integer,primary_key=True,autoincrement = True)
    mid=Column(Integer)
    vlass=Column(String)
    vdate=Column(DateTime,default=datetime.now())#日期日期日期日期
    vreason=Column(String)
    vlaw=Column(String)
    bureau=Column(String)
    chufa=Column(String)
    vinf=Column(String)
    payment=Column(FLOAT)
    illegal=Column(FLOAT)
    
# 罚款缴纳信息表
class PayInf(Base):
    __tablename__="PayInf"
    mid=Column(Integer,primary_key=True)
    vid=Column(Integer,primary_key=True)
    
# 申诉表
class appeal(Base):
    __tablename__="appeal"
    vid=Column(Integer,primary_key=True)
    mid=Column(Integer,primary_key=True)
    inf=Column(String)
    deal=Column(Integer)
    succ=Column(Integer)
    
# 普通用户
class user(Base):
    __tablename__="user"
    uid=Column(Integer,primary_key=True,autoincrement = True)
    uname=Column(String)
    ukey=Column(String)
    
# //举报信息
class report(Base):
    __tablename__="report"
    uid=Column(Integer,primary_key=True)
    mid=Column(Integer,primary_key=True)
    rclass=Column(String)
    inf=Column(String)
    deal=Column(Integer)
    succ=Column(Integer)
    