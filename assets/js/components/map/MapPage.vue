<template>
  <div class="map-view">
    <l-map
      :zoom="zoom"
      :minZoom="minZoom"
      :maxZoom="maxZoom"
      :center="center"
      :bounds="bounds"
      :options="mapOptions"
      @update:center="centerUpdate"
      @update:zoom="zoomUpdate"
      @update:bounds="boundsUpdate"
      ref="map"
    >
      <l-easy-button :html="locateButton" :onClick="locateButtonAction"/>
      <l-tile-layer :url="url" :attribution="attribution" :options="tileOptions"></l-tile-layer>
      <l-marker-cluster :options="markerGroupOptions">
        <l-marker
          v-for="station in stations"
          :key="station.callsign"
          :lat-lng="station.position"
          :ref="station.callsign"
        >
          <l-icon :options="markerIconOptions(station)"/>
          <l-popup :options="{ maxWidth: '300', minWidth: '300', className: 'station-popup' }">
            <div class="columns">
              <div class="column is-2">
                <span :class="`aprs-symbol aprs-icon-symbol ${station.symbol}`"></span>
              </div>
              <div class="column is-8">
                <h3>
                  <b>{{ station.callsign }}</b>
                </h3>
              </div>
              <div class="column is-2">
                <a :href="`/call/${station.callsign}`" target="_blank">
                  Info
                  <i class="fas fa-external"></i>
                </a>
              </div>
            </div>
            <div v-if="station.comment" class="columns">
              <div class="column is-12">
                <em>{{ station.comment }}</em>
              </div>
            </div>
          </l-popup>
        </l-marker>
      </l-marker-cluster>
      <l-polyline
        v-for="station in stations"
        :key="station.callsign"
        :latLngs="station.polyPoints"
        :color="station.polyColor"
      />
    </l-map>
  </div>
</template>

<style scoped>
.map-view {
  height: 100%;
  width: 100%;
}
</style>

<script>
import { mapGetters } from "vuex";
import {
  LMap,
  LTileLayer,
  LMarker,
  LControl,
  LIcon,
  LPolyline,
  LPopup
} from "vue2-leaflet";
import LMarkerCluster from "vue2-leaflet-markercluster";
import LEasyButton from "./LeafletEasyButton.vue";
import mapboxAccessToken from "./mapboxAccessToken";
const MAX_ZOOM = 20;

export default {
  data() {
    return {
      // Map
      minZoom: 0,
      maxZoom: MAX_ZOOM,
      mapOptions: {
        worldCopyJump: true,
        keyboard: true
      },
      // Tile Layer
      url:
        "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}",
      tileOptions: {
        maxZoom: MAX_ZOOM,
        attribution:
          'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
        accessToken: mapboxAccessToken,
        id: "mapbox.streets"
      },
      markerGroupOptions: {
        removeOutsideVisibleBounds: true,
        disableClusteringAtZoom: 9
      }
    };
  },
  components: {
    LMap,
    LTileLayer,
    LMarker,
    LMarkerCluster,
    LControl,
    LIcon,
    LEasyButton,
    LPolyline,
    LPopup
  },
  computed: {
    ...mapGetters(["zoom", "stations", "bounds", "center"]),
    locateButton() {
      return "<i class='fas fa-location-arrow'></i>";
    }
  },
  methods: {
    markerIconOptions(marker) {
      const mapSymbol = marker.symbol
        ? `<div class="aprs-icon-symbol map ${marker.symbol}"></div>`
        : "";
      return {
        html: `
        <div class="aprs-map-symbol-wrapper aprs-icon-callsign">
          ${mapSymbol}
          <span class="aprs-marker-callsign">${marker.callsign}</span>
        </div>
      `
      };
    },
    locateButtonAction(_btn, map) {
      map.locate({
        maxZoom: 10,
        setView: true,
        timeout: 5000
      });
    },
    zoomUpdate(zoom) {
      this.$store.commit("setMapZoom", zoom);
    },
    centerUpdate(center) {
      this.$store.commit("setCenter", [center.lat, center.lng]);
    },
    boundsUpdate(bounds) {
      this.$aprsService.sendMapBounds(bounds, this.$store.state.mapZoom);
    },
    openCallsignPopup(callsign) {
      const callsignMarker = this.$refs[callsign][0];
      callsignMarker.mapObject.openPopup();
    },
    centerOnMarker(callsign) {
      const callsignMarker = this.$refs[callsign][0];
      this.$store.commit("setCenter", [
        callsignMarker.latLng.lat,
        callsignMarker.latLng.lng
      ]);
    }
  },
  mounted() {
    this.$aprsService.sendMapBounds(this.bounds, this.$store.state.mapZoom);
  }
};
</script>