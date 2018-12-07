<template>
  <v-app>
    <app-header :signedIn="signedIn" @handleSignOut="handleSignOut"></app-header>
    <v-content>
      <v-container>
        <v-layout align-center justify-center>
          <v-flex md8 v-if="signedIn">
            <user-form></user-form>
          </v-flex>
          <v-flex md6 v-else>
            <v-form @submit.prevent="onSignIn">
              <v-text-field v-model="signin_email" label="E-mail" type="email"></v-text-field>
              <v-text-field v-model="signin_password" label="Password" type="password"></v-text-field>

              <v-btn color="success" type="submit">Sign In</v-btn>
            </v-form>

            <v-form @submit.prevent="onSignUp">
              <v-text-field v-model="signup_email" label="E-mail" type="email"></v-text-field>
              <v-text-field v-model="signup_password" label="Password" type="password"></v-text-field>

              <v-btn color="success" type="submit">Sign Up</v-btn>
            </v-form>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
  import AppHeader from './shared/AppHeader';
  import UserForm from './UserForm';

  export default {
    components: {
      AppHeader,
      UserForm
    },
    data () {
      return {
        signedIn: false,
        signin_email: '',
        signin_password: '',
        signup_email: '',
        signup_password: ''
      }
    },
    beforeCreate () {
      this.$axios.get('/current_user')
        .then((response) => {
          if(response.data) {
            this.$store.commit('setCurrentUser', response.data);
            this.signedIn = true
          }
        })
        .catch((error) => {
          console.log(error);
        })
    },
    methods: {
      onSignUp: function () {
        this.$axios.post('/users', {
          user: {
            email: this.signup_email,
            password: this.signup_password
          }
        })
          .then((response) => {
            this.$store.commit('setCurrentUser', response.data);
            this.signedIn = true
          })
          .catch((error) => {
            console.log(error);
          })
      },
      onSignIn: function () {
        this.$axios.post('/users/sign_in', {
          user: {
            email: this.signin_email,
            password: this.signin_password
          }
        })
          .then((response) => {
            this.$store.commit('setCurrentUser', response.data);
            this.signedIn = true
          })
          .catch((error) => {
            console.log(error);
          })
      },
      handleSignOut: function () {
        this.$store.commit('setCurrentUser', {});
        this.signedIn = false
      }
    }
  }
</script>

<style lang="scss">
  @import '../styles/app.scss';
</style>
