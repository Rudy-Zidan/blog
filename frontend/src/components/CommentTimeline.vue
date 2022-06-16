<template>
  <v-container>
    <v-text-field
      v-model="content"
      hide-details
      label="Leave a comment and press enter to post it..."
      density="compact"
      @keydown.enter="postComment"
      class="font-weight-light"
      v-if="getCurrentUser !== null"
    >
    </v-text-field>
    <p v-if="comments.length === 0">No Comments yet...</p>
  <div
    v-for="comment in comments"
    :key="comment.id"
    class="mt-5"
    
  >
  <v-card class="pb-2">
    <v-card-title>
      <h5 class="font-weight-light">
      @{{comment.user.name}}
      </h5>
      <v-spacer></v-spacer>
      <p class="font-weight-thin">{{ comment.id }}</p>
    </v-card-title>
    <v-card-text class="font-weight-thin">
      {{comment.content}}
    </v-card-text>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn
        variant="outlined"
        color="blue"
      >
      +1 ({{comment.reaction_summary.likes}})
      </v-btn>
      <v-btn
        variant="outlined"
        color="amber"
      >
      🙂 ({{comment.reaction_summary.smiles}})
      </v-btn>
      <v-btn
        variant="outlined"
        color="yellow"
      >
      👍 ({{comment.reaction_summary.thumbs_up}})
      </v-btn>
    </v-card-actions>
  </v-card>
  </div>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getCurrentUser',
      'getComments'
    ]),
  },
  watch: {
    getComments(value) {
      this.comments = value
    }
  },
  data: () => ({
    content: null,
    postId: null,
    comments: []
  }),
  created() {
    this.postId = this.$route.params.id
    this.loadComments()
  },
  methods: {
    postComment() {
      this.$store.dispatch("createComment", {user_id: this.getCurrentUser.id, post_id: this.postId, content: this.content})
      this.content = null
    },
    loadComments() {
      this.$store.dispatch('getPostCommentsById', this.postId)
    }
  }
}
</script>