import Api from '@/services/Api'

export default {
  create: (payload) => {
    return Api().post("/comments", payload)
  },
}