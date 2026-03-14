# Skill: New Page

Create a new markdown page in `root/carbon/`. The filename determines the URL — no routing config needed.

## Steps

1. Create `root/carbon/page-name.md`
2. Write content using makedown syntax and/or Vue component tags
3. The page is immediately live at `site.com/page-name`

## URL Mapping

| File | URL |
|---|---|
| `carbon/.md` | `site.com/` |
| `carbon/about.md` | `site.com/about` |
| `carbon/work/project.md` | `site.com/work/project` |

Subdirectories work — just create the folder and file.

## Available Syntax

```markdown
# Heading 1
## Heading 2
### Heading 3

Regular text renders as a paragraph.

- unordered list item
1. ordered list item
> blockquote

---

[link text](https://url)
![alt text](/api/images/photo.jpg)
!![alt text](/api/images/photo.jpg)   ← full bleed background image

[ ] unchecked task
[x] checked task

` `` `
code block
` `` `
```

## Using Components

Any component in `root/component/` can be used by its filename (without `.vue`), in PascalCase:

```markdown
<ContentCard image="/api/images/photo.jpg" body="Some text here" />

<SideImage image="/api/images/photo.jpg">
## Title
Some content that goes next to the image.
</SideImage>
```

Props are passed as HTML attributes (always strings). Check the component file for available props.

## Special Pages

- `carbon/background.md` — rendered as the fixed site background on every page
- `carbon/footer.md` — rendered below content on every page
- `carbon/404.md` — shown when a requested page is not found

Avoid overwriting these unless intentional.
