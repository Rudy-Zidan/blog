import CommentService from "@/services/CommentService"

export default {
  createComment: ({dispatch}, comment) => {
    CommentService.create(comment)
      .then(res => {
        if(res.status === 201) {
          dispatch('getPostCommentsById', comment.post_id)
        }
      })
  },
  updateComment: ({commit}, payload) => {
    CommentService.update(payload.id, payload.comment)
      .then(res => {
        if(res.status === 200) {
          commit('updateComment', res.data)
        }
      })
  },
  createReaction: ({dispatch}, reaction) => {
    CommentService.createReaction(reaction.id, reaction.payload)
      .then(res => {
        if(res.status === 201) {
          dispatch('getPostCommentsById', reaction.post_id)
        }
      })
  },
  deleteReaction: ({dispatch}, reaction) => {
    CommentService.deleteReaction(reaction.id, reaction.comment_id, reaction.user_id)
      .then(res => {
        if(res.status === 200) {
          dispatch('getPostCommentsById', reaction.post_id)
        }
      })
  },
  injectCommentAtTop({commit}, comment) {
    commit('injectCommentAtTop', comment)
  },
  replaceComment({commit}, comment) {
    commit('replaceComment', comment)
  },
  react({commit}, reaction) {
    commit('injectToCommentReactions', reaction)
  },
  removeReaction({commit}, reaction) {
    commit('removeCommentReaction', reaction)
  }
}