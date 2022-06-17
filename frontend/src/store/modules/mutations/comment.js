export default {
  setComments(state, comments) {
    state.comments = comments
  },
  updateComment(state, newComment) {
    let index = state.comments.findIndex(comment => comment.id == newComment.id)
    state.comments[index] = newComment
  },
  injectToCommentReactions(state, reaction) {
    let index = state.comments.findIndex(comment => comment.id == reaction.comment_id)
    state.comments[index].reactions.push(reaction)
  },
  injectCommentAtTop(state, newComment) {
    state.comments.unshift(newComment)
  },
  replaceComment(state, updatedComment) {
    let index = state.comments.findIndex(comment => comment.id == updatedComment.id)
    state.comments[index] = updatedComment
  },
}