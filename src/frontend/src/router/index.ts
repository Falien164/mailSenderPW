import { createRouter, createWebHashHistory, RouteRecordRaw } from "vue-router";
import {
  MAIL_GROUPS,
  MAIN,
  LOGIN,
  LOGOUT,
  CLIENT_SELECT,
  CLIENTS,
} from "@/dicts/routes";
import Login from "@/views/Login.vue";
import Main from "@/views/Main.vue";
import { authenticationStore } from "@/store/authentication";

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: MAIN,
    component: Main,
  },
  {
    path: "/mail-groups",
    name: MAIL_GROUPS,
    component: () =>
      import(/* webpackChunkName: "mailGroups" */ "../views/MailGroups.vue"),
  },
  {
    path: "/sent-mails",
    name: CLIENT_SELECT,
    component: () =>
      import(/* webpackChunkName: "mailHistory" */ "../views/ClientSelect.vue"),
  },
  {
    path: "/sent-mails/:id",
    name: CLIENTS,
    component: () =>
      import(/* webpackChunkName: "mailHistory" */ "../views/Clients.vue"),
  },
  {
    path: "/login",
    name: LOGIN,
    component: Login,
  },
  {
    path: "/logout",
    name: LOGOUT,
    component: Login,
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  if (to.name === LOGOUT) {
    authenticationStore.clearToken();
  }

  const { token } = authenticationStore.getState();

  if ([LOGIN, MAIN].includes(to.name as string) || token) {
    return next();
  }

  next({ name: LOGIN });
});

export default router;
