<template>
  <v-text-field
      v-model="commentContent"
      hide-details
      label="Leave a comment and press enter to post it..."
      density="compact"
      @keydown.enter="submit"
      class="font-weight-light"
    >
  </v-text-field>
</template>

<script>

export default {
  props: {
    user: Object,
    content: String,
    postId: String,
    id: {
      type: Number,
      default: null
    }
  },
  created() {
    this.commentContent = this.content
  },
  data: () => ({
    commentContent: null,
    commentId: null
  }),
  methods: {
    submit() {
      if(this.id === null) {
        this.postComment()
      } else {
        this.updateComment()
        this.$emit('changed')
      }
    },
    postComment() {
      this.$store.dispatch("createComment", {
        user_id: this.user.id, 
        post_id: this.postId, 
        content: this.commentContent
      })

      this.commentContent = null
    },
    updateComment() {
      this.$store.dispatch("updateComment", {
        id: this.id, 
        comment: {
          user_id: this.user.id, 
          post_id: this.postId, 
          content: this.commentContent
        }
      })
    }
  }
}
</script>