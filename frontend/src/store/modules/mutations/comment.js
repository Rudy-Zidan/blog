const helper = {
  getReactionKey: (reaction) => {
    switch (reaction) {
      case 'like':
        return 'likes'
      case 'smile':
        return 'smiles'
      case 'thumbsup':
        return 'thumbs_up'
    }
  }
}
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
    let key = helper.getReactionKey(reaction.reaction)
    
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
  removeCommentReaction(state, deletedReaction) {
    let index = state.comments.findIndex(comment => comment.id == deletedReaction.comment_id)
    let reactionIndex = state.comments[index].reactions.findIndex(reaction => reaction.id == deletedReaction.id)
    let key = helper.getReactionKey(deletedReaction.reaction)

    state.comments[index].reactions.splice(reactionIndex, 1)
    state.comments[index].reaction_summary[key] -= 1
  }
}