# Frontend

Vue 3 + Vite + TypeScript SPA located at `frontend/press/`. Built into a static bundle and served by nginx inside the frontend container.

## Routing

All routes are handled client-side via Vue Router (`src/router/index.ts`).

| Path | View | Description |
|---|---|---|
| `/admin` | AdminView | User management |
| `/admin/editor` | EditorView | File editor for root content |
| `/admin/preview` | AdminPreview | Makedown preview panel |
| `/admin/images` | ImageGalleryView | Image browser/uploader |
| `/*` | RenderView | Renders any carbon page |

Admin routes require a valid JWT (managed via the user Pinia store).

## RenderView

The main public-facing view. On mount it fetches three files in parallel:
- `carbon/background.md` — rendered as a fixed fullscreen background layer
- `carbon/footer.md` — rendered below the page content
- `carbon/{route}.md` — the actual page content

Falls back to `carbon/404.md` on error. Reacts to route changes via a `watch` on the router.

## Makedown Parser

`src/library/makedown.ts` is a custom markdown parser built on a `TokenRegistry` (`src/library/TokenRegistry.ts`). It scans content with a `PrefixMatcher` and converts tokens into Vue component descriptors.

**Supported tokens:**

| Syntax | Component |
|---|---|
| `# ` `## ` `### ` ... | `makedown/h1` – `makedown/h6` |
| `- ` `* ` `+ ` | `makedown/unorderedListItem` |
| `1. ` | `makedown/orderedListItem` |
| `[x]` / `[ ]` | `makedown/checkbox` |
| `> ` | `makedown/blockquote` |
| `---` / `***` | `makedown/horizontalRule` |
| ` ``` ` | `makedown/codeBlock` |
| `![alt](url)` | `makedown/image` |
| `!![alt](url)` | `makedown/backgroundImage` (full bleed) |
| `[text](url)` | `makedown/link` |
| `<!-- -->` | `makedown/comment` |
| `<PascalCase />` | remote component (self-closing) |
| `<PascalCase>...</PascalCase>` | remote component (block, inner content passed as slot) |

PascalCase tags are the extension point — they resolve to remote Vue components fetched from `root/component/`.

## Remote Component Loading

`src/components/render/LoadComponent.vue` fetches a component by name from `/api/component/{Name}.vue` using `vue3-external-component`. Components are cached by URL in the `components` Pinia store (`src/stores/components.ts`) so each unique URL is only fetched once per session.

The `Makedown.vue` render component uses `LoadComponent` for every PascalCase token encountered in the document.

## Editor

`EditorView` allows authenticated users to browse and edit files in the root directory through the backend API. `LegendDirectory.vue` handles the file tree; `LegendMenu.vue` is the action bar. `ShowPreview.vue` wraps `Makedown` for live preview while editing.
