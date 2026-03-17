# OsPress — Work Tickets

Sorted by priority area. **Frontend** and **Base Component Library** come first as the primary focus.

---

## Frontend

### FE-01 · Bug: Wide files collapse the directory tree

**Status:** done
The file tree in `EditorView` collapses or is pushed out of view when a file has a lot of content (editor iteself takes a lot fo width), because the editor grows beyond its given size.

**Subtasks:**
- [x] Reproduce the issue and identify the responsible element (likely `LegendDirectory.vue` or the component based inside `EditorView.vue`)
- [x] Apply the correct tailwind styling to the object so it never colapses.
- [ ] Verify the fix works with nested directories and long paths
- [ ] Check that the rest of the editor layout is unaffected

---

### FE-02 · Editor legend redesign

**Status:** open
`LegendDirectory.vue` and `LegendMenu.vue` are functional but visually rough. Goal is a cleaner, more intuitive sidebar that makes the editing experience feel polished.

**Subtasks:**
- [ ] Audit the current legend layout and note pain points
<!-- - [ ] Add file-type indicators (e.g. icon for `.md` vs `.vue`) -->
- [ ] Improve spacing, hierarchy, and active-file highlighting
- [ ] Ensure the action bar (`LegendMenu`) actions are clearly labelled, maybe use different icons
- [ ] improve the styling on the elements in the navigation section
- [ ] Test on narrow viewports

---

### FE-03 · Separate admin navigation from site navigation

**Status:** open
Currently the public site's navigation component (`navigation/default.vue`) loads inside the admin area too. Admin pages should have their own minimal nav; the site nav should only appear on public routes.

**Subtasks:**
- [ ] Hardcode the adminnav to use a certain navigation style which we can also save in the frontend project instead, keep the size of the logo smaller and have it independent from the site navigation style

---

### FE-04 · Styling skill — AI-assisted site style generation

**Status:** open
Add a reusable skill at `docs/skills/style-website.md` that lets an AI assistant apply a consistent visual style across makedown token components and content components.

**Guidance:** A skill file is a markdown prompt template. Look at the existing skills in `docs/skills/` for format. The output of this skill should be a clear design doc which can be given to an AI as a prompt for creating the basic makedown objects based on the default ones but with styling based on this design doc.

**Subtasks:**
- [ ] Define what "a style" means in this context (fonts, colours, spacing, base token look)
- [ ] Write the skill prompt with clear instructions and expected outputs
- [ ] Test the skill on a sample style (e.g. minimalist dark theme)
- [ ] Document any Tailwind constraints or gotchas

---

## Base Component Library

### COMP-01 · RichText component — test with headers

**Status:** open
The `makedown/richText.vue` component handles inline formatting (bold, italic, highlight). It has not been verified inside header tokens (`h1`–`h3`). A header like `# Hello **world**` should render with correct inline styles.

**Subtasks:**
- [ ] Write test pages in `root/carbon/` that use bold, italic, and highlight inside h1/h2/h3 headings
- [ ] Identify whether `makedown/h1.vue` (and siblings) pass content through `richText` or render it as plain text
- [ ] Fix the rendering chain if headers bypass richtext parsing
- [ ] Visually verify on the preview panel in the editor

---

### COMP-02 · Resume component

**Status:** open
A reusable `Resume.vue` component in `root/component/` for displaying a structured résumé/CV. Should accept structured props (sections, entries) or slot content.

**Guidance:** Follow the `new-component` skill (`docs/skills/new-component.md`). Keep the data-to-markup mapping simple — props passed from markdown attributes, slot content for freeform text blocks.

**Subtasks:**
- [ ] Sketch the data shape (name, sections, entries with title/date/description)
- [ ] Create `root/component/Resume.vue` using Tailwind for layout
- [ ] Support both a compact (one-page) and expanded layout via a prop
- [ ] Add a demo page in `root/carbon/` to preview it
- [ ] Test with realistic resume content

-> task has been updated and extended this ticket should be updated to reflect that.

---

### COMP-03 · Offset / ReverseOffset layout component

**Status:** open
There are likely repeated offset-layout patterns across content pages. Extract this into a reusable `Offset.vue` (and optionally `ReverseOffset.vue`) that other remote components can load as a sub-component.

> **Note:** Validate first whether nesting remote components introduces noticeable lag or fetch overhead before committing to this approach. The concern was already flagged in Tasks.md.

**Subtasks:**
- [ ] Identify all places the offset pattern is currently used inline
- [ ] Create `root/component/Offset.vue` with a `reverse` boolean prop
- [ ] Test using `<Offset />` inside another remote component (e.g. `SideImage.vue`) and confirm caching prevents double-fetching
- [ ] Measure any render delay on first load; document findings
- [ ] Remove duplicated inline patterns if the component is adopted

---

### COMP-04 · Blog listing component

**Status:** open
A `Blog.vue` component that fetches a directory listing from a configured backend path and renders a grid of post previews (title, date, excerpt).

**Guidance:** The frontend can list files via `GET /api/<path>` which nginx serves from disk. A directory under `root/carbon/blog/` would work well. Each `.md` file is a post; the component reads its first few lines for the preview.
At the bottom of the preview there will be a read on link. which leads to the specific blog post

**Subtasks:**
- [ ] Decide on directory convention (e.g. `root/carbon/blog/*.md`) or instead i prefer -> the component can accept a param with the base slug like `blog` for `root/carbon/blog`
- [ ] Implement the directory fetch (check if nginx autoindex JSON is usable, or use the backend file list endpoint)
- [ ] Create a `BlogPreview` component which previews one blogpost
	- [ ] Parse a frontmatter-style header (e.g. first `# ` heading as title, first paragraph as excerpt) client-side
- [ ] Create `root/component/BlogOverview.vue` that renders a List of previews
	- specify in a param how many of the posts it should load (newest? / alphabetical)
- [ ] Create a demo blog page and a few sample posts
	- Overview on /blog
	- Blogposts on /blog/post1 etc

-> can put a dateformat in the name so its easy to sort on newest.

---

## Infra

### INFRA-01 · Automatic secrets setup for deployment

**Status:** open
Currently `backend/config.json` requires manual edits for `PG_KEY`, `jwt_secret`, username, and password before the stack can run. This friction makes first-time deploys error-prone.

**Subtasks:**
- [ ] Create a `setup.sh` (or Makefile target) that prompts for credentials and writes `config.json` and a `.env` file
- [ ] Document the secret variables in a `.env.example`
- [ ] Optionally support Docker secrets or environment-variable overrides so `config.json` need not be committed
- [ ] Update the README with the new setup flow

---

### INFRA-02 · Streamlined project setup

**Status:** open
Getting the project running from a fresh clone should be a one-command experience. Currently there are manual steps around config files, the Docker network, and initial content.

**Subtasks:**
- [ ] List all steps currently needed to go from clone to running site
- [ ] Automate as many as possible in a setup script (builds on INFRA-01)
- [ ] Seed a minimal `root/` with working pages and components so the site is not blank on first run
- [ ] Add a `README.md` quickstart section that covers prerequisites, setup, and first login

---

## Site Specific

### SITE-01 · Website: svfarra.com

**Status:** open
Build the site content for svfarra.com using OsPress pages and components.

**Subtasks:**
- [ ] Define the site structure (pages, navigation)
- [ ] Create pages in `root/carbon/` for this site's deployment
- [ ] Style and configure the navigation component
- [ ] Deploy and verify

---

### SITE-02 · Website: indented.dev

**Status:** open
Build the site content for indented.dev.

**Subtasks:**
- [ ] About / introduction section
- [ ] Sailing section
- [ ] Projects / blog section (can reuse the Blog component from COMP-04 once ready)
- [ ] Set up navigation for all sections
- [ ] Deploy and verify

---

## Long Term

### LT-01 · Inline GUI editor for components

**Status:** idea
A system where content components expose editable fields that can be manipulated directly in the editor UI — clicking a component in the preview opens a properties panel for its props without editing raw markdown.

**Guidance:** This is a significant architectural addition. Key questions to answer before starting:
- How does a component declare its editable props? (a manifest file? a special export?)
- How does the editor know which component is selected in the preview?
- How are prop changes written back to the markdown source?

**Subtasks (planning phase):**
- [ ] Research how `vue3-external-component` exposes component metadata
- [ ] Design the prop-declaration convention (e.g. a `defineExpose({ editableProps })` pattern)
- [ ] Prototype a simple property panel for one component (e.g. `WordArt`)
- [ ] Evaluate performance and complexity before committing to a full implementation

