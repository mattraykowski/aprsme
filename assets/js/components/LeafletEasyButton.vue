<template>
  <div style="display: none;">
    <slot v-if="ready"></slot>
  </div>
</template>

<script>
import { findRealParent, propsBinder } from "vue2-leaflet";
import { DomEvent } from "leaflet";
import "leaflet-easybutton";

const props = {
  options: {
    type: Object,
    default() {
      return {};
    }
  },
  html: {
    type: String,
    default() {
      return "";
    }
  },
  onClick: {
    type: Function,
    default() {
      return () => true;
    }
  }
};

export default {
  name: "LEasyButton",
  props,
  data() {
    return {
      ready: false
    };
  },

  mounted() {
    this.mapObject = L.easyButton(this.html, this.onClick);
    this.parentContainer = findRealParent(this.$parent);
    this.mapObject.addTo(this.parentContainer.mapObject);
  },
  beforeDestroy() {
    this.mapObject.removeFrom(this.parentContainer);
  }
};
</script>