<template>
  <v-app>
    <v-app-bar app>
      <p class="text-h4">
        THE BLOG
      </p>
      <v-spacer></v-spacer>
      <v-btn
        color="primary"
        @click="visitAccount"
      >
        Pick / Create User
      </v-btn>
    </v-app-bar>
    <v-main>
      <v-container fluid>

        <!-- If using vue-router -->
        <router-view></router-view>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',
  data: () => ({
    //
  }),
  methods: {
    visitAccount() {
      this.$router.push('/accounts')
    }
  }
}
</script>
