<script setup lang="ts">
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useQuasar } from "quasar";
import { mailGroupsStore } from "@/store/mail-groups";
import { mailGroupItem } from "@/types/mail-groups";
import { CLIENTS } from "@/dicts/routes";

const $q = useQuasar();
const router = useRouter();

const selectedItem = ref(null);
const loading = ref(true);

const options = ref([]);

mailGroupsStore
  .retrieveMailCampaigns()
  .then((mailGroupItems: mailGroupItem[]) => {
    options.value = mailGroupItems.map((item) => ({
      label: item.title,
      value: item,
    }));
    loading.value = false;
  });

async function onSubmit() {
  if (!selectedItem?.value) {
    $q.notify({
      type: "negative",
      message: "Brak wybranej grupy mailowej",
      position: "top-right",
    });
  }
  router.push({
    name: CLIENTS,
    params: { id: selectedItem.value.value.id },
  });
}
</script>

<template>
  <q-page class="row justify-center items-center">
    <div class="row">
      <q-card square bordered class="q-pa-lg shadow-1">
        <q-card-section>
          <q-select
            v-model="selectedItem"
            label="Wybierz grupę mailową"
            :options="options"
          />
        </q-card-section>
        <q-card-actions class="q-px-md">
          <q-btn
            class="full-width"
            label="Pokaż listę klientów"
            unelevated
            color="primary"
            size="lg"
            @click="onSubmit"
          />
        </q-card-actions>

        <q-inner-loading :showing="loading">
          <q-spinner-gears size="50px" color="primary" />
        </q-inner-loading>
      </q-card>
    </div>
  </q-page>
</template>
