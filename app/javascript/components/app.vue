<template>
  <div id='app'>
    <p>{{ message }}</p>
    <form v-on:submit.prevent="onSubmit">
      <input type="text" name="email" v-model="email" placeholder="E-mail">
      <input type="password" name="password" v-model="password" placeholder="Password">
      <input type="submit">
    </form>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        message: "Welcome to Life Vitae!",
        email: '',
        password: ''
      }
    },
    methods: {
      onSubmit: function () {
        this.$axios.post('/users', {
          user: {
            email: this.email,
            password: this.password
          }
        })
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        })
      }
    }
  }
</script>

<style lang="scss">
  @import '../styles/app.scss';

  $color-red: red;

  p {
    color: $color-red;
    font-size: 2em;
    text-align: center;
  }
</style>
