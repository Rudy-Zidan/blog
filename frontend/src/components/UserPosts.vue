<template>
  <v-container>
    <v-row justify="space-around" class="mb-2">
      <h1>Feeds</h1>
    </v-row>
    <v-container class="text-center" v-if="this.getPosts.length === 0">
      <h1>No posts yet..</h1>
    </v-container>
    <div v-for="post in this.getPosts" :key="post.id">
      <PostCard :post="post" class="mb-10"/>
    </div>
  </v-container>
</template>

<script>
import PostCard from '@/components/PostCard.vue'
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getPosts',
    ])
  },
  components: {
    PostCard
  },
  channels: {
    PostUpdateChannel: {
      connected() {},
      rejected() {},
      received(data) { this.$store.dispatch('replacePost', data.post) },
      disconnected() {},
    }
  },
  created() {
    this.$store.dispatch('getPostsByUserId', this.$route.params.id)
  },
  mounted() {
    this.$cable.subscribe({
      channel: "PostUpdateChannel"
    });
  }
}
</script>