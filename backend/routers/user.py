from fastapi import APIRouter, Depends, HTTPException, status
from database import curd, models
from dependencies import get_db
from sqlalchemy.orm import Session
from pydantic import BaseModel

router=APIRouter()

class registerInfo(BaseModel):
    uname:str
    ukey:str
    
@router.post('/registeru')
async def registeru(r:registerInfo,db:Session=Depends(get_db)):
    code=0
    msg="注册成功"
    db_user=curd.get_user_by_name(db=db,uname=r.uname)
    data={}
    if db_user:
        msg="注册失败，用户名已经存在"
        code=1
    else:
        db_user=curd.insert_user(db=db,uname=r.uname,ukey=r.ukey)
    data['uid']=db_user.uid
    data['userName']=db_user.uname
    data['ukey']=db_user.ukey
    return{
        "code":code,
        "msg":msg,
        "data":data
    }

@router.post('/loginu')
async def loginu(r:registerInfo,db:Session=Depends(get_db)):
    code=0
    db_user=curd.get_user_by_name(db=db,uname=r.uname)
    data={"id":1,"name":r.uname}
    if not db_user:
        msg="登录失败！用户名不存在"
        code=1
    elif db_user.ukey==r.ukey:
        msg="登录成功"
        data['id']=db_user.uid
    else:
        msg="密码错误"
        code=2
    return{
        "code":code,
        "msg":msg,
        "data":data
    }
    
class modify_info_u(BaseModel):
    uid:int
    uname:str
    ukey:str
    
@router.post('/modifyu')
async def modifyu(r:modify_info_u,db:Session=Depends(get_db)):
    code=0
    msg="信息修改成功"
    if(r.ukey==''):
        db_user=curd.get_user_by_id(db=db,uid=r.uid)
        r.ukey=db_user.ukey
    db_user=curd.modify_user(db=db,uid=r.uid,uname=r.uname,ukey=r.ukey)
    data={"id":r.uid,"name":db_user.uname,"key":db_user.ukey}
    return{
        "code":code,
        "msg":msg,
        "data":data
    }
    
class getinfou(BaseModel):
    uid:int
@router.post('/getau')
async def getau(r:getinfou,db:Session=Depends(get_db)):
    code=0
    msg="信息获取成功"
    db_user=curd.get_user_by_id(db=db,uid=r.uid)
    data={"uid":db_user.uid,"uname":db_user.uname,"ukey":db_user.ukey}
    return{
        "code":code,
        "msg":msg,
        "data":data
    }

class accuseInfo(BaseModel):
    uid:int
    mname:str
    rclass:str
    inf:str
@router.post('/accuse')
async def accuse(r:accuseInfo,db:Session=Depends(get_db)):
    db_merc=curd.get_Merc_by_Name(db=db,mname=r.mname)
    code=0
    msg="举报成功"
    data={}
    if not db_merc:
        code=1
        msg="不存在对应商家，举报失败"
    else:
        db_res=curd.add_report(db=db,uid=r.uid,mid=db_merc.mid,inf=r.inf,rclass=r.rclass)
        data=db_res
    return{
        "code":code,
        "msg":msg,
        "data":data
    }
    
class getaccuse(BaseModel):
    uid:int
@router.post('/myaccuse')
async def myaccuse(r:getaccuse,db:Session=Depends(get_db)):
    db_res=curd.get_report_by_uid(db=db,uid=r.uid)
    data=[]
    for item in db_res:
        if item.deal==0:
            deal='等待处理'
            succ='等待处理'
        else:
            deal='已审核'
            if item.succ:
                succ='审核通过'
            else:
                succ='举报被驳回'
        db_merc=curd.get_Merc_by_id(db=db,mid=item.mid)
        data.append({'uid':item.uid,'mid':item.mid,'realname':db_merc.realname,'inf':item.inf,'rclass':item.rclass,'deal':deal,'succ':succ})
    return{
        "code":0,
        "msg":"获取举报历史成功",
        "data":data
    }