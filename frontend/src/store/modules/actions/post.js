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
    commit('resetPostForm')
    commit('setPostFormHasNoErrors')
    PostService.create(post)
      .then( () => {
        commit('clearPostForm')
      })
      .catch(err => {
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
  },
  injectPostAtTop: ({commit}, post) => {
    commit('injectPostAtTop', post)
  },
  replacePost: ({commit}, post) => {
    commit('replacePost', post)
  },
  replaceCurrentPost: ({commit}, post) => {
    commit('replaceCurrentPost', post)
  },
  deletePost: (_, payload) => {
    PostService.delete(payload.post_id, payload.author_id)
  },
  removePost: ({commit}, post) => {
    commit("removePostFromPosts", post)
  }
}