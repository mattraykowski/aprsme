<script>
import StationList from "./station_list.vue";
import MapView from "./MapView.vue";
import Sidebar from "./Sidebar.vue";

export default {
  data: () => ({}),
  components: {
    StationList,
    MapView,
    Sidebar
  },
  computed: {
    stationsByCallsign: () => Object.keys(data.markersByCallsign),
    zoomedOutTooFar: () => data.mapZoom < 9
  },
  methods: {
    focusMarker(callsign) {
      this.$refs.mapView.centerOnMarker(callsign);
      this.$refs.mapView.openCallsignPopup(callsign);
    }
  }
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

.main-content {
  flex: 5;

  display: flex;
  flex-direction: row;
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

<template>
  <div class="vue-app">
    <div class="main-content">
      <div class="sidebarz-nav">
        <sidebar :focusMarker="focusMarker"/>
      </div>
      <section class="content">
        <map-view ref="mapView"/>
      </section>
    </div>
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
