<template>
  <edit-field-wrapper :field="field" :errors="errors" :index="index" :displayed-in="displayedIn">
    <div v-if="searchable">
      <resources-search :resource-name="field.id"
        ref="field-input"
        :via-resource-name="resourceName"
        :single="true"
        :search-value="field.model"
        :value="selectedValue"
        @select="select"
        :field-id="field.id"
      />
    </div>
    <div v-else>
      <select :name="field.id"
        ref="field-input"
        :id="field.id"
        :class="inputClasses"
        class="select-input w-full"
        v-model="selectedValue"
      >
        <option value="" v-text="placeholder"></option>
        <option v-for="option in options"
          :key="option.value"
          :value="option.value"
          v-text="option.label"
          ></option>
      </select>
    </div>
    <template #extra>
      <div v-if="searchable">
        <a-button color="indigo"
          @click="removeSelection"
        >Remove selection</a-button>
      </div>
    </template>
  </edit-field-wrapper>
</template>

<script>
import { HasInputAppearance, IsFormField } from '@avo-hq/avo-js'
import Bus from '@/js/Bus'

export default {
  mixins: [IsFormField, HasInputAppearance],
  data: () => ({
    options: [],
    value: {},
    selectedValue: '',
    isLoading: false,
  }),
  props: ['resourceName', 'field'],
  computed: {
    searchable() {
      return this.field.searchable
    },
    placeholder() {
      if (this.field.placeholder) return this.field.placeholder

      return `Choose ${this.field.id}`
    },
  },
  methods: {
    select(resource) {
      this.selectedValue = resource.id
    },
    getValue() {
      return this.selectedValue
    },
    removeSelection() {
      this.selectedValue = {}
      Bus.$emit(`clearSearchSelection${this.field.id}`)
    },
  },
  mounted() {
    this.options = this.field.options
    if (this.field.database_value) this.selectedValue = this.field.database_value
  },
}
</script>
