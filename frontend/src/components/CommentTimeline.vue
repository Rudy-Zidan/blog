<template>
  <v-container>
    <!-- <v-text-field
      v-model="content"
      hide-details
      label="Leave a comment and press enter to post it..."
      density="compact"
      @keydown.enter="postComment"
      class="font-weight-light"
      v-if="getCurrentUser !== null"
    >
    </v-text-field> -->
    <CommentForm :user="getCurrentUser" :postId="postId"/>
    <p v-if="comments.length === 0">No Comments yet...</p>
  <div
    v-for="(comment, index) in comments"
    :key="comment.id"
    class="mt-5"
    
  >
    <v-card class="pb-2" >
      <v-card-title>
        <h5 class="font-weight-light">
        @{{comment.user.name}}
        </h5>
        <v-spacer></v-spacer>
        <p class="font-weight-thin">{{ comment.id }}</p>
      </v-card-title>
      <v-card-text class="font-weight-thin" v-if="!editableComments[index]">
        {{comment.content}}
      </v-card-text>
      <v-card-text class="font-weight-thin" v-if="editableComments[index]" >
        <CommentForm 
          :user="getCurrentUser" 
          :postId="postId" 
          :content="comment.content" 
          :id="comment.id"  
          :key="comment.id"
          @changed="disableEditMode(index)"
        />
      </v-card-text>
      <v-card-actions>
        <v-btn 
          variant="text" 
          color="secondary" 
          @click="editMode(index)" 
          v-if="getCurrentUser && getCurrentUser.id === comment.user.id"
        >
          Edit
        </v-btn>
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
import CommentForm from "@/components/CommentForm"
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getCurrentUser',
      'getComments'
    ]),
  },
  components: {
    CommentForm
  },
  watch: {
    getComments(value) {
      this.comments = value
      this.comments.forEach(() => {
        this.editableComments.push(false)
      })
    }
  },
  data: () => ({
    postId: null,
    comments: [],
    editableComments: []
  }),
  created() {
    this.postId = this.$route.params.id
    this.loadComments()
  },
  methods: {
    loadComments() {
      this.$store.dispatch('getPostCommentsById', this.postId)
    },
    editMode(index) {
      this.editableComments[index] = true
    },
    disableEditMode(index) {
      this.editableComments[index] = false
    }
  }
}
</script>