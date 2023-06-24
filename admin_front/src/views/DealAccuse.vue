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
                <div class="option" style="background-color: gainsboro;">
                    <img src="/static/pictures/告警待处理.png">
                </div>
                <div class="option">
                    <img src="/static/pictures/警情录入.png" @click="to_add">
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
                <span style="font-size:25px;">Accusation handling</span>
                <el-divider />
                <el-tabs v-model="activeName" class="demo-tabs">
                    <el-tab-pane label="待处理举报" name="first">
                        <el-table :data="need_handle"
                            :height="need_handle.length - 10 <= 0 ? 'need_handle.length*10' : '480'"
                            style="width: 1080px;left:50px;" :border="true" :stripe="true">
                            <el-table-column prop="mid" label="商家编号" width="110" sortable></el-table-column>
                            <el-table-column prop="realname" label="商户名" width="300" />
                            <el-table-column prop="rclass" label="举报违法行为类别" width="180" />
                            <el-table-column prop="inf" label="举报信息" width="340" />
                            <el-table-column label="操作">
                                <template #default="scope">
                                    <el-popconfirm title="Are you sure to pass this?" @confirm="agree_appeal(scope.row)">
                                        <template #reference>
                                            <el-button link type="primary" size="small">通过举报</el-button>
                                        </template>
                                    </el-popconfirm>
                                    <el-popconfirm title="Are you sure to reject this?" @confirm="retort_appeal(scope.row)">
                                        <template #reference>
                                            <el-button link type="primary" size="small">驳回举报</el-button>
                                        </template>
                                    </el-popconfirm>
                                </template>
                            </el-table-column>
                        </el-table>
                    </el-tab-pane>
                    <el-tab-pane label="已处理举报" name="second">
                        <el-table :data="handled" :height="handled.length - 10 <= 0 ? 'handled.length*10' : '480'"
                            style="width: 1080px;left:50px;" :border="true" :stripe="true">
                            <el-table-column prop="mid" label="商家编号" width="110" sortable></el-table-column>
                            <el-table-column prop="realname" label="商户名" width="300" />
                            <el-table-column prop="rclass" label="举报违法类别" width="180" sortable />
                            <el-table-column prop="inf" label="举报信息" width="340" />
                            <el-table-column prop="succ" label="审批结果" width="300" fixed="right" />
                        </el-table>
                    </el-tab-pane>
                </el-tabs>
            </el-main>
        </el-container>
    </div>
</template>
  
<script>
import { useRoute } from 'vue-router'
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import request from '../../utils/request'
import { toRaw } from '@vue/reactivity'
export default {
    name: "HomeView",
    data: function () {
        return {
            // user_name: route.query.name,
            need_handle: [],
            handled: [],
            activeName: ref('first'),
        }
    },
    setup() {
        const route = useRoute()
        const user_name = ref(route.query.name)
        const id = ref(route.query.id)
        // console.log('111', route.query)
        return {
            user_name,
            id
        }
    },
    async created() {
        const res1 = await request.get(`/need_handle_accuse`)
        console.log(res1.data)
        this.need_handle = res1.data.data
        const res2 = await request.get(`/handled_accuse`)
        console.log(res2.data)
        this.handled = res2.data.data
    },
    methods: {
        async agree_appeal(row) {
            const res = await request.post('/handle_accuse', { mid: toRaw(row).mid, uid: toRaw(row).uid, succ: 1 })
            console.log(res.data)
            ElMessage({
                message: "举报通过成功",
                type: 'success',
            })
            location.reload()
        },
        async retort_appeal(row) {
            const res = await request.post('/handle_accuse', { mid: toRaw(row).mid, uid: toRaw(row).uid, succ: 0 })
            console.log(res.data)
            ElMessage({
                message: "举报驳回成功",
                type: 'success',
            })
            location.reload()
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
        to_DealAppeal() {
            this.$router.push({
                path: '/DealAppeal',
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
        to_feedback() {
            this.$router.push({
                path: '/Suggestion',
                query: {
                    name: this.user_name,
                    id: this.id,
                }
            })
            // this.$router.push('SuggestionU')
        },
        to_add() {
            this.$router.push({
                path: '/AddVio',
                query: {
                    name: this.user_name,
                    id: this.id,
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
.demo-tabs>.el-tabs__content {
    padding: 32px;
    /* color: #6b778c; */
    font-size: 32px;
    font-weight: 600;
}

.white_main {
    height: 20px;
}

.Law-item {
    margin-left: 100px;
    width: 1040px;
    height: 530px;
    /* color: black; */
    /* background-color: rgb(119, 196, 196); */
    box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0 #4E655D;
}

.contact {
    margin-top: 28px;
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