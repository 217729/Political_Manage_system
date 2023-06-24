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
                <div class="option" v-if="merc == 'true'">
                    <img src="/static/pictures/申诉-appeal.png" @click="to_appeal">
                </div>
                <div class="option" v-else>
                    <img src="/static/pictures/举报、反馈.png" @click="to_accuse">
                </div>
                <div class="option">
                    <img src="/static/pictures/个人中心.png" @click="to_personal">
                </div>
                <div class="option" style="background-color: gainsboro;">
                    <img src="/static/pictures/反馈信息.png">
                </div>

                <div class="white"></div>
                <div class="option">
                    <img src="/static/pictures/退出-green.png" @click="to_exit">
                </div>
            </el-aside>
            <!-- 边缘栏end -->

            <!-- 主要内容栏 -->
            <el-main>
                <span style="font-size:25px;">Feedback & Issues</span>
                <el-divider />
                <el-row>
                    <el-col :span="18">
                        <el-form :model="form" label-width="100px"
                            style="margin-top:15px;margin-left:70px;margin-right: 90px;;" :label-position="labelPosition">
                            <el-form-item label="主题">
                                <el-input v-model="form.name" placeholder="输入任何你想告诉我们的事情"></el-input>
                            </el-form-item>
                            <el-row>
                                <el-form-item label="标签">
                                    <el-select v-model="form.type" placeholder="选择书写内容的类别">
                                        <el-option v-for="(item2, index2) in selectoptions" :label="item2.name"
                                            :value="item2.value"></el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="联系方式" style="margin-left: 50px;">
                                    <el-input v-model="form.tel" placeholder="你可以留下联系方式方便我们联系你"
                                        style="width:500px;"></el-input>
                                </el-form-item></el-row>
                            <el-form-item label="请告诉我们更多细节">
                                <el-input v-model="form.desc" type="textarea" />
                            </el-form-item>
                            <el-upload class="upload-demo" drag multiple>
                                <el-icon class="el-icon--upload"><upload-filled /></el-icon>
                                <div class="el-upload__text">
                                    Drop file here or <em>click to upload</em>
                                    <br />
                                    在这里上传截图/更为详细的资料
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
                    </el-col>
                    <el-divider direction="vertical" />
                    <el-col :span="5">

                    </el-col>
                </el-row>
            </el-main>
        </el-container>
    </div>
</template>
  
<script>
import { useRoute } from 'vue-router'
import { ref, reactive } from 'vue'
import { ElMessage } from 'element-plus'
// import { Position } from '@element-plus/icons-vue/dist/types'
// import { reactive,ref } from 'vue'
export default {
    name: "Homeview",
    data: function () {
        return {
            user_name: "2051857",
            labelPosition: ref('top'),
            selectoptions: [
                { 'name': '缺陷', 'value': 1 },
                { 'name': '需求', 'value': 2 },
                { 'name': '交流沟通', 'value': 3 },
                { 'name': '其他', 'value': 4 },
            ],
            form: reactive({
                name: '',
                type: '',
                tel: '',
            }),
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
        to_accuse() {
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
.feedback {
    width: 800px;
    height: 500px;
    background-color: #4E655D;
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
}</style>