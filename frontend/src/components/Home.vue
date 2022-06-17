<template>
  <v-container>
    <v-row justify="space-around" class="mb-5">
      <h1>Feeds</h1>
    </v-row>
    <PostForm />
    <div v-for="post in this.getPosts" :key="post.id">
      <PostCard :post="post" class="mb-10"/>
    </div>
  </v-container>
</template>

<script>
import PostCard from '@/components/PostCard.vue'
import PostForm from '@/components/PostForm.vue'
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getPosts',
    ])
  },
  name: 'HomePage',
  components: {
    PostCard,
    PostForm
  },
  created() {
    this.$store.dispatch('listPosts')
  },
  data: () => ({}),
}
</script>
