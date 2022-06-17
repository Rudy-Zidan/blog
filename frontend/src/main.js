import { createApp } from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import { loadFonts } from './plugins/webfontloader'
import ActionCableVue from "actioncable-vue"
import axios from 'axios'
import VueAxios from 'vue-axios'
import router from './router'
import actioncableConfig from './actioncable'
import store from "@/store"


loadFonts()

createApp(App)
.use(vuetify)
.use(store)
.use(router)
.use(VueAxios, axios)
.use(ActionCableVue, actioncableConfig)
.mount('#app')
