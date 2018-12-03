import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    axios: {}
  },
  mutations: {
    setAxios (state, axios) {
      state.axios = axios
    }
  },
  actions: {
    setAxios (context, axios) {
      context.commit('setAxios', axios)
    }
  },
  getters: {
    axios: state => {
      return state.axios
    }
  }
})
