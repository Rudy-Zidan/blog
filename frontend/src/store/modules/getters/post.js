export default {
  getPostByID: state => id => {
    let index = state.posts.findIndex(post => post.id == id)
    return state.posts[index]
  },
  getPosts: state => {
    return state.posts
  },
  getCurrentPost: state => state.currentPost
}