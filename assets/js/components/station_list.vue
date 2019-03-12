<template>
  <div>
    <p class="menu-label">Latest Callsigns</p>

    <div class="list">
      <a
        v-for="(a, callsign) in stations"
        :key="callsign"
        class="list-item is-small"
        @click="focusMarker(callsign)"
      >{{callsign}}</a>
    </div>
  </div>
</template>

<script>
export default {
  props: ["focusMarker"],
  data: () => ({}),
  computed: {
    stations() {
      return this.$store.state.markersByCallsign;
    }
  }
};
</script>
