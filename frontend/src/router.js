import { createWebHistory, createRouter } from "vue-router";

import Home from '@/components/Home'
import PostDetails from '@/components/PostDetails'
import Account from '@/components/Account'

const routes = [
  { 
    path: '/',
    name: 'Home',
    component: Home
  },
  { 
    path: '/posts/:id',
    name: 'Show Post',
    component: PostDetails
  },
  {
    path: '/accounts',
    name: 'Accounts',
    component: Account
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router