import { createWebHistory, createRouter } from "vue-router";

import Home from '@/components/Home'
import PostDetails from '@/components/PostDetails'
import EditPost from '@/components/EditPost'
import UserPosts from '@/components/UserPosts'
import Account from '@/components/Account'
import NotFound from '@/components/NotFound'

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
  },
  { 
    path: '/users/:id/posts',
    name: 'Show User Posts',
    component: UserPosts
  },
  {
    path: '/404',
    name: 'Not Found',
    component: NotFound
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router