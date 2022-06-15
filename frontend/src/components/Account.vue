<template>
  <v-container >
    <v-row justify="center">
      <v-col
        cols="12"
        sm="10"
        md="8"
        lg="6"
      >
        <v-select
          v-model="selectedUser"
          :items="users"
          label="Pick a user"
        >
        <template v-slot:append>
          <v-btn
          color="primary"
          text
          @click="use"
        >
          USE
        </v-btn>
        </template>
        </v-select>
        
      </v-col>
    </v-row>
    <h3 class="text-center">Or you can create a new user</h3>
    <v-row justify="center" class="mt-5">
      <v-col
        cols="12"
        sm="10"
        md="8"
        lg="6"
      >
        <v-card ref="form">
          <v-card-text>
            <v-text-field
              ref="name"
              v-model="name"
              :rules="[() => !!name || 'This field is required']"
              :error-messages="errorMessages"
              label="Full Name"
              placeholder="John Doe"
              required
            ></v-text-field>
            <v-text-field
              ref="email"
              v-model="email"
              :rules="[() => !!email || 'This field is required', emailCheck]"
              :error-messages="errorMessages"
              label="Email"
              placeholder="example@gmail.com"
              required
            ></v-text-field>
          </v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-slide-x-reverse-transition>
              <v-tooltip
                v-if="formHasErrors"
                left
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    icon
                    class="my-0"
                    v-bind="attrs"
                    @click="resetForm"
                    v-on="on"
                  >
                    <v-icon>mdi-refresh</v-icon>
                  </v-btn>
                </template>
                <span>Refresh form</span>
              </v-tooltip>
            </v-slide-x-reverse-transition>
            <v-btn
              color="primary"
              text
              @click="submit"
            >
              Submit
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: "AccountPage",
  computed: {
    ...mapGetters([
      'getUsers',
    ]),
    form () {
      return {
        name: this.name,
        email: this.email
      }
    }
  },
  watch: {
    name () {
      this.errorMessages = ''
    },
  },
  created() {
    this.getUsers.forEach((user) => {
      this.users.push(user.name)
    })
  },
  data: () => ({
    name: null,
    email: null,
    formHasErrors: false,
    errorMessages: '',
    users: [],
    selectedUser: null
  }),
  methods: {
    emailCheck() {
      this.errorMessages = this.email && !this.name
          ? `Hey! I'm required`
          : ''
      
      return true
    },
    resetForm () {
      this.errorMessages = []
      this.formHasErrors = false

      Object.keys(this.form).forEach(f => {
        this.$refs[f].reset()
      })
    },
    submit () {
      this.formHasErrors = false

      Object.keys(this.form).forEach(f => {
        if (!this.form[f]) this.formHasErrors = true

        this.$refs[f].validate(true)
      })
    },
    use () {
      
    }
  }
}
</script>