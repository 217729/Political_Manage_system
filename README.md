# Political_Manage_system
违法事件管理平台，Vue3+Element plus+fastapi
1.将backend/database/sql/create_table.sql文件放到MYSQL中执行（该文件中包括了一百多条初始违法记录信息）
2.切换到backend文件夹下，在databas目录下的database.py中请将数据库密码改为你自己的密码；
  之后在终端输入uvicorn main:app --reload指令，即可运行后端（注意：可能需要安装fastapi等包，直接通过pip install下载即可）
3.切换到admin_front文件夹，打开终端，依次输入：npm install;npm install element-plus;npm install axios;
  之后输入npm run dev即可实现管理员前端的运行，打开运行结果给出的网址即可使用管理员端；
4.切换到user_front文件夹，打开终端，依次输入：npm install;npm install element-plus;npm install axios;
  之后输入npm run dev即可实现用户端的运行，打开运行结果给出的网址即可使用用户端。

  本系统实现了登录名的唯一性；在使用过程中可能需要刷新一下界面才会出现相应更新之后的结果；
  系统初始时内置了一百多家商户信息，初始密码均为123456。
  管理员初始内置账号密码为：admin（账号），123456（密码）。
