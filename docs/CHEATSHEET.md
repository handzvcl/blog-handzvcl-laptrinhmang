# Hugo Blog Cheat Sheet

Quick reference cho các lệnh và thao tác thường dùng.

## 🚀 Basic Commands

```bash
# Start development server
hugo server -D

# Start with specific port
hugo server -p 1314

# Build site
hugo

# Build with minification
hugo --minify

# Create new post
hugo new blog/post-name/index.md

# Check Hugo version
hugo version
```

## 📝 Content Management

### Tạo bài viết mới

```bash
hugo new blog/ten-bai-viet/index.md
```

### Front Matter Template

```yaml
---
title: "Tiêu đề bài viết"
date: 2025-10-20T10:00:00+07:00
draft: false
tags: ["Java", "Networking"]
categories: ["Java"]
summary: "Mô tả ngắn gọn (100-160 chars)"
cover:
  image: "/images/covers/post.png"
  alt: "Alt text"
  caption: "Caption"
---
```

### Markdown Syntax

```markdown
## Heading 2

### Heading 3

**Bold text**
_Italic text_
**_Bold italic_**

[Link text](https://example.com)

![Image alt](/images/image.png)

- List item 1
- List item 2

1. Numbered item 1
2. Numbered item 2

> Blockquote

`Inline code`

\`\`\`java
// Code block
public class Example {
// ...
}
\`\`\`
```

## 🔧 Git Commands

### Initial Setup

```bash
git clone https://github.com/username/blog.git
cd blog
git submodule update --init --recursive
```

### Daily Workflow

```bash
# Check status
git status

# Add all changes
git add .

# Commit
git commit -m "Add: New post title"

# Push to GitHub (auto deploy)
git push

# Pull latest changes
git pull
```

### Update Theme

```bash
cd themes/PaperMod
git pull origin master
cd ../..
git add themes/PaperMod
git commit -m "Update theme"
git push
```

## 🌐 Deployment

### GitHub Pages Deploy

```bash
# Push to main branch
git push origin main

# GitHub Actions automatically:
# 1. Builds Hugo site
# 2. Deploys to GitHub Pages
# 3. Site live in ~2-3 minutes
```

### Check Deploy Status

1. Go to repository on GitHub
2. Click **Actions** tab
3. See latest workflow run
4. ✅ Green = success
5. ❌ Red = failed (check logs)

## 🎨 Customization

### Update Profile Info

**File: `hugo.yaml`**

```yaml
params:
  author: "Your Name"
  profileMode:
    title: "Your Name"
    subtitle: "Your bio"
    imageUrl: "/images/avatar.jpg"
  socialIcons:
    - name: github
      url: "https://github.com/username"
```

### Add Avatar

```bash
# Place your image
cp photo.jpg static/images/avatar.jpg
```

### Custom CSS

```bash
# Create file
mkdir -p assets/css/extended
nano assets/css/extended/custom.css
```

```css
:root {
  --primary: #2563eb;
}
```

## 🔍 Search & Replace

### Update baseURL everywhere

```bash
# Find
grep -r "username" .

# Replace in hugo.yaml
sed -i 's/<username>/your-username/g' hugo.yaml

# Or manually edit
nano hugo.yaml
```

### Update social links

```bash
# Edit hugo.yaml
nano hugo.yaml

# Find socialIcons section
# Update URLs
```

## 📊 Monitoring

### Check Links

```bash
hugo --minify
# Check output in public/
```

### Test Locally

```bash
hugo server -D
# Open http://localhost:1313/blog-lap-trinh-mang/
```

### Validate HTML

Use: https://validator.w3.org/

### Check SEO

Use: https://www.seobility.net/en/seocheck/

## 🆘 Troubleshooting

### Theme not loading

```bash
git submodule update --init --recursive
```

### Port 1313 in use

```bash
hugo server -p 1314
```

### Clear Hugo cache

```bash
rm -rf resources/
hugo
```

### GitHub Actions failing

```bash
# Check .github/workflows/gh-pages.yml
# Verify theme submodule
git submodule status

# Re-add submodule if needed
git add .gitmodules themes/PaperMod
git commit -m "Fix theme"
git push
```

### CSS not applying

```bash
# Clear browser cache
Ctrl + Shift + R (or Cmd + Shift + R on Mac)

# Or hard refresh
Ctrl + F5
```

## 📁 File Paths Reference

```
hugo.yaml                    # Main config
content/blog/*/index.md      # Blog posts
static/images/               # Images
layouts/partials/            # Custom layouts
themes/PaperMod/             # Theme files
public/                      # Build output (gitignored)
```

## 🔗 Important URLs

### Local Development

```
http://localhost:1313/blog-lap-trinh-mang/
```

### GitHub Pages (After Deploy)

```
https://username.github.io/blog-lap-trinh-mang/
```

### Repository

```
https://github.com/username/blog-lap-trinh-mang
```

## 📝 Common Tasks

### Publish Draft Post

```yaml
# In front matter, change:
draft: true
# To:
draft: false
```

Then:

```bash
git add .
git commit -m "Publish: Post title"
git push
```

### Add New Tag

Just add to front matter:

```yaml
tags: ["NewTag", "Java"]
```

Hugo will automatically create tag page.

### Change Post Date

```yaml
date: 2025-10-20T10:00:00+07:00
```

### Add Cover Image

1. Place image in `static/images/covers/`
2. Add to front matter:

```yaml
cover:
  image: "/images/covers/my-post.png"
  alt: "Description"
```

## ⌨️ Keyboard Shortcuts (VS Code)

```
Ctrl + `          # Toggle terminal
Ctrl + P          # Quick open file
Ctrl + Shift + F  # Search in files
Ctrl + Shift + H  # Replace in files
Ctrl + /          # Toggle comment
Alt + Shift + F   # Format document
```

## 🧪 Testing Checklist

Before deploy:

- [ ] `hugo server -D` - Site loads locally
- [ ] All images load
- [ ] All links work
- [ ] Dark/Light mode works
- [ ] Mobile responsive
- [ ] No console errors

After deploy:

- [ ] Site live at GitHub Pages URL
- [ ] Home page loads
- [ ] Blog posts load
- [ ] Search works
- [ ] Tags work
- [ ] Archive works
- [ ] Social links correct

## 📚 Quick Links

- [Hugo Docs](https://gohugo.io/documentation/)
- [PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)
- [Markdown Guide](https://www.markdownguide.org/cheat-sheet/)
- [GitHub Actions Docs](https://docs.github.com/en/actions)

## 💡 Pro Tips

1. **Write in draft mode first**: `draft: true`
2. **Use descriptive commit messages**: "Add: Post about X"
3. **Test locally before push**: `hugo server -D`
4. **Optimize images**: Use TinyPNG before upload
5. **Regular backups**: `git clone` to another location
6. **Keep theme updated**: Pull PaperMod updates regularly
7. **Monitor Analytics**: Add Google Analytics
8. **Engage readers**: Respond to feedback
9. **Cross-link posts**: Link related posts together
10. **Schedule posts**: Write multiple, publish over time

## 🎯 One-Liner Commands

```bash
# Full workflow in one go
hugo new blog/new-post/index.md && code content/blog/new-post/index.md

# Build and serve
hugo && hugo server

# Quick commit and push
git add . && git commit -m "Update content" && git push

# Clean and rebuild
rm -rf public/ resources/ && hugo --minify
```

## 📞 Help

Need help?

1. Check [README.md](README.md)
2. Check [SETUP.md](SETUP.md)
3. Search Hugo docs
4. Create GitHub issue

---

**Last Updated**: 2025-10-16  
**Version**: 1.0

Keep this cheat sheet handy for quick reference! 📋✨
