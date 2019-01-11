<template>
  <button
    type="button"
    class="action"
    @click="$emit('click', $event)"
    :disabled="disabled"
  >{{title}}</button>
</template>

<script>
export default {
  name: "Action",
  props: ["title", "disabled"]
};
</script>

<style>
.action + .action {
  margin-left: 10px;
}
</style>
