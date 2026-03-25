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

## Links inside components

For links that point to other pages on the same site, always use `<router-link :to="...">` instead of `<a :href="...">`. This keeps navigation client-side (no full page reload) and makes the site feel instant, matching how the navbar works.

For external links, use a plain `<a>` tag with `target="_blank" rel="noopener noreferrer"`.

When a component can receive either internal or external URLs as a prop, use a computed property to decide:

```vue
<template>
  <router-link v-if="isInternal" :to="href">...</router-link>
  <a v-else :href="href" target="_blank" rel="noopener noreferrer">...</a>
</template>

<script setup>
import { computed } from 'vue';
const props = defineProps({ href: { type: String, required: true } });
const isInternal = computed(() => props.href.startsWith('/'));
</script>
```

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

### Full-bleed layout

`FullBleed` is a remote layout utility that breaks out of the page margin set by `RenderView` (the left padding applied to all page content). Use it when a component needs to span the full viewport width.

```vue
<template>
  <LoadComponent _component="FullBleed">
    <div class="bg-stone-100 p-4">
      <!-- content here spans full width -->
    </div>
  </LoadComponent>
</template>
```

Do not write the negative-margin escape classes (`w-screen -ml-3rem md:-ml-6rem ...`) directly in a component — use `FullBleed` instead so there is one source of truth.

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
