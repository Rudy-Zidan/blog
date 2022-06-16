import { createWebHistory, createRouter } from "vue-router";

import Home from '@/components/Home'
import PostDetails from '@/components/PostDetails'
import EditPost from '@/components/EditPost'
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
    path: '/edit_post/:id',
    name: 'Edit Post',
    component: EditPost
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