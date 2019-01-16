<script>
export default {
  props: ['stations', 'focusMarker'],
  data() {
    return {};
  },
  computed: {
    stationCount: function() {
      return this.stations.length;
    },
    reversedStations: function() {
      return this.stations.slice().reverse();
    }
  },
}
</script>

<template>
<div class="station-list-component">
  <div class="item">
    <div class="header">Latest Callsigns</div>
  </div>

  <div class="stations ui relaxed divided list">
    <a @click="focusMarker(callsign)" class="item" v-for="callsign in reversedStations">{{callsign}}</a>
  </div>

</div>
</template>

<style>
.station-list-component h3 {
  text-align: center;
}


.stations {
  overflow-y: auto;
}
</style>
