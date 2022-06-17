<template>
  <v-row justify="space-around" v-if="getCurrentUser !== null">
    <p v-if="isPostUpdating"> Updating...</p>
    <v-card v-else width="600" class="mb-10" ref="postForm">
      <v-card-title v-if="postId">
          Update Post
      </v-card-title>
      <v-card-title v-else>
          Create Post
      </v-card-title>
      <v-card-subtitle color="red" v-if="generalErrorMessages.length > 0" class="red--text">
        <v-alert type="error"> {{generalErrorMessages[0]}} </v-alert>
      </v-card-subtitle>
      <v-card-text>
        <v-text-field
          ref="title"
          :rules="[() => !!postForm.title || 'This field is required']"
          :error-messages="titleErrorMessages"
          v-model="postForm.title"
          label="Title"
          density="compact"
          class="font-weight-light"
          required
        >
        </v-text-field>
        <v-text-field
          ref="description"
          :rules="[() => !!postForm.description || 'This field is required']"
          :error-messages="descErrorMessages"
          v-model="postForm.description"
          label="Description"
          density="compact"
          class="font-weight-light"
          required
        >
        </v-text-field>
        <v-text-field
          ref="content"
          :rules="[() => !!postForm.content || 'This field is required']"
          :error-messages="contentErrorMessages"
          v-model="postForm.content"
          filled
          class="font-weight-light"
          label="Content"
          auto-grow
        ></v-text-field>
      </v-card-text>
      <v-card-actions>
        <v-btn
          class="mx-0 font-weight-light"
          color="grey"
          variant="outlined"
          @click="back"
          v-if="postId !== null"
        >
          Back
        </v-btn> 
        <v-spacer></v-spacer>
        <v-btn
          class="mx-0 font-weight-light"
          color="secondary"
          variant="outlined"
          @click="submit"
          v-if="postId === null"
        >
          Post
        </v-btn>
        <v-btn
          class="mx-0 font-weight-light"
          color="secondary"
          variant="outlined"
          @click="update"
          v-else
        >
          Update
        </v-btn> 
      </v-card-actions>
    </v-card>
  </v-row>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  props: [
    'updatablePost'
  ],
  computed: {
    ...mapGetters([
      'postFormHasErrors',
      'getCurrentUser',
      'getPostFormErrorByField',
      'isPostUpdating'
    ])
  },
  watch: {
    postFormHasErrors () {
      let titleErrorMsg = this.getPostFormErrorByField("title")
      if(titleErrorMsg !== null) {
        this.titleErrorMessages = [titleErrorMsg]
      }

      let descErrorMsg = this.getPostFormErrorByField("description")
      if(descErrorMsg !== null) {
        this.descErrorMessages = [descErrorMsg]
      }

      let contentErrorMsg = this.getPostFormErrorByField("content")
      if(contentErrorMsg !== null) {
        this.contentErrorMessages = [contentErrorMsg]
      }

      let generalErrorMsg = this.getPostFormErrorByField("author")
      if(generalErrorMsg !== null) {
        this.generalErrorMessages = [generalErrorMsg]
      }
    },
    updatablePost(value) {
      this.postId = value.id
      this.postForm.title = value.title
      this.postForm.description = value.description
      this.postForm.content = value.content
    }
  },
  data: () => ({
    postId: null,
    formHasErrors: false,
    titleErrorMessages: [],
    descErrorMessages: [],
    contentErrorMessages: [],
    generalErrorMessages: [],

    postForm: {
      title: null,
      description: null,
      content: null
    },
  }),
  methods: {
    submit() {
      this.validate()

      if(this.formHasErrors !== true) {
        this.$store.dispatch(
          "createPost",
          {
            author_id: this.getCurrentUser.id,
            title: this.postForm.title,
            description: this.postForm.description,
            content: this.postForm.content
          }
        )
      }
    },
    update() {
      this.validate()

      if(this.formHasErrors !== true) {
        this.$store.dispatch(
          "updatePost",
          {
            id: this.postId,
            post: {
              author_id: this.getCurrentUser.id,
              title: this.postForm.title,
              description: this.postForm.description,
              content: this.postForm.content
            }
          }
        )
      }
    },
    validate() {
      this.formHasErrors = false

      Object.keys(this.postForm).forEach(f => {
        if (!this.postForm[f]) this.formHasErrors = true

        this.$refs[f].validate(true)
      })
    },
    back() {
      this.$router.back()
    }
  }
}
</script>