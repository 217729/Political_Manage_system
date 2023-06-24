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
                <div class="option" style="background-color: gainsboro;">
                    <img src="/static/pictures/查询.png">
                </div>
                <div class="option" v-if="merc == 'true'">
                    <img src="/static/pictures/申诉-appeal.png" @click="to_appeal">
                </div>
                <div class="option" v-else>
                    <img src="/static/pictures/举报、反馈.png" @click="to_Accuse">
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
                <span style="font-size:25px;">You can search any in this page</span>
                <el-divider />
                <div class="search">
                    <el-form :model="form" label-width="100px" :inline="true">
                        <el-form-item label="商家名称">
                            <el-input v-model="form.name" placeholder="请输入商家名称"></el-input>
                        </el-form-item>
                        <el-form-item label="违法类型">
                            <el-select v-model="form.type" placeholder="请选择某一违法类型" multiple collapse-tags
                                collapse-tags-tooltip>
                                <el-option v-for="(item2, index2) in selectoptions" :label="item2.name" :key="item2.value"
                                    :value="item2.value" :disabled="checkAge(item2.value)"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="起始时间">
                            <el-col :span="11">
                                <el-date-picker v-model="form.date1" type="date" placeholder="选择开始时间" format="YYYY/MM/DD"
                                    value-format="YYYY-MM-DD" style="width: 100%" />
                            </el-col>
                            <el-col :span="2" class="text-center">
                                <span class="text-gray-500">-</span>
                            </el-col>
                            <el-col :span="11">
                                <el-date-picker v-model="form.date2" placeholder="选择结束时间" type="date" format="YYYY/MM/DD"
                                    value-format="YYYY-MM-DD" style="width: 100%" />
                            </el-col>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="do_query">查询</el-button>
                            <el-button type="primary" @click="do_search" v-if="merc == 'true'">个人记录</el-button>
                        </el-form-item>
                    </el-form>
                </div>
                <div class="Law-item">
                    <el-table :data="tableData" :height="tableData.length - 10 <= 0 ? 'tableData.length*10' : '470'"
                        style="width: 1180px;" :border="true" :stripe="true">
                        <el-table-column prop="mid" label="商家编号" width="120" sortable fixed></el-table-column>
                        <el-table-column prop="realname" label="商户名" width="200" fixed />
                        <el-table-column prop="vdate" label="处罚日期" width="110" sortable />
                        <el-table-column prop="vreason" label="违法类型" width="140" />
                        <el-table-column prop="chufa" label="处罚内容" width="150" />
                        <el-table-column prop="payment" label="罚金" width="90" sortable />
                        <el-table-column prop="illegal" label="没收非法所得等金额" width="120" sortable />
                        <el-table-column prop="vlass" label="处罚类型" width="150" />
                        <el-table-column prop="vinf" label="案件名" width="200" />
                        <el-table-column prop="vlaw" label="处罚依据" width="300" />
                    </el-table>
                </div>
                <div class="contact">
                    <span style="font-size: 10px;">If you have any suggestion,please contact 2051857@tongji.edu.cn</span>
                </div>
            </el-main>
        </el-container>
    </div>
</template>
  
<script>
import { useRoute } from 'vue-router'
import { ref, reactive } from 'vue'
import { ElMessage } from 'element-plus'
import request from '../../../utils/request'
export default {
    name: "SearchViewU",
    data: function () {
        return {
            // user_name: "2051857",
            form: reactive({
                name: '',
                type: [],
                date1: null,
                date2: null,
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
            tableData: []
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
    async created() {
        const res = await request.get(`/all_viol`)
        console.log(res)
        this.tableData = res.data.data
    },
    methods: {
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
        async do_query() {
            console.log(this.form)
            if (this.form.type.includes('全部'))
                this.form.type = []
            if (this.form.date1 == null && this.form.date2 == null && this.form.name == '' && this.form.type.length == 0) {
                ElMessage({
                    message: '请输入有效的查询参数！',
                    type: 'warning',
                })
                return
            }
            if (this.form.date1 != null && this.form.date2 != null) {
                console.log(1)
                if (this.form.date1 > this.form.date2) {
                    ElMessage({
                        message: '开始时间不能早于结束时间！',
                        type: 'warning',
                    })
                    return
                }
            }
            else if (!(this.form.date1 == null && this.form.date2 == null)) {
                console.log(2)
                ElMessage({
                    message: '请同时输入开始时间和结束时间！',
                    type: 'warning',
                })
                return
            }
            //连后端
            console.log({
                name: this.form.name,
                type: this.form.type,
                date1: this.form.date1==null?'':this.form.date1,
                date2: this.form.date2==null?'':this.form.date2,
            })
            const res = await request.post('/getviol', {
                name: this.form.name,
                type: this.form.type,
                date1: this.form.date1==null?'':this.form.date1,
                date2: this.form.date2==null?'':this.form.date2,
            })
            console.log(res)
            this.tableData = res.data.data
        },
        async do_search() {
            console.log(this.form)
            if (this.form.name != '' && this.form.name != this.user_name) {
                ElMessage({
                    message: '商户名称参数不匹配，请使用查询按钮进行查询！',
                    type: 'warning',
                })
                return
            }
            if (this.form.date1 != null && this.form.data2 != null) {
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
            if (this.form.type.includes('全部'))
                this.form.type = []
            //连后端
            const res = await request.post('/getviol', {
                name: this.user_name,
                type: this.form.type,
                date1: this.form.date1==null?'':this.form.date1,
                date2: this.form.date2==null?'':this.form.date2
            })
            console.log(res)
            this.tableData = res.data.data
        },
        to_Accuse() {
            this.$router.push({
                path: '/AccusationU',
                query: {
                    name: this.user_name,
                    id: this.id,
                    merc: this.merc
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
        to_appeal() {
            this.$router.push({
                path: '/AppealM',
                query: {
                    name: this.user_name,
                    id: this.id,
                    merc: this.merc
                }
            })
        },
        to_exit() {
            this.$router.push('/')
        },
    }

}
</script>
  
<style scoped>
.el-table th.gutter {
    display: table-cell !important;
}

.contact {
    margin-top: 8px;
    /* background-color: #4E655D; */
}

.Law-item {
    margin-left: 30px;
    width: 1180px;
    height: 470px;
    /* height: 530px; */
    /* color: black; */
    /* background-color: rgb(119, 196, 196); */
    /* box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0 #4E655D; */
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