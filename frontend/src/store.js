import { createStore, createLogger } from 'vuex'
import Comment from "@/store/modules/comment"
import Post from "@/store/modules/post"
import User from "@/store/modules/user"

const debug = process.env.NODE_ENV !== 'production'

export default createStore({
  modules: {
    Post,
    Comment,
    User
  },
  strict: debug,
  plugins: debug ? [createLogger()] : []
})