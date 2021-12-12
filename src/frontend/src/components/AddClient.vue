<script setup lang="ts">
import { ref, defineProps } from "vue";
import { clientStore } from "@/store/clients";

const props = defineProps({
  id: String,
});

const clientObjectFactory = () => ({
  email: "",
  name: "",
  surname: "",
});

const clientObject = ref(clientObjectFactory());

const isOpen = ref(false);
function open() {
  isOpen.value = true;
}

const isLoading = ref(false);
async function save() {
  isLoading.value = true;

  try {
    await clientStore.addClient(props.id, clientObject.value);
    isOpen.value = false;
    clientObject.value = clientObjectFactory();
  } catch (err) {
    console.log(err);
  } finally {
    isLoading.value = false;
  }
}
</script>

<template>
  <q-btn @click="open" outline>+</q-btn>

  <q-dialog v-model="isOpen" persistent>
    <q-card class="add-client-popup">
      <q-card-section class="row items-center q-pb-none">
        <q-space />
        <q-btn icon="close" flat round dense v-close-popup />
      </q-card-section>

      <q-card-section class="q-pb-none">
        <q-input v-model="clientObject.email" label="Email" />
        <q-input v-model="clientObject.name" label="Imię" />
        <q-input v-model="clientObject.surname" label="Nazwisko" />
      </q-card-section>

      <q-card-actions>
        <q-space />
        <q-btn flat color="primary" label="Zapisz" @click="save" />
      </q-card-actions>

      <q-inner-loading :showing="isLoading">
        <q-spinner-gears size="50px" color="primary" />
      </q-inner-loading>
    </q-card>
  </q-dialog>
</template>

<style scoped lang="scss">
.add-client-popup {
  width: 900px;
  max-width: 80vw;
}
</style>
