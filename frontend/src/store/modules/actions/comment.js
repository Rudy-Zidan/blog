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
}