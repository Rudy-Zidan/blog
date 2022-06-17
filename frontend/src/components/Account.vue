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
          v-model="selectedUserEmail"
          :items="getUserEmails"
          label="Pick an Email"
        >
        <template v-slot:append>
          <v-btn
          color="primary"
          text
          @click="pick"
        >
          Pick
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
              :error-messages="nameErrorMessages"
              label="Full Name"
              placeholder="John Doe"
              required
            ></v-text-field>
            <v-text-field
              ref="email"
              v-model="email"
              :rules="[() => !!email || 'This field is required']"
              :error-messages="emailErrorMessages"
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
                v-if="this.userFormHasErrors"
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
              Create
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
      'getUserEmails',
      'userFormHasErrors',
      'getFormErrorByField'
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
      this.errorMessages = []
    },
    email () {
      this.emailErrorMessages = []
    },
    userFormHasErrors () {
      let emailErrorMsg = this.getFormErrorByField("email")
      if(emailErrorMsg !== null) {
        this.emailErrorMessages = [emailErrorMsg]
      }

      let nameErrorMsg = this.getFormErrorByField("name")
      if(nameErrorMsg !== null) {
        this.nameErrorMessages = [nameErrorMsg]
      }
    }
  },
  created() {
    this.$store.dispatch("listUsers")
  },
  data: () => ({
    name: null,
    email: null,
    formHasErrors: false,
    nameErrorMessages: [],
    emailErrorMessages: [],

    users: [],
    selectedUserEmail: null
  }),
  methods: {
    resetForm () {
      this.nameErrorMessages = []
      this.emailErrorMessages = []
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

      if(this.formHasErrors !== true) {
        this.$store.dispatch(
          "createUser",
          {
            name: this.form.name,
            email: this.form.email
          }
        )
      }
    },
    pick () {
      this.$store.dispatch("selectUser", this.selectedUserEmail)
        .then(() => {
          this.$router.push("/")
        })
    }
  }
}
</script>