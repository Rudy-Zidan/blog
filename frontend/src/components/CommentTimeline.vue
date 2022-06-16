<template>
  <v-container>
  <v-text-field
    v-model="input"
    hide-details
    label="Leave a comment..."
    density="compact"
    @keydown.enter="comment"
    class="font-weight-light"
    v-if="getCurrentUser !== null"
  >
    <template v-slot:append>
      <v-btn
        class="mx-0 font-weight-light"
        color="primary"
        @click="comment"
      >
        Post
      </v-btn>
    </template>
  </v-text-field>
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
      'getCurrentUser'
    ]),
  },
  props: {
    comments: Array,
  },
}
</script>