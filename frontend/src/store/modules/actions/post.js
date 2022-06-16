import PostService from "@/services/PostService"

export default {
  listPosts: ({commit}) => {
    PostService.posts()
      .then(res => {
        commit("setPosts", res.data)
      })
  },
}