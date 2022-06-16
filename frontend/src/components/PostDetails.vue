<template>
  <v-container>
    <h2 class="text-center mb-10">
      {{getCurrentPost.title}}
    </h2>
    <h4 class="mb-10 font-weight-light">
      {{getCurrentPost.content}}
    </h4>
    <v-divider class="mb-10"></v-divider>
    <CommentTimeline :comments="getComments"/>
  </v-container>
</template>

<script>
import CommentTimeline from '@/components/CommentTimeline.vue'
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getComments',
      'getCurrentPost',
    ])
  },
  components: {
    CommentTimeline,
  },
  watch: {
    getCurrentPost() {
      this.post = this.getCurrentPost
    }
  },
  created() {
    this.$store.dispatch('getPostById', this.$route.params.id)
    this.$store.dispatch('getPostCommentsById', this.$route.params.id)
  },
  data: () => ({
    post: null,
    comments: []
  })
}
</script>