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
  channels: {
    PostChannel: {
      connected() {},
      rejected() {},
      received(data) { this.$store.dispatch('injectPostAtTop', data.post) },
      disconnected() {},
    },
    PostUpdateChannel: {
      connected() {},
      rejected() {},
      received(data) { this.$store.dispatch('replacePost', data.post) },
      disconnected() {},
    },
     DeletePostChannel: {
      connected() {},
      rejected() {},
      received(data) {
        this.$store.dispatch('removePost', data.post) 
      },
      disconnected() {},
    }
  },
  created() {
    this.$store.dispatch('listPosts')
  },
  mounted() {
    this.$cable.subscribe({
      channel: "PostChannel",
    });

    this.$cable.subscribe({
      channel: "PostUpdateChannel"
    });

    this.$cable.subscribe({
      channel: "DeletePostChannel"
    });
  },
  data: () => ({}),
}
</script>
