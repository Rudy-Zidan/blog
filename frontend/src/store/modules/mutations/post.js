export default {
  setPosts(state, posts) {
    state.posts = posts
  },
  setCurrentPost(state, post) {
    state.currentPost = post
  },
  appendPost(state, post) {
    state.posts.unshift(post)
  },
  setPostFormHasErrors(state) {
    state.postForm.hasErrors = true
  },
  setPostFormHasNoErrors(state) {
    state.postForm.hasErrors = false
  },
  setPostFormErrors(state, errors) {
    state.postForm.errors = errors
  }
}