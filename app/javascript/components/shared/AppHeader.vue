<template>
  <v-toolbar>
    <v-toolbar-side-icon></v-toolbar-side-icon>
    <v-toolbar-title>Life Vitae</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items class="hidden-sm-and-down">
      <template v-if="!signedIn">
        <v-btn flat color="success" href="/users/auth/facebook">Sign In via Facebook</v-btn>
        <v-btn flat color="info" href="/users/auth/linkedin">Sign In via LinkedIn</v-btn>
      </template>
      <template v-else>
        <v-btn flat>{{ $store.getters.currentUser.email }}</v-btn>
        <v-btn flat @click="onSignOut">Sign Out</v-btn>
      </template>
    </v-toolbar-items>
  </v-toolbar>
</template>

<script>
  export default {
    name: 'app-header',
    props: {
      signedIn: {
        type: Boolean,
        required: false,
        default: false
      }
    },
    methods: {
      onSignOut: function () {
        this.$axios.delete('/users/sign_out')
          .then(() => {
            this.$emit('handleSignOut')
          })
          .catch((error) => {
            console.log(error);
          })
      }
    }
  }
</script>
