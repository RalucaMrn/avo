<template>
  <show-field-wrapper :field="field" :index="index">
    <div v-if="value" v-text="value"/>
    <empty-dash v-else />
  </show-field-wrapper>
</template>

<script>
export default {
  props: ['field', 'index'],
  computed: {
    label() {
      return this.field.options[this.field.value]
    },
    value() {
      if (!this.field.display_value && this.field.enum) return this.field.enum[this.field.value]
      if (!this.field.display_value && this.label) return this.label

      return this.field.value
    },
  },
}
</script>
