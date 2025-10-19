# Hướng dẫn Setup chi tiết

Tài liệu này hướng dẫn từng bước để setup blog từ đầu.

## 1. Cài đặt Hugo

### Windows

```powershell
# Dùng Chocolatey
choco install hugo-extended

# Hoặc Scoop
scoop install hugo-extended

# Hoặc download từ GitHub Releases
# https://github.com/gohugoio/hugo/releases
```

### macOS

```bash
# Dùng Homebrew
brew install hugo
```

### Linux

```bash
# Ubuntu/Debian
sudo apt install hugo

# Hoặc download binary
wget https://github.com/gohugoio/hugo/releases/download/v0.120.0/hugo_extended_0.120.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.120.0_linux-amd64.deb
```

### Kiểm tra cài đặt

```bash
hugo version
# Hugo Static Site Generator v0.120.0+extended
```

## 2. Clone Repository

```bash
# Clone repo
git clone https://github.com/handzvcl/blog-handzvcl-laptrinhmang.git
cd blog-handzvcl-laptrinhmang

# Clone theme (git submodule)
git submodule update --init --recursive
```

## 3. Cấu hình cá nhân

### Cập nhật thông tin trong hugo.yaml

```yaml
baseURL: "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"
title: "Blog Lập Trình Mạng"

params:
  author: "Tên của bạn"

  profileMode:
    title: "Tên của bạn"
    subtitle: "Bio của bạn"
    imageUrl: "/images/avatar.jpg"

  socialIcons:
    - name: github
      url: "https://github.com/<username>"
    - name: linkedin
      url: "https://linkedin.com/in/<id>"
    - name: email
      url: "mailto:<email>@example.com"
```

### Thêm ảnh đại diện

```bash
# Đặt ảnh avatar.jpg vào static/images/
cp /path/to/your/photo.jpg static/images/avatar.jpg
```

## 4. Test Local

```bash
# Chạy development server
hugo server -D

# Mở browser
# http://localhost:1313/blog-lap-trinh-mang/
```

## 5. Deploy lên GitHub Pages

### 5.1. Tạo GitHub Repository

1. Vào https://github.com/new
2. Tên repo: `blog-lap-trinh-mang`
3. Chọn Public
4. Tạo repository

### 5.2. Push code

```bash
# Thêm remote
git remote add origin https://github.com/<username>/blog-lap-trinh-mang.git

# Push
git add .
git commit -m "Initial commit"
git push -u origin main
```

### 5.3. Cấu hình GitHub Pages

1. Vào repository Settings
2. Pages (sidebar)
3. Source: **GitHub Actions**
4. Đợi GitHub Actions chạy (tab Actions)
5. Sau khi deploy xong, site sẽ live tại:
   `https://<username>.github.io/blog-lap-trinh-mang/`

## 6. Thêm bài viết mới

```bash
# Tạo bài viết mới
hugo new blog/ten-bai-viet/index.md

# Chỉnh sửa file
# content/blog/ten-bai-viet/index.md

# Test
hugo server -D

# Publish (đổi draft: false, rồi push)
git add .
git commit -m "Add new post"
git push
```

## 7. Tùy chỉnh nâng cao

### Custom CSS

Tạo file `assets/css/extended/custom.css`:

```css
/* Custom styles */
:root {
  --primary: #2563eb;
}

.main {
  max-width: 800px;
}
```

### Custom JavaScript

Tạo file `layouts/partials/extend_footer.html`:

```html
<script>
  // Custom JS
  console.log("Blog loaded!");
</script>
```

### Thêm Comments (Disqus)

Trong `hugo.yaml`:

```yaml
services:
  disqus:
    shortname: your-disqus-shortname
```

### Google Analytics

```yaml
params:
  analytics:
    google:
      SiteVerificationTag: "YOUR_TAG"
```

## 8. Troubleshooting

### Theme không load

```bash
# Kiểm tra submodule
git submodule status

# Update submodule
git submodule update --init --recursive
```

### CSS không apply

```bash
# Xóa cache
rm -rf resources/

# Rebuild
hugo
```

### GitHub Actions fail

1. Kiểm tra logs trong tab Actions
2. Đảm bảo GitHub Pages đã bật
3. Đảm bảo baseURL đúng

### Port 1313 đã dùng

```bash
# Dùng port khác
hugo server -p 1314
```

## 9. Maintenance

### Update theme

```bash
cd themes/PaperMod
git pull origin master
cd ../..
git add themes/PaperMod
git commit -m "Update theme"
git push
```

### Update Hugo

```bash
# Windows (Chocolatey)
choco upgrade hugo-extended

# macOS (Homebrew)
brew upgrade hugo

# Linux
# Download new version từ GitHub
```

### Backup

```bash
# Backup toàn bộ repo
git clone --recursive https://github.com/<username>/blog-lap-trinh-mang.git backup/
```

## 10. Resources

### Hugo Documentation

- [Hugo Quick Start](https://gohugo.io/getting-started/quick-start/)
- [Hugo Content Management](https://gohugo.io/content-management/)
- [Hugo Templates](https://gohugo.io/templates/)

### PaperMod Theme

- [PaperMod Demo](https://adityatelange.github.io/hugo-PaperMod/)
- [PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)
- [PaperMod Features](https://github.com/adityatelange/hugo-PaperMod/wiki/Features)

### Markdown

- [Markdown Guide](https://www.markdownguide.org/)
- [CommonMark Spec](https://commonmark.org/)

### GitHub Pages

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [GitHub Actions](https://docs.github.com/en/actions)

## 11. Tips & Tricks

### Viết bài hiệu quả

1. Dùng headings (##, ###) để structure
2. Thêm code blocks với syntax highlighting
3. Dùng lists để dễ đọc
4. Thêm images/diagrams
5. Viết summary ngắn gọn

### SEO

1. Viết title descriptive (< 60 chars)
2. Meta description (< 160 chars)
3. Dùng proper headings hierarchy
4. Add alt text cho images
5. Internal linking giữa các posts

### Performance

1. Optimize images (compress, resize)
2. Minify output (`hugo --minify`)
3. Dùng CDN cho assets
4. Lazy load images

### Workflow

```bash
# Daily workflow
hugo server -D       # Start dev server
# Viết bài...
git add .
git commit -m "Post: Title"
git push            # Auto deploy
```

## Hỗ trợ

Nếu gặp vấn đề:

1. Kiểm tra [Hugo Troubleshooting](https://gohugo.io/troubleshooting/)
2. Xem [PaperMod Issues](https://github.com/adityatelange/hugo-PaperMod/issues)
3. Tạo issue trong repo này
4. Liên hệ qua email

Happy blogging! 🚀
