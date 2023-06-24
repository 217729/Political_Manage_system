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
                    <img src="/static/pictures/用户管理.png" @click="to_home">
                </div>
                <div class="option">
                    <img src="/static/pictures/申诉管理.png" @click="to_DealAppeal">
                </div>
                <div class="option">
                    <img src="/static/pictures/告警待处理.png" @click="to_accuse">
                </div>
                <div class="option" style="background-color: gainsboro;">
                    <img src="/static/pictures/警情录入.png">
                </div>
                <div class="option">
                    <img src="/static/pictures/反馈信息.png" @click="to_suggestion">
                </div>

                <div class="white"></div>
                <div class="option">
                    <img src="/static/pictures/退出-green.png" @click="to_exit">
                </div>
            </el-aside>
            <!-- 边缘栏end -->

            <!-- 主要内容栏 -->
            <el-main>
                <span style="font-size:25px;">Violation entry</span>
                <!-- <el-divider /> -->
                <el-tabs v-model="activeName" class="demo-tabs">
                    <el-tab-pane label="全部违法记录" name="first">
                        <div class="search">
                            <el-form :model="form" label-width="100px" :inline="true">
                                <el-form-item label="商家名称">
                                    <el-input v-model="form.name" placeholder="请输入商家名称"></el-input>
                                </el-form-item>
                                <el-form-item label="违法类型">
                                    <el-select v-model="form.type" placeholder="请选择某一违法类型" multiple collapse-tags
                                        collapse-tags-tooltip>
                                        <el-option v-for="(item2, index2) in selectoptions" :label="item2.name"
                                            :key="item2.value" :value="item2.value"
                                            :disabled="checkAge(item2.value)"></el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="起始时间">
                                    <el-col :span="11">
                                        <el-date-picker v-model="form.date1" type="date" placeholder="选择开始时间"
                                            format="YYYY/MM/DD" value-format="YYYY-MM-DD" style="width: 100%" />
                                    </el-col>
                                    <el-col :span="2" class="text-center">
                                        <span class="text-gray-500">-</span>
                                    </el-col>
                                    <el-col :span="11">
                                        <el-date-picker v-model="form.date2" placeholder="选择结束时间" type="date"
                                            format="YYYY/MM/DD" value-format="YYYY-MM-DD" style="width: 100%" />
                                    </el-col>
                                </el-form-item>
                                <el-form-item>
                                    <el-button type="primary" @click="do_query">查询</el-button>
                                </el-form-item>
                            </el-form>
                        </div>
                        <div>
                            <el-table :data="tableData" :height="tableData.length - 10 <= 0 ? 'tableData.length*10' : '470'"
                                style="width: 1180px;left:20px;" :border="true" :stripe="true">
                                <el-table-column prop="vid" label="处罚编号" width="110" fixed sortable/> 
                                <el-table-column prop="mid" label="商家编号" width="110" fixed sortable/> 
                                <el-table-column prop="realname" label="商户名" width="200" fixed />
                                <el-table-column prop="vdate" label="处罚日期" width="110" sortable />
                                <el-table-column prop="vreason" label="违法类型" width="140" />
                                <el-table-column prop="chufa" label="处罚内容" width="150" />
                                <el-table-column prop="payment" label="罚金" width="90" sortable />
                                <el-table-column prop="illegal" label="没收非法所得等金额" width="120" sortable />
                                <el-table-column prop="vlass" label="处罚类型" width="150" />
                                <el-table-column prop="vinf" label="备注" width="200" />
                                <el-table-column prop="vlaw" label="处罚依据" width="300" />
                            </el-table>
                        </div>
                    </el-tab-pane>
                    <el-tab-pane label="添加违法记录" name="second">
                        <el-form :model="vio_inf" label-width="100px" style="margin-top:15px;margin-left:100px"
                            :label-position="labelPosition">
                            <el-row>
                                <el-form-item label="违法商户名称">
                                    <el-input v-model="vio_inf.mname" style="width:500px"></el-input>
                                </el-form-item>
                                <el-form-item label="违法类型" style="margin-left:90px">
                                    <el-select v-model="vio_inf.vreason" placeholder="请选择一种违法类型" style="width:300px">
                                        <el-option v-for="(item2, index2) in selectoptions2" :label="item2.name"
                                            :value="item2.value"></el-option>
                                    </el-select>
                                </el-form-item>
                            </el-row>
                            <el-row>
                                <el-form-item label="处罚日期">
                                    <el-date-picker v-model="vio_inf.vdate" type="date" placeholder="选择处罚日期"
                                        format="YYYY/MM/DD" value-format="YYYY-MM-DD" />
                                </el-form-item>
                                <el-form-item label="处罚类别" style="margin-left: 70px;">
                                    <el-input v-model="vio_inf.vlass" style="width:600px"
                                        placeholder="罚款/没收非法所得/警告..."></el-input>
                                </el-form-item>
                            </el-row>
                            <el-form-item label="案件名">
                                <el-input v-model="vio_inf.vinf" style="width:600px" placeholder="xx公司xx案"></el-input>
                            </el-form-item>
                            <el-row>
                                <el-form-item label="罚款金额">
                                    <el-input-number v-model="vio_inf.payment" :min="0" />
                                </el-form-item>
                                <el-form-item label="没收非法所得金额" style="margin-left: 100px;">
                                    <el-input-number v-model="vio_inf.illegal" :min="0" />
                                </el-form-item>
                            </el-row>
                            <el-form-item label="处罚内容">
                                <el-input v-model="vio_inf.chufa" style="width:800px" type="textarea"
                                    placeholder="罚款xxx等"></el-input>
                            </el-form-item>
                            <el-form-item label="违反的法律条例">
                                <el-input v-model="vio_inf.vlaw" style="width:800px" type="textarea"></el-input>
                            </el-form-item>
                            <el-form-item>
                                <el-button type="primary" @click="add_vio" style="margin-top: 8px;">Submit</el-button>
                            </el-form-item>
                            <!-- 
                            <el-from-item label="案件名">
                                <el-input v-model="vio_inf.vinf" style="width:500px" placeholder="xx公司xx案"></el-input>
                            </el-from-item>
                            <el-from-item label="处罚内容">
                                <el-input v-model="vio_inf.vinf" type="textarea"></el-input>
                            </el-from-item> -->
                        </el-form>
                    </el-tab-pane>
                </el-tabs>
            </el-main>
        </el-container>
    </div>
</template>
  
<script>
import { useRoute } from 'vue-router'
import { ref, reactive } from 'vue'
import { ElMessage } from 'element-plus'
import request from '../../utils/request'
// import { Position } from '@element-plus/icons-vue/dist/types'
// import { reactive,ref } from 'vue'
export default {
    name: "Suggestion",
    data: function () {
        return {
            labelPosition: ref('top'),
            tableData: [],
            activeName: ref('first'),
            form: reactive({
                name: '',
                type: [],
                date1: null,
                date2: null,
            }),
            vio_inf: reactive({
                mname: '',
                vlass: '',
                vdate: '',
                vreason: '',
                vlaw: '',
                vinf: '',
                chufa: '',
                payment: 0.0,
                illegal: 0.0
            }),
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
            selectoptions2: [
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
        }
    },
    setup() {
        const route = useRoute()
        const user_name = ref(route.query.name)
        const id = ref(route.query.id)
        console.log('111', route.query)
        return {
            user_name,
            id
        }
    },
    async created() {
        const res = await request.get(`/all_viol`)
        console.log(res)
        this.tableData = res.data.data
    },
    methods: {
        async add_vio() {
            console.log(this.vio_inf)
            if (this.vio_inf.mname == '' || this.vio_inf.vlass == '' || this.vio_inf.vdate == '' || this.vio_inf.vreason == '' || this.vio_inf.vlaw == '' || this.vio_inf.vinf == '' || this.vio_inf.chufa == '') {
                ElMessage({
                    message: "请填写完整的表单数据",
                    type: 'warning',
                })
                return
            }
            const res=await request.post('/add_vio',{
                mname:this.vio_inf.mname,
                vlass:this.vio_inf.vlass,
                vdate:this.vio_inf.vdate,
                vreason:this.vio_inf.vreason,
                vlaw:this.vio_inf.vlaw,
                chufa:this.vio_inf.chufa,
                vinf:this.vio_inf.vinf,
                payment:this.vio_inf.payment,
                illegal:this.vio_inf.illegal
            })
            console.log(res.data)
            if(res.data.code==1){
                ElMessage({
                    message: "数据库中为找到对应的商家信息，请确保信息无误",
                    type: 'warning',
                })
            }
            else{
                ElMessage({
                    message: "违法信息添加成功！感谢管理员的努力",
                    type: 'success',
                })
            }
        },
        checkAge(item) {
            // console.log(this.form.type)
            // console.log(this.form.type.includes('全部'))
            if (this.form.type.length == 0)
                return false;
            if (this.form.type.includes('全部') && item !== '全部')
                return true;
            else if (!this.form.type.includes('全部') && item == '全部')
                return true;
            return false;
        },
        async do_query() {
            console.log(this.form)
            if (this.form.type.includes('全部'))
                this.form.type = []
            if (this.form.date1 == null && this.form.date2 == null && this.form.name == '' && this.form.type.length == 0){
                ElMessage({
                    message: "请填写完整的查询数据",
                    type: 'warning',
                })
                return
            }
            if (this.form.date1 != null && this.form.date2 != null) {
                if (this.form.date1 > this.form.date2) {
                    ElMessage({
                        message: '开始时间不能早于结束时间！',
                        type: 'warning',
                    })
                    return
                }
            }
            else if (!(this.form.date1 == null && this.form.date2 == null)) {
                ElMessage({
                    message: '请同时输入开始时间和结束时间！',
                    type: 'warning',
                })
                return
            }
            //连后端
            const res = await request.post('/getviol', {
                name: this.form.name,
                type: this.form.type,
                date1: this.form.date1==null?'':this.form.date1,
                date2: this.form.date2==null?'':this.form.date2
            })
            console.log(res)
            this.tableData = res.data.data
            this.form.date1=null
            this.form.date2=null
        },
        to_DealAppeal() {
            this.$router.push({
                path: '/DealAppeal',
                query: {
                    name: this.user_name,
                    id: this.id,
                }
            })
        },
        to_home() {
            this.$router.push({
                path: '/HomeView',
                query: {
                    name: this.user_name,
                    id: this.id,
                }
            })
        },
        to_accuse() {
            this.$router.push({
                path: '/DealAccuse',
                query: {
                    name: this.user_name,
                    id: this.id,
                }
            })
            // this.$router.push('AccusationU')
        },
        to_personal() {
            this.$router.push({
                path: this.merc == 'true' ? '/PersonalM' : '/PersonalU',
                query: {
                    name: this.user_name,
                    id: this.id,
                }
            })
            // this.$router.push('PersonalU')
        },
        to_suggestion() {
            this.$router.push({
                path: '/Suggestion',
                query: {
                    name: this.user_name,
                    id: this.id,
                }
            })
        },
        to_exit() {
            this.$router.push('/')
        },
        submit() {
            ElMessage({
                message: '反馈提交成功！非常感谢您的反馈❥(^_-)',
                type: 'success',
            })
        }
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

.search {
    width: 1000px;
    margin-left: 100px;
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