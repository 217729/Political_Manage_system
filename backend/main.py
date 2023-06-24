from fastapi.encoders import jsonable_encoder
from routers import user,merc,violation,admin
from fastapi.middleware.cors import CORSMiddleware  
from fastapi import FastAPI
app = FastAPI()

# 加路由
app.include_router(user.router)
app.include_router(merc.router)
app.include_router(violation.router)
app.include_router(admin.router)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {"message": "Hello World!"}