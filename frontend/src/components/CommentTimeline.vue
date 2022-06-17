<template>
  <v-container>
    <CommentForm :user="getCurrentUser" :postId="postId" v-if="getCurrentUser"/>
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
        <p class="font-weight-thin text-caption">{{this.moment.utc(comment.created_at).fromNow()}}</p>
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
          color="red"
          @click="removeComment(comment)" 
          v-if="getCurrentUser && getCurrentUser.id === comment.user.id"
        >
          Remove
        </v-btn>
        <v-btn 
          variant="text" 
          color="amber" 
          @click="editMode(index)" 
          v-if="getCurrentUser && getCurrentUser.id === comment.user.id && !editableComments[index]"
        >
          Edit
        </v-btn>
        <v-btn 
          variant="text" 
          color="grey" 
          @click="undo(index)" 
          v-if="getCurrentUser && getCurrentUser.id === comment.user.id && editableComments[index]"
        >
          Undo
        </v-btn>
        <v-spacer></v-spacer>
        <div v-if="getCurrentUser">

          <v-btn
            variant="outlined"
            color="blue"
            @click="like(comment)"
            v-if="getCurrentUser && !reacted(getCurrentUser.id, comment.id, 'like')"
          >
          +1 ({{comment.reaction_summary.likes}})
          </v-btn>
          <v-btn
            variant="outlined"
            color="green"
            @click="removeLike(comment, getReactionID(getCurrentUser.id, comment.id, 'like'))"
            v-else
          >
          +1 ({{comment.reaction_summary.likes}})
          </v-btn>

          <v-btn
            variant="outlined"
            color="amber"
            @click="smile(comment)"
            v-if="getCurrentUser && !reacted(getCurrentUser.id, comment.id, 'smile')"
          >
          🙂 ({{comment.reaction_summary.smiles}})
          </v-btn>
          <v-btn
            variant="outlined"
            color="green"
            @click="removeSmile(comment, getReactionID(getCurrentUser.id, comment.id, 'smile'))"
            v-else
          >
          🙂 ({{comment.reaction_summary.smiles}})
          </v-btn>

          <v-btn
            variant="outlined"
            color="yellow"
            @click="thumbsUp(comment)"
            v-if="getCurrentUser && !reacted(getCurrentUser.id, comment.id, 'thumbsup')"
          >
          👍 ({{comment.reaction_summary.thumbs_up}})
          </v-btn>
          <v-btn
            variant="outlined"
            color="green"
            @click="removeThumbsUp(comment, getReactionID(getCurrentUser.id, comment.id, 'thumbsup'))"
            v-else
          >
          👍 ({{comment.reaction_summary.thumbs_up}})
          </v-btn>
        </div>
        
      </v-card-actions>
    </v-card>
  </div>
  </v-container>
</template>

<script>
import CommentForm from "@/components/CommentForm"
import moment from 'moment'
import { mapGetters } from "vuex"

export default {
  computed: {
    ...mapGetters([
      'getCurrentUser',
      'getComments',
      'reacted',
      'getReactionID'
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
  channels: {
    PostCommentsChannel: {
      connected() {},
      rejected() {},
      received(data) { this.$store.dispatch('injectCommentAtTop', data.comment) },
      disconnected() {},
    },
    PostCommentUpdateChannel: {
      connected() {},
      rejected() {},
      received(data) { this.$store.dispatch('replaceComment', data.comment) },
      disconnected() {},
    },
    PostCommentDeleteChannel: {
      connected() {},
      rejected() {},
      received(data) { this.$store.dispatch('deleteComment', data.comment) },
      disconnected() {},
    },
    ReactionChannel: {
      connected() {},
      rejected() {},
      received(data) { this.$store.dispatch('react', data.reaction) },
      disconnected() {},
    },
    DeleteReactionChannel: {
      connected() {},
      rejected() {},
      received(data) { this.$store.dispatch('removeReaction', data.reaction) },
      disconnected() {},
    },
  },
  data: () => ({
    postId: null,
    comments: [],
    editableComments: [],
  }),
  created() {
    this.moment = moment
    this.postId = this.$route.params.id
    this.loadComments()

    this.$cable.subscribe({
      channel: "PostCommentsChannel",
      post_id: this.postId
    });

    this.$cable.subscribe({
      channel: "PostCommentUpdateChannel",
      post_id: this.postId
    });

    this.$cable.subscribe({
      channel: "PostCommentDeleteChannel",
      post_id: this.postId
    });

    this.$cable.subscribe({
      channel: "ReactionChannel"
    });

    this.$cable.subscribe({
      channel: "DeleteReactionChannel"
    });
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
    },
    undo(index) {
      this.editableComments[index] = false
    },
    like(comment) {
      this.createReaction(this.reactionPayload('like', comment))
    },
    smile(comment) {
      this.createReaction(this.reactionPayload('smile', comment))
    },
    thumbsUp(comment) {
      this.createReaction(this.reactionPayload('thumbs_up', comment))
    },
    removeLike(comment, id) {
      this.deleteReaction(this.deletableReactionPayload(id, comment))
    },
    removeSmile(comment, id) {
      this.deleteReaction(this.deletableReactionPayload(id, comment))
    },
    removeThumbsUp(comment, id) {
      this.deleteReaction(this.deletableReactionPayload(id, comment))
    },
    createReaction(payload) {
      this.$store.dispatch('createReaction', payload)
    },
    deleteReaction(payload) {
      this.$store.dispatch('deleteReaction', payload)
    },
    reactionPayload(reaction, comment) {
      return {
        id: comment.id,
        post_id: this.postId,
        payload: {
          user_id: this.getCurrentUser.id,
          reaction: reaction
        }
      }
    },
    deletableReactionPayload(id, comment) {
      return {
        id: id,
        comment_id: comment.id,
        user_id: this.getCurrentUser.id,
        post_id: this.postId,
      }
    },
    removeComment(comment) {
      this.$store.dispatch('removeComment', {
        user_id: this.getCurrentUser.id,
        comment_id: comment.id,
        post_id: this.postId
      })
    }
  }
}
</script>