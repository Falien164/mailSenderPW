<script setup lang="ts">
import { defineProps } from "vue";
import { mailGroupsStore } from "@/store/mail-groups";

const props = defineProps({
  id: String,
  title: String,
  description: String,
  subject: String,
  body: String,
});

async function send() {
  try {
    await mailGroupsStore.sendMail(props);
  } catch (err) {
    console.error(err);
  }
}
</script>

<template>
  <q-btn @click="send" icon="forward_to_inbox" no-caps flat dense />
</template>

<style scoped lang="scss">
.edit-mail-popup {
  width: 900px;
  max-width: 80vw;
}
</style>
