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
                    <img src="/static/pictures/举报、反馈.png">
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
                <span style="font-size:25px;">This is the reporting page~Thanks for your supervision</span>
                <el-divider style="background-color: #4E655D;" />
                <el-tabs v-model="activeName" class="demo-tabs">
                    <el-tab-pane label="举报信息填写" name="first">
                        <el-form :model="form" label-width="100px" style="margin-top:15px;margin-left:10px">
                            <el-form-item label="举报单位名称">
                                <el-input v-model="form.name" style="width:500px"></el-input>
                            </el-form-item>
                            <el-form-item label="违法类型">
                                <el-select v-model="form.type" placeholder="如果不确定请选择其他" style="width:300px">
                                    <el-option v-for="(item2, index2) in selectoptions" :label="item2.name"
                                        :value="item2.value"></el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="具体描述信息">
                                <el-input v-model="form.desc" type="textarea"/>
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
                                <el-button type="primary" class="butn" @click="submit">Submit</el-button>
                            </el-form-item>
                        </el-form>
                    </el-tab-pane>
                    <el-tab-pane label="历史举报记录" name="second">
                        <el-table :data="record" :height="record.length - 10 <= 0 ? 'tableData.length*10' : '480'"
                            style="width: 1160px;left:40px;" :border="true" :stripe="true">
                            <el-table-column prop="realname" label="举报商户名" width="300" />
                            <el-table-column prop="rclass" label="举报违法类别" width="150"  />
                            <el-table-column prop="inf" label="举报内容" width="500" />
                            <el-table-column prop="deal" label="处理情况" width="100" />
                            <el-table-column prop="succ" label="举报结果"  />
                        </el-table>
                    </el-tab-pane>
                </el-tabs>
                <!-- <el-row>
                    <el-col :span="11">
                        <span>历史举报记录</span>
                        <div class="imgs">
                            <img src="/static/pictures/None.png">
                        </div>
                    </el-col>
                    <el-divider direction="vertical" />
                    <el-col :span="11">
                        <span>在这里填写举报信息~</span>
                    </el-col>
                </el-row>
                <div class="contact">
                    <span style="font-size: 10px;">If you have any suggestion,please contact 2051857@tongji.edu.cn</span>
                </div> -->
            </el-main>
        </el-container>
    </div>
</template>
  
<script>
import { useRoute } from 'vue-router'
import { ref, reactive } from 'vue'
import { ElMessage } from 'element-plus'
import request from '../../../utils/request'
// import type { UploadProps, UploadUserFile } from 'element-plus'
export default {
    name: "SearchViewU",
    data: function () {
        return {
            // user_name: "2051857",
            record:[],
            selectoptions: [
                { 'name': '全部', 'value': '全部' },
                { 'name': '广告违法行为', 'value': '广告违法行为' },
                { 'name': '产品(商品)质量违法行为', 'value': '产品(商品)质量违法行为' },
                { 'name': '食品违法行为', 'value': '食品违法行为' },
                { 'name': '无照经营', 'value': '无照经营' },
                { 'name': '计量违法行为', 'value': '计量违法行为' },
                { 'name': '化妆品违法行为', 'value': '化妆品违法行为' },
                { 'name': '侵害消费者权益行为', 'value': '侵害消费者权益行为' },
                { 'name': '医疗器械违法行为', 'value': '医疗器械违法行为' },
                { 'name': '药品违法行为', 'value': '药品违法行为' },
                { 'name': '特种设备违法行为', 'value': '特种设备违法行为' },
                { 'name': '商标违法行为', 'value': '商标违法行为' },
                { 'name': '不正当竞争行为', 'value': '不正当竞争行为' },
                { 'name': '价格(含行政事业性收费)违法行为', 'value': '价格(含行政事业性收费)违法行为' },
                { 'name': '其他', 'value': '其他' }
            ],
            activeName: ref('first'),
            form: reactive({
                name: '',
                type: '',
                desc: '',
            }),
            fileList: '',
        }
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
    async created(){
        const res=await request.post('/myaccuse',{uid:this.id})
        console.log(res.data)
        this.record=res.data.data
    },
    methods: {
        async submit(){
            if(this.form.name==''||this.form.type==''||this.form.desc==''){
                ElMessage({
                    message: '举报信息不能为空',
                    type: 'warning',
                })
                return
            }
            const res=await request.post('/accuse',{
                uid:this.id,
                mname:this.form.name,
                rclass:this.form.type,
                inf:this.form.desc
            })
            console.log(res.data)
            if(res.data.code==1){
                ElMessage({
                    message: '对不起，没有在数据库中找到被举报的商家',
                    type: 'warning',
                })
                return
            }
            ElMessage({
                    message: '举报成功，等待管理员审核！很感谢您的检举',
                    type: 'success',
                })
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
        to_personal() {
            this.$router.push({
                path: '/PersonalU',
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
    }

}
</script>
  
<style scoped>
.demo-tabs>.el-tabs__content {
    padding: 32px;
    /* color: #6b778c; */
    font-size: 32px;
    font-weight: 600;
}

.imgs {
    top: 50px;
    height: 500px;
    left: 40px;
    position: absolute;
    width: 500px;
    /* background-color: #4E655D; */
}

.imgs>img {
    width: 100%;
    height: 100%;
}

.butn {
    top: 10px;
    /* left:1000px; */
    /* position: absolute; */
    /* right: 0%; */
}

.el-divider--vertical {
    display: inline-block;
    width: 2px;
    height: 500px;
    vertical-align: middle;
    background-color: #4E655D;
}

.accuse {
    width: 800px;
    margin-left: 200px;
}

.contact {
    margin-top: 75px;
    /* background-color: #4E655D; */
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