<template>
  <p>{{ hello }}</p>
</template>

<script setup lang="ts">
import { ref, defineProps } from "vue";

const props = defineProps({
  name: String,
});
console.log(props.name);
const hello = ref(`hello from ${props.name} component`);
</script>
