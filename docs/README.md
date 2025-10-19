# 📚 Blog Lập Trình Mạng - Phan Trường Hân

Blog cá nhân về lập trình mạng, Java, JavaScript và các công nghệ web hiện đại. Được xây dựng với Hugo và PaperMod theme.

## 🌐 Live Demo

**https://handzvcl.github.io/blog-handzvcl-laptrinhmang/**

## ✨ Features

### Design

- 🎨 **PaperMod Theme** - Clean, modern design với dark/light mode
- 📱 **Fully Responsive** - Tối ưu cho mọi thiết bị
- ⚡ **Fast Loading** - Hugo static site generator
- 🔍 **Search Function** - Tìm kiếm nội dung nhanh chóng
- 📊 **SEO Optimized** - Meta tags, sitemap, RSS feed

### Content

- **Home** - Giới thiệu cá nhân và kỹ năng
- **Blog** - Các bài viết về lập trình mạng
- **About** - Thông tin chi tiết về bản thân
- **Contact** - Form liên hệ và thông tin social

### Technical

- ✅ Hugo Static Site Generator
- ✅ PaperMod Theme
- ✅ Markdown content
- ✅ Custom CSS styling
- ✅ JavaScript enhancements
- ✅ GitHub Pages deployment

## 🚀 Quick Start

### Prerequisites

- [Hugo Extended](https://gohugo.io/installation/) (v0.100.0+)
- Git

### Local Development

```bash
# Clone the repository
git clone https://github.com/handzvcl/blog-handzvcl-laptrinhmang.git
cd blog-handzvcl-laptrinhmang

# Start Hugo server
hugo server -D

# Visit: http://localhost:1313
```

### Build for Production

```bash
# Build static site
hugo --minify

# Deploy to GitHub Pages
git add .
git commit -m "Update blog"
git push origin main
```

## 📁 Project Structure

```
blog-handzvcl-laptrinhmang/
├── content/                # Blog content (Markdown)
│   ├── _index.md          # Homepage content
│   ├── about.md           # About page
│   ├── contact.md         # Contact page
│   └── blog/              # Blog posts
│       ├── java-*/        # Java programming posts
│       └── js-*/          # JavaScript posts
├── layouts/               # Custom layouts
│   ├── _default/          # Default templates
│   ├── partials/          # Reusable components
│   └── index.html         # Homepage layout
├── static/                # Static assets
│   ├── css/custom/        # Custom CSS
│   ├── js/                # JavaScript files
│   └── images/            # Images & covers
├── themes/                # Hugo themes
│   └── PaperMod/          # PaperMod theme
├── docs/                  # Documentation
├── hugo.yaml             # Hugo configuration
└── public/               # Generated site (auto-created)
```

## 🎨 Customization

### Configuration

Edit `hugo.yaml`:

```yaml
params:
  title: "Your Blog Title"
  description: "Your blog description"
  author: "Your Name"
  socialIcons:
    - name: github
      url: "https://github.com/yourusername"
```

### Content

- **Blog Posts**: Add new `.md` files in `content/blog/`
- **Pages**: Edit `content/_index.md`, `content/about.md`, `content/contact.md`
- **Social Links**: Update `hugo.yaml` socialIcons section

### Styling

- **Custom CSS**: Edit files in `static/css/custom/`
- **Theme**: PaperMod theme with custom overrides
- **Images**: Replace `static/images/avatar.jpg` and cover images

## 🛠 Technologies

- **Hugo** - Static site generator
- **PaperMod** - Hugo theme
- **Markdown** - Content writing
- **CSS3** - Custom styling
- **JavaScript** - Interactive features
- **GitHub Pages** - Hosting

## 🌟 Key Features

### 1. Modern Blog Design

Clean, professional design with PaperMod theme

### 2. Dark/Light Mode

Automatic theme switching based on system preference

### 3. Search Function

Fast client-side search through all blog posts

### 4. Responsive Design

Optimized for desktop, tablet, and mobile devices

### 5. SEO Optimized

Meta tags, sitemap, RSS feed, and structured data

### 6. Fast Performance

Static site generation with Hugo for optimal speed

## 📚 Blog Topics

- **Java Programming** - Socket programming, multithreading, NIO
- **JavaScript** - Fetch API, WebSocket, Node.js networking
- **Web Security** - HTTPS, CORS, CSRF protection
- **Network Programming** - TCP/IP, HTTP protocols, real-time communication

## 📱 Browser Support

- ✅ Chrome (latest)
- ✅ Firefox (latest)
- ✅ Safari (latest)
- ✅ Edge (latest)
- ✅ Mobile browsers

## 🚀 Performance

- **Static Site Generation** - Fast loading times
- **Minified Assets** - Optimized CSS and JavaScript
- **Image Optimization** - Compressed images for web
- **CDN Ready** - GitHub Pages with global CDN

## 📄 License

MIT License - feel free to use for your own blog!

## 👤 Author

**Phan Trường Hân**

- GitHub: [@handzvcl](https://github.com/handzvcl)
- Facebook: [facebook.com/100024092942208](https://facebook.com/100024092942208)
- Instagram: [@truonghan\_](https://instagram.com/truonghan_)
- University: HUTECH - Computer Science

## 🙏 Acknowledgments

- [PaperMod Theme](https://github.com/adityatelange/hugo-PaperMod) by Aditya Telange
- [Hugo](https://gohugo.io/) static site generator
- [GitHub Pages](https://pages.github.com/) for hosting

---

⭐ **Star this repo if you find it useful!**
