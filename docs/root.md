# Root Content

The `root/` directory is the content layer of OsPress. It is mounted as `/app/root` in both the frontend and backend containers, making it the shared source of truth for all site content.

Files in root are served to the client via nginx's internal `/files/` location (aliased to `/app/root/`). Clients access them through `/api/` GET requests. Write access goes through the backend API.

## Directory Structure

```
root/
├── carbon/         # Site pages (markdown)
├── component/      # Remote Vue components
│   └── makedown/   # Token renderer components
├── images/         # Static image assets
└── navigation/     # Navigation config and component
```

## carbon/

Each `.md` file in `carbon/` is a page on the site. The URL path maps directly to the filename:

| File | URL |
|---|---|
| `carbon/.md` | `site.com/` |
| `carbon/about.md` | `site.com/about` |
| `carbon/blog.md` | `site.com/blog` |

Two files have special roles and are loaded on every page:
- `carbon/background.md` — rendered as a fixed fullscreen layer behind the page
- `carbon/footer.md` — rendered below the page content

A `carbon/404.md` is used as the fallback when a page file is not found.

## component/

Remote Vue components that can be used inside markdown pages as PascalCase tags. The client fetches these at runtime from `/api/component/Name.vue`.

Current components:
- `ContentCard` — card with image, accent bar, and markdown body
- `CountDown` — countdown timer
- `ImageGrid` — responsive image grid
- `MagicGrid` — auto-layout grid
- `SideImage` — text + image side-by-side layout
- `WordArt` — styled text display
- `Info`, `PopOut`, `meta`, `yellow`, `youtube` — various content blocks

Components can use Tailwind classes for styling. They receive props from attributes on the markdown tag.

### component/makedown/

These are the rendering components for makedown's built-in tokens. They are not used directly in markdown — the parser resolves them internally. Editing these changes how base markdown syntax renders.

Current tokens: `h1`–`h3`, `text`, `link`, `image`, `backgroundImage`, `blockquote`, `horizontalRule`, `checkbox`, `orderedListItem`, `unorderedListItem`, `comment`.

## images/

Static image assets served directly by nginx. Referenced in markdown as `/api/images/filename.jpg` or via the `![alt](url)` makedown syntax.

## navigation/

- `navigation.json` — defines the site navigation structure
- `default.vue` — the default navigation bar component, loaded by `LoadNav.vue` in the frontend
