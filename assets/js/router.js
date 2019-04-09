import VueRouter from 'vue-router';
import MapView from './components/map/MapView.vue';
import StationView from './components/station/StationView.vue';

const router = new VueRouter({
  routes: [
    { path: '/', component: MapView },
    { path: '/station/:station_id', component: StationView }
  ]
});

export default router;