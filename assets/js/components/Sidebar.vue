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
  height: 100%;
  padding: 1em;
  margin: 0.5em;
  overflow: scroll;
}
</style>

<template>
  <div class="sidebar">
    <station-list :focusMarker="focusMarker"/>
  </div>
</template>