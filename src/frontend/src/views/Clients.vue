<script setup lang="ts">
import { ref } from "vue";
import { useRoute } from "vue-router";
import AddClient from "@/components/AddClient";
import RemoveClient from "@/components/RemoveClient";

import { clientItem } from "@/types/clients";
import { clientStore } from "@/store/clients";
import { clientTable } from "@/utils/tables";

const route = useRoute();

const initialPagination = {
  rowsPerPage: 15,
};

const filter = ref("");
const loading = ref(true);
const rows: clientItem[] = ref([]);
const mailGroupId: string = route.params.id;
const mailSent: string[] = ref([]);

clientStore.retrieveMails(mailGroupId).then((data) => {
  mailSent.value = data;

  clientStore.retrieveClients(mailGroupId).then((clientItems: clientItem[]) => {
    rows.value = clientItems;
    loading.value = false;
  });
});
</script>

<template>
  <q-page class="row justify-center">
    <q-table
      class="q-my-md"
      spac
      title="Klienci"
      :rows="rows"
      :columns="clientTable"
      :filter="filter"
      :loading="loading"
      row-key="id"
      :pagination="initialPagination"
    >
      <template v-slot:top-right>
        <q-input
          class="q-mr-sm"
          borderless
          dense
          debounce="300"
          v-model="filter"
          placeholder="Search"
        >
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
        <AddClient :id="mailGroupId" />
      </template>

      <template #body-cell-actions="{ row }">
        <q-td>
          <RemoveClient :id="mailGroupId" :client="row" />
        </q-td>
      </template>
      <template #body-cell-sent="{ row }">
        <q-td>
          <q-checkbox disable :modelValue="mailSent.includes(row.id)" />
        </q-td>
      </template>
    </q-table>
  </q-page>
</template>
