import Vuex from 'vuex';

export const store = new Vuex.Store({
  state: {
    allStations: [],
    stationFilter: '',
    mapZoom: 10,
    bounds: L.latLngBounds([
      [45.3444241045224, -92.58316040039064],
      [44.55329208318496, -93.59390258789064]
    ]),
    center: L.latLng([44.950221181527546, -93.08715820312501]),
  },
  mutations: {
    addStation (state, station) {
      state.allStations.push(station);
    },
    updateStation (state, station) {
      const index = state.allStations.findIndex(s => s.callsign === station.callsign);
      if(index !== -1) {
        state.allStations[index] = station;
      }
    },
    setStationFilter (state, filter) {
      state.stationFilter = filter;
    },
    setBounds (state, bounds) {
      state.bounds = bounds;
      // TODO: Filter stations based on bounds
    },
    setMapZoom (state, zoom) {
      state.mapZoom = zoom;
    },
    setCenter(state, center) {
      state.center = center;
    }
  },
  getters: {
    zoom: state => state.mapZoom,
    center: state => state.center,
    bounds: state => state.bounds,
    stationCallsigns: state => 
      state.allStations
        .filter(s => 
          s.callsign.toUpperCase().includes(state.stationFilter.toUpperCase()))
        .map(s => s.callsign),
    stationFilter: state => state.stationFilter,
    stations: state => state.allStations
      .filter(s => s.callsign.toUpperCase().includes(state.stationFilter.toUpperCase()))
  }

});