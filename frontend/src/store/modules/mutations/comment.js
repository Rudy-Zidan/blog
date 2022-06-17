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
    let key = null
    switch (reaction.reaction) {
      case 'like':
        key = 'likes'
        break;
      case 'smile':
        key = 'smiles'
        break;
      case 'thumbsup':
        key = 'thumbs_up'
        break;
    }
    state.comments[index].reaction_summary[key] += 1
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