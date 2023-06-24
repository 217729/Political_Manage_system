<template>
    <div class="container">
        <div class="main">
            <!-- 整个注册盒子 -->
            <div class="loginbox">
                <!-- 左侧的注册盒子 -->
                <div class="loginbox-in">
                    <!-- <div class="typebox">
                        <el-select v-model="option_type" placeholder="请选择身份">
                            <el-option v-for="item in optionList" :key="item" :label="item" :value="item">
                            </el-option>
                        </el-select>
                    </div> -->
                    <el-tabs v-model="activeName" class="demo-tabs">
                        <el-tab-pane label="&nbsp &nbsp普通用户&nbsp" name="first">
                            <div class="userbox">
                                <span class="iconfont">&#xe817;</span>
                                <input class="user" id="user" v-model="name" placeholder="用户名">
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
                            <button type="primary" class="register_btn" @click="register_user">Register</button>
                            <br>
                            <br><br><br><br><br><br><br>
                            <button type="primary" class="login_btn" @click="login">若有账号请点击登录</button>
                        </el-tab-pane>
                        <el-tab-pane label="商家" name="second">
                            <div class="userbox">
                                <span class="iconfont">&#xe817;</span>
                                <input class="user" id="userm" v-model="name" placeholder="用户名">
                            </div>
                            <div class="userbox">
                                <span class="iconfont">&#xe817;</span>
                                <!-- <el-select v-model="admin_cata" placeholder="请选择行政相对人类别" style="width: 190px;">
                                    <el-option v-for="item in selectoptions" :key="item" :label="item" :value="item">
                                    </el-option>
                                </el-select> -->
                                <input class="user" id="typem" v-model="admin_cata" placeholder="行政相对人类别">
                            </div>
                            <div class="userbox">
                                <span class="iconfont">&#xe817;</span>
                                <input class="user" id="daibiaom" v-model="legal_rep" placeholder="法人代表">
                            </div>
                            <div class="userbox">
                                <span class="iconfont">&#xe817;</span>
                                <input class="user" id="realm" v-model="realname" placeholder="真实商户名">
                            </div>
                            <br>
                            <div class="pwdbox">
                                <span class="iconfont">&#xe775;</span>
                                <input class="pwd" id="passwordm" v-model="pwd" type="password" placeholder="密码">
                            </div>
                            <br>
                            <div class="pwdbox">
                                <span class="iconfont">&#xe775;</span>
                                <input class="pwd" id="re_passwordm" v-model="repwd" type="password" placeholder="确认密码">
                            </div>
                            <br>
                            <button type="primary" class="register_btn" @click="register_merc">Register</button>
                            <button type="primary" class="login_btn" @click="login">若有账号请点击登录</button>
                        </el-tab-pane>
                    </el-tabs>
                </div>

                <!-- 右侧的注册盒子 -->
                <div class="background">
                    <div class="title">Welcome to The Illegal Event Management Platform</div>
                </div>
            </div>
        </div>
    </div>
</template>
    
<script>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import request from '../../utils/request'
export default {
    name: "Register",
    data: function () {
        return {
            optionList: ["普通用户", "商家"],
            selectoptions: ['个体工商户', '法人及非法人组织'],
            option_type: '',
            name: '',
            pwd: '',
            repwd: '',
            admin_cata: '',
            legal_rep: '',
            realname: '',
            activeName: ref('first'),
            user_list: [
                {
                    username: 'admin',
                    password: '123'
                },
            ]
        }
    },
    methods: {
        login() {
            this.$router.push('/')
        },
        async register_user() {
            //判断两次输入的密码是否一致，如果密码不一致，则需要重新输入
            if (this.pwd != this.repwd) {
                ElMessage({
                    message: '两次输入的密码不一致,请重新输入',
                    type: 'warning',
                })
            }
            else if (this.pwd == '') {
                ElMessage({
                    message: '密码不能为空',
                    type: 'warning',
                })
            }
            else if (this.name == '') {
                ElMessage({
                    message: '用户名不能为空',
                    type: 'warning',
                })
            }
            //如果密码也一致，则存到用户列表里面
            else {
                //连后端
                const res = await request.post('/registeru', {
                    uname: this.name,
                    ukey: this.pwd
                })
                console.log(res)
                if (res.data.code == 1) {
                    ElMessage({
                        message: '用户名已经存在，注册失败',
                        type: 'warning',
                    })
                }
                else {
                    ElMessage({
                        message: '注册成功',
                        type: 'success',
                    })
                    this.$router.push('/')
                }
            }
        },
        async register_merc() {
            //判断两次输入的密码是否一致，如果密码不一致，则需要重新输入
            if (this.pwd != this.repwd) {
                ElMessage({
                    message: '两次输入的密码不一致,请重新输入',
                    type: 'warning',
                })
            }
            else if (this.pwd == '') {
                ElMessage({
                    message: '密码不能为空',
                    type: 'warning',
                })
            }
            else if (this.name == '' || this.admin_cata == '' || this.legal_rep == '' || this.realname == '') {
                ElMessage({
                    message: '注册信息不能存在空项',
                    type: 'warning',
                })
            }
            //如果密码也一致，则存到用户列表里面
            else {
                //连后端
                const res = await request.post('/registerm', {
                    mname: this.name,
                    mkey: this.pwd,
                    admin_cata: this.admin_cata,
                    legal_rep: this.legal_rep,
                    realname: this.realname
                })
                console.log(res)
                if (res.data.code == 1) {
                    ElMessage({
                        message: '用户名已经存在，注册失败',
                        type: 'warning',
                    })
                }
                else {
                    ElMessage({
                        message: '注册成功',
                        type: 'success',
                    })
                    this.$router.push('/')
                }
            }
        }
    }
}
</script>
    
<style scoped>
/* // 设置输入框的背景色、字体颜色、边框属性设置； */
.demo-tabs>.el-tabs__content {
    padding: 32px;
    /* color: #6b778c; */
    font-size: 32px;
    font-weight: 600;
}

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

.typebox {
    margin-top: 70px;
    height: 50px;
}

.userbox {
    margin-top: 10px;
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
    margin-top: 60px;
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