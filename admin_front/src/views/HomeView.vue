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
          <img src="/static/pictures/用户管理.png">
        </div>
        <div class="option">
          <img src="/static/pictures/申诉管理.png" @click="to_DealAppeal">
        </div>
        <div class="option">
          <img src="/static/pictures/告警待处理.png" @click="to_Accuse">
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
        <span style="font-size:25px;">Dear admin,Welcome back,{{ user_name }}!</span>
        <el-divider />
        <el-tabs v-model="activeName" class="demo-tabs">
          <el-tab-pane label="商家信息" name="first">
            <el-table :data="Merc" :height="Merc.length - 10 <= 0 ? 'Merc.length*10' : '480'"
              style="width: 1080px;left:50px;" :border="true" :stripe="true">
              <el-table-column prop="mid" label="商家编号" width="120" sortable></el-table-column>
              <el-table-column prop="realname" label="商户名" width="310" />
              <el-table-column prop="mname" label="商户账号名" width="300" />
              <el-table-column prop="legal_rep" label="法人代表" width="130" />
              <el-table-column prop="admin_cata" label="行政相对人类别" />
            </el-table>
          </el-tab-pane>
          <el-tab-pane label="平台用户信息" name="second">
            <el-table :data="User" :height="User.length - 10 <= 0 ? 'User.length*10' : '480'"
              style="width: 530px;left:300px;" :border="true" :stripe="true">
              <el-table-column prop="uid" label="用户编号" width="120" sortable />
              <el-table-column prop="uname" label="用户名" width="300" />
              <el-table-column label="操作">
                <template #default="scope">
                  <el-popconfirm title="Are you sure to delete this?" @confirm="delete_user(scope.row)">
                    <template #reference>
                      <el-button link type="primary" size="small">删除用户</el-button>
                    </template>
                  </el-popconfirm>
                </template>
              </el-table-column>
            </el-table>
          </el-tab-pane>
          <el-tab-pane label="新增商户信息" name="third">
            <el-form :model="form" label-width="200px" style="margin-top:30px;margin-left:100px">
              <el-form-item label="商户名称">
                <el-input v-model="form.name" style="width:500px"></el-input>
              </el-form-item>
              <br>
              <el-form-item label="行政相对人类别">
                <el-select v-model="form.admin_cata" placeholder="请选择行政相对人类别" style="width: 200px;">
                  <el-option v-for="item in selectoptions" :key="item.name" :label="item.value" :value="item.value">
                  </el-option>
                </el-select>
              </el-form-item>
              <br>
              <el-form-item label="行政相对人姓名">
                <el-input v-model="form.legal_rep" style="width:400px"></el-input>
              </el-form-item>
              <br>
              <el-form-item label="密码">
                <el-input v-model="form.mkey" style="width:400px" show-password placeholder="默认为123456"></el-input>
              </el-form-item>
              <br>
              <el-form-item>
                <el-button type="primary" @click="add_merc" style="margin-left: 450px;">Add</el-button>
              </el-form-item>
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
import { toRaw } from '@vue/reactivity'
export default {
  name: "HomeView",
  data: function () {
    return {
      // user_name: route.query.name,
      User: [],
      Merc: [],
      activeName: ref('first'),
      labelPosition: ref('top'),
      form: reactive({
        name: '',
        admin_cata: '',
        legal_rep: '',
        mkey: '',
      }),
      selectoptions: [
        { 'name': '个体工商户', 'value': '个体工商户' },
        { 'name': '法人及非法人组织', 'value': '法人及非法人组织' },
      ],
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
    const res = await request.get(`/alluser`)
    console.log(res.data)
    this.User = res.data.data
    const res2 = await request.get(`/all_merc`)
    console.log(res2.data)
    this.Merc = res2.data.data
  },
  methods: {
    async add_merc(){
      const res=await request.post('/registerm',{
        mname:this.form.name,
        admin_cata:this.form.admin_cata,
        legal_rep:this.form.legal_rep,
        mkey:this.form.mkey==''?'123456':this.form.mkey,
        realname:this.form.name
      })
      console.log(res.data)
      if(res.data.code==1){
        ElMessage({
          message: "商家已经存在，请勿重复添加",
          type: 'warning',
        })
      }
      else{
        ElMessage({
          message: "增加商家信息成功，感谢~",
          type: 'success',
        })
        location.reload()
      }
    },
    async delete_user(row) {
      // console.log(row)
      const res = await request.post('/deleteu', { uid: toRaw(row).uid })
      console.log(res.data)
      if (res.data.code == 0) {
        ElMessage({
          message: "删除用户成功",
          type: 'success',
        })
        location.reload()
      }
      else {
        ElMessage({
          message: res.data.msg,
          type: "warning"
        })
      }
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
    to_Accuse() {
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