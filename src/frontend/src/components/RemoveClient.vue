<script setup lang="ts">
import { ref, defineProps } from "vue";
import { clientStore } from "@/store/clients";
import { clientItem } from "@/types/clients";

const props = defineProps({
  id: String,
  client: clientItem,
});

const isOpen = ref(false);
function open() {
  isOpen.value = true;
}

const isLoading = ref(false);
async function remove() {
  isLoading.value = true;

  try {
    await clientStore.removeClient(props.id, props.client);
    isOpen.value = false;
  } catch (err) {
    console.log(err);
  } finally {
    isLoading.value = false;
  }
}
</script>

<template>
  <q-btn @click="open" icon="delete" no-caps flat dense />

  <q-dialog v-model="isOpen" persistent>
    <q-card class="remove-client-popup">
      <q-card-section>
        Czy jesteś pewien, że chcesz usunąć tego klienta?
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
.remove-client-popup {
  width: 600px;
  max-width: 80vw;
}
</style>
