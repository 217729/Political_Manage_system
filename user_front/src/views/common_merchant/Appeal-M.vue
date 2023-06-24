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
                <div class="option">
                    <img src="/static/pictures/查询.png" @click="to_search">
                </div>
                <div class="option" style="background-color: gainsboro;">
                    <img src="/static/pictures/申诉-appeal.png">
                </div>
                <div class="option">
                    <img src="/static/pictures/个人中心.png" @click="to_personal">
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
                <span style="font-size:25px;">Penalty Point & Operation</span>
                <el-divider />
                <el-tabs v-model="activeName" class="demo-tabs">
                    <el-tab-pane label="所有记录" name="first">
                        <el-table :data="tableData" :height="tableData.length - 6 <= 0 ? 'tableData.length*10' : '500'"
                            style="width: 1160px;left:50px;" :border="true" :stripe="true">
                            <el-table-column prop="vid" label="处罚编号" width="110" fixed sortable />
                            <el-table-column prop="vdate" label="处罚日期" width="110" sortable />
                            <el-table-column prop="vreason" label="违法类型" width="140" />
                            <el-table-column prop="chufa" label="处罚内容" width="150" />
                            <el-table-column prop="payment" label="罚金" width="90" sortable />
                            <el-table-column prop="illegal" label="没收非法所得等金额" width="120" sortable />
                            <el-table-column prop="vlaw" label="处罚依据" width="300" />
                            <el-table-column prop="vinf" label="备注" width="200" />
                            <el-table-column label="操作" width="180" fixed="right">
                                <template #default="scope">
                                    <el-button size="small" type="primary" @click="submit(scope.row)">提交罚款</el-button>
                                    <el-button size="small" type="warning" @click="appeal(scope.row)">提交申诉</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </el-tab-pane>
                    <el-tab-pane label="申诉信息补充界面" v-if="drawer">
                        <el-form :model="form" label-width="100px" style="margin-top:15px;margin-left:10px">
                            <el-form-item label="单位名称">
                                <el-input :placeholder="tableData[0].realname" disabled style="width:300px"></el-input>
                            </el-form-item>
                            <el-form-item label="申诉事件">
                                <el-input :placeholder="inf" disabled style="width:500px"></el-input>
                            </el-form-item>
                            <el-form-item label="具体描述信息">
                                <el-input v-model="form.desc" type="textarea" />
                            </el-form-item>
                            <el-upload class="upload-demo" drag multiple>
                                <el-icon class="el-icon--upload"><upload-filled /></el-icon>
                                <div class="el-upload__text">
                                    Drop file here or <em>click to upload</em>
                                    <br />
                                    在这里上传证明材料(如果有的话)
                                </div>
                                <template #tip>
                                    <div class="el-upload__tip">
                                        建议一次性打包上传所有文件
                                    </div>
                                </template>
                            </el-upload>

                            <el-form-item>
                                <el-button type="primary" class="butn" @click="submit_appeal">Submit</el-button>
                            </el-form-item>
                        </el-form>
                    </el-tab-pane>
                    <el-tab-pane label="申诉记录" name="second">
                        <el-table :data="app_record" :height="app_record.length - 10 <= 0 ? 'tableData.length*10' : '480'"
                            style="width: 1160px;left:50px;" :border="true" :stripe="true">
                            <el-table-column prop="vid" label="处罚编号" width="110" sortable />
                            <el-table-column prop="thing" label="申诉事件" width="350"  />
                            <el-table-column prop="inf" label="申诉信息" width="500" />
                            <el-table-column prop="deal" label="处理情况" width="100" />
                            <el-table-column prop="succ" label="申诉结果"  />
                        </el-table>
                        <!-- <img src="/static/pictures/None.png" width="480" height="480"> -->
                    </el-tab-pane>
                </el-tabs>
                <!-- <div class="contact">
                    <span style="font-size: 10px;">If you have any suggestion,please contact 2051857@tongji.edu.cn</span>
                </div> -->
            </el-main>
        </el-container>
    </div>
</template>
  
<script>
import { useRoute } from 'vue-router'
import { ref, reactive } from 'vue'
import { toRaw } from '@vue/reactivity'
import { ElMessage } from 'element-plus'
import request from '../../../utils/request'
export default {
    name: "Homeview",
    data: function () {
        return {
            activeName: ref('first'),
            // user_name: "2051857",
            tableData: [
            ],
            drawer: false,
            direction: ref('ttb'),
            shensu: 0,
            inf: '',
            form: reactive({
                name: '',
                type: '',
                date1: '',
                date2: '',
                desc: '',
            }),
            app_record:[]
        }
    },
    async created() {
        //连后端
        const res = await request.post('/getmyviol', {
            mid: this.id,
            mname: this.user_name
        })
        console.log(res.data)
        this.tableData = res.data.data
        //连后端
        const res1=await request.post('/getmyappeal',{mid:this.id,vid:0})
        console.log(res1.data)
        this.app_record=res1.data.data
    },
    setup() {
        const route = useRoute()
        const user_name = ref(route.query.name)
        const id = ref(route.query.id)
        const merc = ref(route.query.merc)
        console.log('111', route.query)
        return {
            user_name,
            id,
            merc
        }
    },
    methods: {
        to_search() {
            this.$router.push({
                path: '/SearchViewU',
                query: {
                    name: this.user_name,
                    id: this.id,
                    merc: this.merc
                }
            })
            // this.$router.push('SearchViewU')
        },
        async appeal(row) {
            // console.log(this.sensu)
            if (this.shensu != 0) {
                ElMessage({
                    message: '您还有未补充具体信息的申诉，请先对其进行处理',
                    type: 'warning',
                })
                return
            }
            const res = await request.post('/get_appealv', { mid: this.id, vid: toRaw(row).vid })
            console.log(res)
            if (res.data.code != 0) {
                ElMessage({
                    message: '您已提交过针对本事件的申诉，请勿重复提交',
                    type: 'warning',
                })
                return
            }
            else {
                this.drawer = true
                this.shensu = toRaw(row).vid
                this.inf = toRaw(row).vinf
                ElMessage({
                    message: '申诉申请成功，请在详情界面补充具体信息',
                    type: 'success',
                })
            }
        },
        async submit(row) {
            console.log(row)
            // console.log(toRaw(row).vid)
            const res = await request.post('/payfine', { vid: toRaw(row).vid, mid: this.id })
            console.log(res)
            if (res.data.code == 1) {
                ElMessage({
                    message: '您已提交过罚款，请勿重复提交',
                    type: 'warning',
                })
                return
            }
            else {
                ElMessage({
                    message: '罚款提交成功！希望您日后遵纪守法',
                    type: 'success',
                })
            }
        },
        async submit_appeal() {
            const res = await request.post('/appealv', { vid: this.shensu, mid: this.id, inf: this.form.desc })
            console.log(res)
            ElMessage({
                message: '申诉成功提交，等待管理员处理',
                type: 'success',
            })
            this.shensu=0
            this.drawer=false
            this.inf=''
        },
        to_home() {
            this.$router.push({
                path: '/HomeviewU',
                query: {
                    name: this.user_name,
                    id: this.id,
                    merc: this.merc
                }
            })
            // this.$router.push('HomeviewU')
        },
        to_personal() {
            this.$router.push({
                path: '/PersonalM',
                query: {
                    name: this.user_name,
                    id: this.id,
                    merc: this.merc
                }
            })
            // this.$router.push('PersonalU')
        },
        to_feedback() {
            this.$router.push({
                path: '/SuggestionU',
                query: {
                    name: this.user_name,
                    id: this.id,
                    merc: this.merc
                }
            })
            // this.$router.push('SuggestionU')
        },
        to_exit() {
            this.$router.push('/')
        },
        handleClose() {
            ElMessageBox.confirm('确认关闭？')
                .then(() => {
                    done()
                })
                .catch(() => {
                    // catch error
                })
        }
    }

}
</script>
  
<style scoped>
.imgs {
    top: 50px;
    height: 800px;
    left: 40px;
    position: absolute;
    width: 800px;
    background-color: #4E655D;
}

.imgs>img {
    width: 100%;
    height: 100%;
}

.contact {
    margin-top: 28px;
    /* background-color: #4E655D; */
}

.demo-tabs>.el-tabs__content {
    padding: 32px;
    /* color: #6b778c; */
    font-size: 32px;
    font-weight: 600;
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