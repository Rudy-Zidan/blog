<template>
  <v-container>
    <v-row justify="space-around">
      <v-card width="600">
        <v-card-title>
            {{post.title}}
        </v-card-title>
        <v-card-text>
          <div class="ml-1 mb-2">
            {{post.description}}
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn variant="outlined" color="primary" @click="showPost(post.id)">Read</v-btn>
        </v-card-actions>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    post: Object,
  },
  data: () => ({
  }),
  methods: {
    showPost(postId) {
      this.$router.push(`/posts/${postId}`)
    }
  }
}
</script>