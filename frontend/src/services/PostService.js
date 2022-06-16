import Api from '@/services/Api'

export default {
  posts: () => {
    return Api().get("/posts")
  },
  postById: (id) => {
    return Api().get(`/posts/${id}`)
  },
  comments: (id) => {
    return Api().get(`/posts/${id}/comments`)
  },
  create: (payload) => {
    return Api().post("/posts", payload)
  },
  update: (id, payload) => {
    return Api().put(`/posts/${id}`, payload)
  }
}