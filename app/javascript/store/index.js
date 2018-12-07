import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    currentUser: {}
  },
  mutations: {
    setCurrentUser (state, user) {
      state.currentUser = user
    }
  },
  getters: {
    currentUser: state => {
      return state.currentUser
    }
  }
})
