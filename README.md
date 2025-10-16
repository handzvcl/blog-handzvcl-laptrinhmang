# Blog Lập Trình Mạng

Blog cá nhân chia sẻ kiến thức về lập trình mạng với Java và JavaScript.

🔗 **Live Demo**: https://&lt;username&gt;.github.io/blog-lap-trinh-mang/

## 📋 Mục lục

- [Giới thiệu](#giới-thiệu)
- [Tính năng](#tính-năng)
- [Công nghệ](#công-nghệ)
- [Cài đặt](#cài-đặt)
- [Sử dụng](#sử-dụng)
- [Deploy](#deploy)
- [Cấu trúc thư mục](#cấu-trúc-thư-mục)
- [Thêm bài viết mới](#thêm-bài-viết-mới)
- [Tùy chỉnh](#tùy-chỉnh)

## 🎯 Giới thiệu

Blog này được xây dựng bằng Hugo với theme PaperMod, tập trung vào chia sẻ kiến thức về:

- **Java Networking**: Socket, ServerSocket, NIO, HTTP, Multithreading
- **JavaScript**: WebSocket, Fetch API, Axios, Node.js TCP
- **Bảo mật**: HTTPS, CORS, CSRF

## ✨ Tính năng

- ✅ **Tối giản & Đẹp mắt**: Theme PaperMod responsive
- ✅ **Dark/Light Mode**: Chuyển đổi giao diện sáng/tối
- ✅ **SEO Optimized**: Meta tags, OpenGraph, Twitter Cards, Schema.org
- ✅ **RSS Feed**: Theo dõi bài viết mới
- ✅ **Search**: Tìm kiếm bài viết nhanh chóng
- ✅ **Code Highlighting**: Syntax highlighting cho code blocks
- ✅ **Reading Time**: Thời gian đọc ước tính
- ✅ **Tags & Categories**: Phân loại bài viết
- ✅ **CI/CD**: Tự động deploy với GitHub Actions

## 🛠 Công nghệ

- **SSG**: [Hugo](https://gohugo.io/) v0.120+
- **Theme**: [PaperMod](https://github.com/adityatelange/hugo-PaperMod)
- **Hosting**: GitHub Pages
- **CI/CD**: GitHub Actions
- **Language**: Markdown

## 📦 Cài đặt

### Yêu cầu

- Hugo Extended v0.120+ ([Download](https://gohugo.io/installation/))
- Git

### Clone repository

```bash
git clone https://github.com/<username>/blog-lap-trinh-mang.git
cd blog-lap-trinh-mang
```

### Cài đặt theme

```bash
# Clone theme PaperMod
git submodule update --init --recursive
```

## 🚀 Sử dụng

### Chạy local development server

```bash
hugo server -D
```

Mở trình duyệt: http://localhost:1313/blog-lap-trinh-mang/

### Build static files

```bash
hugo --minify
```

Output sẽ được tạo trong thư mục `public/`.

### Options hữu ích

```bash
# Chạy với draft posts
hugo server -D

# Chạy với live reload
hugo server --disableFastRender

# Build với minification
hugo --minify --gc

# Build và kiểm tra broken links
hugo --minify && hugo check
```

## 🌐 Deploy

### GitHub Pages (Tự động)

1. **Push code lên GitHub**:

```bash
git add .
git commit -m "Initial commit"
git push origin main
```

2. **Bật GitHub Pages**:
   - Vào repository Settings → Pages
   - Source: GitHub Actions
3. **GitHub Actions tự động deploy** khi push lên `main` branch.

### Manual Deploy

```bash
# Build
hugo --minify

# Deploy thư mục public/ lên hosting
```

## 📁 Cấu trúc thư mục

```
blog-lap-trinh-mang/
├── .github/
│   └── workflows/
│       └── gh-pages.yml      # GitHub Actions workflow
├── content/
│   ├── _index.md             # Trang Home
│   ├── archives.md           # Trang Archive
│   ├── search.md             # Trang Search
│   └── blog/
│       ├── _index.md         # Trang Blog listing
│       ├── java-lap-trinh-mang-tong-quan/
│       │   └── index.md
│       ├── java-socket-serversocket/
│       │   └── index.md
│       └── ...               # 9 bài viết
├── layouts/
│   └── partials/
│       └── extend_head.html  # SEO meta tags
├── static/
│   ├── images/               # Hình ảnh
│   ├── robots.txt
│   └── .nojekyll
├── themes/
│   └── PaperMod/             # Theme (git submodule)
├── hugo.yaml                 # Cấu hình Hugo
├── .gitmodules
└── README.md
```

## ✍️ Thêm bài viết mới

### 1. Tạo file bài viết

```bash
hugo new blog/ten-bai-viet/index.md
```

### 2. Chỉnh sửa front matter

```yaml
---
title: "Tiêu đề bài viết"
date: 2025-10-20
draft: false
tags: ["Java", "Networking"]
categories: ["Java"]
summary: "Mô tả ngắn gọn về bài viết"
cover:
  image: "/images/covers/image.png"
  alt: "Alt text"
  caption: "Caption"
---
Nội dung bài viết...
```

### 3. Viết nội dung bằng Markdown

```markdown
## Heading 2

Paragraph với **bold** và _italic_.

### Code block

\`\`\`java
public class Example {
public static void main(String[] args) {
System.out.println("Hello World!");
}
}
\`\`\`

### List

- Item 1
- Item 2

### Link

[Text](https://example.com)
```

### 4. Preview

```bash
hugo server -D
```

### 5. Publish

Đổi `draft: false` trong front matter, sau đó commit và push:

```bash
git add .
git commit -m "Add new post: Tên bài viết"
git push origin main
```

## 🎨 Tùy chỉnh

### Thay đổi thông tin cá nhân

Chỉnh sửa file `hugo.yaml`:

```yaml
params:
  author: "Tên của bạn"
  profileMode:
    title: "Tên của bạn"
    subtitle: "Bio của bạn"
    imageUrl: "/images/avatar.jpg"

  socialIcons:
    - name: github
      url: "https://github.com/username"
    - name: linkedin
      url: "https://linkedin.com/in/username"
    - name: email
      url: "mailto:email@example.com"
```

### Thay đổi baseURL

Trong `hugo.yaml`:

```yaml
baseURL: "https://<username>.github.io/blog-lap-trinh-mang/"
```

### Thêm Google Analytics

```yaml
params:
  analytics:
    google:
      SiteVerificationTag: "YOUR_VERIFICATION_TAG"
```

### Tùy chỉnh màu sắc

Tạo file `assets/css/extended/custom.css`:

```css
:root {
  --primary: #007bff;
  --theme: #fff;
  --entry: #f8f9fa;
}

.dark {
  --theme: #1a1a1a;
  --entry: #2d2d2d;
}
```

## 📝 Bài viết hiện có

1. **Tổng quan lập trình mạng với Java** - Giới thiệu Java networking
2. **Hiểu Socket và ServerSocket trong Java** - TCP socket programming
3. **Xử lý đa luồng cho server TCP** - ExecutorService và thread pool
4. **Giao thức HTTP cơ bản** - HTTP trong Java
5. **Java NIO và Channel/Selector** - Non-blocking I/O
6. **WebSocket bằng JavaScript** - Real-time communication
7. **Fetch API & Axios** - HTTP requests trong JavaScript
8. **Client TCP với Node.js** - net module trong Node.js
9. **Bảo mật: HTTPS, CORS, CSRF** - Web security basics

## 🤝 Contributing

Mọi đóng góp đều được chào đón! Vui lòng:

1. Fork repository
2. Tạo branch mới (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Mở Pull Request

## 📄 License

MIT License - Xem file [LICENSE](LICENSE) để biết thêm chi tiết.

## 📞 Liên hệ

- **Author**: Phan Hân
- **Email**: &lt;email&gt;@example.com
- **GitHub**: [@&lt;username&gt;](https://github.com/<username>)
- **LinkedIn**: [linkedin.com/in/&lt;id&gt;](https://linkedin.com/in/<id>)

## 🙏 Acknowledgments

- [Hugo](https://gohugo.io/) - Static site generator
- [PaperMod](https://github.com/adityatelange/hugo-PaperMod) - Hugo theme
- [GitHub Pages](https://pages.github.com/) - Free hosting

---

⭐ Nếu bạn thấy blog này hữu ích, hãy star repository này!
