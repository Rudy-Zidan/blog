export default {
  getPostByID: state => id => {
    let index = state.posts.findIndex(post => post.id == id)
    return state.posts[index]
  },
  getPosts: state => {
    return state.posts
  },
  getCurrentPost: state => state.currentPost,
  postFormHasErrors: state => state.postForm.hasErrors,
  getPostFormErrorByField: state => field =>{
    let errorMessage = null
    state.postForm.errors.forEach((error) => {
      if(error.field === field) {
        errorMessage = error.message
      }
    })

    return errorMessage
  },
  isPostUpdating: state => state.postUpdating,
}