<template>
  <div>
    <p class="menu-label">Latest Callsigns</p>
    <input
      class="input"
      type="text"
      placeholder="Filter stations..."
      :value="stationFilter"
      @input="setStationFilter"
    >
    <div class="station-list">
      <button
        v-for="callsign in stationCallsigns"
        :key="callsign"
        @click="focusMarker(callsign)"
        class="button is-small station-list-item"
      >{{callsign}}</button>
    </div>
  </div>
</template>

<style scoped>
.station-list {
  display: flex;
  flex-direction: column;
  margin: 0.5em;
}

.station-list-item {
  margin: 0.25em;
}
</style>

<script>
import { mapGetters } from "vuex";

export default {
  props: ["focusMarker"],
  data: () => ({}),
  computed: {
    ...mapGetters(["stationFilter", "stationCallsigns"])
  },
  methods: {
    setStationFilter(e) {
      this.$store.commit("setStationFilter", e.target.value);
    }
  }
};
</script>
