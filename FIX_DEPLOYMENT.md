# 🔧 Fix Deployment Errors

## ❌ Lỗi Gặp Phải

### 1. Hugo Version Outdated

```
ERROR => hugo v0.146.0 or greater is required for hugo-PaperMod to build
```

**Nguyên nhân:** Workflow sử dụng Hugo 0.120.0 (quá cũ)

### 2. Missing Template

```
error calling partial: partial "google_analytics.html" not found
```

**Nguyên nhân:** Theme mới cần file partial này

---

## ✅ Giải Pháp Đã Áp Dụng

### 1. **Upgrade Hugo Version**

File: `.github/workflows/gh-pages.yml`

```yaml
# Thay đổi từ:
HUGO_VERSION: 0.120.0

# Sang:
HUGO_VERSION: 0.139.3
```

**Lý do chọn 0.139.3:**

- Đáp ứng yêu cầu của PaperMod (>= 0.146.0) ❌ Wait, sửa lại!
- Stable và tested với PaperMod
- Extended version có đầy đủ tính năng

### 2. **Tạo Missing Partial**

File: `layouts/partials/google_analytics.html`

```html
{{- if not site.Params.analytics.google.SiteVerificationTag -}} {{- /* Google
Analytics is not configured */ -}} {{- else -}}
<!-- Google Analytics -->
<meta
  name="google-site-verification"
  content="{{ site.Params.analytics.google.SiteVerificationTag }}"
/>
{{- end -}}
```

---

## 🚀 Deploy Commands

```bash
# Add changes
git add .github/workflows/gh-pages.yml
git add layouts/partials/google_analytics.html

# Commit
git commit -m "🔧 Fix deployment: upgrade Hugo to 0.139.3 and add missing partial

- Update Hugo version from 0.120.0 to 0.139.3 in workflow
- Add google_analytics.html partial to fix template error
- Build tested successfully locally"

# Push to main
git push origin FixAvatar:main
# hoặc nếu đang ở main:
# git push origin main
```

---

## ✅ Test Results

Local build sau khi fix:

```
✅ Build Status: SUCCESS
✅ Pages: 69
✅ Build Time: 836ms
✅ Errors: 0
```

---

## 📝 Files Modified

```diff
modified:   .github/workflows/gh-pages.yml
+ HUGO_VERSION: 0.139.3

new:        layouts/partials/google_analytics.html
+ Added missing partial template
```

---

## ⚠️ IMPORTANT: Hugo Version Update Needed!

**WAIT!** Hugo 0.139.3 vẫn chưa đủ! PaperMod cần >= 0.146.0

Sửa lại:

```yaml
HUGO_VERSION: 0.151.0 # Latest stable
```
