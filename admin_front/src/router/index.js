import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/register',
      name: 'register',
      component: () => import('../views/Register.vue')
    },
    {
      path: '/HomeView',
      name: 'HomeView',
      component: () => import('../views/HomeView.vue')
    },
    {
      path: '/Suggestion',
      name: 'Suggestion',
      component: () => import('../views/Suggestion.vue')
    },
    {
      path: '/DealAppeal',
      name: 'DealAppeal',
      component: () => import('../views/DealAppeal.vue')
    },
    {
      path: '/DealAccuse',
      name: 'DealAccuse',
      component: () => import('../views/DealAccuse.vue')
    },
    {
      path: '/AddVio',
      name: 'AddVio',
      component: () => import('../views/AddVio.vue')
    },
  ]
})

export default router
