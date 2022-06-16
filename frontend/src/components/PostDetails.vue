<template>
  <v-container>
    <h2 class="text-center mb-10">
      {{post.title}}
    </h2>
    <h4 class="mb-10 font-weight-light">
      {{post.content}}
    </h4>
    <v-divider class="mb-10"></v-divider>
    <!-- <v-row justify="center"> -->
      <CommentTimeline :comments="this.comments"/>
    <!-- </v-row> -->
  </v-container>
</template>

<script>
import CommentTimeline from '@/components/CommentTimeline.vue'
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getCommentsByPostID',
      'getPostByID',
    ])
  },
  components: {
    CommentTimeline,
  },
  created() {
    this.post = this.getPostByID(this.$route.params.id)
    this.comments = this.getCommentsByPostID(this.$route.params.id)
  },
  data: () => ({
    post: {},
    comments: []
  })
}
</script>