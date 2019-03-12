<script>
import StationList from "./station_list.vue";

export default {
  props: ["focusMarker"],
  components: {
    StationList
  }
};
</script>

<style scoped>
.sidebar {
  height: 100vh;
  margin: 0.5em;
  overflow: scroll;
}
</style>

<template>
  <div class="sidebar">
    <aside class="menu">
      <station-list :focusMarker="focusMarker"/>
    </aside>
  </div>
</template>