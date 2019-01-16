<script>
export default {
  data() {
    return {
      message: "Hello World!"
    };
  }
}
</script>

<template>
<div class="hello">
  <p>Hello component</p>
  <p>Message: {{ message }}</p>
</div>
</template>

<style>
.hello {
  border: 1px dashed red;
}
</style>