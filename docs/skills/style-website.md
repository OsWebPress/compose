# Skill: Style Website

Generate a comprehensive style guide for this OsPress site. The output is a markdown file saved at `root/style-guide.md` that defines the visual language for all makedown token components and content components. This file becomes the source of truth for any AI that later reskins those components.

## Your job

Work through the checklist below with the user. For each item, either ask the user directly or — if they have already provided enough context — make a reasonable design decision yourself and note it. Once all items are resolved, produce `root/style-guide.md` using the output template at the bottom of this skill.

---

## Style Checklist

Go through every section. Mark each item as decided before writing the output doc.

### 1. Design Mood & Direction
- [ ] What is the overall feeling? (e.g. minimal, editorial, brutalist, soft/friendly, technical, luxury, playful)
- [ ] Any reference sites or visual inspirations?
- [ ] Light theme, dark theme, or both?
- [ ] Should the design feel static/calm or dynamic/lively?

### 2. Colour Palette
- [ ] Primary colour (dominant brand colour — used for headings, accents, CTAs)
- [ ] Secondary colour (supporting accent — used for highlights, borders, hover states)
- [ ] Background colour(s) — page background, card backgrounds, code backgrounds
- [ ] Text colour(s) — body text, muted text, inverted text
- [ ] Semantic colours — link default, link hover, success, warning, danger
- [ ] Are semi-transparent overlays needed? (e.g. `bg-black/25` style)

### 3. Typography
- [ ] Primary typeface — headings (serif, sans-serif, monospace, display?)
- [ ] Secondary typeface — body text (can be the same)
- [ ] Monospace typeface — code / highlight tokens
- [ ] Base font size and line height for body text
- [ ] Heading scale: how large should h1 be? How does it step down to h6?
- [ ] Heading weight and letter-spacing style (tight tracking, wide tracking, normal?)
- [ ] Should body text be light, regular, or medium weight?

### 4. Spacing & Layout
- [ ] Base spacing unit (Tailwind defaults to 4px — keep or customise?)
- [ ] Page content max-width and horizontal padding
- [ ] Vertical rhythm — how much space between paragraphs? Between sections?
- [ ] Should headings have visible top margin to separate sections?

### 5. Navigation Bar
- [ ] Does the site have a top navigation bar? (or is it a component to be built later?)
- [ ] Nav bar background — solid colour, transparent, blurred glass, gradient?
- [ ] Nav bar height and padding
- [ ] Link style in nav — underline, pill, plain text, icon+text?
- [ ] Active / current-page indicator style
- [ ] Should it be sticky / fixed on scroll?
- [ ] Mobile behaviour — hamburger menu, drawer, collapse to icons?
- [ ] Logo/wordmark placement — left, centre, or none?

### 6. Makedown Token Components
For each token below, decide: colour overrides (if any), size, weight, spacing, and any decorative treatment.

- [ ] **h1** — size, weight, colour, margin-bottom, any underline or border?
- [ ] **h2** — same fields
- [ ] **h3 / h4 / h5 / h6** — can share a pattern (e.g. progressively smaller + lighter)
- [ ] **paragraph text** — colour, size, line-height, max-width for readability
- [ ] **bold** — same colour as text, or accent colour?
- [ ] **italic** — colour, any opacity change?
- [ ] **highlight / inline code** — background chip colour, text colour, border radius
- [ ] **codeBlock** — multi-line fenced code block; background colour, text colour, border radius, padding, scrollable overflow
- [ ] **link** — colour, underline style, hover treatment
- [ ] **blockquote** — left border colour + width, background, text style (italic?)
- [ ] **horizontal rule** — colour, thickness, margin
- [ ] **unordered list item** — bullet style/colour, indent
- [ ] **ordered list item** — number style/colour, indent
- [ ] **checkbox** — checked/unchecked colours, label style

### 7. Image Tokens
- [ ] **image** — rounded corners? Shadow? Max-width constraint?
- [ ] **backgroundImage** — overlay colour/opacity for text legibility?

### 8. Content Component Archetypes

Rather than listing every component by name, define visual archetypes. Any component (existing or future) that shares a pattern inherits its tokens. When creating or restyling a component, identify which archetype it belongs to and apply accordingly.

- [ ] **Card** — components with their own contained background, border, and shadow (e.g. ContentCard, BlogPreview). Decide: background colour, border style/colour, border radius, shadow depth, inner padding.
- [ ] **Callout** — components that draw attention with an accent treatment (e.g. Info, PopOut, blockquote-like wrappers). Decide: accent colour/position (left border, top strip, full background tint), shadow, background tint.
- [ ] **Layout wrapper** — full-width or section-level containers that set a background zone (e.g. Section, FullBleed). Decide: available background options, how they interact with the page background, padding above/below content.
- [ ] **Media grid** — components that arrange images or cards in a grid layout (e.g. ImageGrid, MagicGrid). Decide: gap, border radius on items, hover effect (scale, shadow, overlay).
- [ ] **Content + image** — components that pair text with a visual side by side (e.g. SideImage). Decide: proportions, gap, whether background is transparent or tinted.
- [ ] **Listing / feed** — components that render a list of posts or items (e.g. BlogOverview, BlogPreview). Decide: item card style (inherits Card archetype?), date/tag colour and size, spacing between items.
- [ ] **Display text** — components for decorative or hero-level text (e.g. WordArt). Decide: gradient or solid colour treatment, size scale relative to h1, weight.
- [ ] **Data / widget** — components that show live or structured data (e.g. CountDown). Decide: digit colour, label colour, container style (inherits Card or is borderless?).

### 9. Global Tokens (Tailwind Constraints)
- [ ] Are custom Tailwind colours needed, or will default palette suffice?
- [ ] Any utility classes that should be avoided or standardised across components?
- [ ] Is UnoCSS runtime being used? (affects which features are safe to use — avoid JIT-only features like arbitrary values if UnoCSS support is uncertain)

---

## Output

Once all checklist items are decided, create the file `root/style-guide.md` using the structure below. Fill every section with concrete values — no placeholders. This file will be read by an AI to rewrite component Tailwind classes, so it must be specific enough to produce consistent code without further questions.

```markdown
# Site Style Guide

> Generated by the style-website skill. Use this document as a prompt when restyling makedown token components (`root/component/makedown/`) or content components (`root/component/`).

## Design Mood
<!-- One paragraph describing the intended look and feel -->

## Colour Palette

| Role | Tailwind class / hex | Notes |
|---|---|---|
| Primary | | |
| Secondary | | |
| Page background | | |
| Card background | | |
| Body text | | |
| Muted text | | |
| Link default | | |
| Link hover | | |
| Heading | | |
| Accent / highlight chip | | |
| Border / divider | | |

## Typography

| Role | Font family | Tailwind size | Weight | Letter spacing |
|---|---|---|---|---|
| h1 | | | | |
| h2 | | | | |
| h3 | | | | |
| h4–h6 | | | | |
| Body text | | | | |
| Inline code | | | | |

Line height (body): ...
Paragraph max-width: ...

## Spacing

Base unit: 4px (Tailwind default)
Paragraph gap: ...
Section gap: ...
Page horizontal padding: ...
Page content max-width: ...

## Navigation Bar

Background: ...
Height: ...
Link style: ...
Active indicator: ...
Sticky: yes / no
Mobile: ...

## Makedown Token Styling

### Headings
<!-- h1 through h6 — describe Tailwind classes or intent for each -->

### Paragraph / Text
<!-- body text and richText wrapper -->

### Inline Formatting
- **Bold:** ...
- *Italic:* ...
- `Highlight / code:` ...

### Links
Default: ... | Hover: ... | Visited: ...

### Blockquote
Border: ... | Background: ... | Text style: ...

### Horizontal Rule
Colour: ... | Thickness: ...

### Lists
Unordered bullet: ... | Ordered number: ... | Indent: ...

### Checkbox
Unchecked: ... | Checked: ...

## Image Tokens

### image
Border radius: ... | Shadow: ... | Max-width: ...

### backgroundImage
Overlay: ...

## Content Component Archetypes

> When creating or restyling any component, identify its archetype below and apply those tokens. A component may combine archetypes (e.g. a listing item that is also a card).

### Card
Background: ... | Border: ... | Border radius: ... | Shadow: ... | Inner padding: ...

### Callout
Accent colour: ... | Accent position: (left border / top strip / full tint) | Background tint: ... | Shadow: ...

### Layout wrapper
Available backgrounds: ... | Content padding (vertical): ... | Interaction with page background: ...

### Media grid
Gap: ... | Item border radius: ... | Hover effect: ...

### Content + image
Proportions: ... | Gap: ... | Background: ...

### Listing / feed
Item style: (inherits Card / custom) | Date colour: ... | Tag colour: ... | Item gap: ...

### Display text
Treatment: (gradient / solid) | Colours: ... | Size relative to h1: ... | Weight: ...

### Data / widget
Container style: (inherits Card / borderless) | Primary value colour: ... | Label colour: ...

## Tailwind Constraints & Notes
<!-- Anything an AI should know before writing Tailwind classes for this site -->
```

## Notes

- All components use Tailwind utility classes — the style guide should express decisions as Tailwind class names or colour hex values wherever possible.
- UnoCSS runtime is used for Tailwind in this project; avoid arbitrary value syntax (`w-[123px]`) unless you have confirmed it works.
- The `FullBleed` component handles full-viewport-width layouts — do not add negative margin hacks in individual components.
- `root/component/makedown/` components all receive a `body` prop (string) and use `<LoadComponent _component="makedown/richText" :body="body" />` for inline rich text. Keep that pattern intact when restyling — only change the wrapping element's classes.
- Once `root/style-guide.md` exists, reference it in any future prompt that asks an AI to restyle or create components.
