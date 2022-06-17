<template>
  <v-container>
    <v-row justify="space-around">
      <v-card width="600">
        <v-card-title>
          {{post.title}}
          <v-spacer></v-spacer>
          <p class="font-weight-thin text-caption">{{this.moment.utc(post.created_at).fromNow()}}</p>
        </v-card-title>
        <v-card-subtitle>
          <p>Written by</p>
          &nbsp;
          <!-- <v-btn
            variant="text"
            color="amber"
            @click="showAuthorPosts(post.author.id)"
          >
            {{post.author.name}}
          </v-btn> -->
          <p >
            <router-link :to="authorPostsUrl(post.author.id)"> {{authorName(post.author)}} </router-link>
          </p>
        </v-card-subtitle>
        <v-card-text>
          <div class="ml-1 mb-2">
            {{post.description}}
          </div>
        </v-card-text>
        <v-card-actions>
          <v-btn
            variant="outlined"
            color="red"
            @click="removePost(post.id)"
            v-if="getCurrentUser !== null && getCurrentUser.id === post.author.id"
          >
            Remove
          </v-btn>
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
import moment from 'moment'

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
  created() {
    this.moment = moment
  },
  data: () => ({}),
  methods: {
    showPost(postId) {
      this.$router.push(`/posts/${postId}`)
    },
    editPost(postId) {
      this.$router.push(`/edit_post/${postId}`)
    },
    showAuthorPosts(id) {
      this.$router.push(`/users/${id}/posts`)
    },
    authorPostsUrl(id) {
      return `/users/${id}/posts`
    },
    authorName(author){
      if(this.getCurrentUser && this.getCurrentUser.id === author.id){
        return "Me"
      }

      return author.name
    },
    removePost(postId) {
      this.$store.dispatch('deletePost', {
        post_id: postId,
        author_id: this.getCurrentUser.id
      })
    }
  }
}
</script>