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

## Using other remote components inside a remote component

`LoadComponent` and `Makedown` are registered globally in the app, so they are available in any remote component's template without importing.

### Loading another remote component

Use `<LoadComponent>` to render any other remote component by path. Props are passed through normally:

```vue
<template>
  <div>
    <LoadComponent _component="makedown/richText" :body="someText" />
    <LoadComponent _component="MyOtherComponent" title="Hello" />
  </div>
</template>
```

The `_component` value is the path under `root/component/` without the `.vue` extension. `LoadComponent` fetches and caches the component asynchronously — it renders nothing until the remote component is loaded.

Props other than `_component` fall through to the loaded component via `$attrs`, so they are received as normal props by the inner component.

### Rendering markdown content

Use `<Makedown>` to parse and render a string of makedown content, including all registered tokens and Vue component tags:

```vue
<template>
  <div>
    <Makedown :content="markdownString" />
  </div>
</template>
```

This is useful when a component holds a body of text that should support headings, lists, inline formatting, and embedded components — for example a card component whose content comes from a prop.
