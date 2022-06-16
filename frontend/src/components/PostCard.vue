<template>
  <v-container>
    <v-row justify="space-around">
      <v-card width="600">
        <v-card-title>
          {{post.title}}
        </v-card-title>
        <v-card-subtitle>
          <p>Written by</p>
          &nbsp;
          <p class="text-amber font-weight-bold">{{post.author.name}}</p>
        </v-card-subtitle>
        <v-card-text>
          <div class="ml-1 mb-2">
            {{post.description}}
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            variant="outlined"
            color="secondary"
            @click="editPost(post.id)"
            v-if="getCurrentUser !== null && getCurrentUser.id === post.author.id"
          >
            Edit
          </v-btn>
          <v-btn variant="outlined" color="primary" @click="showPost(post.id)">Read</v-btn>
        </v-card-actions>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getComments',
      'getCurrentUser',
    ])
  },
  props: {
    post: Object,
  },
  data: () => ({
  }),
  methods: {
    showPost(postId) {
      this.$router.push(`/posts/${postId}`)
    },
    editPost(postId) {
      this.$router.push(`/edit_post/${postId}`)
    }
  }
}
</script>