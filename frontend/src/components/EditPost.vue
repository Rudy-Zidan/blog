<template>
  <PostForm :updatablePost="post"/>
</template>

<script>
import PostForm from '@/components/PostForm.vue'
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getCurrentPost',
      'getCurrentUser'
    ])
  },
  watch: {
    getCurrentPost(value) {
      this.post = value

      if(this.getCurrentUser === null || this.post.author.id !== this.getCurrentUser.id) {
        this.$router.push("/")
      }
    },
  },
  components: {
    PostForm
  },
  created() {
    this.$store.dispatch('getPostById', this.$route.params.id)
  },
  data: () => ({
    post: null
  }),
}
</script>