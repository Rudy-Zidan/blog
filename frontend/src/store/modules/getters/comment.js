export default {
  getCommentsByPostID: state => post_id => {
    var filteredComments = []
    state.comments.forEach((comment) => {
      if(comment.post_id == post_id) {
        filteredComments.push(comment)
      }
    })

    return filteredComments
  }
}