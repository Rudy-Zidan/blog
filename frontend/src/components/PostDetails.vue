<template>
  <v-container>
    <h2 class="text-center mb-10">
      {{post.title}}
    </h2>
    <h4 class="mb-10 font-weight-light">
      {{post.content}}
    </h4>
    <v-divider class="mb-10"></v-divider>
    <CommentTimeline/>
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
    getCurrentPost(value) {
      this.post = value
    },
    getComments(value) {
      this.comments = value
    }
  },
  created() {
    this.$store.dispatch('getPostById', this.$route.params.id)
  },
  data: () => ({
    post: {
      title: 'loading...',
      content: 'loading...'
    },
    comments: [
      {
        content: 'loading...',
        user: {
          name: "loading..."
        },
        reaction_summary: {
          likes: 0,
          smile: 0,
          thumbs_u: 0
        },
        reactions: []
      }
    ]
  })
}
</script>