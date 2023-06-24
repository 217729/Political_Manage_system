<template>
    <div class="total">
        <el-container>
            <!-- 边=边缘栏 -->
            <el-aside width="200px" style="background-color: whitesmoke;">
                <div class="logo">
                    <img src="/static/pictures/touxiang.jpg">
                </div>
                <br />
                <div class="option" style="background-color: gainsboro;">
                    <img src="/static/pictures/首页.png">
                </div>
                <div class="option">
                    <img src="/static/pictures/查询.png" @click="to_search">
                </div>
                <div class="option" v-if="merc=='true'">
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
                <span style="font-size:25px;">Welcome back,{{ user_name }}!</span>
                <el-divider />
                <div class="white_main"></div>
                <div class="Law-item">
                    <span style="font-size:20px;">快来看看你可能感兴趣的一些法律法规吧~</span>
                    <el-table :data="LawData" height="480" style="width: 1000px;left: 20px;top:10px;" :border="true"
                        :stripe="true">
                        <el-table-column prop="Order" label="序号" width="90" />
                        <el-table-column prop="Name" label="法典名" width="270" />
                        <el-table-column prop="Level" label="效力级别" width="130" />
                        <el-table-column prop="effencify" label="时效性" width="150" />
                        <el-table-column prop="kind" label="类别" width="190" />
                        <el-table-column prop="Date" label="公布日期" />
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
import {useRoute} from 'vue-router'
import {ref} from 'vue'
export default {
    name: "HomeviewU",
    data: function () {
        return {
            // user_name: route.query.name,
            LawData: [
                { Order: '1', Name: '中华人民共和国反垄断法', Level: '法律', effencify: '现行有效', kind: '反垄断执法', Date: '2022-06-24' },
                { Order: '2', Name: '中华人民共和国广告法', Level: '法律', effencify: '现行有效', kind: '广告监督管理', Date: '2021-04-29' },
                { Order: '3', Name: '中华人民共和国食品安全法', Level: '法律', effencify: '现行有效', kind: '食品安全监督管理', Date: '2021-04-29' },
                { Order: '4', Name: '中华人民共和国专利法', Level: '法律', effencify: '现行有效', kind: '知识产权', Date: '2020-10-17' },
                { Order: '5', Name: '中华人民共和国药品管理法', Level: '法律', effencify: '现行有效', kind: '药品监督管理', Date: '2019-08-26' },
                { Order: '6', Name: '中华人民共和国疫苗管理法', Level: '法律', effencify: '现行有效', kind: '药品监督管理', Date: '2019-04-23' },
                { Order: '7', Name: '中华人民共和国商标法', Level: '法律', effencify: '现行有效', kind: '	知识产权', Date: '2019-04-23' },
                { Order: '8', Name: '中华人民共和国反不正当竞争法', Level: '法律', effencify: '现行有效', kind: '反不正当竞争监督管理', Date: '2018-12-29' },
                { Order: '9', Name: '中华人民共和国产品质量法', Level: '法律', effencify: '现行有效', kind: '质量发展与安全监督管理', Date: '2018-10-26' },
                { Order: '10', Name: '中华人民共和国公司法', Level: '法律', effencify: '现行有效', kind: '	市场主体登记注册', Date: '2022-06-24' },
                { Order: '11', Name: '中华人民共和国电子商务法', Level: '法律', effencify: '现行有效', kind: '网络市场交易监督管理', Date: '2018-08-30' },
                { Order: '12', Name: '中华人民共和国消费者权益保护法', Level: '法律', effencify: '现行有效', kind: '市场监管综合执法', Date: '2013-10-25' },
                { Order: '13', Name: '中华人民共和国合伙企业法', Level: '法律', effencify: '现行有效', kind: '市场主体登记注册', Date: '2006-08-27' },
            ]
        }
    },
    setup(){
        const route=useRoute()
        const user_name=ref(route.query.name)
        const id=ref(route.query.id)
        const merc=ref(route.query.merc)
        console.log('111',route.query)
        return {
            user_name,
            id,
            merc
        }
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
        to_Accuse(){
            this.$router.push({
                path:'/AccusationU',
                query:{
                    name:this.user_name,
                    id:this.id,
                    merc:this.merc
                }
            })
            // this.$router.push('AccusationU')
        },
        to_personal(){
            this.$router.push({
                path:this.merc=='true'?'/PersonalM':'/PersonalU',
                query:{
                    name:this.user_name,
                    id:this.id,
                    merc:this.merc
                }
            })
            // this.$router.push('PersonalU')
        },
        to_feedback(){
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
        to_appeal(){
            this.$router.push({
                path:'/AppealM',
                query:{
                    name:this.user_name,
                    id:this.id,
                    merc:this.merc
                }
            })
        },
        to_exit(){
            this.$router.push('/')
        },
    }

}
</script>
  
<style scoped>
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