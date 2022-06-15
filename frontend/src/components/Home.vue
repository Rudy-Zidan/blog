<template>
  <v-container>
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
  name: 'HomePage',
  components: {
    PostCard,
  },
  data: () => ({}),
}
</script>
