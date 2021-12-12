<script setup lang="ts">
import { ref, defineProps } from "vue";
import { mailGroupsStore } from "@/store/mail-groups";

const props = defineProps({
  id: String,
  title: String,
  description: String,
  subject: String,
  body: String,
});

const isOpen = ref(false);
function open() {
  isOpen.value = true;
}

const isLoading = ref(false);
async function remove() {
  isLoading.value = true;

  try {
    await mailGroupsStore.removeMailCampaign(props);
    isOpen.value = false;
  } catch (err) {
    console.error(err);
  } finally {
    isLoading.value = false;
  }
}
</script>

<template>
  <q-btn @click="open" icon="delete" no-caps flat dense />

  <q-dialog v-model="isOpen" persistent>
    <q-card class="remove-mail-popup">
      <q-card-section>
        Czy jesteś pewien, że chcesz usunąć tą kampanię mailową?
      </q-card-section>
      <q-card-actions>
        <q-space />
        <q-btn flat color="negative" label="usuń" @click="remove" />
        <q-btn flat color="dark" label="anuluj" @click="isOpen = false" />
      </q-card-actions>

      <q-inner-loading :showing="isLoading">
        <q-spinner-gears size="50px" color="primary" />
      </q-inner-loading>
    </q-card>
  </q-dialog>
</template>

<style scoped lang="scss">
.remove-mail-popup {
  width: 600px;
  max-width: 80vw;
}
</style>
