<template>
  <q-layout view="hHh Lpr lff" container style="height: 100vh" class="shadow-2">
    <q-header elevated class="bg-black">
      <q-toolbar>
        <q-btn flat @click="drawer = !drawer" round dense icon="menu" />
        <q-toolbar-title>
          <q-btn flat :to="{ name: MAIN }">Mail Sender</q-btn>
        </q-toolbar-title>
      </q-toolbar>
    </q-header>

    <q-drawer
      v-model="drawer"
      show-if-above
      :width="200"
      :breakpoint="500"
      bordered
      class="bg-grey-3"
    >
      <q-scroll-area class="fit">
        <q-list>
          <template v-for="(menuItem, index) in menuList" :key="index">
            <q-item
              v-if="menuItem.show()"
              clickable
              :active="menuItem.label === 'Outbox'"
              :to="{ name: menuItem.route }"
              v-ripple
            >
              <q-item-section avatar>
                <q-icon :name="menuItem.icon" />
              </q-item-section>
              <q-item-section>
                {{ menuItem.label }}
              </q-item-section>
            </q-item>
            <q-separator v-if="menuItem.separator" />
          </template>
        </q-list>
      </q-scroll-area>
    </q-drawer>

    <q-page-container>
      <q-page>
        <suspense>
          <router-view />
        </suspense>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script setup lang="ts">
import { ref } from "vue";
import {
  MAIN,
  MAIL_GROUPS,
  LOGIN,
  CLIENT_SELECT,
  LOGOUT,
} from "@/dicts/routes";
import { authenticationStore } from "./store/authentication";

const menuList = [
  {
    icon: "login",
    label: "Login",
    route: LOGIN,
    separator: true,
    show: () => !authenticationStore.getState().token,
  },
  {
    icon: "logout",
    label: "Logout",
    route: LOGOUT,
    separator: true,
    show: () => !!authenticationStore.getState().token,
  },
  {
    icon: "home",
    label: "Strona Główna",
    route: MAIN,
    show: () => !!authenticationStore.getState().token,
  },
  {
    icon: "forward_to_inbox",
    label: "Grupy Mailowe",
    route: MAIL_GROUPS,
    separator: false,
    show: () => !!authenticationStore.getState().token,
  },
  {
    icon: "person",
    label: "Lista klientów",
    route: CLIENT_SELECT,
    separator: false,
    show: () => !!authenticationStore.getState().token,
  },
];

const drawer = ref(false);
</script>
