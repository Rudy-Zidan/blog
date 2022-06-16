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
}