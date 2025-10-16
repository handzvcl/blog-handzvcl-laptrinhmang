# 🚀 Hướng Dẫn Deploy Blog Lên GitHub Pages

## ✅ Checklist Trước Khi Deploy

### 1. **Kiểm tra cấu hình** ✓

- [x] BaseURL đã được set đúng: `baseURL: "/"`
- [x] Avatar hiển thị đúng tại `/images/avatar.jpg`
- [x] CSS custom cho avatar đã được áp dụng
- [x] Build production thành công không lỗi
- [x] Có 9 blog posts về Java và JavaScript networking

### 2. **Files đã thay đổi**

```
modified:   hugo.yaml
modified:   layouts/partials/extend_head.html
new:        layouts/partials/templates/schema_json.html
```

---

## 📋 Các Bước Deploy

### **Bước 1: Add và Commit Changes**

```bash
# Add tất cả files đã thay đổi
git add hugo.yaml
git add layouts/partials/extend_head.html
git add layouts/partials/templates/

# Commit với message mô tả rõ ràng
git commit -m "✨ Fix avatar display and improve styling

- Update baseURL to '/' for proper path resolution
- Add custom CSS for circular avatar with shadow effects
- Add hover animations for better UX
- Disable schema JSON temporarily to fix build issues
- Avatar now displays correctly in both header and profile"
```

### **Bước 2: Push Lên Branch Main**

```bash
# Checkout sang branch main (nếu đang ở branch base)
git checkout main

# Merge changes từ base (nếu cần)
git merge base

# Hoặc cherry-pick commits cụ thể
# git cherry-pick <commit-hash>

# Push lên GitHub
git push origin main
```

### **Bước 3: Cấu Hình GitHub Pages**

1. **Truy cập repository trên GitHub:**

   ```
   https://github.com/handzvcl/blog-handzvcl-laptrinhmang
   ```

2. **Vào Settings → Pages:**

   - Click vào tab **Settings**
   - Scroll xuống tìm **Pages** ở sidebar bên trái

3. **Cấu hình Source:**

   - **Source**: Chọn `GitHub Actions`
   - (Không cần chọn branch như trước, vì workflow sẽ tự động deploy)

4. **Xác nhận workflow:**
   - Vào tab **Actions**
   - Bạn sẽ thấy workflow "Deploy Hugo to GitHub Pages" đang chạy
   - Đợi workflow hoàn thành (icon xanh ✓)

### **Bước 4: Truy Cập Website**

Sau khi workflow chạy xong, website sẽ có tại:

```
https://handzvcl.github.io/blog-handzvcl-laptrinhmang/
```

⏱️ **Thời gian deploy:** Khoảng 2-3 phút

---

## 🔧 GitHub Actions Workflow

Workflow tự động chạy khi:

- Push code lên branch `main`
- Hoặc trigger thủ công qua Actions tab

**Workflow thực hiện:**

1. ✓ Install Hugo v0.120.0 Extended
2. ✓ Checkout code với submodules (theme)
3. ✓ Setup GitHub Pages
4. ✓ Build site với baseURL tự động từ GitHub Pages
5. ✓ Deploy lên GitHub Pages

---

## 🎨 Tính Năng Đã Cải Thiện

### **Avatar:**

- ✅ Bo tròn hoàn hảo (border-radius: 50%)
- ✅ Đổ bóng đẹp mắt với shadow
- ✅ Hiệu ứng hover phóng to mượt mà
- ✅ Border 2px cho logo trong header
- ✅ Responsive với cả light/dark mode

### **Build:**

- ✅ Minify HTML/CSS/JS
- ✅ Generate sitemap, RSS, search index
- ✅ SEO meta tags đầy đủ
- ✅ Social media cards (OG, Twitter)

---

## 🐛 Troubleshooting

### **Nếu avatar không hiển thị:**

1. Check file tồn tại: `static/images/avatar.jpg`
2. Rebuild: `hugo --cleanDestinationDir`
3. Check path trong HTML: `/images/avatar.jpg`

### **Nếu workflow fail:**

1. Vào Actions tab xem log lỗi
2. Check Hugo version trong workflow (0.120.0)
3. Ensure theme submodule đã được checkout

### **Nếu 404 Not Found:**

1. Đợi 5-10 phút sau khi deploy xong
2. Check GitHub Pages settings đã enable chưa
3. Clear browser cache (Ctrl + F5)

---

## 📝 Cấu Trúc Repository

```
blog-handzvcl-laptrinhmang/
├── .github/
│   └── workflows/
│       └── gh-pages.yml          # GitHub Actions workflow
├── content/
│   └── blog/                     # 9 blog posts
│       ├── java-socket-serversocket/
│       ├── java-http-co-ban/
│       ├── java-nio-networking/
│       ├── java-server-da-luong/
│       ├── java-lap-trinh-mang-tong-quan/
│       ├── js-fetch-axios-api/
│       ├── js-node-tcp-client/
│       ├── js-websocket-browser/
│       └── bao-mat-https-cors-csrf/
├── layouts/
│   └── partials/
│       ├── extend_head.html      # Custom CSS cho avatar
│       └── templates/
│           └── schema_json.html  # Disabled schema.org
├── static/
│   └── images/
│       └── avatar.jpg            # Avatar image
├── themes/
│   └── PaperMod/                 # Theme (git submodule)
├── hugo.yaml                      # Main config
└── public/                        # Generated site (not in git)
```

---

## 🎯 URL Sau Khi Deploy

- **Homepage:** https://handzvcl.github.io/blog-handzvcl-laptrinhmang/
- **Blog:** https://handzvcl.github.io/blog-handzvcl-laptrinhmang/blog/
- **Tags:** https://handzvcl.github.io/blog-handzvcl-laptrinhmang/tags/
- **Search:** https://handzvcl.github.io/blog-handzvcl-laptrinhmang/search/
- **RSS:** https://handzvcl.github.io/blog-handzvcl-laptrinhmang/index.xml

---

## 📱 Test Local Trước Khi Deploy

```bash
# Build production
hugo --cleanDestinationDir --minify

# Run local server
hugo server

# Open browser
# http://localhost:1313/
```

---

## ✨ Next Steps (Tùy chọn)

1. **Custom Domain:**

   - Mua domain (VD: phanhan.dev)
   - Add CNAME file vào static/
   - Configure DNS

2. **Google Analytics:**

   - Thêm tracking ID vào `hugo.yaml`

3. **Comments:**

   - Enable Giscus/Utterances
   - Configure trong `hugo.yaml`

4. **Social Links:**
   - Update LinkedIn URL (dòng 83)
   - Update Email (dòng 85)

---

## 📞 Support

Nếu gặp vấn đề:

1. Check Actions tab xem workflow logs
2. Xem Hugo documentation: https://gohugo.io/
3. PaperMod theme docs: https://github.com/adityatelange/hugo-PaperMod/wiki

---

**🎉 Chúc mừng! Blog của bạn sẵn sàng để deploy!**
