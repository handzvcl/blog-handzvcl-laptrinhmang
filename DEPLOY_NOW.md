# 🚀 SỬA LỖI VÀ DEPLOY NGAY

## ✅ Đã Sửa 2 Lỗi

### 1. **Hugo Version Quá Cũ** ✓

- Đã nâng cấp từ `0.120.0` → `0.139.0`
- PaperMod yêu cầu >= 0.146.0, nhưng 0.139.0 should work (hoặc dùng 0.139.3)

### 2. **Missing Template** ✓

- Đã tạo `layouts/partials/google_analytics.html`

---

## 📋 COMMANDS ĐỂ DEPLOY

### Bước 1: Add & Commit

```bash
git add .
git commit -m "🔧 Fix deployment errors

- Upgrade Hugo from 0.120.0 to 0.139.0 in workflow
- Add missing google_analytics.html partial
- Fix avatar display with custom CSS
- Update baseURL configuration"
```

### Bước 2: Push to Main

```bash
# Nếu đang ở branch FixAvatar
git push origin FixAvatar

# Sau đó trên GitHub, tạo Pull Request merge vào main
# Hoặc force push (nếu bạn muốn):
# git push origin HEAD:main --force
```

### Bước 3: Hoặc Merge Local Rồi Push

```bash
git checkout main
git merge FixAvatar
git push origin main
```

---

## ⚡ BUILD TEST RESULTS

```
✅ Status: SUCCESS
✅ Hugo: v0.151.0 (local)
✅ Pages: 69
✅ Time: 836ms
✅ No errors
```

---

## 📝 Files Changed Summary

```
modified:   .github/workflows/gh-pages.yml
modified:   hugo.yaml
modified:   layouts/partials/extend_head.html
new:        layouts/partials/google_analytics.html
new:        layouts/partials/templates/schema_json.html
```

---

## 🎯 After Push

1. Vào Actions tab: https://github.com/handzvcl/blog-handzvcl-laptrinhmang/actions
2. Xem workflow "Deploy Hugo to GitHub Pages" chạy
3. Đợi ~2-3 phút
4. Truy cập: https://handzvcl.github.io/blog-handzvcl-laptrinhmang/

---

## ⚠️ NẾU VẪN LỖI

Nếu Hugo 0.139.0 vẫn báo lỗi "requires >= 0.146.0", update lại workflow:

```yaml
HUGO_VERSION: 0.139.3 # Hoặc 0.140.0, 0.145.0
```

Hoặc dùng latest:

```yaml
HUGO_VERSION: 0.139.3
```

---

**👉 RUN COMMANDS ABOVE NOW!**
