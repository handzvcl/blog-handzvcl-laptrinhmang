# 🔧 Fix 404 Error - BaseURL Issue

## ❌ Problem

Deploy thành công nhưng truy cập https://handzvcl.github.io/blog-handzvcl-laptrinhmang/ bị **404 Not Found**

## 🔍 Root Cause

**BaseURL không đúng!**

```yaml
# SAI - Quá generic
baseURL: "/"

# ĐÚNG - Full path với sub-directory
baseURL: "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"
```

### Giải thích:

- Repository: `blog-handzvcl-laptrinhmang`
- GitHub Pages URL: `https://handzvcl.github.io/blog-handzvcl-laptrinhmang/`
- Khi baseURL = "/", Hugo generate các links sai:
  - CSS: `/assets/...` thay vì `/blog-handzvcl-laptrinhmang/assets/...`
  - Pages: `/blog/` thay vì `/blog-handzvcl-laptrinhmang/blog/`
- Kết quả: Browser không tìm thấy files → 404

## ✅ Solution

Đã update `hugo.yaml`:

```yaml
baseURL: "https://handzvcl.github.io/blog-handzvcl-laptrinhmang/"
```

## 🚀 Deploy Commands

```bash
# Add and commit
git add hugo.yaml
git commit -m "🔧 Fix 404 error - correct baseURL for GitHub Pages

Set baseURL to full GitHub Pages URL including repository name.
This ensures all assets and links are generated with correct paths."

# Push
git push origin FixAvatar

# Or if on main:
# git push origin main
```

## ✅ Test Results

```
✅ Build: SUCCESS
✅ Pages: 69
✅ Time: 1066ms
✅ BaseURL: Correct
```

## 🎯 After Push

Wait 2-3 minutes, then visit:

- ✅ https://handzvcl.github.io/blog-handzvcl-laptrinhmang/

Should work perfectly now!

---

## 📝 Alternative (If Still 404)

Nếu vẫn 404, check GitHub Pages settings:

1. Go to: https://github.com/handzvcl/blog-handzvcl-laptrinhmang/settings/pages
2. Ensure:
   - ✅ Source: **GitHub Actions**
   - ✅ Custom domain: (empty)
3. Check latest workflow run completed successfully

---

**Run the commands above to fix 404!**
