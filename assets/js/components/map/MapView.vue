<template>
  <div class="main-content">
    <div class="sidebarz-nav">
      <sidebar :focusMarker="focusMarker"/>
    </div>
    <section class="content">
      <map-page ref="mapPage"/>
    </section>
  </div>
</template>

<style scoped>
.main-content {
  flex: 5;
  display: flex;
  flex-direction: row;
  z-index: 10;
}

div.sidebarz-nav {
  flex: 1;
  min-height: calc(100vh - 52px);
  max-height: calc(100vh - 52px);
  overflow: scroll;
}

section.content {
  flex: 5;
}
</style>

<script>
import StationList from "./station_list.vue";
import Sidebar from "./Sidebar.vue";
import MapPage from "./MapPage.vue";

export default {
  data: () => ({}),
  components: {
    StationList,
    MapPage,
    Sidebar
  },
  methods: {
    focusMarker(callsign) {
      this.$refs.mapPage.centerOnMarker(callsign);
      this.$refs.mapPage.openCallsignPopup(callsign);
    }
  }
};
</script>