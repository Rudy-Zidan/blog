<template>
  <v-app>
    <v-app-bar app>
      <p class="text-h4">
        THE BLOG
      </p>
      <v-spacer></v-spacer>
      <v-btn
        color="primary"
        @click="visitHome"
      >
        Feeds
      </v-btn>
      <v-btn
        color="primary"
        @click="visitMyPosts"
        v-if="getCurrentUser"
      >
        My Posts
      </v-btn>
      <v-btn
        color="primary"
        @click="visitAccount"
      >
        {{actionName()}}
      </v-btn>
    </v-app-bar>
    <v-main>
      <v-container fluid>
        <router-view></router-view>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: 'App',
  computed: {
    ...mapGetters([
      'getCurrentUser'
    ]),
  },
  methods: {
    visitAccount() {
      this.$router.push('/accounts')
    },
    visitHome() {
      this.$router.push('/')
    },
    actionName() {
      if(this.getCurrentUser !== null) {
        return this.getCurrentUser.name
      }

      return 'Pick / Create User'
    },
    visitMyPosts() {
      this.$router.push(`/users/${this.getCurrentUser.id}/posts`)
    },
  }
}
</script>
