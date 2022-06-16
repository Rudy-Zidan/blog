import Api from '@/services/Api'

export default {
  create: (payload) => {
    return Api().post("/comments", payload)
  },
  update: (id, payload) => {
    return Api().put(`/comments/${id}`, payload)
  },
}