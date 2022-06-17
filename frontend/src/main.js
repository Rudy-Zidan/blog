import { createApp } from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import { loadFonts } from './plugins/webfontloader'
import axios from 'axios'
import VueAxios from 'vue-axios'
import router from './router'
import store from "@/store"


loadFonts()

createApp(App)
.use(vuetify)
.use(store)
.use(router)
.use(VueAxios, axios)
.mount('#app')
