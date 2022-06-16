
export default {
  setUsers(state, users) {
    state.users = users
  },
  setCurrentUserByEmail(state, email) {
    state.users.forEach((user) => {
      if(user.email == email) {
        state.currentUser = user
      }
    })
  },
  setCurrentUser(state, user) {
    state.currentUser = user
  },
  setUserEmails(state, users) {
    state.userEmails = []
    users.forEach((user) => {
      state.userEmails.push(user.email)
    })
  },
  setUserFormHasErrors(state) {
    state.userForm.hasErrors = true
  },
  setUserFormHasNoErrors(state) {
    state.userForm.hasErrors = false
  },
  setUserFormErrors(state, errors) {
    state.userForm.errors = errors
  }
}