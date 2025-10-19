# 🚀 Bắt Đầu Ngay Lập Tức

Chào mừng bạn đến với **Blog Lập Trình Mạng**! 🎉

## ⚡ 3 Bước Đơn Giản

### Bước 1: Chạy Script Khởi Tạo

#### Windows (PowerShell):

```powershell
.\init.ps1
```

#### macOS/Linux (Terminal):

```bash
chmod +x init.sh
./init.sh
```

Script này sẽ tự động:

- ✅ Kiểm tra Git và Hugo
- ✅ Khởi tạo Git repository
- ✅ Tải theme PaperMod
- ✅ Tạo commit đầu tiên

---

### Bước 2: Thêm Ảnh Đại Diện

Copy ảnh của bạn vào:

```
static/images/avatar.jpg
```

**Lưu ý:** Nếu chưa có ảnh, blog vẫn chạy được, chỉ không hiển thị avatar.

---

### Bước 3: Xem Blog

```bash
hugo server -D
```

Mở trình duyệt: **http://localhost:1313**

---

## 🎯 Đó Là Tất Cả!

Blog của bạn đã sẵn sàng với:

- ✅ 9 bài viết về Java & JavaScript Network Programming
- ✅ Giao diện tối giản, responsive
- ✅ Dark mode
- ✅ SEO được tối ưu
- ✅ Sẵn sàng deploy lên GitHub Pages

---

## 📚 Tiếp Theo Là Gì?

### Cá Nhân Hóa Blog

Sửa file `hugo.yaml` để cập nhật:

- **baseURL**: URL của bạn (sau khi deploy)
- **params.author**: Tên và bio của bạn
- **params.social**: Liên kết GitHub, LinkedIn, Email

### Deploy Lên GitHub Pages

1. Tạo repo mới trên GitHub: `blog-lap-trinh-mang`
2. Chạy lệnh:
   ```bash
   git remote add origin https://github.com/<username>/blog-lap-trinh-mang.git
   git branch -M main
   git push -u origin main
   ```
3. Vào **Settings > Pages > Source**: Chọn **GitHub Actions**
4. Sau vài phút, blog sẽ live tại:
   ```
   https://<username>.github.io/blog-lap-trinh-mang/
   ```

### Viết Bài Mới

```bash
hugo new blog/ten-bai-viet/index.md
```

Sửa file vừa tạo, sau đó:

```bash
hugo server -D
```

---

## 🆘 Gặp Vấn Đề?

### Hugo chưa cài đặt?

**Windows:**

```powershell
choco install hugo-extended -y
```

**macOS:**

```bash
brew install hugo
```

**Linux (Ubuntu):**

```bash
sudo snap install hugo
```

### Git chưa cài đặt?

Tải tại: https://git-scm.com/downloads

### Cần trợ giúp thêm?

Xem các file tài liệu:

- **README.md** - Tổng quan dự án
- **SETUP.md** - Hướng dẫn chi tiết
- **QUICKSTART.md** - Các lệnh nhanh
- **CHEATSHEET.md** - Cheat sheet Hugo & Git
- **CONTRIBUTING.md** - Cách đóng góp
- **PROJECT_STRUCTURE.md** - Cấu trúc thư mục

---

## ✨ Tính Năng Nổi Bật

- 🎨 **Giao diện tối giản** - Dễ đọc, dễ điều hướng
- 🌙 **Dark Mode** - Tự động hoặc thủ công
- 📱 **Responsive** - Hoàn hảo trên mọi thiết bị
- ⚡ **Hiệu suất cao** - Lighthouse Score ≥ 90
- 🔍 **SEO tối ưu** - Sitemap, RSS, OpenGraph, Schema.org
- 🤖 **CI/CD tự động** - Deploy tự động mỗi lần push
- 📊 **9 bài viết chất lượng** - Sẵn sàng sử dụng

---

## 🎓 Nội Dung Blog

### Java Networking (5 bài)

1. Tổng quan lập trình mạng với Java
2. Hiểu Socket và ServerSocket trong Java
3. Xử lý đa luồng cho server TCP (ExecutorService)
4. Giao thức HTTP cơ bản cho lập trình viên Java
5. Java NIO và Channel/Selector trong ứng dụng mạng

### JavaScript Networking (3 bài)

6. WebSocket bằng JavaScript phía trình duyệt
7. Fetch API & Axios: gọi API hiệu quả
8. Xây dựng client TCP nhỏ bằng Node.js (net module)

### Security (1 bài)

9. Bảo mật cơ bản: HTTPS, CORS, CSRF cho lập trình mạng

---

## 🏆 Checklist Hoàn Thành

- [ ] Chạy `init.ps1` hoặc `init.sh`
- [ ] Thêm ảnh đại diện (`static/images/avatar.jpg`)
- [ ] Chạy `hugo server -D` và xem blog
- [ ] Cập nhật `hugo.yaml` với thông tin cá nhân
- [ ] Tạo repo trên GitHub
- [ ] Push code lên GitHub
- [ ] Enable GitHub Pages (GitHub Actions)
- [ ] Kiểm tra blog live trên GitHub Pages

---

## 🎉 Chúc Mừng!

Bạn đã có một blog cá nhân chuyên nghiệp về lập trình mạng!

**Happy Coding!** 💻🚀

---

_© 2025 Blog Lập Trình Mạng - Powered by Hugo & PaperMod_
