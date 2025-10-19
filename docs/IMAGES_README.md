# Images Directory

Đặt các hình ảnh cho blog tại đây.

## Cấu trúc

```
images/
├── avatar.jpg              # Ảnh đại diện profile
├── site-cover.png          # Ảnh cover mặc định cho site
└── covers/                 # Ảnh cover cho các bài viết
    ├── java-networking-overview.png
    ├── java-socket.png
    ├── java-multithreading.png
    ├── java-http.png
    ├── java-nio.png
    ├── js-websocket.png
    ├── js-fetch-axios.png
    ├── nodejs-tcp.png
    └── web-security.png
```

## Hướng dẫn

1. **Avatar**: Thêm ảnh đại diện tên `avatar.jpg` (khuyến nghị 180x180px)
2. **Site Cover**: Thêm ảnh cover mặc định `site-cover.png` (1200x630px cho social sharing)
3. **Post Covers**: Thêm ảnh cover cho từng bài viết trong thư mục `covers/`

## Tạo placeholder images

Bạn có thể tạo placeholder images tại:

- https://placehold.co/
- https://placeholder.com/
- https://via.placeholder.com/

Ví dụ:

```bash
# Download placeholder images
curl -o avatar.jpg "https://placehold.co/180x180/2563eb/white?text=PH"
curl -o site-cover.png "https://placehold.co/1200x630/2563eb/white?text=Blog+Lap+Trinh+Mang"
```

## Optimize images

Để tối ưu hiệu năng, nên compress images trước khi upload:

- https://tinypng.com/
- https://squoosh.app/
- ImageOptim (macOS)
- GIMP / Photoshop
