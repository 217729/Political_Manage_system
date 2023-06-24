import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Register from '../views/Register.Vue'
import HomeviewU from '../views/common_user/HomeView-U.vue'
import SearchViewU from '../views/common_user/SearchView-U.vue'
import AccusationU from '../views/common_user/Accusation-U.vue'
import PersonalU from '../views/common_user/Personal-U.vue'
import SuggestionU from '../views/common_user/Suggestion-U.vue'
// import HomeViewM from '../views/common_merchant/HomeView-M.vue'
import AppealM from '../views/common_merchant/Appeal-M.vue'
import PersonalM from '../views/common_merchant/Personal-M.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/Register',
      name: 'Register',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: Register
    },
    {
      path:'/HomeviewU',
      name:'HomeviewU',
      component:HomeviewU
    },
    {
      path:'/SearchViewU',
      name:'SearchViewU',
      component:SearchViewU
    },
    {
      path:'/AccusationU',
      name:'AccusationU',
      component:AccusationU
    },
    {
      path:'/PersonalU',
      name:'PersonalU',
      component:PersonalU
    },
    {
      path:'/SuggestionU',
      name:'SuggestionU',
      component:SuggestionU
    },
    {
      path:'/PersonalM',
      name:'PersonalM',
      component:PersonalM
    },
    {
      path:'/AppealM',
      name:'AppealM',
      component:AppealM
    },
  ]
})

export default router
