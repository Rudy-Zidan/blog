export default {
  getComments: state => state.comments,
  reacted: state => (user_id, comment_id, reaction) => {
    let index = state.comments.findIndex(comment => comment.id == comment_id)
    let reactionIndex = state.comments[index].reactions.findIndex(obj => obj.user_id == user_id && obj.reaction === reaction)
    if(reactionIndex >= 0 ){
      return true
    }

    return false
  },
  getReactionID: state => (user_id, comment_id, reaction) => {
    let index = state.comments.findIndex(comment => comment.id == comment_id)
    let reactionIndex = state.comments[index].reactions.findIndex(obj => obj.user_id == user_id && obj.reaction === reaction)
    if(reactionIndex !== null){
      return state.comments[index].reactions[reactionIndex].id
    }

    return null
  }
}