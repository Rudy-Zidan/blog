import Api from '@/services/Api'

export default {
  posts: () => {
    return Api().get("/posts")
  }
}