# Oswin's Website — Plan

A personal site for Oswin. Informal tone, first-name basis. Two main content streams: tech writing and sailing. Plus a section documenting the OsPress builder itself.

---

## Site Structure

### Pages

| URL | File | Description |
|---|---|---|
| `/` | `carbon/.md` | Homepage |
| `/blog` | `carbon/blog.md` | Tech blog overview |
| `/blog/[date]-[slug]` | `carbon/blog/*.md` | Individual tech posts |
| `/sailing` | `carbon/sailing.md` | Sailing logbook overview |
| `/sailing/[date]-[slug]` | `carbon/sailing/*.md` | Individual sailing posts |
| `/builder` | `carbon/builder.md` | OsPress overview (medium length) |
| `/builder/docs` | `carbon/builder/docs.md` | Docs index (hardcoded links) |
| `/builder/docs/components` | `carbon/builder/docs/components.md` | Component creation guide (in-depth) |
| `/builder/docs/rendering` | `carbon/builder/docs/rendering.md` | Rendering & page adding guide (in-depth) |
| `/builder/docs/markdown` | `carbon/builder/docs/markdown.md` | Supported markdown tokens reference |

### Special pages (loaded on every route)

| File | Role |
|---|---|
| `carbon/background.md` | Fixed fullscreen background layer |
| `carbon/footer.md` | Footer rendered below every page |
| `carbon/404.md` | Fallback for missing pages |

---

## Homepage (`/`)

Two sections, short and informal:

1. **About Oswin** — a half-page-or-less intro. Who he is, what he's into. Photo placeholder (to be added later).
2. **About this site / builder** — short section teasing OsPress: what it is, why it exists, links to `/builder` for more.

Nav text: "Home" (logo to be added later).

No socials. CV page to be added in a later phase (probably `/cv`).

---

## Blog (`/blog`)

Tech writing. Not project-only — general tech thoughts welcome too.

- `/blog` — overview page using `<BlogOverview />` to list posts
- Posts live at `/blog/[date]-[slug]`, e.g. `/blog/2026-03-21-my-first-post`
- Files: `carbon/blog/YYYY-MM-DD-slug.md`

---

## Sailing (`/sailing`)

Logbook-style sailing blog. Selective — bigger adventures and thoughts only, not a full diary.

- `/sailing` — overview page using `<BlogOverview />` to list posts
- Posts live at `/sailing/[date]-[slug]`
- Files: `carbon/sailing/YYYY-MM-DD-slug.md`

---

## Builder section (`/builder`)

Documents the OsPress builder itself.

### `/builder`
Medium-length page. What OsPress is, why it was built, how it works at a high level. Links to the docs sub-pages.

### `/builder/docs`
Docs index — hardcoded list of doc pages with a short description each. Not auto-generated. New entries added manually when a new doc page is created.

### `/builder/docs/components`
In-depth guide: how to create a remote Vue component, props, Tailwind usage, self-closing vs block form in markdown.

### `/builder/docs/rendering`
In-depth guide: how the makedown parser works, how pages are loaded, how to add a new page, background/footer/404 conventions.

### `/builder/docs/markdown`
Reference page: lists all supported makedown tokens with syntax examples. Covers headings, lists, blockquotes, code blocks, images, links, horizontal rules, checkboxes, and PascalCase component tags.

---

## Navigation

| Label | URL |
|---|---|
| Home | `/` |
| Blog | `/blog` |
| Sailing | `/sailing` |
| Builder | `/builder` |

No socials link. CV to be added later.

---

## Cleanup tasks

### Pages to delete

- `carbon/our-story.md`
- `carbon/farra.md`
- `carbon/crew.md`
- `carbon/socials.md`
- `carbon/social.md`
- `carbon/photography.md`
- `carbon/blog/2026-03-01-hello-world.md`
- `carbon/blog/2026-03-10-behind-the-scenes.md`
- `carbon/blog/2026-03-17-whats-next.md`
- `carbon/.md` — to be replaced with Oswin's homepage content
- `carbon/footer.md` — to be replaced
- `carbon/background.md` — to be replaced
- `root/navigation/navigation.json` — to be updated

### Images — reorganise

**Move to `root/images/farra/`** (Pascal & Dianda's photos, free to use but not in active use):

- `boat.jpg`, `bridge.jpg`, `church leuven.jpg`, `horses wallpaper.jpg`, `horses.jpg`, `molen.jpg`, `salzburg.jpg`, `shroom.jpg`, `IMG_0428.jpeg`, `farra-1-3-scaled.jpg`, `farra-logo.png`, `dianda-pascal.jpg`, `pascal-dianda-rotsen.jpg`, `dianda.jpg`, `pascal.jpeg`, `kaya.jpg`

**Keep in place:**

- `root/images/bauhaus/` — Oswin's own SVG experiments, keep and expand

**To be added later:**

- Photo of Oswin (for homepage about section)
- Site logo

---

## Components — what stays

All existing components are worth keeping as building blocks. None need to be deleted.

| Component | Likely use |
|---|---|
| `BlogOverview.vue` | `/blog` and `/sailing` listing pages |
| `BlogPreview.vue` | Used inside BlogOverview |
| `ContentCard.vue` | Flexible content blocks |
| `Section.vue` | Coloured/padded page sections |
| `SideImage.vue` | Text + image layouts |
| `WordArt.vue` | Styled display text |
| `MagicGrid.vue`, `ImageGrid.vue` | Image or card grids |
| `FullBleed.vue` | Full-width sections |
| `CountDown.vue` | Not planned — keep for now |
| `info.vue`, `popOut.vue`, `yellow.vue`, `meta.vue`, `youtube.vue` | Keep as utilities |

---

## Styling

The visual language is fully defined in [`root/style-guide.md`](root/style-guide.md). Reference that document whenever creating or restyling any component.

**Summary:**
- Palette: `sky-100` page background, `amber-100` sand for nav and sections, `stone-700/800` warm brown text, `sky-500` ocean blue accents, `amber-500` warm amber highlights
- Fonts: Josefin Sans (headings), Inter (body), JetBrains Mono (code) — loaded via Google Fonts in the frontend `index.html`
- Components follow named archetypes (Card, Callout, Layout wrapper, etc.) defined in the style guide — any new component picks its archetype rather than inventing its own style

---

## Open / deferred

- Style guide (colours, fonts, general vibe) — to be done via `/style-guide` once overall direction is clearer
- CV page (`/cv`) — future phase
- Site logo — future phase
- Oswin photo for homepage — future phase

---

## Build order (suggested)

1. Cleanup — delete old pages, reorganise images, update nav
2. Homepage — about section + builder teaser (no photo yet)
3. `/blog` overview page
4. `/sailing` overview page
5. `/builder` + `/builder/docs` index
6. `/builder/docs/components`, `/builder/docs/rendering`, `/builder/docs/markdown`
7. First real blog post and first sailing post (to test the flow)
8. Style pass once content shape is clear

