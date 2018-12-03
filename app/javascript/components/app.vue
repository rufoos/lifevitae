<template>
  <div id='app'>
    <p>{{ message }}</p>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        message: "Welcome to Life Vitae!"
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
