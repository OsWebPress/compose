# Skill: New Component

Create a new remote Vue component in `root/component/`. These components are fetched by the client at runtime and can be used in any markdown page with a PascalCase tag.

## Steps

1. Create `root/component/ComponentName.vue`
2. Use Options API (`export default { name, props, ... }`) or Composition API (`<script setup>`)
3. Define props for everything the markdown author needs to pass in
4. Use Tailwind classes for all styling — no scoped CSS needed
5. The component name used in markdown must match the filename exactly (case-sensitive)

## Template

```vue
<template>
  <!-- component markup with Tailwind -->
</template>

<script>
export default {
  name: 'ComponentName',

  props: {
    exampleProp: {
      type: String,
      required: true,
    },
  },
}
</script>
```

Or with Composition API:

```vue
<template>
  <!-- component markup -->
</template>

<script setup>
const props = defineProps({
  exampleProp: {
    type: String,
    required: true,
  },
})
</script>
```

## Usage in Markdown

Self-closing (no inner content):
```
<ComponentName exampleProp="hello" />
```

Block form (inner content passed as a slot):
```
<ComponentName exampleProp="hello">
Some inner content here
</ComponentName>
```

## Notes

- Props are parsed from tag attributes as strings. Cast to numbers/booleans inside the component if needed.
- Components are cached in the browser session after first load — a hard refresh is needed to pick up changes during development.
- Do not put components in `component/makedown/` — that subdirectory is reserved for makedown token renderers.
- If the component needs images, reference them as `/api/images/filename.jpg`.
- The props.body field is populated with the component slot as string.
