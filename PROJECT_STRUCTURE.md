# Project Structure

Tài liệu mô tả chi tiết cấu trúc dự án Hugo blog.

## 📁 Cấu trúc thư mục đầy đủ

```
blog-lap-trinh-mang/
│
├── .github/
│   └── workflows/
│       └── gh-pages.yml          # GitHub Actions workflow cho deploy
│
├── archetypes/                   # Template cho hugo new
│   └── default.md
│
├── content/                      # Nội dung blog (Markdown)
│   ├── _index.md                # Trang Home / Profile
│   ├── archives.md              # Trang Archive
│   ├── search.md                # Trang Search
│   └── blog/                    # Thư mục chứa bài viết
│       ├── _index.md            # Listing page
│       ├── java-lap-trinh-mang-tong-quan/
│       │   └── index.md
│       ├── java-socket-serversocket/
│       │   └── index.md
│       ├── java-server-da-luong/
│       │   └── index.md
│       ├── java-http-co-ban/
│       │   └── index.md
│       ├── java-nio-networking/
│       │   └── index.md
│       ├── js-websocket-browser/
│       │   └── index.md
│       ├── js-fetch-axios-api/
│       │   └── index.md
│       ├── js-node-tcp-client/
│       │   └── index.md
│       └── bao-mat-https-cors-csrf/
│           └── index.md
│
├── layouts/                      # Custom layouts
│   └── partials/
│       └── extend_head.html     # SEO meta tags extension
│
├── static/                       # Static files (served as-is)
│   ├── images/                  # Hình ảnh
│   │   ├── avatar.jpg           # Ảnh đại diện
│   │   ├── site-cover.png       # Cover mặc định
│   │   ├── covers/              # Cover cho posts
│   │   └── README.md
│   ├── robots.txt               # Robots directives
│   └── .nojekyll                # Disable Jekyll processing
│
├── themes/                       # Hugo themes
│   └── PaperMod/                # Theme PaperMod (git submodule)
│
├── .gitignore                   # Git ignore rules
├── .gitmodules                  # Git submodules config
├── hugo.yaml                    # Hugo configuration
│
├── LICENSE                      # MIT License
├── README.md                    # Main documentation
├── SETUP.md                     # Setup guide chi tiết
├── QUICKSTART.md                # Quick start guide
├── CONTRIBUTING.md              # Contributing guidelines
└── PROJECT_STRUCTURE.md         # File này

Generated (not in git):
├── public/                      # Build output (gitignored)
└── resources/                   # Hugo cache (gitignored)
```

## 📄 Mô tả các file quan trọng

### Configuration

**`hugo.yaml`**

- Cấu hình chính của Hugo site
- Theme settings
- Menu configuration
- SEO parameters
- Social links
- Taxonomies (tags, categories)

### Content

**`content/_index.md`**

- Trang chủ với profile mode
- Giới thiệu về tác giả
- Kỹ năng, kinh nghiệm
- Links to blog

**`content/blog/_index.md`**

- Trang listing của blog
- Hiển thị tất cả bài viết

**`content/blog/*/index.md`**

- 9 bài viết về Java & JavaScript
- Front matter với metadata
- Nội dung Markdown

### Layouts

**`layouts/partials/extend_head.html`**

- Custom SEO meta tags
- OpenGraph tags
- Twitter Cards
- Schema.org structured data

### Static Assets

**`static/images/`**

- Avatar image
- Cover images cho posts
- Site cover

**`static/robots.txt`**

- Search engine directives
- Sitemap URL

**`static/.nojekyll`**

- Disable GitHub Pages Jekyll processing

### CI/CD

**`.github/workflows/gh-pages.yml`**

- GitHub Actions workflow
- Auto build và deploy Hugo site
- Trigger: push to main branch

### Documentation

**`README.md`**

- Overview dự án
- Quick start
- Features
- Usage instructions

**`SETUP.md`**

- Hướng dẫn setup từng bước
- Cài đặt Hugo
- Configuration
- Deployment
- Troubleshooting

**`QUICKSTART.md`**

- 5-minute quick start
- Essential commands
- Rapid deployment

**`CONTRIBUTING.md`**

- How to contribute
- Code style guide
- Pull request process

## 🎯 Chức năng các thư mục

### `content/`

**Mục đích**: Chứa tất cả nội dung của site

**Cấu trúc**:

- Mỗi thư mục con = 1 section
- `_index.md` = listing page
- `index.md` (trong subfolder) = single page

**URL mapping**:

```
content/blog/java-socket-serversocket/index.md
→ /blog/java-socket-serversocket/
```

### `static/`

**Mục đích**: Files được serve nguyên vẹn, không qua processing

**Examples**:

- Images: `/images/avatar.jpg` → `https://site.com/images/avatar.jpg`
- Robots: `/robots.txt` → `https://site.com/robots.txt`
- Favicon: `/favicon.ico` → `https://site.com/favicon.ico`

### `layouts/`

**Mục đích**: Custom templates override theme

**Hierarchy**:

```
1. layouts/              (highest priority)
2. themes/PaperMod/layouts/
3. Hugo defaults         (lowest priority)
```

### `themes/`

**Mục đích**: Theme files (PaperMod)

**Note**:

- Là git submodule
- Không sửa trực tiếp
- Override bằng layouts/ hoặc assets/

## 🔧 Hugo Build Process

```
1. Read hugo.yaml config
2. Load theme (themes/PaperMod/)
3. Read content/ (Markdown files)
4. Process layouts/ (templates)
5. Copy static/ files
6. Generate public/ output
```

## 📦 Generated Output (`public/`)

```
public/
├── index.html              # Home page
├── blog/
│   ├── index.html         # Blog listing
│   └── java-socket-serversocket/
│       └── index.html     # Post page
├── tags/
├── categories/
├── images/                 # From static/
├── css/
├── js/
├── index.xml              # RSS feed
├── sitemap.xml            # Sitemap
└── robots.txt
```

## 🚀 Workflow

### Development

```bash
hugo server -D
# → Live reload tại localhost:1313
```

### Build

```bash
hugo --minify
# → Static site trong public/
```

### Deploy

```bash
git push origin main
# → GitHub Actions tự động build & deploy
```

## 🎨 Theme Customization

### Override theme templates

```
layouts/
└── partials/
    ├── extend_head.html      # Thêm vào <head>
    ├── extend_footer.html    # Thêm vào footer
    └── comments.html         # Custom comments
```

### Custom CSS

```
assets/css/extended/
└── custom.css                # Custom styles
```

### Custom JS

```
layouts/partials/
└── extend_footer.html        # Add <script> tags
```

## 📊 Content Organization

### Front Matter (YAML)

```yaml
---
title: "Tiêu đề" # Required
date: 2025-10-20 # Required
draft: false # true = không build
tags: ["Java", "Socket"] # Tags
categories: ["Java"] # Categories
summary: "Mô tả ngắn" # Summary
cover:
  image: "/images/cover.png" # Cover image
  alt: "Alt text"
  caption: "Caption"
---
```

### Taxonomies

**Tags**: Chủ đề cụ thể (Socket, HTTP, WebSocket)
**Categories**: Nhóm lớn (Java, JavaScript)

**URL structure**:

- `/tags/java/` - Tất cả posts tagged "Java"
- `/categories/javascript/` - Tất cả posts trong category "JavaScript"

## 🔍 SEO & Meta

### Generated by Hugo

- `sitemap.xml` - Auto-generated
- `index.xml` - RSS feed
- `robots.txt` - From static/

### Custom (extend_head.html)

- OpenGraph tags
- Twitter Cards
- Schema.org structured data
- Canonical URLs

## 🌐 Deployment

### GitHub Pages

**URL**: `https://<username>.github.io/blog-lap-trinh-mang/`

**Process**:

1. Push to main branch
2. GitHub Actions trigger
3. Build với Hugo
4. Upload artifact
5. Deploy to gh-pages branch
6. Site live

### Custom Domain (Optional)

1. Thêm file `static/CNAME`:

   ```
   blog.yourdomain.com
   ```

2. Config DNS:

   ```
   CNAME blog -> <username>.github.io
   ```

3. Update `baseURL` trong `hugo.yaml`:
   ```yaml
   baseURL: "https://blog.yourdomain.com/"
   ```

## 🔧 Configuration Details

### Menu (`hugo.yaml`)

```yaml
menu:
  main:
    - identifier: home
      name: Trang chủ
      url: /
      weight: 10
```

**Weight**: Thứ tự hiển thị (nhỏ hơn = trước)

### Params

```yaml
params:
  profileMode:
    enabled: true # Bật profile mode cho home
  ShowReadingTime: true
  ShowShareButtons: true
  ShowCodeCopyButtons: true
```

## 📈 Analytics & Monitoring

### Add Google Analytics

```yaml
params:
  analytics:
    google:
      SiteVerificationTag: "YOUR_TAG"
```

### Performance Monitoring

- Lighthouse CI
- Google Search Console
- Core Web Vitals

## 🔐 Security

### HTTPS

- Automatically enabled trên GitHub Pages
- Enforce HTTPS trong repo settings

### Content Security Policy

Có thể thêm trong `extend_head.html`:

```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self';" />
```

## 🎓 Learning Resources

### Hugo

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Hugo Discourse](https://discourse.gohugo.io/)

### PaperMod

- [PaperMod Demo](https://adityatelange.github.io/hugo-PaperMod/)
- [PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)

### Markdown

- [Markdown Guide](https://www.markdownguide.org/)
- [CommonMark](https://commonmark.org/)

---

**Last Updated**: 2025-10-16  
**Hugo Version**: 0.120+  
**Theme**: PaperMod latest
