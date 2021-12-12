<script setup lang="ts">
import { ref } from "vue";
import EditMailGroup from "@/components/EditMailGroup";
import RemoveMailGroup from "@/components/RemoveMailGroup";
import SendMail from "@/components/SendMail";

import { mailGroupItem } from "@/types/mail-groups";
import { mailGroupsStore } from "@/store/mail-groups";
import { mailGroupTable } from "@/utils/tables";

const initialPagination = {
  rowsPerPage: 15,
};

const filter = ref("");
const loading = ref(true);
const rows: mailGroupItem[] = ref([]);

mailGroupsStore
  .retrieveMailCampaigns()
  .then((mailGroupItems: mailGroupItem[]) => {
    rows.value = mailGroupItems;
    loading.value = false;
  });
</script>

<template>
  <q-page class="row justify-center">
    <q-table
      class="q-my-md"
      spac
      title="Grupy Mailowe"
      :rows="rows"
      :columns="mailGroupTable"
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
        <EditMailGroup />
      </template>

      <template #body-cell-actions="{ row }">
        <q-td>
          <EditMailGroup
            :id="row.id"
            :title="row.title"
            :description="row.description"
            :subject="row.subject"
            :body="row.body"
          />
          <SendMail
            :id="row.id"
            :title="row.title"
            :description="row.description"
            :subject="row.subject"
            :body="row.body"
          />
          <RemoveMailGroup
            :id="row.id"
            :title="row.title"
            :description="row.description"
            :subject="row.subject"
            :body="row.body"
          />
        </q-td>
      </template>
    </q-table>
  </q-page>
</template>
