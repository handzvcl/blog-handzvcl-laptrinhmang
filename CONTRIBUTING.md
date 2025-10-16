# Contributing Guidelines

Cảm ơn bạn quan tâm đến việc đóng góp cho blog này! 🎉

## 🤝 Cách đóng góp

### 1. Báo lỗi (Bug Reports)

Nếu bạn phát hiện lỗi, vui lòng tạo issue với thông tin:

- **Mô tả lỗi**: Mô tả rõ ràng về lỗi
- **Cách reproduce**: Các bước để tái hiện lỗi
- **Expected behavior**: Hành vi mong đợi
- **Screenshots**: Nếu có
- **Environment**: Browser, OS, Hugo version

### 2. Đề xuất tính năng (Feature Requests)

Tạo issue với label `enhancement` bao gồm:

- **Mô tả tính năng**: Tính năng bạn muốn thêm
- **Use case**: Tại sao tính năng này hữu ích
- **Ví dụ**: Mock-up hoặc ví dụ cụ thể

### 3. Đóng góp code

#### Quy trình

1. **Fork repository**

```bash
# Click "Fork" trên GitHub
```

2. **Clone fork của bạn**

```bash
git clone https://github.com/your-username/blog-lap-trinh-mang.git
cd blog-lap-trinh-mang
git submodule update --init --recursive
```

3. **Tạo branch mới**

```bash
git checkout -b feature/amazing-feature
# Hoặc
git checkout -b fix/bug-description
```

4. **Thực hiện thay đổi**

```bash
# Code...
hugo server -D  # Test local
```

5. **Commit changes**

```bash
git add .
git commit -m "Add: Amazing feature"
```

**Commit message format:**

- `Add: Thêm tính năng mới`
- `Fix: Sửa lỗi X`
- `Update: Cập nhật Y`
- `Docs: Cập nhật documentation`
- `Style: Format code, CSS changes`

6. **Push to your fork**

```bash
git push origin feature/amazing-feature
```

7. **Tạo Pull Request**

- Vào GitHub fork của bạn
- Click "New Pull Request"
- Điền mô tả chi tiết về thay đổi
- Submit PR

### 4. Đóng góp bài viết

Nếu bạn muốn đóng góp bài viết mới:

1. Fork repository
2. Tạo bài viết mới:

```bash
hugo new blog/ten-bai-viet/index.md
```

3. Viết nội dung với front matter đầy đủ:

```yaml
---
title: "Tiêu đề bài viết"
date: 2025-10-20
draft: false
tags: ["Java", "JavaScript", "Networking"]
categories: ["Java"]
summary: "Mô tả ngắn gọn (100-160 chars)"
---
Nội dung bài viết...
```

4. Đảm bảo:

   - Nội dung tiếng Việt
   - Code examples rõ ràng
   - Proper markdown formatting
   - 600-1500 từ
   - Tag và category phù hợp

5. Tạo Pull Request với mô tả bài viết

## 📝 Style Guide

### Markdown

- Sử dụng headings đúng hierarchy (##, ###)
- Code blocks với syntax highlighting
- Lists cho nội dung dễ scan
- Links descriptive
- Alt text cho images

### Code Style

**Java:**

```java
public class Example {
    public static void main(String[] args) {
        // Comment tiếng Việt
        System.out.println("Hello");
    }
}
```

**JavaScript:**

```javascript
// Comment tiếng Việt
function example() {
  console.log("Hello");
}
```

### Tiếng Việt

- Sử dụng tiếng Việt có dấu
- Dùng thuật ngữ tiếng Anh khi cần thiết (socket, thread, etc.)
- Giải thích thuật ngữ lần đầu xuất hiện

## ✅ Checklist trước khi submit PR

- [ ] Code chạy được và không có lỗi
- [ ] Test local với `hugo server -D`
- [ ] Commit messages rõ ràng
- [ ] Documentation được cập nhật (nếu cần)
- [ ] Không có conflict với main branch
- [ ] PR description chi tiết

## 🚫 Không chấp nhận

- Code có lỗi hoặc không chạy
- Nội dung không liên quan đến chủ đề blog
- Spam, quảng cáo
- Nội dung vi phạm bản quyền
- Code không format

## 💬 Giao tiếp

- Tôn trọng lẫn nhau
- Constructive feedback
- Tiếng Việt hoặc tiếng Anh đều OK
- Be patient - maintainer có thể mất vài ngày để review

## 📄 License

Khi đóng góp, bạn đồng ý rằng contributions của bạn sẽ được license dưới MIT License.

## 🙏 Cảm ơn

Mọi đóng góp đều được trân trọng! Dù là:

- Sửa typo
- Báo lỗi
- Đề xuất tính năng
- Viết bài mới
- Cải thiện documentation

Cảm ơn bạn đã giúp làm blog này tốt hơn! 🚀
