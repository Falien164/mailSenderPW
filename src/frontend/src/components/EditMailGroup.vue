<script setup lang="ts">
import { ref, defineProps } from "vue";
import { mailGroupsStore } from "@/store/mail-groups";
import Editor from "@/components/Editor";

const props = defineProps({
  id: String,
  title: String,
  description: String,
  subject: String,
  body: String,
});

const mailObjectFactory = () => ({
  id: props.id || "",
  title: props.title || "",
  description: props.description || "",
  subject: props.subject || "",
  body: props.body || "",
});

const mailObject = ref(mailObjectFactory());

const isOpen = ref(false);
function open() {
  isOpen.value = true;
}

const isLoading = ref(false);
async function save() {
  isLoading.value = true;
  const method = props.id ? "editMailCampaign" : "addMailCampaign";

  try {
    await mailGroupsStore[method](mailObject.value);
    isOpen.value = false;
    mailObject.value = mailObjectFactory();
  } catch (err) {
    console.log(err);
  } finally {
    isLoading.value = false;
  }
}
</script>

<template>
  <q-btn v-if="id" @click="open" icon="edit" no-caps flat dense />
  <q-btn v-else @click="open" outline>+</q-btn>

  <q-dialog v-model="isOpen" persistent>
    <q-card class="edit-mail-popup">
      <q-card-section class="row items-center q-pb-none">
        <q-space />
        <q-btn icon="close" flat round dense v-close-popup />
      </q-card-section>

      <q-card-section class="q-pb-none">
        <q-input v-model="mailObject.title" label="Nazwa kampani" />
        <q-input v-model="mailObject.description" label="Opis kampani" />
        <q-input v-model="mailObject.subject" label="Tytuł maila" />
      </q-card-section>

      <Editor v-model="mailObject.body" />

      <q-card-actions>
        <q-space />
        <q-btn
          flat
          color="primary"
          :label="id ? 'Zapisz' : 'Utwórz'"
          @click="save"
        />
      </q-card-actions>

      <q-inner-loading :showing="isLoading">
        <q-spinner-gears size="50px" color="primary" />
      </q-inner-loading>
    </q-card>
  </q-dialog>
</template>

<style scoped lang="scss">
.edit-mail-popup {
  width: 900px;
  max-width: 80vw;
}
</style>
