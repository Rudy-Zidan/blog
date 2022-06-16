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
  }
}