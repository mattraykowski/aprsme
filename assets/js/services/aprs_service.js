import Packet from "../packet";
import { getSymbol } from "../symbols";


function hashCode(str) { // java String#hashCode
  var hash = 0;
  for (var i = 0; i < str.length; i++) {
     hash = str.charCodeAt(i) + ((hash << 5) - hash);
  }
  return hash;
} 

function intToRGB(i){
  var c = (i & 0x00FFFFFF)
      .toString(16)
      .toUpperCase();

  return "00000".substring(0, 6 - c.length) + c;
}

export const getHashedColor = str => {
  const hash = hashCode(str);
  return `#${intToRGB(hash)}`;
}

export default class AprsService {
  constructor(socket, store) {
    console.log('*** APRS Initializing...');
    this.receiveAprsPosition = this.receiveAprsPosition.bind(this);
    this.sendMapBounds = this.sendMapBounds.bind(this);

    this.store = store;

    console.log('*** Connecting socket...');
    socket.connect();

    console.log('*** Joining position channel...')
    this.channel = socket
      .channel('aprs:messages')
    this.channel.on('aprs:position', this.receiveAprsPosition)
    this.channel.join()
      .receive("ok", (resp) => {
        console.log("*** Joined position channel...", resp);
      }).receive("error", (reason) => {
        console.log("*** Join position channel failed, reason:", reason);
      });
  }

  receiveAprsPosition(data) {
    const packet = new Packet(JSON.parse(data.payload));

    if(packet.hasPosition()) {
      if(packet.isLocation() || packet.isObject()) {
        const callsign = packet.getDisplayName();
        const position = packet.getLatLng();
        const comment = packet.getComment();
        const symbol = getSymbol(packet);
        const polyColor = getHashedColor(callsign);

        let station = this.store.state.allStations.find(s => s.callsign === callsign);

        if(station) {
          // Handling the case when the marker is already in Vuex.
          if(packet.isDifferentLocation(station.position) && callsign !== 'WINLINK') {
            if (!packet.isObject()) {
              station.polyPoints = [...station.polyPoints, position]
            }

            // Update Station.
            station.position = position;
            station.comment = comment;
            this.store.commit("updateStation", station);
          }
        } else {
          const polyPoints = [];

          // Object packets should track their positions over time to plot them.
          if (!packet.isObject()) {
            polyPoints.push(position);
          }

          station = {
            callsign,
            position,
            symbol,
            comment,
            polyColor,
            polyPoints
          };

          // Add new station.
          this.store.commit("addStation", station);
        }
      } else {
        console.log("Warning! Unhandled packet type:", packet.type);
      }
    }
  }

  sendMapBounds(bounds, zoom) {
    if (zoom < 9) {
      console.log(`*** User zoomed too far out, skipping map bounds server update. Zoom level: ${zoom}.`);
      return;
    }

    console.log('*** Updating map bounds with server...');
    this.channel.push('map_bounds', {
      ne: bounds._northEast,
      sw: bounds._southWest,
      zoom
    });
  }
}