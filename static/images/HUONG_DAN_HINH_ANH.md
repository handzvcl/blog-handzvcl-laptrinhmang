# 📸 Hướng Dẫn Thêm Hình Ảnh

## 🎯 Cách Thêm Ảnh Đại Diện (Avatar)

### Bước 1: Chuẩn bị ảnh

- **File name:** `avatar.jpg` (hoặc `.png`, `.webp`)
- **Kích thước:** 300x300px đến 500x500px (vuông)
- **Dung lượng:** < 200KB
- **Chất lượng:** Rõ nét, tỷ lệ 1:1

### Bước 2: Copy vào thư mục

```
Copy ảnh của bạn vào đây:
static/images/avatar.jpg
```

### Bước 3: Hugo tự động nhận

- Hugo sẽ tự động copy sang `public/images/avatar.jpg`
- Ảnh sẽ hiển thị trên trang chủ
- Không cần restart server (hot reload)

---

## 🖼️ Cách Thêm Cover Image Cho Bài Viết

### Option 1: Ảnh trong thư mục bài viết (Khuyên dùng)

1. **Copy ảnh vào thư mục bài viết:**

   ```
   content/blog/java-socket-serversocket/cover.jpg
   ```

2. **Sửa front matter:**
   ```yaml
   ---
   title: "Tiêu đề"
   cover:
     image: cover.jpg
     alt: "Mô tả ảnh"
     caption: "Nguồn ảnh"
   ---
   ```

### Option 2: Ảnh trong static (Dùng chung nhiều bài)

1. **Copy ảnh vào:**

   ```
   static/images/covers/java-socket.png
   ```

2. **Sửa front matter:**
   ```yaml
   cover:
     image: /images/covers/java-socket.png
     alt: "Mô tả ảnh"
   ```

---

## 🎨 Cách Thêm Ảnh Trong Nội Dung

### Markdown cơ bản:

```markdown
![Mô tả ảnh](image.jpg)
```

### Với đường dẫn tuyệt đối:

```markdown
![Sơ đồ](/images/diagrams/architecture.png)
```

### Hugo Figure Shortcode:

```markdown
{{< figure src="diagram.png"
           alt="Sơ đồ kiến trúc"
           caption="Hình 1: Kiến trúc hệ thống"
           width="600px" >}}
```

---

## 🌐 Cách Thêm Favicon

### Bước 1: Tạo favicon

Sử dụng tools online:

- https://realfavicongenerator.net/
- https://favicon.io/

### Bước 2: Copy vào static

```
static/
├── favicon.ico
├── favicon-16x16.png
├── favicon-32x32.png
└── apple-touch-icon.png
```

### Bước 3: Hugo tự động nhận (đã config)

---

## 📁 Cấu Trúc Thư Mục Đề Xuất

```
static/
├── images/
│   ├── avatar.jpg              ← Ảnh đại diện
│   ├── site-cover.png          ← Ảnh SEO mặc định
│   │
│   ├── covers/                 ← Cover images
│   │   ├── java-socket.png
│   │   ├── java-nio.png
│   │   ├── websocket.png
│   │   └── security.png
│   │
│   └── diagrams/               ← Sơ đồ, minh họa
│       ├── tcp-flow.png
│       ├── osi-model.png
│       └── socket-lifecycle.png
│
├── favicon.ico                 ← Favicon files
├── favicon-16x16.png
├── favicon-32x32.png
└── apple-touch-icon.png
```

---

## ⚠️ LƯU Ý QUAN TRỌNG

### ✅ ĐÚNG:

- Đặt ảnh trong `static/images/`
- Hugo tự động copy sang `public/images/`
- Hot reload tự động

### ❌ SAI:

- **KHÔNG** đặt ảnh trực tiếp trong `public/`
- `public/` là thư mục build tự động
- Sẽ bị xóa mỗi lần build lại

---

## 🎯 Checklist Hình Ảnh

### Ảnh Đại Diện

- [ ] File: `static/images/avatar.jpg`
- [ ] Kích thước: 300-500px (vuông)
- [ ] Dung lượng: < 200KB

### Cover Images (9 bài)

- [ ] `static/images/covers/java-overview.png`
- [ ] `static/images/covers/java-socket.png`
- [ ] `static/images/covers/java-threading.png`
- [ ] `static/images/covers/java-http.png`
- [ ] `static/images/covers/java-nio.png`
- [ ] `static/images/covers/js-websocket.png`
- [ ] `static/images/covers/js-fetch.png`
- [ ] `static/images/covers/js-node-tcp.png`
- [ ] `static/images/covers/security.png`

### Favicon

- [ ] `static/favicon.ico`
- [ ] `static/favicon-16x16.png`
- [ ] `static/favicon-32x32.png`
- [ ] `static/apple-touch-icon.png`

---

## 🚀 Bắt Đầu Ngay

### Thêm Ảnh Đại Diện:

1. Chọn ảnh của bạn
2. Đổi tên thành `avatar.jpg`
3. Copy vào `static/images/avatar.jpg`
4. Mở http://localhost:1313 → Xem kết quả!

### Thêm Cover Cho Bài Viết:

1. Tìm/tạo ảnh phù hợp với chủ đề
2. Copy vào `static/images/covers/`
3. Sửa front matter của bài viết
4. Reload trang → Xong!

---

## 📚 Tools Hữu Ích

### Tạo/Chỉnh sửa ảnh:

- **Photopea**: https://photopea.com (Free Photoshop online)
- **Canva**: https://canva.com (Thiết kế đơn giản)
- **Remove.bg**: https://remove.bg (Xóa background)

### Tối ưu ảnh:

- **TinyPNG**: https://tinypng.com
- **Squoosh**: https://squoosh.app
- **ImageOptim** (Mac)

### Tìm ảnh miễn phí:

- **Unsplash**: https://unsplash.com
- **Pexels**: https://pexels.com
- **Pixabay**: https://pixabay.com

### Tạo Favicon:

- **RealFaviconGenerator**: https://realfavicongenerator.net
- **Favicon.io**: https://favicon.io

---

**🎉 Chúc bạn tạo blog đẹp mắt!**

_Lưu ý: Mọi thay đổi trong `static/` sẽ tự động reload, không cần restart server._
