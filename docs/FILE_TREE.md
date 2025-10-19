# 📁 Cấu Trúc File Dự Án

## 🌲 Tree View - Toàn Bộ Dự Án

```
blog-lap-trinh-mang/
│
├── 📄 hugo.yaml                        # Cấu hình Hugo chính
├── 📄 LICENSE                          # MIT License
├── 📄 .gitignore                       # Git ignore rules
├── 📄 .gitmodules                      # Theme submodule config
│
├── 🚀 init.ps1                         # Script khởi tạo Windows
├── 🚀 init.sh                          # Script khởi tạo macOS/Linux
│
├── 📚 README.md                        # Tổng quan dự án ⭐
├── 📚 SETUP.md                         # Hướng dẫn cài đặt
├── 📚 QUICKSTART.md                    # Lệnh nhanh
├── 📚 CHEATSHEET.md                    # Cheat sheet
├── 📚 CONTRIBUTING.md                  # Hướng dẫn đóng góp
├── 📚 PROJECT_STRUCTURE.md             # Cấu trúc chi tiết
├── 📚 GET_STARTED.md                   # Hướng dẫn toàn diện
├── 📚 START_HERE.md                    # Điểm khởi đầu
├── 📚 INDEX.md                         # Chỉ mục tài liệu
├── 📚 SUMMARY.md                       # Tóm tắt metrics
├── 📚 BAT_DAU_NGAY.md                  # Bắt đầu ngay! ⭐⭐⭐
├── 📚 HOAN_TAT.md                      # Hoàn tất dự án
├── 📚 NEXT_STEPS.md                    # Các bước tiếp theo ⭐⭐
├── 📚 FILE_TREE.md                     # File này!
│
├── 📂 content/                         # Nội dung blog
│   ├── 📄 _index.md                   # Trang chủ (Profile)
│   ├── 📄 archives.md                 # Trang archive
│   ├── 📄 search.md                   # Trang tìm kiếm
│   │
│   └── 📂 blog/                        # Thư mục blog
│       ├── 📄 _index.md               # Danh sách blog
│       │
│       ├── 📂 java-lap-trinh-mang-tong-quan/
│       │   └── 📄 index.md            # Bài 1: Tổng quan Java networking
│       │
│       ├── 📂 java-socket-serversocket/
│       │   └── 📄 index.md            # Bài 2: Socket & ServerSocket
│       │
│       ├── 📂 java-server-da-luong/
│       │   └── 📄 index.md            # Bài 3: Multithreading TCP server
│       │
│       ├── 📂 java-http-co-ban/
│       │   └── 📄 index.md            # Bài 4: HTTP cơ bản
│       │
│       ├── 📂 java-nio-networking/
│       │   └── 📄 index.md            # Bài 5: Java NIO
│       │
│       ├── 📂 js-websocket-browser/
│       │   └── 📄 index.md            # Bài 6: WebSocket browser
│       │
│       ├── 📂 js-fetch-axios-api/
│       │   └── 📄 index.md            # Bài 7: Fetch API & Axios
│       │
│       ├── 📂 js-node-tcp-client/
│       │   └── 📄 index.md            # Bài 8: Node.js TCP client
│       │
│       └── 📂 bao-mat-https-cors-csrf/
│           └── 📄 index.md            # Bài 9: Security (HTTPS, CORS, CSRF)
│
├── 📂 layouts/                         # Custom layouts
│   └── 📂 partials/
│       └── 📄 extend_head.html        # SEO meta tags
│
├── 📂 static/                          # Static files
│   ├── 📄 robots.txt                  # SEO cho search engines
│   ├── 📄 .nojekyll                   # Disable Jekyll
│   │
│   └── 📂 images/                      # Images
│       └── 📄 README.md               # Hướng dẫn thêm ảnh
│       └── [avatar.jpg]               # ⚠️ CẦN THÊM
│
├── 📂 themes/                          # Themes (tạo bởi init script)
│   └── 📂 PaperMod/                    # ⚠️ CẦN CHẠY init.ps1/init.sh
│       └── [PaperMod theme files]
│
└── 📂 .github/                         # GitHub Actions
    └── 📂 workflows/
        └── 📄 gh-pages.yml            # CI/CD workflow
```

---

## 📊 Thống Kê Chi Tiết

### Theo Loại File

| Loại         | Số Lượng | Mô Tả                                                 |
| ------------ | -------- | ----------------------------------------------------- |
| **Cấu hình** | 3        | `hugo.yaml`, `.gitignore`, `.gitmodules`              |
| **Content**  | 13       | Trang chủ, blog listing, 9 bài viết, archives, search |
| **Layouts**  | 1        | SEO partial                                           |
| **Static**   | 3        | `robots.txt`, `.nojekyll`, `images/README.md`         |
| **CI/CD**    | 1        | GitHub Actions workflow                               |
| **Scripts**  | 2        | `init.ps1`, `init.sh`                                 |
| **Docs**     | 14       | Tất cả file `.md` hướng dẫn                           |
| **License**  | 1        | MIT License                                           |
| **TỔNG**     | **38**   | **Tất cả files**                                      |

### Theo Thư Mục

```
content/          : 13 files (trang + bài viết)
.github/          :  1 file  (CI/CD)
layouts/          :  1 file  (SEO)
static/           :  3 files (robots, images)
themes/           :  0 files (⚠️ cần chạy init script)
[root]            : 20 files (config + docs + scripts)
```

---

## 📝 Các File Quan Trọng

### ⭐⭐⭐ BẮT ĐẦU TỪ ĐÂY

1. **BAT_DAU_NGAY.md** - Hướng dẫn bắt đầu nhanh nhất
2. **NEXT_STEPS.md** - 3 lệnh cần chạy
3. **init.ps1** / **init.sh** - Script khởi tạo

### ⭐⭐ ĐỌC TIẾP

4. **README.md** - Tổng quan dự án
5. **HOAN_TAT.md** - Chi tiết những gì đã hoàn thành
6. **SETUP.md** - Hướng dẫn cài đặt chi tiết

### ⭐ THAM KHẢO KHI CẦN

7. **QUICKSTART.md** - Các lệnh nhanh
8. **CHEATSHEET.md** - Cheat sheet Hugo & Git
9. **CONTRIBUTING.md** - Quy tắc đóng góp
10. **PROJECT_STRUCTURE.md** - Cấu trúc chi tiết

---

## 🔍 Chi Tiết Các Thư Mục

### 📂 `content/` - Nội Dung Blog

**Mục đích:** Chứa tất cả nội dung Markdown của blog

**Cấu trúc:**

```
content/
├── _index.md              → Trang chủ (/) - Profile page
├── archives.md            → Archive page (/archives/)
├── search.md              → Search page (/search/)
└── blog/
    ├── _index.md          → Blog listing (/blog/)
    └── [slug]/
        └── index.md       → Bài viết (/blog/[slug]/)
```

**Lưu ý:**

- Mỗi bài viết nằm trong thư mục riêng
- File bài viết luôn tên `index.md`
- Có thể thêm ảnh vào cùng thư mục với bài viết

---

### 📂 `layouts/` - Custom Layouts

**Mục đích:** Override hoặc extend theme layouts

**Hiện có:**

```
layouts/
└── partials/
    └── extend_head.html   → Thêm SEO meta tags
```

**Có thể thêm:**

- `layouts/partials/extend_footer.html` - Custom footer
- `layouts/shortcodes/` - Custom shortcodes
- `layouts/_default/` - Override default templates

---

### 📂 `static/` - Static Files

**Mục đích:** Files tĩnh (ảnh, fonts, etc.) được copy nguyên vẹn

**Cấu trúc:**

```
static/
├── robots.txt             → SEO cho search engines
├── .nojekyll              → Disable Jekyll processing
├── images/
│   ├── avatar.jpg         → ⚠️ CẦN THÊM (ảnh profile)
│   ├── [cover-*.jpg]      → Optional: cover images cho bài viết
│   └── README.md          → Hướng dẫn
└── [favicon.ico]          → Optional: favicon
```

**URL mapping:**

```
static/images/avatar.jpg  →  /images/avatar.jpg
static/robots.txt         →  /robots.txt
```

---

### 📂 `themes/` - Hugo Themes

**Mục đích:** Chứa theme PaperMod

**⚠️ QUAN TRỌNG:**

- Thư mục này **CHƯA TỒN TẠI** cho đến khi chạy `init.ps1`/`init.sh`
- Theme được quản lý bằng Git submodule
- **KHÔNG** commit toàn bộ theme vào repo

**Sau khi chạy init script:**

```
themes/
└── PaperMod/              → Hugo theme (Git submodule)
    ├── layouts/
    ├── assets/
    ├── static/
    └── ...
```

---

### 📂 `.github/workflows/` - CI/CD

**Mục đích:** GitHub Actions workflows

**Hiện có:**

```
.github/
└── workflows/
    └── gh-pages.yml       → Deploy tự động lên GitHub Pages
```

**Workflow hoạt động:**

1. Trigger: Push lên branch `main`
2. Install Hugo & Dart Sass
3. Checkout code (including submodules)
4. Build: `hugo --gc --minify`
5. Upload artifact
6. Deploy to GitHub Pages

---

## 🎯 Files Cần Tạo/Sửa Thủ Công

### ⚠️ BẮT BUỘC

1. **Chạy init script:**

   ```bash
   .\init.ps1  # Windows
   ./init.sh   # macOS/Linux
   ```

   ➜ Tạo `themes/PaperMod/`

2. **Thêm ảnh đại diện:**

   ```
   Copy ảnh vào: static/images/avatar.jpg
   ```

3. **Sửa thông tin cá nhân:**
   ```
   Sửa file: hugo.yaml
   - baseURL
   - params.author
   - socialIcons
   ```

### 💡 TÙY CHỌN

4. **Favicon:**

   ```
   static/favicon.ico
   static/favicon-16x16.png
   static/favicon-32x32.png
   static/apple-touch-icon.png
   ```

5. **Cover images cho bài viết:**

   ```
   content/blog/[slug]/cover.jpg
   ```

   Thêm vào front matter:

   ```yaml
   cover:
     image: cover.jpg
     alt: "Mô tả ảnh"
   ```

6. **Google Analytics:**
   ```yaml
   # hugo.yaml
   params:
     analytics:
       google:
         SiteVerificationTag: "G-XXXXXXXXXX"
   ```

---

## 🗺️ URL Structure

Sau khi deploy, cấu trúc URL:

```
https://<username>.github.io/blog-lap-trinh-mang/
│
├── /                              → Trang chủ (Profile)
├── /blog/                         → Danh sách blog
├── /blog/java-socket-serversocket/ → Bài viết cụ thể
├── /tags/                         → Tất cả tags
├── /tags/java/                    → Bài viết tag "Java"
├── /categories/                   → Tất cả categories
├── /archives/                     → Archive timeline
├── /search/                       → Tìm kiếm
├── /index.xml                     → RSS feed
└── /sitemap.xml                   → Sitemap
```

---

## 🚀 Generated Files (Không Commit)

Sau khi chạy `hugo` hoặc `hugo server`, các files được tạo:

```
public/                    # Build output (gitignored)
├── index.html
├── blog/
├── css/
├── js/
└── ...

resources/                 # Hugo cache (gitignored)
└── _gen/
    ├── assets/
    └── images/

.hugo_build.lock           # Build lock file (gitignored)
```

**⚠️ KHÔNG commit các thư mục này!** (Đã có trong `.gitignore`)

---

## 📦 Kích Thước Dự Án

```
Source code (không kể theme):  ~500 KB
Theme PaperMod:                 ~2 MB
Generated build (public/):      ~1-2 MB
Total repo size:                ~3-4 MB
```

Rất nhẹ và nhanh! ⚡

---

## 🔗 Dependencies

### Git Submodules

```
themes/PaperMod → https://github.com/adityatelange/hugo-PaperMod.git
```

### External Services

- **GitHub** - Code hosting
- **GitHub Pages** - Website hosting
- **GitHub Actions** - CI/CD

### Local Tools Required

- **Hugo** (extended version) ≥ 0.110.0
- **Git** ≥ 2.0

---

## 📋 Quick Reference

### Thêm Bài Viết Mới

```bash
hugo new blog/ten-bai-moi/index.md
```

### Thêm Ảnh Vào Bài Viết

```
1. Copy ảnh vào: content/blog/ten-bai-moi/image.jpg
2. Trong bài viết: ![Alt text](image.jpg)
```

### Cập Nhật Theme

```bash
git submodule update --remote --merge
```

### Local Development

```bash
hugo server -D           # Xem drafts
hugo server -D --noHTTPCache  # Disable cache
```

### Build Production

```bash
hugo --gc --minify       # Output: public/
```

---

## 🎓 Learning Path

### Muốn Sửa Giao Diện?

➜ Đọc: `themes/PaperMod/layouts/`

### Muốn Thêm Shortcode?

➜ Tạo: `layouts/shortcodes/`

### Muốn Custom CSS?

➜ Tạo: `assets/css/extended/custom.css`

### Muốn Thêm JS?

➜ Tạo: `assets/js/extended/custom.js`

---

## ✅ Checklist Files Đầy Đủ

```
[✓] hugo.yaml
[✓] LICENSE
[✓] .gitignore
[✓] .gitmodules
[✓] init.ps1
[✓] init.sh
[✓] 14 files tài liệu .md
[✓] content/ (13 files)
[✓] layouts/ (1 file)
[✓] static/ (3 files)
[✓] .github/workflows/ (1 file)
[ ] themes/PaperMod/ (⚠️ chạy init script)
[ ] static/images/avatar.jpg (⚠️ thêm thủ công)
```

---

**🎉 TẤT CẢ FILES ĐÃ SẴN SÀNG!**

**👉 Bước tiếp theo: Đọc `BAT_DAU_NGAY.md` hoặc `NEXT_STEPS.md`**

---

_© 2025 Blog Lập Trình Mạng_
