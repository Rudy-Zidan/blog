import PostService from "@/services/PostService"

export default {
  listPosts: ({commit}) => {
    PostService.posts()
      .then(res => {
        commit("setPosts", res.data)
      })
  },
  getPostById: ({commit}, postId) => {
    PostService.postById(postId)
      .then(res => {
        commit("setCurrentPost", res.data)
      })
  },
  getPostCommentsById: ({commit}, postId) => {
    PostService.comments(postId)
      .then(res => {
        commit("setComments", res.data)
      })
  },
  createPost: ({commit}, post) => {
    commit('setPostFormHasNoErrors')
    PostService.create(post)
      .then(res => {
        if(res.status === 201) {
          commit("appendPost", res.data)
        }
      }).catch(err => {
        if(err.response.status === 400) {
          commit('setPostFormHasErrors')
          commit('setPostFormErrors', err.response.data.errors)
        }
      })
  },
  updatePost: ({commit}, payload) => {
    commit('startPostUpdating')
    commit('setPostFormHasNoErrors')
    PostService.update(payload.id, payload.post)
      .then(res => {
        if(res.status === 200) {
          commit("setCurrentPost", res.data)
          commit('stopPostUpdating')
        }
      }).catch(err => {
        if(err.response.status === 400) {
          commit('setPostFormHasErrors')
          commit('setPostFormErrors', err.response.data.errors)
          commit('stopPostUpdating')
        }
      })
  }
}