<template>
  <div class="vue-app">
    <top-nav/>
    <router-view></router-view>
    <!-- div class="ui container">
      <div v-if="zoomedOutTooFar" class="ui blue icon tiny message">
        <i class="icon info circle"></i>
        <div class="content">
          <p>Zoom in to see live positions.</p>
        </div>
      </div>
    </div-->
    <!-- container -->
  </div>
</template>

<script>
import TopNav from "./TopNav.vue";

export default {
  data: () => ({}),
  components: { TopNav }
};
</script>

<style scoped>
.vue-app {
  width: 100%;
  height: 100%;
  margin: 0;

  display: flex;
  flex-direction: column;
}
</style>
