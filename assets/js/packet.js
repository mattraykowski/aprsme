export default class Packet {
  constructor(p) {
    this.alive = p.alive;
    this.altitude = p.altitude;
    this.capabilities = p.capabilities;
    this.checksumok = p.checksumok;
    this.comment = p.comment;
    this.course = p.course;
    this.daodatumbyte = p.daodatumbyte;
    this.destination = p.destination;
    this.dstcallsign = p.dstcallsign;
    this.dxcall = p.dxcall;
    this.dxfreq = p.dxfreq;
    this.dxinfo = p.dxinfo;
    this.format = p.format;
    this.gpsfixstatus = p.gpsfixstatus;
    this.header = p.header;
    this.itemname = p.itemname;
    this.latitude = p.latitude;
    this.longitude = p.longitude;
    this.mbits = p.mbits;
    this.message = p.message;
    this.messageack = p.messageack;
    this.messageid = p.messageid;
    this.messagerej = p.messagerej;
    this.messaging = p.messaging;
    this.objectname = p.objectname;
    this.origpacket = p.origpacket;
    this.type = p.type;
    this.phg = p.phg;
    this.posambiguity = p.posambiguity;
    this.posresolution = p.posresolution;
    this.radiorange = p.radiorange;
    this.resultcode = p.resultcode;
    this.resultmsg = p.resultmsg;
    this.speed = p.speed;
    this.srccallsign = p.srccallsign;
    this.status = p.status;
    this.symbolcode = p.symbolcode;
    this.symboltable = p.symboltable;
    this.telemetry = p.telemetry;
    this.timestamp = p.timestamp;

    this.latlng = new L.LatLng(this.latitude, this.longitude);
  }

  getDisplayName() {
    return this.objectname || this.srccallsign;
  }

  getComment() {
    return this.comment || "";
  }

  getSymbol() {
    return `${this.symboltable}${this.symbolcode}`;
  }

  hasPosition() {
    return this.latitude && this.longitude;
  }

  isLocation() {
    return this.type === "location";
  }

  isObject() {
    return this.type === "object";
  }

  getLatLng() {
    return this.latlng;
  }

  isDifferentLocation(other) {
    if (other.lat && other.lng) {
      return this.latitude !== other.lat || this.longitude !== other.lng;
    } else if (other.latitude && other.longitude) {
      return this.latitude !== thing.latitude || this.longitude !== other.longitude
    } else {
      throw "Can't compare location to item:", other
    }
  }

  toSummary() {
    return `[${this.type}] src=${this.srccallsign} "${this.getComment()}"`;
  }
};
