/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue'
import Vuetify from 'vuetify'
import axios from 'axios'
import 'vuetify/dist/vuetify.min.css'

import store from '../store'
import App from '../components/App.vue'

let csrf_token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = csrf_token;
axios.defaults.headers.common['Accept'] = 'application/json';

Vue.use(Vuetify);
Vue.use(store);

Vue.prototype.$axios = axios;
Vue.prototype.$store = store;

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('application'));
  new Vue({
    el,
    render: h => h(App)
  });
});

