export default {
  getUsers: state => {
    return state.users
  },
  getUserEmails: state => {
    return state.userEmails
  },
  getCurrentUser: state => state.currentUser,
  userFormHasErrors: state => state.userForm.hasErrors,
  getFormErrorByField: state => field =>{
    let errorMessage = null
    state.userForm.errors.forEach((error) => {
      if(error.field === field) {
        errorMessage = error.message
      }
    })

    return errorMessage
  }
}