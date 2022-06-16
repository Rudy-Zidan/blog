<template>
  <v-container>
    <v-row justify="space-around" v-if="getCurrentUser !== null">
      <v-card width="600" class="mb-10">
        <v-card-title>
            Create Post
        </v-card-title>
        <v-card-text>
          <v-text-field
            v-model="input"
            hide-details
            label="Title"
            density="compact"
            @keydown.enter="comment"
            class="font-weight-light"
          >
          </v-text-field>
          <v-text-field
            v-model="input"
            hide-details
            label="Description"
            density="compact"
            @keydown.enter="comment"
            class="font-weight-light"
          >
          </v-text-field>
          <v-textarea
            name="input-7-1"
            filled
            label="Content"
            density="compact"
            auto-grow
            value=""
          ></v-textarea>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            class="mx-0 font-weight-light"
            color="secondary"
            variant="outlined"
            @click="comment"
          >
            Post
          </v-btn> 
        </v-card-actions>
      </v-card>
    </v-row>
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
      'getCurrentUser'
    ])
  },
  name: 'HomePage',
  components: {
    PostCard,
  },
  data: () => ({}),
}
</script>
