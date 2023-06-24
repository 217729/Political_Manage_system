from fastapi import APIRouter, Depends, HTTPException, status
from database import curd, models
from dependencies import get_db
from sqlalchemy.orm import Session
from pydantic import BaseModel

router=APIRouter()

class registerInfoA(BaseModel):
    aname:str
    akey:str
    
@router.post('/registera')
async def registera(r:registerInfoA,db:Session=Depends(get_db)):
    code=0
    msg="注册成功"
    db_user=curd.get_Admin_by_Name(db=db,aname=r.aname)
    if db_user:
        msg="注册失败，管理员名已经存在"
        code=1
    else:
        db_user=curd.create_Admin(db=db,aname=r.aname,akey=r.akey,bureau='深圳办事处')
    return{
        "code":code,
        "msg":msg,
        "data":db_user
    }
    
@router.post('/logina')
async def logina(r:registerInfoA,db:Session=Depends(get_db)):
    code=0
    msg="登录成功"
    db_user=curd.get_Admin_by_Name(db=db,aname=r.aname)
    data={"id":1,"name":r.aname}
    if not db_user:
        msg="登录失败！管理员名不存在"
        code=1
    elif db_user.akey==r.akey:
        msg="登录成功"
        data['id']=db_user.aid
    else:
        msg="密码错误"
        code=2
    return{
        "code":code,
        "msg":msg,
        "data":data
    }
    
@router.get('/alluser')
async def alluser(db:Session=Depends(get_db)):
    db_user=curd.get_all_user(db=db)
    return{
        "code":0,
        "msg":"获取全部用户成功",
        "data":db_user
    }
    
@router.get('/all_merc')
async def all_merc(db:Session=Depends(get_db)):
    db_merc=curd.get_all_Merc(db=db)
    return{
        "code":0,
        "msg":"获取全部商家成功",
        "data":db_merc
    }
    
class dUser(BaseModel):
    uid:int
@router.post('/deleteu')
async def deleteu(r:dUser,db:Session=Depends(get_db)):
    db_res=curd.get_report_by_uid(db=db,uid=r.uid)
    if db_res:
        return{
            "code":2,
            "msg":"该用户有过举报行为，无法从数据库中删除"
        }
    res=curd.delete_user(db=db,uid=r.uid)
    code=0
    msg="删除成功"
    if res==0:
        msg="不存在对应用户，删除失败"
        code=1
    return{
        "code":code,
        "msg":msg
    }
    
@router.get('/need_handle_appeal')
async def need_handle_appeal(db:Session=Depends(get_db)):
    db_res=curd.get_appeal_nohandle(db=db)
    data=[]
    for item in db_res:
        db_merc=curd.get_Merc_by_id(db=db,mid=item.mid)
        db_vio=curd.get_vio_by_vid(db=db,vid=item.vid)
        data.append({'mid':item.mid,'succ':item.succ,'deal':item.deal,'inf':item.inf,'vid':item.vid,'realname':db_merc.realname,'thing':db_vio.vinf})
    return{
        "code":0,
        "msg":"获取未处理的申诉成功",
        "data":data
    }
    
@router.get('/need_handle_accuse')
async def need_handle_accuse(db:Session=Depends(get_db)):
    db_res=curd.get_report_unhandle(db=db)
    data=[]
    for item in db_res:
        db_merc=curd.get_Merc_by_id(db=db,mid=item.mid)
        data.append({'uid':item.uid,'mid':item.mid,'succ':item.succ,'deal':item.deal,'inf':item.inf,'rclass':item.rclass,'realname':db_merc.realname,})
    return{
        "code":0,
        "msg":"获取未处理的举报成功",
        "data":data
    }
    
@router.get('/handled_accuse')
async def handled_accuse(db:Session=Depends(get_db)):
    db_res=curd.get_report_handle(db=db)
    data=[]
    for item in db_res:
        db_merc=curd.get_Merc_by_id(db=db,mid=item.mid)
        if item.succ:
            succ='举报审核已通过'
        else:
            succ='举报审核未通过'
        data.append({'uid':item.uid,'mid':item.mid,'succ':succ,'deal':item.deal,'inf':item.inf,'rclass':item.rclass,'realname':db_merc.realname,})
    return{
        "code":0,
        "msg":"获取已处理的举报成功",
        "data":data
    }
    
@router.get('/handled_appeal')
async def handled_appeal(db:Session=Depends(get_db)):
    db_res=curd.get_appeal_handled(db=db)
    data=[]
    for item in db_res:
        db_merc=curd.get_Merc_by_id(db=db,mid=item.mid)
        db_vio=curd.get_vio_by_vid(db=db,vid=item.vid)
        if item.succ:
            succ="申诉审核已通过"
        else:
            succ="申诉审核已驳回"
        data.append({'mid':item.mid,'succ':succ,'deal':'已处理','inf':item.inf,'vid':item.vid,'realname':db_merc.realname,'thing':db_vio.vinf})
    
    return{
        "code":0,
        "msg":"获取已经处理的申诉成功",
        "data":data
    }
    
class deal_appeal(BaseModel):
    vid:int
    succ:int
@router.post('/handleit')
async def handleit(r:deal_appeal,db:Session=Depends(get_db)):
    # print(r.succ,'---',r.vid)
    # input()
    db_res=curd.deal_appeal(db=db,vid=r.vid,succ=r.succ)
    return{
        "code":0,
        "msg":"处理申诉成功",
        "data":db_res
    }
    
class deal_accuse(BaseModel):
    uid:int
    mid:int
    succ:int
@router.post('/handle_accuse')
async def handle_accuse(r:deal_accuse,db:Session=Depends(get_db)):
    db_res=curd.deal_report(db=db,uid=r.uid,mid=r.mid,succ=r.succ)
    return{
        "code":0,
        "msg":"处理申诉成功",
        "data":db_res
    }
    
class VioInf(BaseModel):
    mname:str
    vlass:str
    vdate:str
    vreason:str
    vlaw:str
    chufa:str
    vinf:str
    payment:float
    illegal:float
@router.post('/add_vio')
async def add_vio(r:VioInf,db:Session=Depends(get_db)):
    print(r.mname)
    db_merc=curd.get_Merc_by_Name(db=db,mname=r.mname)
    print(db_merc)
    if not db_merc:
        return{
            "code":1,
            "msg":"不存在对应商家的信息",
            "data":{}
        }
    db_res=curd.add_vio(db=db,mid=db_merc.mid,vlass=r.vlass,vdate=r.vdate,vreason=r.vreason,vlaw=r.vlaw,vinf=r.vinf,chufa=r.chufa,payment=r.payment,illegal=r.illegal)
    return{
        "code":0,
        "msg":"增加成功",
        "data":db_res
    }