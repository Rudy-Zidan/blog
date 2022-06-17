import Api from '@/services/Api'

export default {
  users: () => {
    return Api().get("/users")
  },
  create: (userPayload) => {
    return Api().post("/users", userPayload)
  },
  postsByUserId: (userId) => {
    return Api().get(`/users/${userId}/posts`)
  },
}