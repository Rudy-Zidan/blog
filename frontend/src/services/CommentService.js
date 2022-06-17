import Api from '@/services/Api'

export default {
  create: (payload) => {
    return Api().post("/comments", payload)
  },
  update: (id, payload) => {
    return Api().put(`/comments/${id}`, payload)
  },
  delete: (id, user_id) => {
    return Api().delete(`/comments/${id}?user_id=${user_id}`)
  },
  createReaction: (comment_id, payload) => {
    return Api().post(`/comments/${comment_id}/reactions`, payload)
  },
  deleteReaction: (id, comment_id, user_id) => {
    return Api().delete(`/comments/${comment_id}/reactions/${id}?user_id=${user_id}`)
  }
}