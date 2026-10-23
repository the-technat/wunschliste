<template>
  <Menu ref="menu" :pt="style">
    <template #item="{ item, props }">
      <a class="flex items-center justify-between" v-bind="props.action">
        <IconLabel :iconPath="item.icon" :label="item.label" />
        <span
          v-if="item.keyboardShortcut"
          class="ml-4 rounded-sm bg-theme-background-elevated px-3 py-1 text-xs"
          >{{ item.keyboardShortcut }}</span
        >
      </a>
    </template>
  </Menu>
</template>
<script setup>
import Menu from "primevue/menu";
import { ref } from "vue";

import IconLabel from "./IconLabel.vue";

const menu = ref();

const style = {
  root: "border p-1 rounded-sm border-theme-border bg-theme-background",
  item: ({ context }) => ({
    class: [
      "text-theme-text-muted rounded-sm px-2 py-1",
      "hover:bg-theme-background-elevated hover:cursor-pointer",
      {
        "bg-theme-background-elevated": context.focused,
      },
    ],
  }),
  separator: "border-t border-theme-border my-2",
};

function toggle(event) {
  menu.value.toggle(event);
}

defineExpose({ toggle });
</script>
