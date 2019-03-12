import Vuex from 'vuex';

export const store = new Vuex.Store({
  state: {
    markersByCallsign: {},
    polylinesByCallsign: {},
    recentCallsigns: [],
    mapZoom: 10,
    bounds: L.latLngBounds([
      [45.3444241045224, -92.58316040039064],
      [44.55329208318496, -93.59390258789064]
    ]),
    center: L.latLng([44.950221181527546, -93.08715820312501]),
  },
  mutations: {
    addRecentCallsign (state, callsign) {
      state.recentCallsigns = [...state.recentCallsigns, callsign];
    },
    setCallsignMarker (state, { callsign, marker }) {
      state.markersByCallsign = {
        ...state.markersByCallsign,
        [callsign]: marker
      }
    },
    setCallsignPolyline (state, { callsign, polyline }) {
      state.polylinesByCallsign[callsign] = polyline;
    },
    setBounds (state, bounds) {
      state.bounds = bounds;
    },
    setMapZoom (state, zoom) {
      state.mapZoom = zoom;
      // state.markersByCallsign = {};
      // state.polylinesByCallsign  = {};
      // state.recentCallsigns = [];
    },
    setCenter(state, center) {
      state.center = center;
    }
  },
  getters: {
    zoom: state => state.mapZoom,
    center: state => state.center,
    bounds: state => state.bounds,
    markersByCallsign: state => state.markersByCallsign
  }

});