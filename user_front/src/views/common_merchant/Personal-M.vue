<template>
    <div class="total">
        <el-container>
            <!-- 边=边缘栏 -->
            <el-aside width="200px" style="background-color: whitesmoke;">
                <div class="logo">
                    <img src="/static/pictures/touxiang.jpg">
                </div>
                <br />
                <div class="option">
                    <img src="/static/pictures/首页.png" @click="to_home">
                </div>
                <div class="option" @click="to_search">
                    <img src="/static/pictures/查询.png" @click="to_search">
                </div>
                <div class="option">
                    <img src="/static/pictures/申诉-appeal.png" @click="to_accuse">
                </div>
                <div class="option" style="background-color: gainsboro;">
                    <img src="/static/pictures/个人中心.png">
                </div>
                <div class="option">
                    <img src="/static/pictures/反馈信息.png" @click="to_feedback">
                </div>

                <div class="white"></div>
                <div class="option">
                    <img src="/static/pictures/退出-green.png" @click="to_exit">
                </div>
            </el-aside>
            <!-- 边缘栏end -->

            <!-- 主要内容栏 -->
            <el-main>
                <el-divider />
                <el-row>
                    <el-col :span="8">
                        <span style="font-size: 20px;margin-top:10px">账户信息</span>
                        <el-form :model="form" label-width="100px"
                            style="margin-left:60px;margin-right: 60px; margin-top: 10px;" :label-position="labelPosition">
                            <el-form-item label="账号名">
                                <el-input v-model="form.name" :placeholder="user_name" :disabled="no_edit"></el-input>
                            </el-form-item>
                            <el-form-item label="密码">
                                <el-input v-model="form.key" show-password :disabled="no_edit"
                                    :placeholder="mkey"></el-input>
                            </el-form-item>
                            <el-form-item label="商家名称">
                                <el-input v-model="form.store_name" disabled :placeholder="realname"></el-input>
                            </el-form-item>
                            <el-form-item label="法人代表">
                                <el-input v-model="form.legal_rep" disabled
                                    :placeholder="legal_rep"></el-input>
                            </el-form-item>
                            <el-form-item label="是否为商家">
                                <el-input disabled placeholder="是"></el-input>
                            </el-form-item>
                            <el-form-item>
                                <el-button type="primary" :icon="Edit1" circle :disabled="!no_edit"
                                    style="position: absolute;right:50px;top:10px;" @click="edit"/>
                                <el-button type="primary" :icon="Check1" circle :disabled="no_edit"
                                    style="position: absolute;right:0%;top:10px;" @click="confirm"/>
                            </el-form-item>
                        </el-form>
                    </el-col>
                    <el-divider direction="vertical" />
                    <el-col :span="8">
                        <span style="font-size: 20px;margin-top:10px">申诉回复消息</span>
                        <div class="imgs">
                            <img src="/static/pictures/None.png">
                        </div>
                    </el-col>
                    <el-divider direction="vertical" />
                    <el-col :span="7">
                        <span style="font-size: 20px;margin-top:10px">系统消息</span>
                        <div class="demo-collapse">
                            <el-collapse accordion style="margin-top: 20px;">
                                <el-collapse-item title="欢迎来到市场监管领域下的违法事件查询平台" name="1">
                                    <div>
                                        在这里，你可以查询你想查询的相应事件。首页提供了你可能感兴趣的一些法律法规。
                                    </div>
                                    <div>
                                        在申诉界面你可以看到贵店的违法记录，你可以在这里提交罚金或者对相应记录提出申诉。
                                    </div>
                                    <div>
                                        希望您可以努力规范自己的行为，不要违法乱纪。
                                    </div>
                                </el-collapse-item>
                                <el-collapse-item title="关于反馈的一些说明" name="2">
                                    <div>
                                        我们希望你在使用过程中遇到任何问题或bug都能够及时通过反馈界面或者邮箱联系我们，我们将会很荣幸收到您的反馈。
                                    </div>
                                </el-collapse-item>
                                <el-collapse-item title="积极规范店铺行为，从我做起" name="3">
                                    <div>
                                        我们希望你在企业的经营过程中能够做到城市诚信，我们感谢您为构建和谐市场所作出的努力。
                                    </div>
                                </el-collapse-item>
                            </el-collapse>
                        </div>
                    </el-col>
                </el-row>
            </el-main>
        </el-container>
    </div>
</template>
  
<script>
import request from '../../../utils/request'
import {useRoute} from 'vue-router'
import { reactive, ref,shallowRef } from 'vue'
import { Delete, Edit, Check, Share, Upload } from '@element-plus/icons-vue'
export default {
    name: "Homeview",
    data: function () {
        return {
            no_edit: true,
            // user_name: "2051857",
            form: reactive({
                name: '',
                key: '',
                store_name: '',
                legal_rep: '',
            }),
            mkey:'',
            realname:'',
            legal_rep:'',
            labelPosition: ref('top'),
            Edit1: shallowRef(Edit),
            Check1: shallowRef(Check),
        }
    },
    setup(){
        const route=useRoute()
        const user_name=ref(route.query.name)
        const id=ref(route.query.id)
        const merc=ref(route.query.merc)
        console.log('111',route.query)
        // const mkey='123456'
        // const realname=user_name
        // const legal_rep='2051857'
        return {
            user_name,
            id,
            merc,
        }
    },
    async created(){
        //连后端
        const res=await request.post('/getam',{mid:this.id})
        console.log(res)
        this.mkey=res.data.data.mkey
        this.realname=res.data.data.realname
        this.legal_rep=res.data.data.legal_rep
    },
    methods: {
        to_search() {
            this.$router.push({
                path:'/SearchViewU',
                query:{
                    name:this.user_name,
                    id:this.id,
                    merc:this.merc
                }
            })
            // this.$router.push('SearchViewU')
        },
        to_home() {
            this.$router.push({
                path:'/HomeviewU',
                query:{
                    name:this.user_name,
                    id:this.id,
                    merc:this.merc
                }
            })
            // this.$router.push('HomeviewU')
        },
        to_accuse() {
            this.$router.push({
                path:'/AppealM',
                query:{
                    name:this.user_name,
                    id:this.id,
                    merc:this.merc
                }
            })
            // this.$router.push('AccusationU')
        },
        to_feedback() {
            this.$router.push({
                path:'/SuggestionU',
                query:{
                    name:this.user_name,
                    id:this.id,
                    merc:this.merc
                }
            })
            // this.$router.push('SuggestionU')
        },
        to_exit() {
            this.$router.push('/')
        },
        edit(){
            this.no_edit=false
        },
        async confirm(){
            this.no_edit=true
            if (this.form.name != '' || this.form.key != '') {
                //连后端
                const res = await request.post('/modifym', {
                    mid: this.id,
                    mname: this.form.name == '' ? this.user_name : this.form.name,
                    mkey: this.form.key
                })
                console.log(res)
                if (this.form.name != '')
                    this.user_name = this.form.name
            }
        }
    }

}
</script>
  
<style scoped>
:deep .el-collapse-item__header{
    background-color: gainsboro;
}
.imgs {
    top: 50px;
    height: 400px;
    left: 450px;
    position: absolute;
    width: 400px;
    /* background-color: #4E655D; */
}

.imgs>img {
    width: 100%;
    height: 100%;
}

.el-divider--vertical {
    display: inline-block;
    width: 2px;
    height: 500px;
    vertical-align: middle;
    background-color: #4E655D;
}

.total {
    /*整个大基调 */
    top: 20px;
    left: 20px;
    display: flex;
    position: absolute;
    width: 1480px;
    height: 95%;
    box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0 #4E655D;
}

.logo {
    margin-top: 20px;
    margin-left: 50px;
    width: 100px;
    height: 100px;
    /* background-color: aliceblue; */
}

.logo img {
    width: 100%;
    height: 100%;
    border-radius: 60px;
}

.option {
    width: 200px;
    height: 80px;
    top: 10px;
    /* margin-left: 25px; */
    /* left:50px; */
    display: flex;
    position: relative;
    /* background-color: aliceblue; */
}

.option img {
    margin-left: 75px;
    width: 50px;
    height: 50px;
    align-self: center;
    /* background-color: #4E655D; */
}

.option img:hover {
    background-color: gainsboro;
}

.white {
    width: 90%;
    height: 80px;
    /* background-color: #4E655D; */
}
</style>