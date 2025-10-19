# 🚀 Getting Started

Chào mừng bạn đến với blog Hugo của bạn! Đây là hướng dẫn hoàn chỉnh để bắt đầu.

## 📋 Checklist đầy đủ

### ✅ Bước 1: Chuẩn bị môi trường

- [ ] Cài đặt Hugo Extended v0.120+ ([Download](https://gohugo.io/installation/))
- [ ] Cài đặt Git ([Download](https://git-scm.com/downloads))
- [ ] Tạo tài khoản GitHub (nếu chưa có)
- [ ] Cài đặt editor (VS Code recommended)

### ✅ Bước 2: Clone và setup project

```bash
# Clone repository
git clone https://github.com/<username>/blog-lap-trinh-mang.git
cd blog-lap-trinh-mang

# Clone theme
git submodule update --init --recursive

# Test local
hugo server -D
```

Mở browser: http://localhost:1313/blog-lap-trinh-mang/

### ✅ Bước 3: Tùy chỉnh thông tin cá nhân

**File: `hugo.yaml`**

Thay đổi các phần sau:

```yaml
# 1. Base URL
baseURL: "https://<username>.github.io/blog-lap-trinh-mang/"

# 2. Thông tin tác giả
params:
  author: "Tên của bạn"

  # 3. Profile
  profileMode:
    title: "Tên của bạn"
    subtitle: "Bio ngắn gọn về bạn"
    imageUrl: "/images/avatar.jpg"

  # 4. Social links
  socialIcons:
    - name: github
      url: "https://github.com/your-username"
    - name: linkedin
      url: "https://linkedin.com/in/your-id"
    - name: email
      url: "mailto:your-email@example.com"

  # 5. Edit post URL
  editPost:
    URL: "https://github.com/your-username/blog-lap-trinh-mang/tree/main/content"
```

**File: `static/robots.txt`**

```txt
Sitemap: https://your-username.github.io/blog-lap-trinh-mang/sitemap.xml
```

### ✅ Bước 4: Thêm ảnh đại diện

**Option 1: Ảnh thật**

```bash
# Copy ảnh của bạn (180x180px recommended)
cp /path/to/your-photo.jpg static/images/avatar.jpg
```

**Option 2: Placeholder**

```bash
# Tạo thư mục nếu chưa có
mkdir -p static/images

# Download placeholder
curl -o static/images/avatar.jpg "https://placehold.co/180x180/2563eb/white?text=Avatar"
```

**Option 3: Tự tạo với initials**

```bash
# Ví dụ: PH cho Phan Hân
curl -o static/images/avatar.jpg "https://placehold.co/180x180/2563eb/white?text=PH&font=montserrat"
```

### ✅ Bước 5: Test lại local

```bash
# Restart server để apply changes
Ctrl+C  # Stop server
hugo server -D

# Kiểm tra:
# - Tên và bio hiển thị đúng
# - Avatar hiển thị
# - Social links hoạt động
# - 9 bài viết hiển thị
```

### ✅ Bước 6: Tạo GitHub Repository

1. Vào https://github.com/new
2. Repository name: `blog-lap-trinh-mang`
3. Chọn **Public**
4. **KHÔNG** check "Initialize with README"
5. Click **Create repository**

### ✅ Bước 7: Push code lên GitHub

```bash
# Thêm remote (thay <username> bằng username GitHub của bạn)
git remote add origin https://github.com/<username>/blog-lap-trinh-mang.git

# Push code
git add .
git commit -m "Initial commit - Blog setup"
git push -u origin main
```

### ✅ Bước 8: Deploy lên GitHub Pages

1. Vào repository trên GitHub
2. Click **Settings** (tab trên cùng)
3. Sidebar: Click **Pages**
4. Source: Chọn **GitHub Actions**
5. Save

### ✅ Bước 9: Đợi deploy

1. Vào tab **Actions** trong repository
2. Xem workflow "Deploy Hugo to GitHub Pages" đang chạy
3. Đợi ~2-3 phút để deploy hoàn tất
4. Khi có dấu ✅ xanh = deploy thành công

### ✅ Bước 10: Kiểm tra site live

Truy cập: `https://<username>.github.io/blog-lap-trinh-mang/`

**Checklist:**

- [ ] Trang chủ hiển thị profile
- [ ] Menu Home, Blog, Tags, Archive hoạt động
- [ ] 9 bài viết hiển thị trong Blog
- [ ] Dark/Light mode toggle hoạt động
- [ ] Search hoạt động
- [ ] Social links đúng

## 🎉 Chúc mừng!

Blog của bạn đã live!

## 📝 Next Steps

### Viết bài mới

```bash
# Tạo bài viết mới
hugo new blog/ten-bai-viet-cua-ban/index.md

# Sửa file
# content/blog/ten-bai-viet-cua-ban/index.md

# Test local
hugo server -D

# Publish
git add .
git commit -m "Add: Tên bài viết"
git push
```

### Tùy chỉnh thêm

**Thêm cover images cho posts**

1. Tạo ảnh cover (1200x630px for social sharing)
2. Lưu vào `static/images/covers/`
3. Update front matter:

```yaml
cover:
  image: "/images/covers/my-post-cover.png"
  alt: "Alt text mô tả ảnh"
  caption: "Caption cho ảnh"
```

**Custom CSS**

```bash
# Tạo file
mkdir -p assets/css/extended
nano assets/css/extended/custom.css
```

```css
/* Custom styles */
:root {
  --primary: #2563eb;
}
```

**Google Analytics**

```yaml
# Trong hugo.yaml
params:
  analytics:
    google:
      SiteVerificationTag: "YOUR_VERIFICATION_TAG"
```

## 🔄 Daily Workflow

```bash
# 1. Start dev server
hugo server -D

# 2. Viết/sửa content
# ...

# 3. Preview trong browser
# localhost:1313/blog-lap-trinh-mang/

# 4. Commit & push khi hài lòng
git add .
git commit -m "Update: Description"
git push

# 5. GitHub Actions tự động deploy
# Đợi 2-3 phút → site updated
```

## 🆘 Troubleshooting

### Theme không hiển thị

```bash
# Clone lại theme
git submodule update --init --recursive
```

### GitHub Actions fail

**Check logs:**

1. Tab Actions → Click workflow run
2. Xem error message
3. Common issues:
   - baseURL không đúng
   - Theme submodule chưa clone
   - Hugo version incompatible

**Fix:**

```bash
# Ensure submodule committed
git add .gitmodules themes/PaperMod
git commit -m "Fix: Add theme submodule"
git push
```

### Site không load CSS

- Clear browser cache (Ctrl+Shift+R)
- Check baseURL trong hugo.yaml
- Đợi GitHub Pages propagate (~5 phút)

### Avatar không hiển thị

```bash
# Verify file exists
ls -la static/images/avatar.jpg

# Correct path in hugo.yaml
imageUrl: "/images/avatar.jpg"  # Leading slash!
```

## 📚 Tài liệu tham khảo

Theo thứ tự nên đọc:

1. **[QUICKSTART.md](QUICKSTART.md)** - Quick commands
2. **[README.md](README.md)** - Full documentation
3. **[SETUP.md](SETUP.md)** - Detailed setup guide
4. **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - Project structure
5. **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contributing guide

### External Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Pages Docs](https://docs.github.com/en/pages)

## 💡 Tips

### Performance

- Optimize images trước khi upload (TinyPNG, Squoosh)
- Use `hugo --minify` để minify output
- Enable CDN nếu có

### SEO

- Viết meta description cho mỗi post
- Sử dụng proper heading structure
- Add alt text cho images
- Internal linking giữa posts

### Content

- Consistency: Post regularly
- Quality > Quantity
- Engage với readers (comments)
- Share trên social media

## ❓ FAQ

**Q: Tôi có thể dùng custom domain không?**  
A: Có! Thêm file `static/CNAME` với domain của bạn, và config DNS.

**Q: Làm sao backup blog?**  
A: Repository GitHub chính là backup. Clone về local: `git clone --recursive <repo-url>`

**Q: Có thể dùng theme khác không?**  
A: Có, nhưng cần update hugo.yaml và có thể cần adjust layouts.

**Q: Làm sao track analytics?**  
A: Thêm Google Analytics hoặc Plausible Analytics vào config.

**Q: Blog có thể password protect không?**  
A: GitHub Pages không hỗ trợ. Cần dùng Netlify hoặc Vercel.

## 🤝 Support

Nếu gặp vấn đề:

1. Check [SETUP.md](SETUP.md) troubleshooting section
2. Search [Hugo Discourse](https://discourse.gohugo.io/)
3. Create issue trong repository
4. Email: your-email@example.com

---

**Happy Blogging!** 🎉✨

Bắt đầu viết bài đầu tiên của bạn ngay hôm nay!

```bash
hugo new blog/bai-viet-dau-tien/index.md
```
