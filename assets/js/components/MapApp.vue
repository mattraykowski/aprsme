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
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  visibility: visible;
}

.vue-app > .columns {
  height: 100vh;
}
.columns .column.map {
  margin: 0;
}
</style>

<template>
  <section class="vue-app">
    <div class="columns">
      <div class="column is-3">
        <sidebar :focusMarker="focusMarker"/>
      </div>
      <div class="column is-9 map">
        <map-view ref="mapView"/>
      </div>
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
  </section>
</template>
