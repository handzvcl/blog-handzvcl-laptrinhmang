# Quick Start Guide

Hướng dẫn nhanh để khởi động blog trong 5 phút!

## 🚀 Setup nhanh

```bash
# 1. Clone repository
git clone https://github.com/handzvcl/blog-handzvcl-laptrinhmang.git
cd blog-handzvcl-laptrinhmang

# 2. Clone theme
git submodule update --init --recursive

# 3. Chạy local server
hugo server -D

# 4. Mở browser
# http://localhost:1313/
```

## ✏️ Thêm bài viết nhanh

```bash
# Tạo bài mới
hugo new blog/ten-bai-viet/index.md

# Sửa front matter
---
title: "Tiêu đề"
date: 2025-10-20
draft: false
tags: ["Java"]
categories: ["Java"]
summary: "Mô tả ngắn"
---

# Viết content...

# Commit & push
git add .
git commit -m "Add: Tiêu đề bài viết"
git push
```

## 🌐 Deploy lên GitHub Pages

```bash
# 1. Tạo repo trên GitHub: blog-handzvcl-laptrinhmang

# 2. Push code
git remote add origin https://github.com/handzvcl/blog-handzvcl-laptrinhmang.git
git push -u origin main

# 3. Bật GitHub Pages
# Settings → Pages → Source: GitHub Actions

# 4. Đợi deploy (tab Actions)
# Site live tại: https://handzvcl.github.io/blog-handzvcl-laptrinhmang/
```

## 🎨 Tùy chỉnh thông tin

Sửa file `hugo.yaml`:

```yaml
# Thay đổi các giá trị sau:
baseURL: "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"

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

## 📸 Thêm ảnh đại diện

```bash
# Copy ảnh của bạn
cp your-photo.jpg static/images/avatar.jpg

# Hoặc dùng placeholder
curl -o static/images/avatar.jpg "https://placehold.co/180x180/2563eb/white?text=Avatar"
```

## ✅ Checklist

- [ ] Clone repository và theme
- [ ] Cập nhật thông tin trong `hugo.yaml`
- [ ] Thêm ảnh đại diện
- [ ] Test local với `hugo server -D`
- [ ] Tạo GitHub repository
- [ ] Push code và bật GitHub Pages
- [ ] Verify site hoạt động

## 🆘 Troubleshooting

**Theme không load?**

```bash
git submodule update --init --recursive
```

**Port 1313 đã dùng?**

```bash
hugo server -p 1314
```

**GitHub Actions fail?**

- Kiểm tra tab Actions để xem logs
- Đảm bảo đã bật GitHub Pages với source "GitHub Actions"

## 📚 Tài liệu

- [README.md](README.md) - Tài liệu đầy đủ
- [SETUP.md](SETUP.md) - Hướng dẫn setup chi tiết
- [Hugo Docs](https://gohugo.io/documentation/)
- [PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)

Chúc bạn viết blog vui vẻ! ✨
