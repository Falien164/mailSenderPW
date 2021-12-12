<script setup lang="ts">
import { ref, watch, defineProps, defineEmits } from "vue";

const props = defineProps({
  modelValue: String,
});
const emit = defineEmits();

const editorRef = ref(null);
const text = ref(props.modelValue);
watch(text, (now) => emit("update:modelValue", now));
const add = (variable) => {
  const edit = editorRef.value;
  edit.runCmd("insertText", `{{var:${variable}}}`);
};

const isEditorFocused = ref(false);
const focusEditor = () => (isEditorFocused.value = true);
const blurEditor = () => (isEditorFocused.value = false);
</script>

<template>
  <q-card-section class="row items-center">
    <p
      class="editor__label"
      :class="{ 'editor__label--focus': isEditorFocused }"
    >
      Treść maila
    </p>
    <q-editor
      ref="editorRef"
      v-model="text"
      label="Label"
      class="editor"
      @focus="focusEditor"
      @blur="blurEditor"
      :toolbar="[
        ['left', 'center', 'right', 'justify'],
        ['bold', 'italic', 'underline', 'strike'],
        ['undo', 'redo'],
        ['variable'],
      ]"
    >
      <template v-slot:variable>
        <q-btn-dropdown
          dense
          no-caps
          ref="tokenRef"
          no-wrap
          unelevated
          color="white"
          text-color="primary"
          label="Zmienne"
          size="sm"
        >
          <q-list dense>
            <q-item tag="label" clickable @click="add('name')">
              <q-item-section>Imie</q-item-section>
            </q-item>
            <q-item tag="label" clickable @click="add('surname')">
              <q-item-section>Nazwisko</q-item-section>
            </q-item>
          </q-list>
        </q-btn-dropdown>
      </template>
    </q-editor>
  </q-card-section>
</template>

<style scoped lang="scss">
@import "@/styles/quasar.variables.scss";

.editor {
  width: 100%;
  min-height: 10rem;

  &__label {
    color: #767676;
    font-size: 16px;
    margin: 0 0 8px;

    &--focus {
      color: $primary;
    }
  }
}
</style>
