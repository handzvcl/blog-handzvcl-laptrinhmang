# 📚 Documentation Index

Chào mừng đến với blog Hugo về lập trình mạng! Đây là danh sách đầy đủ tất cả tài liệu có sẵn.

## 🚀 Bắt đầu nhanh

| File                                 | Mô tả                                 | Thời gian |
| ------------------------------------ | ------------------------------------- | --------- |
| **[GET_STARTED.md](GET_STARTED.md)** | Hướng dẫn đầy đủ từ A-Z với checklist | 30 phút   |
| **[QUICKSTART.md](QUICKSTART.md)**   | Quick start trong 5 phút              | 5 phút    |
| **[CHEATSHEET.md](CHEATSHEET.md)**   | Commands và shortcuts thường dùng     | Tham khảo |

**→ Nếu lần đầu sử dụng, đọc [GET_STARTED.md](GET_STARTED.md)**

## 📖 Tài liệu chính

### Tổng quan

| File                                             | Nội dung                                   | Ai nên đọc    |
| ------------------------------------------------ | ------------------------------------------ | ------------- |
| **[README.md](README.md)**                       | Overview dự án, features, cài đặt, sử dụng | Mọi người     |
| **[SUMMARY.md](SUMMARY.md)**                     | Tổng hợp toàn bộ dự án, metrics, checklist | PM, Developer |
| **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** | Cấu trúc thư mục chi tiết, file paths      | Developer     |

### Setup & Configuration

| File                       | Nội dung                                  | Khi nào dùng      |
| -------------------------- | ----------------------------------------- | ----------------- |
| **[SETUP.md](SETUP.md)**   | Hướng dẫn setup chi tiết, troubleshooting | Khi gặp vấn đề    |
| **[hugo.yaml](hugo.yaml)** | Hugo configuration file                   | Khi cần customize |

### Contributing

| File                                   | Nội dung                         | Ai nên đọc   |
| -------------------------------------- | -------------------------------- | ------------ |
| **[CONTRIBUTING.md](CONTRIBUTING.md)** | Guidelines đóng góp, style guide | Contributors |
| **[LICENSE](LICENSE)**                 | MIT License                      | Mọi người    |

## 📝 Content Files

### Trang chính

| File                     | Mục đích           | URL          |
| ------------------------ | ------------------ | ------------ |
| `content/_index.md`      | Trang Home/Profile | `/`          |
| `content/blog/_index.md` | Blog listing       | `/blog/`     |
| `content/archives.md`    | Archive page       | `/archives/` |
| `content/search.md`      | Search page        | `/search/`   |

### Bài viết (9 posts)

#### Java Posts (5)

1. **[java-lap-trinh-mang-tong-quan](content/blog/java-lap-trinh-mang-tong-quan/index.md)**

   - Tổng quan lập trình mạng với Java
   - Tags: Java, Networking, Socket

2. **[java-socket-serversocket](content/blog/java-socket-serversocket/index.md)**

   - Hiểu Socket và ServerSocket trong Java
   - Tags: Java, Networking, Socket, TCP

3. **[java-server-da-luong](content/blog/java-server-da-luong/index.md)**

   - Xử lý đa luồng cho server TCP
   - Tags: Java, Networking, Concurrency, ExecutorService

4. **[java-http-co-ban](content/blog/java-http-co-ban/index.md)**

   - Giao thức HTTP cơ bản cho Java
   - Tags: Java, HTTP, Networking, REST

5. **[java-nio-networking](content/blog/java-nio-networking/index.md)**
   - Java NIO và Channel/Selector
   - Tags: Java, NIO, Networking, Performance

#### JavaScript Posts (3)

6. **[js-websocket-browser](content/blog/js-websocket-browser/index.md)**

   - WebSocket bằng JavaScript phía browser
   - Tags: JavaScript, WebSocket, Real-time

7. **[js-fetch-axios-api](content/blog/js-fetch-axios-api/index.md)**

   - Fetch API & Axios: gọi API hiệu quả
   - Tags: JavaScript, HTTP, API, Fetch, Axios

8. **[js-node-tcp-client](content/blog/js-node-tcp-client/index.md)**
   - Xây dựng client TCP với Node.js
   - Tags: JavaScript, Node.js, TCP, Networking

#### Security Post (1)

9. **[bao-mat-https-cors-csrf](content/blog/bao-mat-https-cors-csrf/index.md)**
   - Bảo mật cơ bản: HTTPS, CORS, CSRF
   - Tags: Security, HTTPS, CORS, CSRF, Networking

## 🔧 Configuration Files

| File                | Mục đích                     |
| ------------------- | ---------------------------- |
| `hugo.yaml`         | Hugo main configuration      |
| `.gitignore`        | Git ignore rules             |
| `.gitmodules`       | Git submodule config (theme) |
| `static/robots.txt` | SEO robots directives        |
| `static/.nojekyll`  | GitHub Pages config          |

## 🎨 Custom Files

| File                                | Mục đích                  |
| ----------------------------------- | ------------------------- |
| `layouts/partials/extend_head.html` | SEO meta tags, Schema.org |
| `static/images/README.md`           | Images guide              |

## 🚀 CI/CD

| File                             | Mục đích                       |
| -------------------------------- | ------------------------------ |
| `.github/workflows/gh-pages.yml` | GitHub Actions deploy workflow |

## 📊 Statistics

- **Total Documentation Files**: 10
- **Total Content Files**: 13 (4 pages + 9 posts)
- **Total Configuration Files**: 6
- **Total Custom Files**: 2
- **Total Lines**: ~5,000+
- **Total Words**: ~20,000+

## 🎯 Reading Path

### For First-Time Users

```
1. README.md              (10 min) - Overview
2. GET_STARTED.md         (30 min) - Setup step-by-step
3. Test local             (10 min)
4. Deploy to GitHub       (10 min)
5. CHEATSHEET.md          (5 min)  - Keep for reference
```

**Total**: ~1 hour to get blog live

### For Developers

```
1. README.md              - Overview
2. PROJECT_STRUCTURE.md   - Understand structure
3. hugo.yaml              - See configuration
4. CONTRIBUTING.md        - Coding standards
5. CHEATSHEET.md          - Quick reference
```

### For Content Writers

```
1. QUICKSTART.md          - How to add posts
2. CHEATSHEET.md          - Markdown syntax
3. Example posts          - See format
4. Write and publish!
```

### For Troubleshooting

```
1. SETUP.md               - Troubleshooting section
2. CHEATSHEET.md          - Common fixes
3. GitHub Issues          - Search existing issues
4. Hugo Docs              - Official documentation
```

## 🔍 Find Information

### "How do I...?"

| Question              | Answer                                             |
| --------------------- | -------------------------------------------------- |
| ...install Hugo?      | [SETUP.md](SETUP.md) → Section 1                   |
| ...create a new post? | [QUICKSTART.md](QUICKSTART.md) → "Thêm bài viết"   |
| ...change my profile? | [GET_STARTED.md](GET_STARTED.md) → Bước 3          |
| ...deploy to GitHub?  | [GET_STARTED.md](GET_STARTED.md) → Bước 6-10       |
| ...customize CSS?     | [CHEATSHEET.md](CHEATSHEET.md) → "Customization"   |
| ...update theme?      | [CHEATSHEET.md](CHEATSHEET.md) → "Update Theme"    |
| ...add images?        | [static/images/README.md](static/images/README.md) |
| ...fix errors?        | [SETUP.md](SETUP.md) → "Troubleshooting"           |

### "What is...?"

| Topic                | Document                                                               |
| -------------------- | ---------------------------------------------------------------------- |
| Project structure    | [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)                           |
| Hugo configuration   | [hugo.yaml](hugo.yaml) + comments                                      |
| Available commands   | [CHEATSHEET.md](CHEATSHEET.md)                                         |
| Content organization | [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) → "Content Organization"  |
| SEO setup            | [layouts/partials/extend_head.html](layouts/partials/extend_head.html) |
| Deployment process   | [.github/workflows/gh-pages.yml](.github/workflows/gh-pages.yml)       |

## 📱 Quick Links by Role

### 👤 End User (Blog Owner)

Priority reading:

1. [GET_STARTED.md](GET_STARTED.md) - Setup your blog
2. [QUICKSTART.md](QUICKSTART.md) - Daily tasks
3. [CHEATSHEET.md](CHEATSHEET.md) - Commands reference

### 👨‍💻 Developer

Priority reading:

1. [README.md](README.md) - Overview
2. [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) - Architecture
3. [CONTRIBUTING.md](CONTRIBUTING.md) - Dev guidelines
4. [hugo.yaml](hugo.yaml) - Configuration

### ✍️ Content Writer

Priority reading:

1. [QUICKSTART.md](QUICKSTART.md) - Create posts
2. [CHEATSHEET.md](CHEATSHEET.md) - Markdown syntax
3. Example posts in `content/blog/` - Reference

### 🔧 DevOps / Maintainer

Priority reading:

1. [SETUP.md](SETUP.md) - Deployment details
2. [.github/workflows/gh-pages.yml](.github/workflows/gh-pages.yml) - CI/CD
3. [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) - Build process

## 🆘 Help & Support

### I'm stuck!

1. **Search this index** for your topic
2. **Check [SETUP.md](SETUP.md)** troubleshooting
3. **Read [CHEATSHEET.md](CHEATSHEET.md)** for quick fixes
4. **Google** the error message
5. **Create issue** on GitHub

### Common Issues

| Issue               | Solution                                                    |
| ------------------- | ----------------------------------------------------------- |
| Theme not loading   | [SETUP.md](SETUP.md) → Troubleshooting → "Theme không load" |
| Port 1313 in use    | [CHEATSHEET.md](CHEATSHEET.md) → "Port 1313 in use"         |
| GitHub Actions fail | [SETUP.md](SETUP.md) → "GitHub Actions fail"                |
| CSS not applying    | [CHEATSHEET.md](CHEATSHEET.md) → "CSS not applying"         |

## 📞 Contact & Resources

### Internal

- 📧 Email: &lt;email&gt;@example.com
- 🐙 GitHub: [@&lt;username&gt;](https://github.com/<username>)
- 💼 LinkedIn: [linkedin.com/in/&lt;id&gt;](https://linkedin.com/in/<id>)

### External

- [Hugo Documentation](https://gohugo.io/documentation/)
- [PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)
- [Hugo Discourse](https://discourse.gohugo.io/)
- [Markdown Guide](https://www.markdownguide.org/)

## 🎓 Learning Path

### Beginner

```
Day 1: Setup
- READ: GET_STARTED.md
- DO: Clone, configure, deploy
- RESULT: Blog live

Day 2: Content
- READ: QUICKSTART.md
- DO: Write first post
- RESULT: New post published

Day 3: Customize
- READ: CHEATSHEET.md
- DO: Change colors, add avatar
- RESULT: Personalized blog
```

### Intermediate

```
Week 1: Master Hugo
- READ: Hugo Documentation
- DO: Create custom layouts
- RESULT: Understand Hugo deeply

Week 2: Content Strategy
- READ: SEO guides
- DO: Write 3-5 quality posts
- RESULT: Consistent content

Week 3: Optimization
- READ: Performance guides
- DO: Optimize images, add analytics
- RESULT: Fast, trackable blog
```

### Advanced

```
Month 1: Advanced Features
- Custom shortcodes
- Dynamic layouts
- Advanced SEO

Month 2: Integration
- Newsletter signup
- Comments system
- Social sharing

Month 3: Growth
- Analytics deep dive
- Content marketing
- Community building
```

## 🏆 Achievements

Track your progress:

- [ ] Blog setup and deployed
- [ ] Profile customized
- [ ] First post published
- [ ] 10 posts published
- [ ] Custom CSS added
- [ ] Analytics integrated
- [ ] 100 visitors milestone
- [ ] 1000 visitors milestone
- [ ] Guest post published
- [ ] Featured on other sites

## 📈 Next Steps

1. **Start**: Read [GET_STARTED.md](GET_STARTED.md)
2. **Setup**: Follow the checklist
3. **Write**: Create your first post
4. **Share**: Promote on social media
5. **Grow**: Keep writing consistently

## 🎉 You're Ready!

Bạn đã có tất cả tài liệu cần thiết để:

- ✅ Setup blog
- ✅ Customize design
- ✅ Write content
- ✅ Deploy to production
- ✅ Maintain and grow

**Start with**: [GET_STARTED.md](GET_STARTED.md)

Happy blogging! 🚀📝✨

---

**Documentation Version**: 1.0  
**Last Updated**: October 16, 2025  
**Total Pages**: 40+  
**Total Words**: 20,000+

**Need help?** Start with [GET_STARTED.md](GET_STARTED.md) or [SETUP.md](SETUP.md)
