import UserService from "@/services/UserService"
import router from '@/router'

export default {
  createUser: ({commit}, user) => {
    commit('setUserFormHasNoErrors')
    UserService.create(user)
      .then(res => {
        if(res.status === 201) {
          commit("setCurrentUser", res.data)
          router.push("/")
        }
      }).catch(err => {
        if(err.response.status === 400) {
          commit('setUserFormHasErrors')
          commit('setUserFormErrors', err.response.data.errors)
        }
      })
  },
  listUsers: ({commit}) => {
    UserService.users()
      .then(res => {
        commit("setUsers", res.data)
        commit("setUserEmails", res.data)
      })
  },
  selectUser: ({commit}, selectedUserEmail) => {
    commit("setCurrentUserByEmail", selectedUserEmail)
  },
  getPostsByUserId: ({commit}, userId) => {
    UserService.postsByUserId(userId)
      .then(res => {
        commit("setPosts", res.data)
      })
  },
}