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
  },
  startPostUpdating(state) {
    state.postUpdating = true
  },
  stopPostUpdating(state) {
    state.postUpdating = false
  },
  injectPostAtTop(state, post) {
    state.posts.unshift(post)
  },
  replacePost(state, updatedPost) {
    let index = state.posts.findIndex(post => post.id == updatedPost.id)
    state.posts[index] = updatedPost
  },
  replaceCurrentPost(state, updatedPost) {
    state.currentPost = updatedPost
  }
}