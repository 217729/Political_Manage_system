#1、导入SQLAlchemy部件
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import URL
from sqlalchemy.orm import sessionmaker

#2、定义数据库URL地址，配置数据库,创建引擎
engine = create_engine(
    "mysql+pymysql://root:your_password_of_MYSQL@127.0.0.1:3306/db_bhw"
    #”drivername://root:password@127.0.0.0:3306(port)/database_name"
)
#创建数据库会话
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
#创建一个base类
Base = declarative_base()