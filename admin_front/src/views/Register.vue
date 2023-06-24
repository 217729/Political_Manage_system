<template>
    <div class="container">
        <div class="main">
            <!-- 整个注册盒子 -->
            <div class="loginbox">
                <!-- 左侧的注册盒子 -->
                <div class="loginbox-in">
                    <div class="userbox">
                        <span class="iconfont">&#xe817;</span>
                        <input class="user" id="user" v-model="name" placeholder="管理员账号名">
                    </div>
                    <br>
                    <div class="pwdbox">
                        <span class="iconfont">&#xe775;</span>
                        <input class="pwd" id="password" v-model="pwd" type="password" placeholder="密码">
                    </div>
                    <br>
                    <div class="pwdbox">
                        <span class="iconfont">&#xe775;</span>
                        <input class="pwd" id="re_password" v-model="repwd" type="password" placeholder="确认密码">
                    </div>

                    <br>
                    <button type="primary" class="register_btn" @click="register">Register</button>
                    <div class="warn">@2051857</div>
                    <button type="primary" class="login_btn" @click="login">若有账号请点击登录</button>
                </div>

                <!-- 右侧的注册盒子 -->
                <div class="background">
                    <div class="title">Welcome to The administrator system</div>
                </div>

            </div>
        </div>
    </div>
</template>
    
<script>
import request from '../../utils/request'
import { ElMessage } from 'element-plus'
export default {
    name: "Login",

    data: function () {
        return {
            name: '',
            pwd: '',
            repwd: '',
            user_list: [
                {
                    username: 'admin',
                    password: '123'
                },
            ]
        }
    },
    methods: {
        login(){
            this.$router.push('/')
        },
        async register() {
            //判断两次输入的密码是否一致，如果密码不一致，则需要重新输入
            if (this.pwd != this.repwd) {
                ElMessage({
                    message: '两次输入的密码不一致,请重新输入',
                    type: 'warning',
                })
            }
            else if (this.pwd == '') {
                ElMessage({
                    message: "密码不能为空",
                    type: 'warning',
                })
            }
            else if (this.name == '') {
                ElMessage({
                    message: "用户名不能为空",
                    type: 'warning',
                })
            }
            //如果密码也一直，则存到用户列表里面
            else {
                //连后端
                const res = await request.post('/registera', {
                    aname: this.name,
                    akey: this.pwd
                })
                console.log(res.data)
                if (res.data.code == 1)
                    ElMessage({
                        message: "管理员已经存在，注册失败！",
                        type: 'warning',
                    })
                else {
                    ElMessage({
                        message: '注册成功',
                        type: 'success',
                    })
                    console.log(res.data.data)
                    this.$router.push({
                        path: '/',
                    })
                }
            }
        }
    }
}
</script>
    
<style scoped>
.login_btn {
    background-color: transparent;
    /* Green */
    border: none;
    text-decoration: none;
    font-size: 12px;
    /* border-radius: 20px;   */
    color: #4E655D;
    font-size: 12px;
    text-decoration: underline;
    display: flex;
    margin-left: 25px;
    outline: none;

}
.loginbox {
    display: flex;
    position: absolute;
    width: 800px;
    height: 400px;
    top: 40%;
    left: 50%;
    transform: translate(-50%, -50%);
    box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0 #4E655D;
}

.loginbox-in {
    background-color: #89AB9E;
    width: 240px;
}

.userbox {
    margin-top: 100px;
    height: 30px;
    width: 230px;
    display: flex;
    margin-left: 10px;
}

.pwdbox {
    height: 30px;
    width: 225px;
    display: flex;
    margin-left: 10px;
}

.background {
    width: 570px;
    background-image: url('./img/Christmas_Trees.png');
    background-size: cover;
    font-family: sans-serif;
}

.title {
    margin-top: 320px;
    font-weight: bold;
    font-size: 20px;
    color: #4E655D;

}

.title:hover {
    font-size: 21px;
    transition: all 0.4s ease-in-out;
    cursor: pointer;
}

.uesr-text {
    position: left;
}

input {
    outline-style: none;
    border: 0;
    border-bottom: 1px solid #E9E9E9;
    background-color: transparent;
    height: 20px;
    font-family: sans-serif;
    font-size: 15px;
    color: #445b53;
    font-weight: bold;
}

/* input::-webkit-input-placeholder{
        color:#E9E9E9;
     } */
input:focus {
    border-bottom: 2px solid #445b53;
    background-color: transparent;
    transition: all 0.2s ease-in;
    font-family: sans-serif;
    font-size: 15px;
    color: #445b53;
    font-weight: bold;

}

input:hover {
    border-bottom: 2px solid #445b53;
    background-color: transparent;
    transition: all 0.2s ease-in;
    font-family: sans-serif;
    font-size: 15px;
    color: #445b53;
    font-weight: bold;

}

input:-webkit-autofill {
    box-shadow: 0 0 0px 1000px #89AB9E inset !important;
    -webkit-text-fill-color: #445b53;

}

input:-webkit-autofill::first-line {
    font-size: 15px;
    font-weight: bold;
}

.log-box {
    font-size: 12px;
    display: flex;
    justify-content: space-between;
    width: 174px;
    margin-left: 30px;
    color: #4E655D;
    margin-top: -5px;
    align-items: center;

}

.log-box-text {
    color: #4E655D;
    font-size: 12px;
    text-decoration: underline;
}

.register_btn {
    background-color: #5f8276;
    /* Green */
    border: none;
    color: #FAFAFA;
    padding: 7px 35px;
    text-align: center;
    text-decoration: none;
    font-size: 13px;
    border-radius: 20px;
    outline: none;
}

.register_btn:hover {
    box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0 rgba(0, 0, 0, 0.19);
    cursor: pointer;
    background-color: #0b5137;
    transition: all 0.2s ease-in;
}

.warn {
    margin-top: 50px;
    margin-right: 110px;
    margin-bottom: 5px;
    font-weight: bold;
    font-size: 17px;
}


.register_btn:hover {
    font-weight: bold;
    cursor: pointer;
}

@font-face {
    font-family: "iconfont";
    src: url('./font/iconfont.eot');
    src: url('./font/iconfont.eot?#iefix') format('embedded-opentype'),
        /* IE6-IE8 */
        url('./font/iconfont.woff2') format('woff2'), url('./font/iconfont.woff') format('woff'), url('./font/iconfont.ttf') format('truetype'),
        /* chrome, firefox, opera, Safari, Android, iOS 4.2+ */
        url('./font/iconfont.svg#iconfont') format('svg');
}

.iconfont {
    font-family: "iconfont" !important;
    font-size: 20px;
    font-style: normal;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    height: 22px;
    color: #4E655D;
    margin-right: 10px;
    margin-top: 3px;
}

.icon-key:before {
    content: "\e775";
}

.icon-account:before {
    content: "\e817";
}
</style>