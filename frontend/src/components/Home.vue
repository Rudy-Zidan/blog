<template>
  <v-container>
    <v-row justify="space-around" v-if="getCurrentUser !== null">
      <v-card width="600" class="mb-10" ref="postForm">
        <v-card-title>
            Create Post
        </v-card-title>
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
          <v-spacer></v-spacer>
          <v-btn
            class="mx-0 font-weight-light"
            color="secondary"
            variant="outlined"
            @click="submit"
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
      'postFormHasErrors',
      'getCurrentUser',
      'getPostFormErrorByField'
    ])
  },
  name: 'HomePage',
  components: {
    PostCard,
  },
  created() {
    this.$store.dispatch('listPosts')
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
    }
  },
  data: () => ({
    formHasErrors: false,
    titleErrorMessages: [],
    descErrorMessages: [],
    contentErrorMessages: [],
    postForm: {
      title: null,
      description: null,
      content: null
    },
  }),
  methods: {
    submit() {
      this.formHasErrors = false

      Object.keys(this.postForm).forEach(f => {
        if (!this.postForm[f]) this.formHasErrors = true

        this.$refs[f].validate(true)
      })

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
    }
  }
}
</script>
