from fastapi import APIRouter, Depends, HTTPException, status
from database import curd, models
from dependencies import get_db
from sqlalchemy.orm import Session
from pydantic import BaseModel

router=APIRouter()

@router.get('/all_viol')
async def all_viol(db:Session=Depends(get_db)):
    code=0
    db_vio=curd.get_all_vio(db=db)
    db_merc=curd.get_all_Merc(db=db)
    data=[]
    for item in db_vio:
        data.append({'vid':item.vid,'mid':item.mid,'realname':db_merc[item.mid-1].realname,'vlass':item.vlass,'vdate':item.vdate,'vreason':item.vreason,'vlaw':item.vlaw,'vinf':item.vinf,'chufa':item.chufa,'payment':item.payment,'illegal':item.illegal})
    msg="获取全部违法记录成功"
    return {
        "code":code,
        "msg":msg,
        "data":data
    }
    
class viol_inf(BaseModel):
    name:str
    type:list
    date1:str
    date2:str
    
@router.post('/getviol')
async def getviol(r:viol_inf,db:Session=Depends(get_db)):
    print(r)
    msg="查询成功"
    code=0
    data=[]
    id_list=[]
    if r.name!='':
        db_res=curd.get_Merc_by_Name_mohu(db=db,mname=r.name)
        id_list=[item.mid for item in db_res]
    if r.name=='' and r.date1=='' and r.date2=='':#只针对违法类型
        db_res=curd.get_vio_by_class(db=db,vclass=r.type)
        # for item in r.type:
        #     db_res=curd.get_vio_by_class(db=db,vclass=item)
        #     data.extend(db_res)
    elif r.date1=='' and r.date2=='' and len(r.type)==0:#只针对名称
        db_res=curd.get_vio_by_mid_list(db=db,mid=id_list)
    elif r.date1!='':#针对包括时间在内
        db_res=curd.get_vio_by_time(db=db,prior_time=r.date1,last_time=r.date2,vclass=r.type,mid=id_list)
    elif r.date1=='':#针对类型&姓名
        db_res=curd.get_vio_name_class(db=db,mid=id_list,vclass=r.type)
    db_merc=curd.get_all_Merc(db=db)
    for item in db_res:
        data.append({'vid':item.vid,'mid':item.mid,'realname':db_merc[item.mid-1].realname,'vlass':item.vlass,'vdate':item.vdate,'vreason':item.vreason,'vlaw':item.vlaw,'vinf':item.vinf,'chufa':item.chufa,'payment':item.payment,'illegal':item.illegal})
    # data.extend(db_res)
    return{
        "code":code,
        "msg":msg,
        "data":data
    }
    
class getmyvioInf(BaseModel):
    mid:int
    mname:str
@router.post('/getmyviol')
async def getmyviol(r:getmyvioInf,db:Session=Depends(get_db)):
    db_res=curd.get_vio_by_mname(db=db,mid=r.mid)
    data=[]
    for item in db_res:
        # db_res[i]['realname']=r.mname
        data.append({'vid':item.vid,'realname':r.mname,'vlass':item.vlass,'vdate':item.vdate,'vreason':item.vreason,'vlaw':item.vlaw,'vinf':item.vinf,'chufa':item.chufa,'payment':item.payment,'illegal':item.illegal})
    return{
        "code":0,
        "msg":"获取个人记录成功",
        "data":data
    }
    
class getfineInf(BaseModel):
    vid:int
    mid:int
@router.post('/payfine')
async def payfine(r:getfineInf,db:Session=Depends(get_db)):
    db_res=curd.mid_pay(db=db,vid=r.vid)
    code=1
    msg="查询到对应记录，重复提交"
    print(db_res)
    if not db_res:
        code=0
        db_res=curd.add_pay(db=db,vid=r.vid,mid=r.mid)
        msg="未查询到对应记录，罚款提交成功"
    return{
        "code":code,
        "msg":msg,
        "data":db_res
    }
    
class getappealInf(BaseModel):
    mid:int
    vid:int

@router.post('/get_appealv')
async def get_appealv(r:getappealInf,db:Session=Depends(get_db)):
    db_res=curd.get_appeal_by_vid(db=db,vid=r.vid)
    code=1
    msg="查询到对应记录，重复提交"
    if not db_res:
        code=0
        msg="未查找到对应记录，可以提交"
    return{
        "code":code,
        "msg":msg
    }
    
@router.post('/getmyappeal')
async def getmyappeal(r:getappealInf,db:Session=Depends(get_db)):
    db_res=curd.get_appeal_by_mid(db=db,mid=r.mid)
    data=[]
    for item in db_res:
        if item.deal:
            deal='已处理'
            if item.succ:
                succ='申诉成功'
            else:
                succ='申诉被驳回'
        else:
            deal='等待处理'
            succ='等待处理'
        db_v=curd.get_vio_by_vid(db=db,vid=item.vid)
        data.append({'vid':item.vid,'mid':item.mid,'inf':item.inf,'deal':deal,'succ':succ,'thing':db_v.vinf})
    return{
        "code":0,
        "msg":"查询成功",
        "data":data
    }
    
class appealInf(BaseModel):
    mid:int
    vid:int
    inf:str

@router.post('/appealv')
async def appealv(r:appealInf,db:Session=Depends(get_db)):
    db_res=curd.add_appeal(db=db,mid=r.mid,vid=r.vid,inf=r.inf)
    return{
        "code":0,
        "msg":"申诉提交成功",
        "data":db_res
    }