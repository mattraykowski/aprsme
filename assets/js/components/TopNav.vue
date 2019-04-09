<template>
  <nav class="navbar" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <router-link class="navbar-item" to="/">APRS.me</router-link>

      <a
        role="button"
        class="navbar-burger burger"
        :class="{ 'is-active': topNavOpen }"
        aria-label="menu"
        :aria-expanded="topNavOpen"
        v-on:click="toggleTopNav"
      >
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>

    <div class="navbar-menu top-nav" :class="{ 'is-active': topNavOpen }">
      <div class="navbar-start">
        <router-link class="navbar-item" to="/">Home</router-link>

        <a class="navbar-item">Search</a>
      </div>

      <div class="navbar-end">
        <div class="navbar-item">
          <div class="buttons">
            <a class="button is-primary">
              <strong>Sign up</strong>
            </a>
            <a class="button is-light">Log in</a>
          </div>
        </div>
        <div class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link">KD0DEP</a>

          <div class="navbar-dropdown">
            <a class="navbar-item">About</a>
            <a class="navbar-item">Jobs</a>
            <a class="navbar-item">Contact</a>
            <hr class="navbar-divider">
            <a class="navbar-item">Report an issue</a>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>

<style scoped>
.top-nav {
  position: fixed;
  width: 100%;
}
</style>

<script>
export default {
  name: "TopNav",
  data: () => ({
    topNavOpen: true
  }),
  methods: {
    toggleTopNav: function() {
      this.topNavOpen = !this.topNavOpen;
    }
  }
};
</script>