<script setup lang="ts">
import { ref } from "vue";
import { useRouter } from "vue-router";
import { authenticationStore } from "@/store/authentication";
import { MAIN } from "@/dicts/routes";
import * as rules from "@/utils/rules";

const credentialsBoilerplate = {
  email: "",
  password: "",
  confirmPassword: "",
};

const router = useRouter();

(function onBeforeRouteEnter() {
  const { token } = authenticationStore.getState();

  if (token) {
    router.push({ name: MAIN });
  }
})();

const formRef = ref(null);
const isRegister = ref(false);
const credentials = ref({ ...credentialsBoilerplate });

function changeIsRegister() {
  isRegister.value = !isRegister.value;

  credentials.value = { ...credentialsBoilerplate };
}

async function onSubmit() {
  if (!(await formRef.value.validate())) {
    return;
  }

  const { email, password } = credentials.value;

  const method = isRegister.value ? "register" : "authenticate";

  authenticationStore[method](email, password).then((isAuthenticated) => {
    if (isAuthenticated) {
      router.push({ name: MAIN });
    }
  });
}
</script>

<template>
  <q-page class="row justify-center items-center">
    <div class="row">
      <q-card square bordered class="q-pa-lg bg-blue-1 shadow-1">
        <q-card-section>
          <q-form ref="formRef" class="q-gutter-md">
            <q-input
              v-model="credentials.email"
              type="email"
              label="email"
              :rules="[rules.isEmpty(), rules.isEmail()]"
              square
              filled
              clearable
            />
            <q-input
              v-model="credentials.password"
              type="password"
              label="hasło"
              :rules="[
                rules.isEmpty(),
                rules.isValidPassword(credentials.password),
              ]"
              square
              filled
              clearable
            />
            <q-input
              v-if="isRegister"
              v-model="credentials.confirmPassword"
              type="password"
              label="potwierdź hasło"
              :rules="[rules.isEmpty(), rules.isSame(credentials.password)]"
              square
              filled
              clearable
            />
          </q-form>
        </q-card-section>
        <q-card-actions class="q-px-md">
          <q-btn
            class="full-width"
            :label="isRegister ? 'Zarejestruj' : 'Zaloguj'"
            unelevated
            color="primary"
            size="lg"
            @click="onSubmit"
          />
        </q-card-actions>
        <q-card-section class="text-center q-pa-none">
          <p
            v-if="isRegister"
            class="text-grey-6 cursor-pointer"
            @click="changeIsRegister"
          >
            Posiadasz już konto? Zaloguj się
          </p>
          <p
            v-else
            class="text-grey-6 cursor-pointer"
            @click="changeIsRegister"
          >
            Nie posiadasz konta? Zarejestruj się
          </p>
        </q-card-section>
      </q-card>
    </div>
  </q-page>
</template>

<style scoped>
.q-card {
  width: 360px;
}
</style>
