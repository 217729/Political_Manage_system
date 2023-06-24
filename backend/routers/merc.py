from fastapi import APIRouter, Depends, HTTPException, status
from database import curd, models
from dependencies import get_db
from sqlalchemy.orm import Session
from pydantic import BaseModel

router = APIRouter()

class registerInfoM(BaseModel):
    mname:str
    admin_cata:str
    legal_rep:str
    mkey:str
    realname:str
    
@router.post('/registerm')
async def registerm(r:registerInfoM,db:Session=Depends(get_db)):
    code=0
    msg="注册成功"
    db_user=curd.get_Merc_by_Name(db=db,mname=r.mname)
    data={}
    if db_user:
        msg="注册失败，用户名已经存在"
        code=1
    else:
        db_user=curd.create_Merc(db=db,mname=r.mname,admin_cata=r.admin_cata,legal_rep=r.legal_rep,mkey=r.mkey,realname=r.realname)
    data['mid']=db_user.mid
    data['mName']=db_user.mname
    data['mkey']=db_user.mkey
    return{
        "code":code,
        "msg":msg,
        "data":data
    }
    
class registerInfoM_login(BaseModel):
    mname:str
    mkey:str
    
@router.post('/loginm')
async def loginm(r:registerInfoM_login,db:Session=Depends(get_db)):
    code=0
    msg="登录成功"
    db_user=curd.get_Merc_by_Name(db=db,mname=r.mname)
    data={"id":1,"name":r.mname}
    if not db_user:
        msg="登录失败，用户名不存在"
        code=1
    elif r.mkey==db_user.mkey:
        data['id']=db_user.mid
    else:
        msg="登录失败，密码错误"
        code=2
    return{
        "code":code,
        "msg":msg,
        "data":data
    }
    
class modify_m(BaseModel):
    mname:str
    mkey:str
    mid:int

@router.post('/modifym')
async def modifym(r:modify_m,db:Session=Depends(get_db)):
    code=0
    msg="信息修改成功"
    if r.mkey=='':
        db_user=curd.get_Merc_by_id(db=db,mid=r.mid)
        r.mkey=db_user.mkey
    db_user=curd.modify_Merc(db=db,mid=r.mid,mname=r.mname,mkey=r.mkey)
    data={"id":r.mid,"name":db_user.mname,"key":db_user.mkey}
    return{
        "code":code,
        "msg":msg,
        "data":data
    }
    
class getinfom(BaseModel):
    mid:int
    
@router.post('/getam')
async def getam(r:getinfom,db:Session=Depends(get_db)):
    code=0
    msg="信息获取成功"
    db_user=curd.get_Merc_by_id(db=db,mid=r.mid)
    data={"mid":db_user.mid,"mname":db_user.mname,"mkey":db_user.mkey,"realname":db_user.realname,"legal_rep":db_user.legal_rep}
    return{
        "code":code,
        "msg":msg,
        "data":data
    }